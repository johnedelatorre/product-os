---
description: "Design success metrics framework with north star and guardrails."
argument-hint: "--from <prd> [--goals <goals>]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:metrics

Design success metrics framework with north star and guardrails.

## Usage

```
/jdlt-product-os:metrics --from <prd> [--goals <goals>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | PRD or project brief |
| `--goals` | No | Specific goals to measure |

## Examples

```bash
# Create metrics framework from PRD
/jdlt-product-os:metrics --from prd.md

# Focus on specific goals
/jdlt-product-os:metrics --from prd.md --goals "conversion,retention"
```

## Agent

Uses `.claude/agents/metrics-designer.md`
