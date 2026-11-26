#!/usr/bin/env python3
"""Build the Product OS workspace page: artifact/product-os.html.

The workspace is one self-contained HTML page. It runs all nine phases inside
a Claude artifact: the guide asks, each agent writes its document, and the
board tracks every task. To do that the page carries every agent, playbook,
command and template as data.

The page's code is artifact/src/workspace.html. This script puts the Product OS
files into it. Edit the source or the Product OS files, then run the script.

Usage:
    python3 scripts/build-workspace.py           # write artifact/product-os.html
    python3 scripts/build-workspace.py --check   # exit 1 if it is out of date
"""
import io
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "artifact", "src", "workspace.html")
OUT = os.path.join(ROOT, "artifact", "product-os.html")
MARK = "__PRODUCT_OS_DATA__"


def read(path):
    with io.open(path, encoding="utf-8") as fh:
        return fh.read()


def folder(rel, nested=False):
    base = os.path.join(ROOT, rel)
    out = {}
    for where, _, names in sorted(os.walk(base)):
        for name in sorted(names):
            if not name.endswith(".md"):
                continue
            full = os.path.join(where, name)
            key = os.path.relpath(full, base).replace(os.sep, "/")
            out[key if nested else key[:-3]] = read(full)
    return out


def description(text):
    m = re.match(r"---\n(.*?)\n---\n", text, re.S)
    d = re.search(r'^description:\s*"?(.*?)"?\s*$', m.group(1), re.M) if m else None
    return d.group(1).strip() if d else ""


def data():
    agents = folder(".claude/agents")
    commands = folder(".claude/commands")
    return {
        "agents": agents,
        "playbooks": folder(".claude/skills"),
        "commands": commands,
        "templates": folder("templates", nested=True),
        "docs": folder("docs/reference", nested=True),
        "about": {
            "agents": {k: description(v) for k, v in agents.items()},
            "commands": {k: description(v) for k, v in commands.items()},
        },
    }


def check_catalog(src, bundle):
    """Every agent and template the page names must exist in the bundle."""
    missing = []
    for name in re.findall(r'agent: "([a-z0-9-]+)"', src):
        if name not in bundle["agents"]:
            missing.append("agent " + name)
    for block in re.findall(r"tpl: \[([^\]]*)\]", src):
        for name in re.findall(r'"([^"]+)"', block):
            if name not in bundle["templates"]:
                missing.append("template " + name)
    if missing:
        raise SystemExit("build-workspace: the page names files that do not exist: " + ", ".join(sorted(set(missing))))


def build():
    src = read(SRC)
    if src.count(MARK) != 1:
        raise SystemExit("build-workspace: %s must contain %s exactly once" % (SRC, MARK))
    bundle = data()
    check_catalog(src, bundle)
    # JSON inside a <script> block: every "<" is written as < so no tag can close it.
    text = json.dumps(bundle, ensure_ascii=False, separators=(",", ":")).replace("<", "\\u003c")
    return src.replace(MARK, text)


def main():
    page = build()
    if "--check" in sys.argv:
        if not os.path.isfile(OUT) or read(OUT) != page:
            print("artifact/product-os.html is out of date.")
            print("Run: python3 scripts/build-workspace.py")
            return 1
        print("artifact/product-os.html is up to date.")
        return 0
    with io.open(OUT, "w", encoding="utf-8") as fh:
        fh.write(page)
    print("Wrote artifact/product-os.html (%d KB)" % (len(page.encode("utf-8")) // 1024))
    return 0


if __name__ == "__main__":
    sys.exit(main())
