---
description: "Design success metrics framework with north star and guardrails."
argument-hint: "--from <prd> [--goals <goals>]"
---
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
