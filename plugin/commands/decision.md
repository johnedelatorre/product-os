---
description: "Log a product decision (ADR style)."
argument-hint: "--title \"<title>\" --options \"<options>\" --decision \"<outcome>\""
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:decision

Log a product decision (ADR style).

## Usage
```
/jdlt-product-os:decision --title "<title>" --options "<options>" --decision "<outcome>"
```

## Output
- `decisions/DEC-XXX.md` — Individual decision record
- Updates `decision-log.md`

## Agent
Uses: `decision-logger.md`
