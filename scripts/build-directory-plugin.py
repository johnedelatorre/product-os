#!/usr/bin/env python3
"""Build the two plugin folders of Product OS from the same sources.

marketplace/product-os/  what people get when they add this repo by its address
                         (Add marketplace), and what Claude Code installs as
                         product-os@product-os. Title: Product OS.
plugin/                  the copy submitted to Claude's plugin directory.
                         Name: jdlt-product-os. Title: Product OS by JDLT.

The repo root is a marketplace, not a plugin: a plugin cannot hold a second
plugin, and the directory accepts only Markdown, text, JSON, YAML and images
from an organization that is not Verified. So both folders hold only the
skill (from scripts/build-plugin-skill.py), the agents (.claude/agents/), the
commands (.claude/commands/), a README, the license, the notices, the privacy
page and the icon. The text is changed in four ways:

1. In plugin/, /product-os:<name> becomes /jdlt-product-os:<name>.
2. The parts about the REST fallback script and its credentials are left out.
   The plugin has no scripts: it publishes through the PM's own connectors.
3. Install commands for outside tools are replaced with a pointer to the tool.
4. The board page is carried as a text file, assets/product-os-board.txt.

Usage:
    python3 scripts/build-directory-plugin.py           # write both folders
    python3 scripts/build-directory-plugin.py --check   # exit 1 if one is out of date
"""

import importlib.util
import io
import json
import os
import re
import shutil
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# Each copy: (folder, the plugin's name, its title, whether it carries the directory's listing links).
# plugin/ is read by Claude's plugin directory. marketplace/product-os/ is what people get when they
# add this repo by its address (Add marketplace), and what Claude Code installs as product-os@product-os.
COPIES = [
    ("plugin", "jdlt-product-os", "Product OS by JDLT", True),
    ("marketplace/product-os", "product-os", "Product OS", False),
]
DESCRIPTION = 'Product management and design operating system. Claude leads a PM through a guided 9-phase workflow with 41 agents, 48 commands (/product-os:*), 45 playbooks and templates, makes each output in its real form, publishes to Confluence and Jira, and keeps a live board. Works in Claude chat, Cowork and Claude Code.'
AUTHOR = {"name": "John De La Torre-Ugarte", "url": "https://github.com/johnedelatorre"}
REPOSITORY = "https://github.com/johnedelatorre/product-os"
ALLOWED = (".md", ".txt", ".json", ".yaml", ".yml", ".png", ".jpg", ".jpeg")

spec = importlib.util.spec_from_file_location("skill_builder", os.path.join(ROOT, "scripts", "build-plugin-skill.py"))
skill_builder = importlib.util.module_from_spec(spec)
spec.loader.exec_module(skill_builder)

README = """# {title}

Product OS turns Claude into the agent that runs a product project with you, from the first request to the handoff your engineers read. It is for product managers and designers. You do not need a terminal.

## What it does

1. Leads you through nine phases: intake, discovery, prioritize, define, design, review, deliver, launch and measure.
2. Asks before it writes, one question at a time, with choices to tap.
3. Has a specialist role take over each step: 41 roles, from the PRD author to the UX writer.
4. Makes each output in its real form: documents, user flows, wireframes, designs and a clickable prototype.
5. Publishes to your Confluence and Jira after your yes, then reads the result back.
6. Keeps a live board of every task, document and ticket.

## Use it

Start a chat and say: Start Product OS.

Claude welcomes you, names the version, and asks the first of seven start questions. Nothing is written or published before your yes. In a Cowork task or in Claude Code you can also run a step directly, for example /{name}:prd.

## What data it handles

Product OS is a set of instructions, templates and one board page. It has no server of its own, and it collects nothing.

1. Your documents are written by Claude in your own Claude account, from what you type, attach and link.
2. After your yes to a publish plan, Claude sends the documents and tickets you approved to your own Atlassian site, through your own Atlassian connector.
3. When you ask for it, Claude reads and writes designs in your own Figma account, through your own Figma connector.
4. The board keeps the project's state in its own database in your Claude account. Only people you share the board with can see it.

[Privacy](https://github.com/johnedelatorre/product-os/blob/main/PRIVACY.md)

## Source and license

Product OS is open source under the MIT License: https://github.com/johnedelatorre/product-os

Product OS {version}. Copyright 2026 John De La Torre-Ugarte.
"""

