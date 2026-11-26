---
description: "Create a market analysis brief."
argument-hint: "--market <market> [--depth <level>]"
---
# /product-os:market

Create a market analysis brief.

## Usage

```
/product-os:market --market <market> [--depth <level>]
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
/product-os:market --market "B2B SaaS Customer Onboarding"

# Deep analysis with context
/product-os:market --market "B2B SaaS Customer Onboarding" \
  --depth deep --context company-strategy.md
```

## Agent

Uses `.claude/agents/market-analyst.md`
