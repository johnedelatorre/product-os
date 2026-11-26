---
description: "Check Definition of Ready or Definition of Done for stories."
argument-hint: "--stories <path> --gate <dor|dod> [--strict]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:gate

Check Definition of Ready or Definition of Done for stories.

## Usage

```
/jdlt-product-os:gate --stories <path> --gate <dor|dod> [--strict]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--stories` | Yes | Stories file or Jira query |
| `--gate` | Yes | `dor` or `dod` |
| `--strict` | No | Fail on any missing item |

## Examples

```bash
# Check Definition of Ready
/jdlt-product-os:gate --stories stories.md --gate dor

# Strict check for Definition of Done
/jdlt-product-os:gate --stories stories.md --gate dod --strict
```

## Agent

Uses `.claude/agents/gate-keeper.md`
