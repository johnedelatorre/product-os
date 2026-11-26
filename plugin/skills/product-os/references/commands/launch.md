---
description: "Create go-to-market materials for launch."
argument-hint: "--project <path> [--version <version>] [--audience <audience>]"
---
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
