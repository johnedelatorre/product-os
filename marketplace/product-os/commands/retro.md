---
description: "Facilitate retrospective and capture learnings."
argument-hint: "--context \"<what we're reflecting on>\""
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /product-os:retro

Facilitate retrospective and capture learnings.

## Usage
```
/product-os:retro --context "<what we're reflecting on>"
```

## Output
- `retro.md` — What went well/poorly, learnings, actions

## Agent
Uses: `retro-facilitator.md`
