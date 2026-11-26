---
description: "Write Amazon-style PR/FAQ."
argument-hint: "--product \"<name>\" --customer \"<who>\" --benefit \"<why>\""
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /product-os:prfaq

Write Amazon-style PR/FAQ.

## Usage
```
/product-os:prfaq --product "<name>" --customer "<who>" --benefit "<why>"
```

## Output
- `prfaq.md` — Press release + FAQ

## Agent
Uses: `prfaq-author.md`
