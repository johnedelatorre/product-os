#!/usr/bin/env python3
"""
Doc Hygiene Check for Product OS

Keeps specs, Confluence pages, epics and Jira tickets in their current state
only (see .claude/skills/doc-hygiene.md). Standard library only.

Usage:
    python3 scripts/doc-hygiene-check.py lint <file> [<file> ...]
    python3 scripts/doc-hygiene-check.py guard <new> --against <old>
    python3 scripts/doc-hygiene-check.py guard <new> [<new> ...] [--git-ref HEAD]
    python3 scripts/doc-hygiene-check.py guard <new> [<new> ...] --against-dir <dir>

lint   Flags version-history material: version banners and tokens, "kept as
       history" text, superseded TL;DRs, history <details> blocks, change
       narratives, disposition tags (Re-scoped / New / Amended ...), vague TBDs,
       odd code-fence counts, unbalanced <details>, and anchor links that no
       longer resolve. Skips inline code, URLs, API paths, filenames and
       x.y.z library versions. Add <!-- hygiene-ok --> to a line to accept it.
       Exit 1 if anything is flagged.

guard  Invention guard. Word-level diff of a cleaned file against its original;
       lists every inserted run that contains words not present anywhere in the
       original. A cleanup should only delete or minimally reword, so every
       listed run needs a human look before publishing (common function words such
       as "is" or "the" are not listed). Exit 1 if any are found.
       Originals: --against <file> (one new file), --against-dir <dir> (matched
       by filename, e.g. a folder of fetched Jira descriptions), or --git-ref
       <ref> (default HEAD; the committed version of each file).
"""

import argparse
import difflib
import os
import re
import subprocess
import sys

SUPPRESS = "<!-- hygiene-ok -->"

# (rule id, regex, message). Matched case-insensitively against each line after
# inline code, URLs and link targets are removed.
LINE_RULES = [
    ("history-kept", r"\b(kept|retained|preserved|left)\s+(as|for)\s+(history|reference|the record)\b",
     "history kept in the body; delete it (history lives in page/issue history)"),
    ("history-label", r"\((history|kept|old|previous|archived)\)",
     "history label; delete the superseded block"),
    ("history-below", r"\b(text|content|section|version)\s+below\s+(is\s+)?(kept|retained|from)\b",
     "history pointer; delete it and the old text"),
    ("carried-from", r"\bcarried\s+(over\s+)?from\b",
     "carry-over note; delete it"),
    ("version-note", r"\bv\d+(\.\d+)?\s+(note|text|tl;dr|banner|change|update)s?\b",
     "version note; keep still-current content as **Note:**, delete the rest"),
    ("disposition-tag", r"(?:\s[-—–]|[—–])\s*(re-?scoped|new|unchanged|amended|updated|changed|revised)\s*(\(|$)",
     "disposition tag; drop it (keep only Deferred / Parked)"),
    ("disposition-tag", r"\((re-?scoped|new|unchanged|amended|updated|revised)(\s*[,;:]?\s*[A-Z]+-\d+)?\)",
     "disposition tag; drop it (keep only Deferred / Parked)"),
    ("amended-tag", r"\[(amended|updated|changed|revised|new)\b[^\]]*\]",
     "amended tag; apply its wording to the text, then drop the tag"),
    ("change-narrative", r"\b(renamed|changed|switched|migrated)\s+from\b",
     "change narrative; state only the current name/value"),
    ("change-narrative", r"\b(formerly|previously (called|named|known as))\b",
     "change narrative; state only the current name/value"),
    ("change-narrative", r"\bwas\s+[^.;|]{1,60}?,?\s+now\b",
     "change narrative ('was X, now Y'); state only the current value"),
    ("change-narrative", r"\breplaces\s+the\s+(old|previous|original|v\d+|earlier)\b",
     "change narrative; describe the current item only"),
    ("retired-item", r"\b(retired|superseded)\s*(\(|\)|\||:|—|–|$|in\s+[A-Z]+-\d+|by\s+[A-Z]+-\d+|per\s+[A-Z]+-\d+)",
     "retired/superseded item; remove it from current docs (decision logs: title + 'Superseded by DEC-xxx.')"),
    ("retired-item", r"\((dropped|removed)\b|\b(dropped|removed)\s*(\)|\||in\s+[A-Z]+-\d+|by\s+[A-Z]+-\d+|per\s+[A-Z]+-\d+)",
     "retired/removed item; remove it from current docs"),
    ("tbd-source", r"\bTBD\s*\(\s*not\s+(specified|defined|in|covered)",
     "TBD with a source note; say what is undecided and who decides"),
    ("rev-token", r"\brev(ision)?\.?\s*\d+(\.\d+)?\b",
     "revision token; remove it (keep 'Last updated: <date>')"),
]

