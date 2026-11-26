---
description: "Manage technical and design debt tracker."
argument-hint: "[--project <path>] [--action <action>] [--type <type>]"
---
# /jdlt-product-os:debt

Manage technical and design debt tracker.

## Usage

```
/jdlt-product-os:debt [--project <path>] [--action <action>] [--type <type>]
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
/jdlt-product-os:debt

# Add tech debt item
/jdlt-product-os:debt --action add --type tech

# Project-scoped report
/jdlt-product-os:debt --project initiatives/onboarding/signup
```

## Agent

Uses `.claude/agents/debt-tracker.md`
