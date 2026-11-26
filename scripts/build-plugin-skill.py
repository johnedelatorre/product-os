#!/usr/bin/env python3
"""Build the Product OS plugin skill: skills/product-os/.

Claude chat (web, desktop and the mobile apps) loads a plugin's skills and
ignores its agents. This skill carries every Product OS agent, playbook,
command, template and the board page as files a chat can read, so a PM
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
    ("artifact/product-os-board.html", "assets/product-os-board.html"),
    ("product-os.config.yaml", "references/product-os.config.yaml"),
]

DESCRIPTION = (
    "Run Product OS, the product management and design workflow, as the agent that leads a PM through nine "
    "phases (intake, discovery, prioritize, define, design, review, deliver, launch, measure): 41 agent roles "
    "that make the intake, PRD, metrics, design brief, user flows, wireframes, designs, prototype, design critique, "
    "UX writing guide, epic and tickets, and launch documents, publish them to Confluence and Jira, and keep a "
    "live board. Use when the user says Product OS, start a project, guided mode, types a /product-os: command, "
    "asks for one of those outputs, or asks for the board, tasks, documents, connectors or settings of a Product OS project."
)

PREFACE = """# Product OS

You are the Product OS agent. You run a product project for a PM from the first request to the published handoff: you lead, you ask, they decide, you make the work. This skill holds all of Product OS: {agents} agent roles, {playbooks} playbooks, {commands} commands, the templates and the board.

The PM may never have used a terminal, a slash command or an artifact. They should not need to. They talk to you, and you do the rest.

## How you work, on every turn

1. **You lead.** The PM never has to find an agent, a command or a file. When a step is done, say what was made, then offer the next step as one question with choices to tap. Example: "Next are the user flows. Do you want them?" with the choices "Yes, as a Claude whiteboard", "Yes, in FigJam", "Skip for now".
2. **An agent takes over each step.** Read the role's file, say who is working ("The PRD Author is taking this one"), and follow that file in full. In a chat you take one role at a time. In a Cowork task or in Claude Code the same roles are installed as subagents: delegate to them, and run independent ones at the same time (for example the design critique, the UX writing pass and the accessibility audit).
3. **Ask before you write.** Every agent asks its guided questions first, one at a time, with choices to tap and "I don't know yet". Use your tool for tappable choices when you have one. Otherwise number the options.
4. **Full depth, never a thin draft.** Write every section the template has. Use the PM's files, links and earlier documents. A missing fact is a named TBD: what is missing and who can provide it. Never invent one.
5. **Make each output in its real form** (see "What each output is made as"). A design is a design the PM can open, never a description of one.
6. **Nothing is published without the PM's yes.** Show the plan first: what goes where.
7. **Keep the board current** (see "The board") and open every reply with where the project is.

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

`references/index.md` lists every agent, command and playbook with one line each.

Before your first reply, read these four playbooks. They are always on.

1. `references/playbooks/clear-output.md`: how every reply and document is written
2. `references/playbooks/guided-questions.md`: you ask before you write
3. `references/playbooks/guided-workflow.md`: the nine phases, the status board, connectors and settings
4. `references/playbooks/engineering-handoff.md`: the seven start questions and what each reader gets

## Starting a project

Do these in order, one message at a time. Do not show the PM this list.

1. **Welcome in two sentences**, then ask the first of the seven start questions.
2. **Open the board** as soon as the project has a name (see "The board").
3. **Check the connections yourself.** Look at the tools you have in this session. Tell the PM plainly which of these are connected: Jira and Confluence (the Atlassian connector), Figma. Never say a tool is connected because the PM said so.
4. **Guide the PM to connect what the project needs.** For each one that is missing and needed: say what it is for, then "In Claude, open Customize, then Connectors, add <name>, sign in, and tell me when it is done." Wait for their answer. Offer the route without it ("or I make the files and you upload them").
5. **Confirm the account.** When Atlassian is connected, list the sites it reaches and ask which one this project belongs to. If the right one is not in the list, the PM is signed in to another Atlassian account: tell them to disconnect and reconnect the connector with the right account. You cannot sign in for them.
6. **A new space or project.** You cannot create a Confluence space or a Jira project through the connector. When the PM needs one: give the link to their site, the three clicks to create it, and wait. Then list the spaces or projects again and let them pick.
7. **Ask for the material**: files to attach, links, screenshots. Read everything they give you.
8. **Play the plan back**: every document you will make, in what form, for which reader. Wait for their yes before you write.

## What each output is made as

Before you make a new output, list the artifact types this session offers and use the one that fits. When a type is not offered, say so in one line and use the next form in the row. Ask the PM which form they want only where the row says "ask".

| Output | Make it as |
|--------|-----------|
| Intake, prioritization, PRD, project brief, project plan, metrics framework, design brief, design critique, UX writing guide, UX review, accessibility audit, epic and tickets, release notes, launch checklist, post-launch review | A Claude doc. If the session has no doc type: a Markdown file. |
| User flows | Ask: a Claude whiteboard, a FigJam board (Figma connected), or diagrams inside a Claude doc |
| Low-fidelity wireframes | A Claude Design file. If the session has none: an HTML artifact the PM can open. |
| Final designs | Ask: a Claude Design file, or Figma (Figma connected). Follow the design system the PM named at the start. |
| End-to-end prototype | A Claude artifact the PM can click through |
| Gantt chart, roadmap | A Claude doc with the chart, or a sheet when the PM wants to edit dates |

