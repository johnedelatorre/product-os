---
description: "Design success metrics framework with north star and guardrails."
argument-hint: "--from <prd> [--goals <goals>]"
---
# /product-os:metrics

Design success metrics framework with north star and guardrails.

## Usage

```
/product-os:metrics --from <prd> [--goals <goals>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | PRD or project brief |
| `--goals` | No | Specific goals to measure |

## Examples

```bash
# Create metrics framework from PRD
/product-os:metrics --from prd.md

# Focus on specific goals
/product-os:metrics --from prd.md --goals "conversion,retention"
```

## Agent

Uses `.claude/agents/metrics-designer.md`
