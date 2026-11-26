---
description: "Manage the hypothesis log for a project."
argument-hint: "--project <path> [--action <action>]"
---
# /product-os:hypotheses

Manage the hypothesis log for a project.

## Usage

```
/product-os:hypotheses --project <path> [--action <action>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--project` | Yes | Project path |
| `--action` | No | `add`, `update`, `report` (default: `report`) |
| `--hypothesis` | For add | Hypothesis statement |

## Examples

```bash
# Generate hypothesis report
/product-os:hypotheses --project initiatives/onboarding/signup

# Add a new hypothesis
/product-os:hypotheses --project initiatives/onboarding/signup --action add \
  --hypothesis "Reducing form fields will increase completion by 15%"
```

## Agent

Uses `.claude/agents/hypothesis-logger.md`
