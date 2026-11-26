---
description: "Create go-to-market materials for launch."
argument-hint: "--project <path> [--version <version>] [--audience <audience>]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:launch

Create go-to-market materials for launch.

## Usage

```
/jdlt-product-os:launch --project <path> [--version <version>] [--audience <audience>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--project` | Yes | Project path |
| `--version` | No | Version number |
| `--audience` | No | `customers`, `internal`, `all` (default: `all`) |

## Examples

```bash
# Full launch materials
/jdlt-product-os:launch --project initiatives/onboarding/signup --version 2.4.0

# Customer-only release notes
/jdlt-product-os:launch --project initiatives/onboarding/signup --audience customers
```

## Agent

Uses `.claude/agents/launch-manager.md`
