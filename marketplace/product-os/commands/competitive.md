---
description: "Create competitive analysis."
argument-hint: "--competitors <list> --features <list>"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /product-os:competitive

Create competitive analysis.

## Usage
```
/product-os:competitive --competitors <list> --features <list>
```

## Output
- `competitive-analysis.md` — Profiles, feature matrix, SWOT

## Agent
Uses: `competitive-analyst.md`
