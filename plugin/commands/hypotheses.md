---
description: "Manage the hypothesis log for a project."
argument-hint: "--project <path> [--action <action>]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:hypotheses

Manage the hypothesis log for a project.

## Usage

```
/jdlt-product-os:hypotheses --project <path> [--action <action>]
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
/jdlt-product-os:hypotheses --project initiatives/onboarding/signup

# Add a new hypothesis
/jdlt-product-os:hypotheses --project initiatives/onboarding/signup --action add \
  --hypothesis "Reducing form fields will increase completion by 15%"
```

## Agent

Uses `.claude/agents/hypothesis-logger.md`
