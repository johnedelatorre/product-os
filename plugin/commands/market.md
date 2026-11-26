---
description: "Create a market analysis brief."
argument-hint: "--market <market> [--depth <level>]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:market

Create a market analysis brief.

## Usage

```
/jdlt-product-os:market --market <market> [--depth <level>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--market` | Yes | Market or category to analyze |
| `--context` | No | Existing research, company info |
| `--depth` | No | `brief`, `standard`, `deep` (default: `standard`) |

## Examples

```bash
# Standard market analysis
/jdlt-product-os:market --market "B2B SaaS Customer Onboarding"

# Deep analysis with context
/jdlt-product-os:market --market "B2B SaaS Customer Onboarding" \
  --depth deep --context company-strategy.md
```

## Agent

Uses `.claude/agents/market-analyst.md`
