---
description: "Create a one-page executive project brief."
argument-hint: "--from <prd.md>"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /product-os:brief

Create a one-page executive project brief.

## Usage

```
/product-os:brief --from <prd.md>
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | Path to PRD |
| `--output` | No | Output path (default: `project-brief.md`) |

## Output

Generates one-page `project-brief.md` with:
- Problem (2-3 sentences)
- Why now
- Goals and success metrics
- Scope (in/out)
- Users
- Stakeholders
- Timeline
- Risks
- Links

## Example

```
/product-os:brief --from prd.md
```

## Agent

Uses: `project-brief.md`

## Constraint

Must fit on one printed page (~500-600 words).
