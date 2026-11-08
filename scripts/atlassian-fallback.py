#!/usr/bin/env python3
"""
Atlassian Fallback Script for Product OS

Use this script when the Atlassian MCP server is not available.
Provides direct REST API access to Confluence and Jira.

Usage:
    python atlassian-fallback.py publish --config product-os.config.yaml --project <path>
    python atlassian-fallback.py jira-sync --config product-os.config.yaml --project <path>
    python atlassian-fallback.py --help

Requirements:
    pip install requests pyyaml python-dotenv markdown
"""

import argparse
import json
import os
import re
import sys
from datetime import datetime
from pathlib import Path

import requests
import yaml
from dotenv import load_dotenv

# Load environment variables
load_dotenv()


class AtlassianClient:
    """Base client for Atlassian REST APIs."""

    def __init__(self, base_url: str, email: str, token: str, dry_run: bool = False):
        self.base_url = base_url.rstrip("/")
        self.auth = (email, token)
        self.dry_run = dry_run
        self.headers = {
            "Accept": "application/json",
            "Content-Type": "application/json",
        }

    def get(self, endpoint: str, params: dict = None) -> dict:
        url = f"{self.base_url}{endpoint}"
        response = requests.get(url, auth=self.auth, headers=self.headers, params=params)
        response.raise_for_status()
        return response.json()

    def post(self, endpoint: str, data: dict) -> dict:
        if self.dry_run:
            print(f"    [dry run] POST {endpoint}")
            return {"id": "DRY-RUN", "key": "DRY-RUN", "version": {"number": 0}}
        url = f"{self.base_url}{endpoint}"
        response = requests.post(url, auth=self.auth, headers=self.headers, json=data)
        response.raise_for_status()
        return response.json()

    def put(self, endpoint: str, data: dict) -> dict:
        if self.dry_run:
            print(f"    [dry run] PUT {endpoint}")
            return {"id": endpoint.rsplit("/", 1)[-1], "key": endpoint.rsplit("/", 1)[-1]}
        url = f"{self.base_url}{endpoint}"
        response = requests.put(url, auth=self.auth, headers=self.headers, json=data)
        response.raise_for_status()
        return response.json()


