#!/usr/bin/env python3
"""Build the ChatGPT knowledge pack: Product OS files bundled into 8 Markdown files.

A ChatGPT Project holds 5, 25 or 40 files depending on the plan, and a custom GPT
holds 20. The pack keeps the core path under every paid limit.

Usage:
    python3 scripts/build-chatgpt-pack.py           # write chatgpt/pack/
    python3 scripts/build-chatgpt-pack.py --check   # exit 1 if chatgpt/pack/ is out of date
"""
import io
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "chatgpt", "pack")

PACK = [
    ("01-how-to-work.md", "How Product OS works: output style, questions, document hygiene", [
        ".claude/skills/clear-output.md",
        ".claude/skills/guided-questions.md",
        ".claude/skills/doc-hygiene.md",
    ]),
    ("02-guided-workflow.md", "The nine phases and the guide", [
        ".claude/skills/guided-workflow.md",
        ".claude/agents/guide.md",
    ]),
    ("03-handoff.md", "The start questions, the engineering handoff and UX writing", [
        ".claude/skills/engineering-handoff.md",
        ".claude/skills/ux-writing.md",
        ".claude/agents/delivery-agent.md",
    ]),
    ("04-pm-agents.md", "Product management roles", [
        ".claude/agents/intake-analyst.md",
        ".claude/agents/prd-author.md",
        ".claude/agents/project-brief.md",
        ".claude/agents/metrics-designer.md",
    ]),
    ("05-design-agents.md", "Design roles", [
        ".claude/agents/product-designer.md",
        ".claude/agents/flow-designer.md",
        ".claude/agents/wireframer.md",
        ".claude/agents/prototyper.md",
    ]),
    ("06-review-agents.md", "Review roles: critique, UX writing, UX review, accessibility", [
        ".claude/agents/design-critic.md",
        ".claude/agents/ux-writer.md",
        ".claude/agents/ux-reviewer.md",
        ".claude/agents/accessibility-auditor.md",
    ]),
    ("07-document-format.md", "The standard document, epic and ticket formats", [
        "docs/reference/document-format.md",
    ]),
    ("08-templates.md", "Templates", [
        "templates/pm/prd.md",
        "templates/pm/project-brief.md",
        "templates/pm/metrics-framework.md",
        "templates/design/design-brief.md",
        "templates/design/design-critique.md",
        "templates/design/ux-writing-guide.md",
        "templates/delivery/epic.md",
        "templates/delivery/user-story.md",
    ]),
]


def build():
    files = {}
    for name, title, sources in PACK:
        parts = [
            "# Product OS pack: %s" % title,
            "",
            "Bundled from the Product OS repo for ChatGPT. Each section below is one Product OS file.",
            "Its path is on the line that starts with `FILE:`. Instructions that name a path mean that section.",
            "",
            "Contents:",
        ]
        parts += ["- `%s`" % s for s in sources]
        for s in sources:
            with io.open(os.path.join(ROOT, s), encoding="utf-8") as fh:
                body = fh.read().rstrip("\n")
            parts += ["", "---", "", "FILE: `%s`" % s, "", body]
        files[name] = "\n".join(parts) + "\n"
    return files


def main():
    files = build()
    if "--check" in sys.argv:
        stale = []
        for name, content in files.items():
            path = os.path.join(OUT, name)
            if not os.path.isfile(path) or io.open(path, encoding="utf-8").read() != content:
                stale.append(name)
        extra = [f for f in os.listdir(OUT) if f not in files] if os.path.isdir(OUT) else []
        if stale or extra:
            print("ChatGPT pack is out of date: %s" % ", ".join(stale + extra))
            print("Run: python3 scripts/build-chatgpt-pack.py")
            return 1
        print("ChatGPT pack is up to date (%d files)." % len(files))
        return 0
    os.makedirs(OUT, exist_ok=True)
    for f in os.listdir(OUT):
        if f not in files:
            os.remove(os.path.join(OUT, f))
    for name, content in files.items():
        with io.open(os.path.join(OUT, name), "w", encoding="utf-8") as fh:
            fh.write(content)
    print("Wrote %d files to chatgpt/pack/" % len(files))
    return 0


if __name__ == "__main__":
    sys.exit(main())
