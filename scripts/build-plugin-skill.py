#!/usr/bin/env python3
"""Build the Product OS plugin skill: skills/product-os/.

Claude chat (web, desktop and the mobile apps) loads a plugin's skills and
ignores its agents. This skill carries every Product OS agent, playbook,
command, template and the visual workspace as files a chat can read, so a PM
who adds the plugin to their own Claude account has all of Product OS there.

The canonical content stays in .claude/, templates/, docs/reference/ and
artifact/. Everything under skills/product-os/ is generated: do not edit it.
The script also lists every agent file in .claude-plugin/plugin.json, so that
Cowork and Claude Code register all of them as subagents.

Usage:
    python3 scripts/build-plugin-skill.py           # write skills/product-os/
    python3 scripts/build-plugin-skill.py --check   # exit 1 if it is out of date
"""
import io
import json
import os
import re
import shutil
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "skills", "product-os")
MANIFEST = os.path.join(ROOT, ".claude-plugin", "plugin.json")

# (source folder, folder inside the skill, extensions)
TREES = [
    (".claude/agents", "references/agents", (".md",)),
    (".claude/skills", "references/playbooks", (".md",)),
    (".claude/commands", "references/commands", (".md",)),
    ("templates", "references/templates", (".md", ".yaml", ".yml", ".json", ".html")),
    ("docs/reference", "references/docs", (".md",)),
]
SINGLE = [
    ("artifact/product-os.html", "assets/product-os.html"),
    ("product-os.config.yaml", "references/product-os.config.yaml"),
]

DESCRIPTION = (
    "Run Product OS, the product management and design workflow: guided mode through nine phases "
    "(intake, discovery, prioritize, define, design, review, deliver, launch, measure), with 41 agent roles "
    "that write the intake, PRD, metrics, design brief, flows, wireframes, prototype, design critique, "
    "UX writing guide, epics and tickets, and launch documents. Use when the user says Product OS, "
    "guided mode, types a /product-os: command, asks for one of those documents, asks for the board, "
    "tasks, docs, connectors or settings of a Product OS project, or asks to open the Product OS workspace."
)

PREFACE = """# Product OS

Product OS is a product management and design workflow. You run it for the PM: you ask, they decide, you write. This skill holds all of it: {agents} agent roles, {playbooks} playbooks, {commands} commands, the templates and the visual workspace.

## Where the files are

Product OS files name each other by their path in the Product OS repo. In this skill the same files sit under `references/`. Read a file before you act on it.

| A path in Product OS | The file in this skill |
|----------------------|------------------------|
| `.claude/agents/<name>.md` | `references/agents/<name>.md` |
| `.claude/skills/<name>.md` | `references/playbooks/<name>.md` |
| `.claude/commands/<name>.md` and `/product-os:<name>` | `references/commands/<name>.md` |
| `templates/<folder>/<name>` | `references/templates/<folder>/<name>` |
| `docs/reference/<name>.md` | `references/docs/<name>.md` |
| `product-os.config.yaml` | `references/product-os.config.yaml` (the defaults) |

`references/index.md` lists every agent, command and playbook with one line each. Open it when you need to find the right one.

## Before your first reply

Read these four playbooks. They are always on.

1. `references/playbooks/clear-output.md`: how every reply and document is written
2. `references/playbooks/guided-questions.md`: you ask before you write, with quick replies
3. `references/playbooks/guided-workflow.md`: the nine phases, the status board, the phone views, connectors and settings
4. `references/playbooks/engineering-handoff.md`: the seven start questions and what each reader gets

## Where you are running

1. **In a chat** (web, desktop app, phone): you take one agent role at a time. Read the role's file, say which role you are using, and follow it. You cannot write into a repo, so give each document as a file the PM can keep.
2. **In a Cowork task or in Claude Code**: the same agents are also installed as subagents, and the commands run as `/product-os:<name>`. Delegate to them as `references/commands/<name>.md` says.

## The workspace page

Product OS has a workspace page with a UI: the conversation with the guide beside a board of every task. It runs all nine phases itself and writes each document through Claude.

When the PM asks to open the workspace, the UI, the board as a page, or the visual start:

1. Publish `assets/product-os.html` as an artifact in the PM's own account, titled "Product OS". Publish the file as it is. Do not rewrite it.
2. Declare these capabilities for it: `sample` with images (`{{"sample": {{"images": true}}}}`) and `downloads`. The page writes its documents through `sample`; without it the page only asks the start questions and tracks documents.
3. Give the PM the link. It is their artifact, private to them until they share it.

If you cannot publish artifacts in this session, say so and send the file.

## The team's setup

Ask for the Confluence space and the Jira project when they are first needed, and show them under Connectors and settings. There is no config file in a chat: keep the values the PM gave, and write them into the `progress.yaml` you hand back.

---

"""

INSTRUCTIONS = "claude-ai/project-instructions.md"
TEAM_BLOCK = re.compile(r"\*\*Our team\*\* \(edit these lines\)\n- Confluence space: [^\n]*\n- Jira project: [^\n]*\n\n")
KNOWLEDGE_OLD = "1. The project knowledge holds Product OS files: agent roles (`.claude/agents/*.md`), playbooks (`.claude/skills/*.md`), templates (`templates/**`) and the format standard (`docs/reference/document-format.md`). Read the relevant file before you write anything."
KNOWLEDGE_NEW = "1. This skill holds every Product OS file: agent roles, playbooks, commands, templates and the format standard (see \"Where the files are\"). Read the relevant file before you write anything."
MISSING_OLD = re.compile(r"4\. If the PM asks for an agent whose file is not in the project knowledge,[^\n]*\n")
MISSING_NEW = "4. Every agent's file is in this skill. Never improvise a role: read its file first.\n"


