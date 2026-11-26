---
description: "Create Now/Next/Later roadmap."
argument-hint: "--items <prioritized-items>"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:roadmap

Create Now/Next/Later roadmap.

## Usage
```
/jdlt-product-os:roadmap --items <prioritized-items>
```

## Output
- `roadmap.md` — Now/Next/Later roadmap with Mermaid Gantt

## Agent
Uses: `roadmap-agent.md`
