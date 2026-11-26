#!/usr/bin/env python3
"""Build the copy of Product OS that is submitted to Claude's plugin directory: plugin/.

The directory accepts only Markdown, text, JSON, YAML and images from an
organization that is not Verified, in a folder laid out as a plugin:
.claude-plugin/, skills/, commands/, agents/, a README and a license. The repo
root holds more than that (scripts, tests, the Cursor rules, the ChatGPT pack),
so the directory reads this folder instead.

Everything here is generated from the same sources as the rest of Product OS:
the skill from scripts/build-plugin-skill.py, the agents from .claude/agents/
and the commands from .claude/commands/. The text is changed in four ways:

1. The plugin's name in the directory is jdlt-product-os, so /product-os:<name>
   becomes /jdlt-product-os:<name>.
2. The parts about the REST fallback script and its credentials are left out.
   This copy has no scripts: it publishes through the PM's own connectors.
3. Install commands for outside tools are replaced with a pointer to the tool.
4. The board page is carried as a text file, assets/product-os-board.txt.

Usage:
    python3 scripts/build-directory-plugin.py           # write plugin/
    python3 scripts/build-directory-plugin.py --check   # exit 1 if it is out of date
"""

import importlib.util
import io
import json
import os
import re
import shutil
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "plugin")
NAME = "jdlt-product-os"
TITLE = "Product OS by JDLT"
ALLOWED = (".md", ".txt", ".json", ".yaml", ".yml", ".png", ".jpg", ".jpeg")

spec = importlib.util.spec_from_file_location("skill_builder", os.path.join(ROOT, "scripts", "build-plugin-skill.py"))
skill_builder = importlib.util.module_from_spec(spec)
spec.loader.exec_module(skill_builder)

README = """# Product OS by JDLT

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


def clean(text):
    for pattern, replacement in RULES:
        text = re.sub(pattern, replacement, text)
    return text.replace("/product-os:", "/%s:" % NAME)


def after_frontmatter(text, extra):
    """Put a note right after a file's YAML front matter."""
    if text.startswith("---\n"):
        end = text.index("\n---\n", 4) + 5
        return text[:end] + extra + "\n" + text[end:].lstrip("\n")
    return extra.lstrip("\n") + "\n" + text


def build():
    """Return {relative path: text or bytes} for every file in plugin/."""
    files = {}
    version = skill_builder.version()

    for rel, content in skill_builder.build().items():
        if rel == "assets/product-os-board.html":
            rel = "assets/product-os-board.txt"
        else:
            content = clean(content)
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
        for name in sorted(os.listdir(os.path.join(ROOT, folder))):
            if name.endswith(".md"):
                text = io.open(os.path.join(ROOT, folder, name), encoding="utf-8").read()
                files["%s/%s" % (target, name)] = after_frontmatter(clean(text), FIRST)

    with io.open(skill_builder.MANIFEST, encoding="utf-8") as fh:
        root = json.load(fh)
    manifest = {
        "name": NAME,
        "displayName": TITLE,
        "version": version,
        "description": skill_builder.with_version(root["description"].replace("/product-os:", "/%s:" % NAME)),
        "author": root["author"],
        "homepage": root["homepage"],
        "repository": root["repository"],
        "license": root["license"],
    }
    files[".claude-plugin/plugin.json"] = json.dumps(manifest, indent=2, ensure_ascii=False) + "\n"
    with io.open(os.path.join(ROOT, ".claude-plugin", "icon.png"), "rb") as fh:
        files[".claude-plugin/icon.png"] = fh.read()
    files["README.md"] = README.format(name=NAME, version=version)
    files["LICENSE"] = io.open(os.path.join(ROOT, "LICENSE"), encoding="utf-8").read()
    files["NOTICE.md"] = clean(io.open(os.path.join(ROOT, "NOTICE.md"), encoding="utf-8").read())

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


def on_disk():
    found = set()
    for folder, _, names in os.walk(OUT):
        for name in names:
            found.add(os.path.relpath(os.path.join(folder, name), OUT).replace(os.sep, "/"))
    return found


def same(path, content):
    if not os.path.isfile(path):
        return False
    if isinstance(content, bytes):
        return open(path, "rb").read() == content
    return io.open(path, encoding="utf-8").read() == content


def main():
    files = build()
    if "--check" in sys.argv:
        stale = [rel for rel, content in files.items() if not same(os.path.join(OUT, rel), content)]
        extra = sorted(on_disk() - set(files))
        if stale or extra:
            print("plugin/ is out of date: %s" % ", ".join((stale + extra)[:8]))
            print("Run: python3 scripts/build-directory-plugin.py")
            return 1
        print("plugin/ is up to date (%d files)." % len(files))
        return 0
    if os.path.isdir(OUT):
        shutil.rmtree(OUT)
    for rel, content in files.items():
        path = os.path.join(OUT, rel)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        if isinstance(content, bytes):
            with open(path, "wb") as fh:
                fh.write(content)
        else:
            with io.open(path, "w", encoding="utf-8") as fh:
                fh.write(content)
    print("Wrote %d files to plugin/ (%s %s)" % (len(files), NAME, skill_builder.version()))
    return 0


if __name__ == "__main__":
    sys.exit(main())