class ConfluencePublisher:
    """Publish documents to Confluence."""

    def __init__(self, config: dict, client: AtlassianClient):
        self.config = config
        self.client = client
        self.space_key = config["confluence"]["space_key"]
        self.parent_id = config["confluence"]["initiatives_parent_page_id"]

    def markdown_to_storage(self, markdown: str) -> str:
        """Convert Markdown to Confluence storage format."""
        # Basic conversion - for complex docs, consider using a proper library
        html = markdown
        
        # Headers
        html = re.sub(r"^### (.+)$", r"<h3>\1</h3>", html, flags=re.MULTILINE)
        html = re.sub(r"^## (.+)$", r"<h2>\1</h2>", html, flags=re.MULTILINE)
        html = re.sub(r"^# (.+)$", r"<h1>\1</h1>", html, flags=re.MULTILINE)
        
        # Bold and italic
        html = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", html)
        html = re.sub(r"\*(.+?)\*", r"<em>\1</em>", html)
        
        # Code blocks (preserve Mermaid)
        html = re.sub(
            r"```mermaid\n(.*?)\n```",
            r'<ac:structured-macro ac:name="mermaid"><ac:plain-text-body><![CDATA[\1]]></ac:plain-text-body></ac:structured-macro>',
            html,
            flags=re.DOTALL,
        )
        html = re.sub(r"```\w*\n(.*?)\n```", r"<pre><code>\1</code></pre>", html, flags=re.DOTALL)
        
        # Inline code
        html = re.sub(r"`([^`]+)`", r"<code>\1</code>", html)
        
        # Links
        html = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r'<a href="\2">\1</a>', html)
        
        # Lists
        lines = html.split("\n")
        in_list = False
        result = []
        for line in lines:
            if line.strip().startswith("- "):
                if not in_list:
                    result.append("<ul>")
                    in_list = True
                result.append(f"<li>{line.strip()[2:]}</li>")
            else:
                if in_list:
                    result.append("</ul>")
                    in_list = False
                result.append(line)
        if in_list:
            result.append("</ul>")
        html = "\n".join(result)
        
        # Paragraphs
        html = re.sub(r"\n\n+", "</p><p>", html)
        html = f"<p>{html}</p>"
        
        return html

    def find_page(self, title: str, parent_id: str = None) -> dict | None:
        """Find a page by title."""
        escaped = title.replace("\\", "\\\\").replace('"', '\\"')
        cql = f'title="{escaped}" and space="{self.space_key}" and type=page'
        if parent_id:
            cql += f" and parent={parent_id}"

        try:
            # Confluence Cloud: CQL goes to /content/search (base_url keeps /wiki)
            result = self.client.get(
                "/rest/api/content/search",
                params={"cql": cql, "limit": 5, "expand": "version"}
            )
            if result.get("results"):
                return result["results"][0]
        except requests.HTTPError:
            pass
        return None

    def create_page(self, title: str, content: str, parent_id: str) -> dict:
        """Create a new Confluence page."""
        data = {
            "type": "page",
            "title": title,
            "space": {"key": self.space_key},
            "ancestors": [{"id": parent_id}],
            "body": {
                "storage": {
                    "value": self.markdown_to_storage(content),
                    "representation": "storage",
                }
            },
        }
        return self.client.post("/rest/api/content", data)

    def update_page(self, page_id: str, title: str, content: str, version: int) -> dict:
        """Update an existing Confluence page."""
        data = {
            "type": "page",
            "title": title,
            "version": {"number": version + 1},
            "body": {
                "storage": {
                    "value": self.markdown_to_storage(content),
                    "representation": "storage",
                }
            },
        }
        return self.client.put(f"/rest/api/content/{page_id}", data)

    def get_page(self, page_id: str) -> dict | None:
        """Fetch a page by id (used to update pages recorded in a manifest)."""
        try:
            return self.client.get(f"/rest/api/content/{page_id}", params={"expand": "version"})
        except requests.HTTPError:
            return None

    def publish_project(self, project_path: Path) -> dict:
        """Publish all artifacts from a project folder."""
        previous = {}
        manifest_path = project_path / "publish-manifest.json"
        if manifest_path.exists():
            previous = json.loads(manifest_path.read_text()).get("pages", {})
        manifest = {
            "project": str(project_path),
            "published_at": datetime.now().isoformat(),
            "pages": {},
        }

        # Determine initiative and project names from path
        parts = project_path.parts
        if "initiatives" in parts:
            idx = parts.index("initiatives")
            initiative = parts[idx + 1] if len(parts) > idx + 1 else "default"
            project = parts[idx + 2] if len(parts) > idx + 2 else "default"
        else:
            initiative = "default"
            project = project_path.name

        # Create or find initiative folder
        initiative_title = initiative.replace("-", " ").title()
        initiative_page = self.find_page(initiative_title, self.parent_id)
        if not initiative_page:
            initiative_page = self.create_page(
                initiative_title,
                f"# {initiative_title}\n\nInitiative documentation.",
                self.parent_id,
            )
        initiative_id = initiative_page["id"]

        # Create or find project folder
        project_title = project.replace("-", " ").title()
        project_page = self.find_page(project_title, initiative_id)
        if not project_page:
            project_page = self.create_page(
                project_title,
                f"# {project_title}\n\nProject documentation.",
                initiative_id,
            )
        project_id = project_page["id"]

        # Publish each markdown file
        doc_order = [
            "project-brief.md",
            "prd.md",
            "project-plan.md",
            "raci.md",
            "gantt.md",
            "design-brief.md",
            "flows.md",
            "wireframes.md",
            "prototype-spec.md",
            "design-critique.md",
            "ux-review.md",
            "accessibility-audit.md",
            "epics.md",
            "stories.md",
            "decision-log.md",
        ]

        for filename in doc_order:
            filepath = project_path / filename
            if filepath.exists():
                content = filepath.read_text()
                # Extract title from first heading or use filename
                title_match = re.search(r"^#\s+(.+)$", content, re.MULTILINE)
                title = title_match.group(1) if title_match else filename.replace(".md", "").replace("-", " ").title()
                page_title = f"{project_title} - {title}"

                existing = None
                if previous.get(filename, {}).get("page_id"):
                    existing = self.get_page(previous[filename]["page_id"])
                if not existing:
                    existing = self.find_page(page_title, project_id)
                if existing:
                    page = self.update_page(
                        existing["id"],
                        page_title,
                        content,
                        existing["version"]["number"],
                    )
                    status = "updated"
                else:
                    page = self.create_page(page_title, content, project_id)
                    status = "created"

                manifest["pages"][filename] = {
                    "page_id": page["id"],
                    "title": page_title,
                    "url": f"{self.client.base_url}/spaces/{self.space_key}/pages/{page['id']}",
                    "status": status,
                }
                print(f"  {status.capitalize()}: {page_title}")

        return manifest


