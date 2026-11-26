---
description: "Manage project dependencies and risks."
argument-hint: "--project <path> [--action <action>]"
---
# /product-os:dependencies

Manage project dependencies and risks.

## Usage

```
/product-os:dependencies --project <path> [--action <action>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--project` | Yes | Project path |
| `--action` | No | `add`, `update`, `report` (default: `report`) |
| `--raci` | No | Path to RACI for linking |

## Examples

```bash
# Generate dependency report
/product-os:dependencies --project initiatives/onboarding/signup

# Add a dependency
/product-os:dependencies --project initiatives/onboarding/signup --action add
```

## Agent

Uses `.claude/agents/dependency-tracker.md`
