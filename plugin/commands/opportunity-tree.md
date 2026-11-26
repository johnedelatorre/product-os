---
description: "Create an opportunity solution tree for discovery."
argument-hint: "--outcome <outcome> [--context <path>]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:opportunity-tree

Create an opportunity solution tree for discovery.

## Usage

```
/jdlt-product-os:opportunity-tree --outcome <outcome> [--context <path>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--outcome` | Yes | Desired measurable outcome |
| `--context` | No | Research, data, or intake docs |
| `--existing` | No | Path to existing tree to expand |

## Examples

```bash
# Create new opportunity tree
/jdlt-product-os:opportunity-tree --outcome "Increase signup conversion from 66% to 80%"

# Expand existing tree
/jdlt-product-os:opportunity-tree --existing opportunity-tree.yaml \
  --outcome "Reduce time to first value"
```

## Agent

Uses `.claude/agents/opportunity-tree.md`