class JiraSyncer:
    """Sync epics and stories to Jira."""

    def __init__(self, config: dict, client: AtlassianClient):
        self.config = config
        self.client = client
        self.project_key = config["jira"]["project_key"]
        self.issue_types = config["jira"]["issue_types"]
        self.custom_fields = config["jira"]["custom_fields"]
        self.discipline_mapping = config["jira"].get("discipline_mapping", "labels")
        self.default_labels = config["jira"].get("default_labels", ["product-os"])
        # "parent" works for team-managed and current company-managed projects;
        # "custom_field" uses custom_fields.epic_link (legacy Epic Link field)
        self.epic_link_mode = config["jira"].get("epic_link_mode", "parent")

    def find_issue(self, summary: str, issue_type: str) -> dict | None:
        """Find an issue by summary and type."""
        # summary ~ is a fuzzy text search, so filter the hits for an exact match
        escaped = summary.replace("\\", "\\\\").replace('"', '\\"')
        jql = f'project="{self.project_key}" AND summary~"{escaped}" AND issuetype="{issue_type}"'
        try:
            result = self.client.get(
                "/rest/api/3/search/jql",
                params={"jql": jql, "maxResults": 50, "fields": "summary"}
            )
            for issue in result.get("issues", []):
                if issue.get("fields", {}).get("summary") == summary:
                    return issue
        except requests.HTTPError:
            pass
        return None

    def issue_exists(self, key: str) -> bool:
        try:
            self.client.get(f"/rest/api/3/issue/{key}", params={"fields": "summary"})
            return True
        except requests.HTTPError:
            return False

    def resolve_existing(self, recorded_key: str | None, summary: str, issue_type: str) -> dict | None:
        """Prefer the key recorded in an earlier sync manifest, then an exact-summary match."""
        if recorded_key and recorded_key != "DRY-RUN" and self.issue_exists(recorded_key):
            return {"key": recorded_key}
        return self.find_issue(summary, issue_type)

    def create_issue(self, issue_data: dict) -> dict:
        """Create a new Jira issue."""
        return self.client.post("/rest/api/3/issue", {"fields": issue_data})

    def update_issue(self, issue_key: str, issue_data: dict) -> dict:
        """Update an existing Jira issue."""
        return self.client.put(f"/rest/api/3/issue/{issue_key}", {"fields": issue_data})

    def create_link(self, inward_key: str, outward_key: str, link_type: str = "Blocks") -> dict:
        """Create an issue link."""
        data = {
            "type": {"name": link_type},
            "inwardIssue": {"key": inward_key},
            "outwardIssue": {"key": outward_key},
        }
        return self.client.post("/rest/api/3/issueLink", data)

    def parse_epics(self, epics_content: str) -> list:
        """Parse epics from epics.md content."""
        epics = []
        current_epic = None
        
        for line in epics_content.split("\n"):
            if line.startswith("### EPIC-"):
                if current_epic:
                    epics.append(current_epic)
                # Extract epic ID and title
                match = re.match(r"### (EPIC-\d+):\s*(.+)", line)
                if match:
                    current_epic = {
                        "id": match.group(1),
                        "title": match.group(2),
                        "description": "",
                    }
            elif current_epic and line.startswith("**Goal:**"):
                current_epic["description"] = line.replace("**Goal:**", "").strip()
        
        if current_epic:
            epics.append(current_epic)
        
        return epics

    def parse_stories(self, stories_content: str) -> list:
        """Parse stories from stories.md content."""
        stories = []
        current_story = None
        
        for line in stories_content.split("\n"):
            if line.startswith("## STORY-"):
                if current_story:
                    stories.append(current_story)
                match = re.match(r"## (STORY-\d+):\s*(.+)", line)
                if match:
                    current_story = {
                        "id": match.group(1),
                        "title": match.group(2),
                        "epic_id": "",
                        "points": 0,
                        "discipline": "fullstack",
                        "description": "",
                        "body": [],
                    }
            elif current_story:
                current_story["body"].append(line)
                if "EPIC-" in line and current_story["epic_id"] == "":
                    match = re.search(r"(EPIC-\d+)", line)
                    if match:
                        current_story["epic_id"] = match.group(1)
                elif line.startswith("**Points:**"):
                    match = re.search(r"\d+", line)
                    if match:
                        current_story["points"] = int(match.group())
                elif line.startswith("**Label:**"):
                    if "frontend" in line.lower():
                        current_story["discipline"] = "frontend"
                    elif "backend" in line.lower():
                        current_story["discipline"] = "backend"
                    else:
                        current_story["discipline"] = "fullstack"
        
        if current_story:
            stories.append(current_story)

        for story in stories:
            story["description"] = "\n".join(story.pop("body")).strip()

        return stories

    def sync_project(self, project_path: Path, confluence_manifest: dict = None) -> dict:
        """Sync epics and stories from a project folder."""
        previous = {"epics": {}, "stories": {}}
        manifest_path = project_path / "jira-sync-manifest.json"
        if manifest_path.exists():
            previous.update(json.loads(manifest_path.read_text()))
        manifest = {
            "project": str(project_path),
            "synced_at": datetime.now().isoformat(),
            "epics": {},
            "stories": {},
        }

        epics_path = project_path / "epics.md"
        stories_path = project_path / "stories.md"

        if not epics_path.exists() or not stories_path.exists():
            print("Error: epics.md and stories.md required")
            return manifest

        # Parse epics and stories
        epics = self.parse_epics(epics_path.read_text())
        stories = self.parse_stories(stories_path.read_text())

        # Determine project name for prefixing
        project_name = project_path.name.replace("-", " ").title()

        # Create epics
        epic_key_map = {}
        for epic in epics:
            summary = f"[{project_name}] Epic: {epic['title']}"
            labels = self.default_labels + ["epic"]
            
            issue_data = {
                "project": {"key": self.project_key},
                "summary": summary,
                "description": {
                    "type": "doc",
                    "version": 1,
                    "content": [{"type": "paragraph", "content": [{"type": "text", "text": epic["description"]}]}]
                },
                "issuetype": {"name": self.issue_types["epic"]},
                "labels": labels,
            }

            existing = self.resolve_existing(
                previous["epics"].get(epic["id"], {}).get("jira_key"), summary, self.issue_types["epic"]
            )
            if existing:
                self.update_issue(existing["key"], issue_data)
                key = existing["key"]
                status = "updated"
            else:
                result = self.create_issue(issue_data)
                key = result["key"]
                status = "created"

            epic_key_map[epic["id"]] = key
            manifest["epics"][epic["id"]] = {
                "jira_key": key,
                "url": f"{self.client.base_url}/browse/{key}",
                "status": status,
            }
            print(f"  Epic {status}: {key} - {epic['title']}")

        # Create stories
        for story in stories:
            summary = story["title"]
            labels = self.default_labels + [story["discipline"]]
            if story["discipline"] == "fullstack":
                labels = self.default_labels + ["frontend", "backend"]

            issue_data = {
                "project": {"key": self.project_key},
                "summary": summary,
                "description": {
                    "type": "doc",
                    "version": 1,
                    "content": [
                        {"type": "paragraph", "content": [{"type": "text", "text": para}]}
                        for para in (story["description"] or f"Story {story['id']}").split("\n\n")
                        if para.strip()
                    ]
                },
                "issuetype": {"name": self.issue_types["story"]},
                "labels": labels,
            }

            # Add story points if custom field is configured
            if self.custom_fields.get("story_points"):
                issue_data[self.custom_fields["story_points"]] = story["points"]

            # Link the story to its epic
            if story["epic_id"] in epic_key_map:
                epic_key = epic_key_map[story["epic_id"]]
                if self.epic_link_mode == "custom_field" and self.custom_fields.get("epic_link"):
                    issue_data[self.custom_fields["epic_link"]] = epic_key
                else:
                    issue_data["parent"] = {"key": epic_key}

            existing = self.resolve_existing(
                previous["stories"].get(story["id"], {}).get("jira_key"), summary, self.issue_types["story"]
            )
            if existing:
                self.update_issue(existing["key"], issue_data)
                key = existing["key"]
                status = "updated"
            else:
                result = self.create_issue(issue_data)
                key = result["key"]
                status = "created"

            manifest["stories"][story["id"]] = {
                "jira_key": key,
                "epic_key": epic_key_map.get(story["epic_id"]),
                "url": f"{self.client.base_url}/browse/{key}",
                "story_points": story["points"],
                "discipline": story["discipline"],
                "status": status,
            }
            print(f"  Story {status}: {key} - {story['title']} ({story['points']} pts, {story['discipline']})")

        return manifest


