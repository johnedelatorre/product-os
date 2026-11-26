---
description: "Manage technical and design debt tracker."
argument-hint: "[--project <path>] [--action <action>] [--type <type>]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /product-os:debt

Manage technical and design debt tracker.

## Usage

```
/product-os:debt [--project <path>] [--action <action>] [--type <type>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--project` | No | Project scope (or all) |
| `--action` | No | `add`, `update`, `report` (default: `report`) |
| `--type` | For add | `tech` or `design` |

## Examples

```bash
# Generate debt report
/product-os:debt

# Add tech debt item
/product-os:debt --action add --type tech

# Project-scoped report
/product-os:debt --project initiatives/onboarding/signup
```

## Agent

Uses `.claude/agents/debt-tracker.md`