def read(rel):
    with io.open(os.path.join(ROOT, rel), encoding="utf-8") as fh:
        return fh.read()


def frontmatter_description(text):
    m = re.match(r"---\n(.*?)\n---\n", text, re.S)
    if not m:
        return ""
    d = re.search(r'^description:\s*"?(.*?)"?\s*$', m.group(1), re.M)
    return d.group(1).strip() if d else ""


def first_line(text):
    for line in text.splitlines():
        line = line.strip()
        if line.startswith(">"):
            return re.sub(r"\*\*TL;DR:\*\*\s*", "", line.lstrip("> ")).strip()
    for line in text.splitlines():
        line = line.strip()
        if line and not line.startswith(("#", "---", "name:", "description:")):
            return line
    return ""


def clip(text, n=150):
    text = " ".join(text.split())
    return text if len(text) <= n else text[: n - 1].rstrip() + "…"


def build():
    files = {}
    counts = {}
    for src, dst, exts in TREES:
        base = os.path.join(ROOT, src)
        n = 0
        for folder, _, names in sorted(os.walk(base)):
            for name in sorted(names):
                if not name.endswith(exts):
                    continue
                full = os.path.join(folder, name)
                rel = os.path.relpath(full, base).replace(os.sep, "/")
                with io.open(full, encoding="utf-8") as fh:
                    files[dst + "/" + rel] = fh.read()
                n += 1
        counts[dst] = n
    for src, dst in SINGLE:
        files[dst] = read(src)

    index = ["# Product OS index", "", "Every agent, command and playbook in this skill, with one line each.", ""]
    for title, dst, describe in (
        ("Agents", "references/agents", frontmatter_description),
        ("Commands", "references/commands", frontmatter_description),
        ("Playbooks", "references/playbooks", first_line),
    ):
        index += ["## %s" % title, ""]
        for path in sorted(p for p in files if p.startswith(dst + "/")):
            index.append("- `%s`: %s" % (path, clip(describe(files[path]) or first_line(files[path]))))
        index.append("")
    files["references/index.md"] = "\n".join(index)

    body = read(INSTRUCTIONS).split("\n---\n", 1)[1].lstrip("\n")
    for pattern, new in ((TEAM_BLOCK, ""), (MISSING_OLD, MISSING_NEW)):
        body, n = pattern.subn(new, body)
        if n != 1:
            raise SystemExit("build-plugin-skill: %s changed; update the pattern %r" % (INSTRUCTIONS, pattern.pattern[:40]))
    if body.count(KNOWLEDGE_OLD) != 1:
        raise SystemExit("build-plugin-skill: %s changed; update KNOWLEDGE_OLD" % INSTRUCTIONS)
    body = body.replace(KNOWLEDGE_OLD, KNOWLEDGE_NEW)
    body = body.replace("in the project knowledge", "in this skill").replace("the project knowledge", "this skill")
    preface = PREFACE.format(
        agents=counts["references/agents"], playbooks=counts["references/playbooks"], commands=counts["references/commands"]
    )
    assert '"' not in DESCRIPTION and len(DESCRIPTION) <= 1024
    files["SKILL.md"] = '---\nname: product-os\ndescription: "%s"\n---\n\n%s%s' % (DESCRIPTION, preface, body)
    return files


def manifest_text():
    """plugin.json with every agent file listed, so Cowork and Claude Code register all of them."""
    with io.open(MANIFEST, encoding="utf-8") as fh:
        data = json.load(fh)
    data["agents"] = ["./.claude/agents/" + n for n in sorted(os.listdir(os.path.join(ROOT, ".claude", "agents"))) if n.endswith(".md")]
    return json.dumps(data, indent=2, ensure_ascii=False) + "\n"


def on_disk():
    found = set()
    for folder, _, names in os.walk(OUT):
        for name in names:
            found.add(os.path.relpath(os.path.join(folder, name), OUT).replace(os.sep, "/"))
    return found


def main():
    files = build()
    if "--check" in sys.argv:
        stale = []
        for rel, content in files.items():
            path = os.path.join(OUT, rel)
            if not os.path.isfile(path) or io.open(path, encoding="utf-8").read() != content:
                stale.append(rel)
        extra = sorted(on_disk() - set(files))
        if io.open(MANIFEST, encoding="utf-8").read() != manifest_text():
            stale.append(".claude-plugin/plugin.json (agents list)")
        if stale or extra:
            print("skills/product-os is out of date: %s" % ", ".join((stale + extra)[:8]))
            print("Run: python3 scripts/build-plugin-skill.py")
            return 1
        print("skills/product-os is up to date (%d files)." % len(files))
        return 0
    if os.path.isdir(OUT):
        shutil.rmtree(OUT)
    for rel, content in files.items():
        path = os.path.join(OUT, rel)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with io.open(path, "w", encoding="utf-8") as fh:
            fh.write(content)
    text = manifest_text()
    with io.open(MANIFEST, "w", encoding="utf-8") as fh:
        fh.write(text)
    print("Wrote %d files to skills/product-os/ and the agents list in plugin.json" % len(files))
    return 0


if __name__ == "__main__":
    sys.exit(main())
