---
description: "Structure a raw requirement into a problem/opportunity statement."
argument-hint: "--input \"<requirement>\" [--source \"<source>\"]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:intake

Structure a raw requirement into a problem/opportunity statement.

## Usage

```
/jdlt-product-os:intake --input "<requirement>" [--source "<source>"]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--input` | Yes | Raw requirement text or file path |
| `--source` | No | Source attribution (who, when, context) |
| `--context` | No | Files or links with background: proposals, emails, tickets, existing PRDs, tech stack and schema documents, existing designs. Comma-separated |
| `--output` | No | Output path (default: `intake.md`) |

## Output

Generates `intake.md` with:
- Problem statement (neutral, not solution-biased)
- Evidence and supporting data
- Affected users and segments
- Business impact hypothesis
- Open questions for PM

## Example

```
/jdlt-product-os:intake \
  --input "CEO wants us to add Apple Pay to checkout" \
  --source "Leadership meeting, Nov 2026"
```

## Agent

Uses: `intake-analyst.md`

## Quality Checklist

- [ ] Problem is stated neutrally
- [ ] Source is documented
- [ ] Evidence is captured
- [ ] Users are identified
- [ ] Questions are listed