# A labelled bare TBD: "Platform: TBD", "**Owner:** TBD". In tables the column header names the
# subject, so table cells are not flagged.
VAGUE_TBD = re.compile(r"^\W*[\w ./&-]{1,40}:\W*TBD\W*$", re.IGNORECASE)
# Version tokens like v2, v3.1, (v3). Three-part versions (v1.2.3) are library versions.
VERSION_TOKEN = re.compile(r"(?<![\w./-])\(?v\d+(\.\d+)?\)?(?![\w./-])", re.IGNORECASE)
TLDR_HEADING = re.compile(r"^\s{0,3}#{1,6}\s*TL;?DR\b(.*)$", re.IGNORECASE)
TLDR_LABEL = re.compile(r"\(|\bv\d|\b(kept|old|previous|history|current|latest|new|updated|revised)\b", re.IGNORECASE)
DETAILS_SUMMARY = re.compile(r"<summary>(.*?)</summary>", re.IGNORECASE)
HISTORY_WORDS = re.compile(r"\b(history|previous|old|earlier|v\d+|superseded|changelog|kept)\b", re.IGNORECASE)
FENCE = re.compile(r"^\s{0,3}(```|~~~)")
HEADING = re.compile(r"^\s{0,3}(#{1,6})\s+(.*?)\s*#*\s*$")
ANCHOR_LINK = re.compile(r"\]\(#([^)\s]+)\)")

INLINE_CODE = re.compile(r"`[^`]*`")
URL = re.compile(r"https?://\S+|www\.\S+")
LINK_TARGET = re.compile(r"\]\([^)]*\)")
PATHLIKE = re.compile(r"\S*/\S*|\S+\.(md|json|ya?ml|csv|html?|py|sh|tsx?|jsx?|pdf|png|svg)\b", re.IGNORECASE)


def scrub(line):
    """Remove spans that must never be flagged: inline code, URLs, link targets, paths, filenames."""
    line = INLINE_CODE.sub(" ", line)
    line = URL.sub(" ", line)
    line = LINK_TARGET.sub("]", line)
    line = PATHLIKE.sub(" ", line)
    return line


def slugify(text):
    """GitHub-style heading anchor: link text kept, punctuation dropped, spaces to hyphens."""
    text = re.sub(r"!?\[([^\]]*)\]\([^)]*\)", r"\1", text)
    text = re.sub(r"<[^>]+>", "", text)
    text = text.strip().lower()
    text = re.sub(r"[^\w\- ]", "", text)
    return text.replace(" ", "-")


def lint_file(path):
    hits = []
    try:
        lines = open(path, encoding="utf-8").read().splitlines()
    except (OSError, UnicodeDecodeError) as exc:
        return [(path, 0, "unreadable", str(exc), "")]

    in_fence = False
    fences = 0
    details_open = 0
    details_close = 0
    tldr_lines = []
    heading_counts = {}
    slugs = set()
    anchors = []

    for n, raw in enumerate(lines, 1):
        if FENCE.match(raw):
            fences += 1
            in_fence = not in_fence
            continue
        if SUPPRESS in raw:
            continue
        text = scrub(raw)
        markup = INLINE_CODE.sub(" ", raw)
        if not in_fence:
            details_open += len(re.findall(r"<details\b", markup, re.IGNORECASE))
            details_close += len(re.findall(r"</details>", markup, re.IGNORECASE))
            m = HEADING.match(raw)
            if m:
                base = slugify(m.group(2))
                count = heading_counts.get(base, 0)
                heading_counts[base] = count + 1
                slugs.add(base if count == 0 else f"{base}-{count}")
            for a in ANCHOR_LINK.findall(raw):
                anchors.append((n, a, raw))
            t = TLDR_HEADING.match(raw)
            if t:
                tldr_lines.append(n)
                if TLDR_LABEL.search(t.group(1)):
                    hits.append((path, n, "tldr-label", "TL;DR heading carries a label; use just '## TL;DR'", raw))
            for s in DETAILS_SUMMARY.findall(markup):
                if HISTORY_WORDS.search(s):
                    hits.append((path, n, "history-block", "history <details> block; delete the whole block", raw))
            for v in VERSION_TOKEN.finditer(text):
                hits.append((path, n, "version-token", f"version token '{v.group(0).strip('()')}'; remove it (IDs, paths, filenames and library versions are skipped)", raw))
            if VAGUE_TBD.search(text):
                hits.append((path, n, "vague-tbd", "bare TBD; name exactly what is undecided and who decides, e.g. 'Analytics tool: TBD (owner picks during E10)'", raw))
        for rule, pattern, msg in LINE_RULES:
            if re.search(pattern, text, re.IGNORECASE):
                if rule == "retired-item" and re.search(r"superseded by [A-Z]+-\d+\.?\s*$", text, re.IGNORECASE):
                    continue  # decision-log stub: "Superseded by DEC-0xx."
                hits.append((path, n, rule, msg, raw))

    if len(tldr_lines) > 1:
        hits.append((path, tldr_lines[1], "tldr-duplicate", f"{len(tldr_lines)} TL;DR headings (lines {', '.join(map(str, tldr_lines))}); keep one, the current one", ""))
    if fences % 2:
        hits.append((path, len(lines), "fence-odd", f"odd number of code fences ({fences}); a fence is unbalanced", ""))
    if details_open != details_close:
        hits.append((path, len(lines), "details-unbalanced", f"<details> opened {details_open}x, closed {details_close}x", ""))
    for n, a, raw in anchors:
        if a.lower() not in slugs:
            hits.append((path, n, "anchor-broken", f"anchor '#{a}' matches no heading; fix or remove the link", raw))
    return hits


