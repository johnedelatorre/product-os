---
description: "Generate stakeholder communications."
argument-hint: "--type <exec-summary|update|release-notes|launch> --from <artifacts>"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /product-os:comms

Generate stakeholder communications.

## Usage
```
/product-os:comms --type <exec-summary|update|release-notes|launch> --from <artifacts>
```

## Types
- `exec-summary` — One-page executive summary
- `update` — Stakeholder status update
- `release-notes` — Customer-facing changelog
- `launch` — Launch announcement
- `checklist` — Launch readiness checklist

## Agent
Uses: `stakeholder-comms.md`