FIRST = (
    "\n> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). "
    "In this plugin those files are in the `product-os` skill: load that skill first, and use its \"Where the files are\" table to find each one.\n"
)

# (pattern, replacement): the parts that do not apply to the directory copy.
RULES = [
    (r"(?ms)^#{2,3} (?:Via REST API \(Fallback\)|Fallback Script)\n.*?(?=^#{1,3} |^---$)", ""),
    (r"(?:From|In) `\.env`[^\n]*\n\n```\nATLASSIAN_EMAIL=[^\n]*\nATLASSIAN_API_TOKEN=[^\n]*\n```\n\n?", ""),
    (r"(?s) With the REST fallback:\n\n```bash\n.*?```\n", "\n"),
    (r" Use the REST fallback \(`scripts/atlassian-fallback\.py`\) only when no Atlassian MCP server is connected\.(?: With MCP, no credentials are needed; `\.env` is only for the fallback\.)?", " No credentials are needed."),
    (r" The REST fallback script \(with `\.env`\) is only for when no MCP server is connected\.", ""),
    (r"(?m)^- `ATLASSIAN_EMAIL` and `ATLASSIAN_API_TOKEN` in `\.env` \(REST fallback only\)\n", ""),
    (r"Atlassian MCP connected \(preferred; no credentials needed\), OR `ATLASSIAN_EMAIL` and `ATLASSIAN_API_TOKEN` in `\.env` \(REST fallback only\)", "the Atlassian connector connected"),
    (r"Atlassian MCP connected, or API token in environment for the REST fallback", "the Atlassian connector connected"),
    (r"Atlassian MCP connected \(or credentials in \.env for the REST fallback\)", "the Atlassian connector connected"),
    (r" \(Atlassian MCP preferred; REST fallback otherwise\)", " (the Atlassian connector)"),
    (r"`editJiraIssue`,? or the REST fallback", "`editJiraIssue`"),
    (r"(?m)^# Install\nnpm install -g (\S+)\n", r"# Install \1 first: see its own install instructions\n"),
    (r"(?m)^npm install -g (\S+)\n", r"# Install \1 first: see its own install instructions\n"),
    (r"// Install: npm install @axe-core/puppeteer puppeteer", "// Install @axe-core/puppeteer and puppeteer first: see their own install instructions"),
]
FORBIDDEN = ("atlassian-fallback", "ATLASSIAN_", ".env", "REST fallback", "npm install", "pip install", "curl ", "wget ")


def clean(text, name):
    for pattern, replacement in RULES:
        text = re.sub(pattern, replacement, text)
    return text.replace("/product-os:", "/%s:" % name)


def after_frontmatter(text, extra):
    """Put a note right after a file's YAML front matter."""
    if text.startswith("---\n"):
        end = text.index("\n---\n", 4) + 5
        return text[:end] + extra + "\n" + text[end:].lstrip("\n")
    return extra.lstrip("\n") + "\n" + text