def cmd_lint(args):
    total = 0
    for path in args.files:
        hits = lint_file(path)
        total += len(hits)
        for p, n, rule, msg, raw in hits:
            print(f"{p}:{n}: [{rule}] {msg}")
            if raw:
                print(f"    {raw.strip()[:160]}")
    files = len(args.files)
    if total:
        print(f"\n{total} hygiene hit(s) in {files} file(s). Fix each, or add {SUPPRESS} to a line that is correct as written.")
        return 1
    print(f"Clean: {files} file(s), no hygiene hits.")
    return 0


WORD = re.compile(r"\S+")
# Function words a minimal reword may add ("was called X, now Y" -> "is called Y") plus the
# prescribed **Note:** label. Everything else that is new gets listed for review.
REWORD_WORDS = {"a", "an", "the", "is", "are", "be", "it", "its", "this", "that", "these", "those",
                "and", "or", "of", "to", "for", "in", "on", "at", "by", "with", "as", "from", "note"}


def norm(word):
    return word.strip("*_`~.,;:!?()[]{}\"'|<>").lower()


def novel_insertions(old, new):
    a, b = WORD.findall(old), WORD.findall(new)
    known = {norm(w) for w in a}
    out = []
    for op, _i1, _i2, j1, j2 in difflib.SequenceMatcher(None, a, b, autojunk=False).get_opcodes():
        if op in ("insert", "replace"):
            run = b[j1:j2]
            novel = [w for w in run if norm(w) and norm(w) not in known and norm(w) not in REWORD_WORDS]
            if novel:
                out.append((" ".join(run), " ".join(novel)))
    return len(a), len(b), out


def read_git(path, ref):
    directory = os.path.dirname(os.path.abspath(path))
    res = subprocess.run(["git", "show", f"{ref}:./{os.path.basename(path)}"],
                         cwd=directory, capture_output=True, text=True)
    if res.returncode != 0:
        raise ValueError(f"no {ref} version of {path}: {res.stderr.strip()}")
    return res.stdout


def cmd_guard(args):
    if args.against and len(args.files) != 1:
        print("--against takes exactly one new file; use --against-dir or --git-ref for several.", file=sys.stderr)
        return 2
    flagged = 0
    for path in args.files:
        try:
            if args.against:
                old = open(args.against, encoding="utf-8").read()
            elif args.against_dir:
                old = open(os.path.join(args.against_dir, os.path.basename(path)), encoding="utf-8").read()
            else:
                old = read_git(path, args.git_ref)
            new = open(path, encoding="utf-8").read()
        except (OSError, ValueError) as exc:
            print(f"== {path}: cannot compare ({exc})")
            flagged += 1
            continue
        before, after, adds = novel_insertions(old, new)
        flagged += len(adds)
        print(f"== {path}: {before} -> {after} words, {len(adds)} insertion(s) with new words")
        for run, novel in adds:
            print(f"   + {run[:200]}")
            print(f"     new words: {novel[:120]}")
    if flagged:
        print(f"\n{flagged} insertion(s) to review. Each must be a minimal reword of existing text, never a new fact.")
        return 1
    print("\nNo new words inserted.")
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(
        prog="doc-hygiene-check.py",
        description="Keep docs and tickets in their current state only (see .claude/skills/doc-hygiene.md).")
    sub = parser.add_subparsers(dest="command", required=True)

    lint = sub.add_parser("lint", help="flag version-history material and broken structure")
    lint.add_argument("files", nargs="+")
    lint.set_defaults(func=cmd_lint)

    guard = sub.add_parser("guard", help="list inserted words that the original never contained")
    guard.add_argument("files", nargs="+", help="cleaned file(s)")
    source = guard.add_mutually_exclusive_group()
    source.add_argument("--against", help="original file (one cleaned file only)")
    source.add_argument("--against-dir", help="folder of originals, matched by filename")
    source.add_argument("--git-ref", default="HEAD", help="git ref holding the originals (default HEAD)")
    guard.set_defaults(func=cmd_guard)

    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