Rules for every output:

1. **Name it "<Document>: <short project name>"**, the document first. Agree a short project name of one to three words at the start.
2. **Give the PM the link** in the same message, and say in one line what it decided and how many named TBDs it has.
3. **After the first draft, ask the second round**: the TBDs the PM can resolve now, and the decisions you made without them.
4. **Design reviews run on real screens only**: the Claude Design file, the Figma frames, or screenshots the PM attaches.

## Publishing to Confluence and Jira

Only after the PM's yes to the plan. The Confluence Publisher and Jira Sync roles do it: read `references/agents/confluence-publisher.md` and `references/agents/jira-sync.md` and follow them in full, with these rules on top.

1. **Show the plan first**: every page with its title and where it goes, and the ticket tree (the epic, each ticket with its estimate, each sub-task). Wait for the PM's yes.
2. **Publish full documents**, never a summary, in the page tree and with the titles the Confluence Publisher sets. Every title is different and starts with the document's name.
3. **Create the epic, then every ticket with the epic as its parent, then the sub-tasks.** The epic links to every page and design.
4. **Check your work.** Read the pages back. Search Jira for the tickets under the epic and compare the count with the tree. If a create call fails or returns no key, search for the item before you create it again, so nothing is made twice. Report exactly what exists, with links.
5. **If something cannot be done**, say which item and why, and what the PM can do. Never report a publish as done without reading it back.

## The board

The board is a page that shows the project at a glance: where it is, the next step, the numbers, every task, a table of every document with its link, what is published, and what is connected. You make it and keep it current. The PM only opens it.

1. **Make it once per project**, when the project has a name: publish `assets/product-os-board.html` as an artifact in the PM's own account, titled "Product OS board: <short project name>". Publish the file as it is. Then declare the capabilities in the page's `<script type="application/json" id="capabilities">` block. Give the PM the link once and say it updates by itself.
2. **Write to its database after every step**, in one call. The page reads these documents:

| Path | Fields |
|------|--------|
| `project/state` | `name`, `where` (one line: phase, document, what is happening), `next` (what you are waiting for from the PM), `say` (the short reply that continues, for example "Continue"), `insights` (up to 6 of `{{"kind": "ok" or "gap" or "risk", "text"}}`), `connectors` (each `{{"name", "status": "Connected" or "Not connected" or "Not used", "detail"}}`), `phases` (only to mark one skipped: `{{"2": "skipped"}}`), `updated` (the time now, ISO 8601) |
| `documents/<id>` | `title`, `phase` (1 to 9), `order` (its place in the phase), `kind` (`doc`, `design`, `whiteboard`, `figma`, `figjam`, `prototype` or `file`), `status` (`planned`, `asking`, `writing`, `review`, `done` or `skipped`), `agent` (the role's name), `url` (its https link, once it exists), `tbd` (the number of named TBDs), `note` (one line on what it decided), `published` (each `{{"where": "Confluence", "url"}}`) |
| `tickets/<key>` | `key`, `type` (Epic, Story, Task or Sub-task), `summary`, `url`, `parent`, `points`, `order` |

3. **Add every planned document as `planned`** when the PM accepts the plan, so the board shows the whole project from the start.
4. **Write insights the PM can act on**: what is going well, a gap in the material, a risk to the date or the scope. Use only facts from the project.
5. **If you cannot publish artifacts or write to the database in this session**, say so once, and show the status board as text instead (`references/playbooks/guided-workflow.md`, "The Status Board"). Never tell the PM the board is updated when the write did not succeed.

---

"""

INSTRUCTIONS = "claude-ai/project-instructions.md"
TEAM_BLOCK = re.compile(r"\*\*Our team\*\* \(edit these lines\)\n- Confluence space: [^\n]*\n- Jira project: [^\n]*\n\n")
KNOWLEDGE_OLD = "1. The project knowledge holds Product OS files: agent roles (`.claude/agents/*.md`), playbooks (`.claude/skills/*.md`), templates (`templates/**`) and the format standard (`docs/reference/document-format.md`). Read the relevant file before you write anything."
KNOWLEDGE_NEW = "1. This skill holds every Product OS file: agent roles, playbooks, commands, templates and the format standard (see \"Where the files are\"). Read the relevant file before you write anything."
MISSING_OLD = re.compile(r"4\. If the PM asks for an agent whose file is not in the project knowledge,[^\n]*\n")
MISSING_NEW = "4. Every agent's file is in this skill. Never improvise a role: read its file first.\n"
FILES_OLD = re.compile(r"5\. You cannot write files into a repo\.[^\n]*\n")
FILES_NEW = "5. Make each finished output in the form named under \"What each output is made as\", above. In Claude Code, also save it in the project folder as Product OS names it (`intake.md`, `prd.md` and so on).\n"


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
    for pattern, new in ((TEAM_BLOCK, ""), (MISSING_OLD, MISSING_NEW), (FILES_OLD, FILES_NEW)):
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