def build(name, title, listing):
    """Return {relative path: text or bytes} for every file in one copy of the plugin."""
    files = {}
    version = skill_builder.version()

    for rel, content in skill_builder.build().items():
        if rel == "assets/product-os-board.html":
            rel = "assets/product-os-board.txt"
        else:
            content = clean(content, name)
        if rel == "SKILL.md":
            old = ("publish `assets/product-os-board.html` as an artifact in the PM's own account, titled \"Product OS board: <short project name>\". "
                   "Publish the file as it is.")
            if content.count(old) != 1:
                raise SystemExit("build-directory-plugin: the board step in SKILL.md changed; update this script")
            content = content.replace(old, (
                "copy `assets/product-os-board.txt` to a file named `index.html` without changing a character, and publish that file as an artifact "
                "in the PM's own account, titled \"Product OS board: <short project name>\". The text file is the board's HTML page."))
        files["skills/product-os/" + rel] = content

    for folder, target in ((".claude/agents", "agents"), (".claude/commands", "commands")):
        for fname in sorted(os.listdir(os.path.join(ROOT, folder))):
            if fname.endswith(".md"):
                text = io.open(os.path.join(ROOT, folder, fname), encoding="utf-8").read()
                files["%s/%s" % (target, fname)] = after_frontmatter(clean(text, name), FIRST)

    manifest = {
        "name": name,
        "displayName": title,
        "version": version,
        "description": skill_builder.with_version(DESCRIPTION.replace("/product-os:", "/%s:" % name)),
        "author": AUTHOR,
        "homepage": REPOSITORY,
        "repository": REPOSITORY,
        "license": "MIT",
    }
    if listing:
        manifest.update({
            "keywords": ["product management", "product design", "prd", "user flows", "ux writing", "jira", "confluence", "figma"],
            "privacyPolicyUrl": REPOSITORY + "/blob/main/PRIVACY.md",
            "supportUrl": REPOSITORY + "/issues",
            "documentationUrl": REPOSITORY + "#readme",
        })
    files[".claude-plugin/plugin.json"] = json.dumps(manifest, indent=2, ensure_ascii=False) + "\n"
    with io.open(os.path.join(ROOT, ".claude-plugin", "icon.png"), "rb") as fh:
        files[".claude-plugin/icon.png"] = fh.read()
    files["README.md"] = README.format(name=name, title=title, version=version)
    files["LICENSE"] = io.open(os.path.join(ROOT, "LICENSE"), encoding="utf-8").read()
    files["NOTICE.md"] = clean(io.open(os.path.join(ROOT, "NOTICE.md"), encoding="utf-8").read(), name)
    files["PRIVACY.md"] = io.open(os.path.join(ROOT, "PRIVACY.md"), encoding="utf-8").read()

    problems = []
    for rel, content in files.items():
        if rel != "LICENSE" and not rel.lower().endswith(ALLOWED):
            problems.append("%s: file type the directory does not accept" % rel)
        if os.path.basename(rel).lower() in ("claude.md", "claude.local.md", "agents.md"):
            problems.append("%s: file name the directory does not accept" % rel)
        if isinstance(content, bytes) or rel.endswith("product-os-board.txt"):
            continue
        if content.startswith("#!"):
            problems.append("%s: starts with #!" % rel)
        for n, line in enumerate(content.split("\n"), 1):
            for token in FORBIDDEN:
                if token in line:
                    problems.append("%s:%d: %r in: %s" % (rel, n, token, line.strip()[:90]))
    if problems:
        raise SystemExit("build-directory-plugin: fix these before the directory will accept the plugin:\n  " + "\n  ".join(problems[:40]))
    if len(files) > 512:
        raise SystemExit("build-directory-plugin: %d files; the directory holds a plugin of more than 512 for a reviewer" % len(files))
    return files


def on_disk(out):
    found = set()
    for folder, _, names in os.walk(out):
        for fname in names:
            found.add(os.path.relpath(os.path.join(folder, fname), out).replace(os.sep, "/"))
    return found


def same(path, content):
    if not os.path.isfile(path):
        return False
    if isinstance(content, bytes):
        return open(path, "rb").read() == content
    return io.open(path, encoding="utf-8").read() == content


def main():
    check = "--check" in sys.argv
    for folder, name, title, listing in COPIES:
        out = os.path.join(ROOT, *folder.split("/"))
        files = build(name, title, listing)
        if check:
            stale = [rel for rel, content in files.items() if not same(os.path.join(out, rel), content)]
            extra = sorted(on_disk(out) - set(files))
            if stale or extra:
                print("%s/ is out of date: %s" % (folder, ", ".join((stale + extra)[:8])))
                print("Run: python3 scripts/build-directory-plugin.py")
                return 1
            print("%s/ is up to date (%d files)." % (folder, len(files)))
            continue
        if os.path.isdir(out):
            shutil.rmtree(out)
        for rel, content in files.items():
            path = os.path.join(out, rel)
            os.makedirs(os.path.dirname(path), exist_ok=True)
            if isinstance(content, bytes):
                with open(path, "wb") as fh:
                    fh.write(content)
            else:
                with io.open(path, "w", encoding="utf-8") as fh:
                    fh.write(content)
        print("Wrote %d files to %s/ (%s %s)" % (len(files), folder, name, skill_builder.version()))
    return 0


if __name__ == "__main__":
    sys.exit(main())