def load_config(config_path: str) -> dict:
    """Load configuration from YAML file."""
    with open(config_path) as f:
        return yaml.safe_load(f)


def main():
    parser = argparse.ArgumentParser(description="Atlassian Fallback Script for Product OS")
    parser.add_argument("action", choices=["publish", "jira-sync"], help="Action to perform")
    parser.add_argument("--config", default="product-os.config.yaml", help="Config file path")
    parser.add_argument("--project", required=True, help="Project folder path")
    parser.add_argument("--dry-run", action="store_true", help="Preview without making changes")

    args = parser.parse_args()

    # Load config
    config = load_config(args.config)

    # Get credentials
    email = os.getenv("ATLASSIAN_EMAIL")
    token = os.getenv("ATLASSIAN_API_TOKEN")

    if not email or not token:
        print("Error: ATLASSIAN_EMAIL and ATLASSIAN_API_TOKEN must be set in .env")
        sys.exit(1)

    project_path = Path(args.project)
    if not project_path.exists():
        print(f"Error: Project path does not exist: {project_path}")
        sys.exit(1)

    if args.action == "publish":
        print(f"Publishing to Confluence: {project_path}")
        # Confluence Cloud REST lives under /wiki, so keep it in the base URL
        client = AtlassianClient(config["confluence"]["base_url"], email, token, dry_run=args.dry_run)
        publisher = ConfluencePublisher(config, client)
        manifest = publisher.publish_project(project_path)

        if args.dry_run:
            print("\nDry run - no changes made, manifest not written")
        else:
            manifest_path = project_path / "publish-manifest.json"
            with open(manifest_path, "w") as f:
                json.dump(manifest, f, indent=2)
            print(f"\nManifest saved to: {manifest_path}")

    elif args.action == "jira-sync":
        print(f"Syncing to Jira: {project_path}")
        client = AtlassianClient(config["jira"]["base_url"], email, token, dry_run=args.dry_run)
        syncer = JiraSyncer(config, client)
        manifest = syncer.sync_project(project_path)

        if args.dry_run:
            print("\nDry run - no changes made, manifest not written")
        else:
            manifest_path = project_path / "jira-sync-manifest.json"
            with open(manifest_path, "w") as f:
                json.dump(manifest, f, indent=2)
            print(f"\nManifest saved to: {manifest_path}")


if __name__ == "__main__":
    main()
