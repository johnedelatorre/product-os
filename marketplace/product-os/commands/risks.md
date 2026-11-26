---
description: "Create and maintain risk register."
argument-hint: "--from <prd.md|project-plan.md>"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /product-os:risks

Create and maintain risk register.

## Usage
```
/product-os:risks --from <prd.md|project-plan.md>
```

## Output
- `risk-register.md` — Risks with probability, impact, mitigations

## Agent
Uses: `risk-manager.md`
