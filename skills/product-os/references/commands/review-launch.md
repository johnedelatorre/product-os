---
description: "Conduct post-launch review comparing results to PRD goals."
argument-hint: "--project <path> --prd <prd> [--days <days>]"
---
# /product-os:review-launch

Conduct post-launch review comparing results to PRD goals.

## Usage

```
/product-os:review-launch --project <path> --prd <prd> [--days <days>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--project` | Yes | Project path |
| `--prd` | Yes | Original PRD |
| `--metrics` | No | Metrics data source |
| `--days` | No | Days since launch (default: 14) |

## Examples

```bash
# Standard 14-day review
/product-os:review-launch --project initiatives/onboarding/signup --prd prd.md

# 30-day review
/product-os:review-launch --project initiatives/onboarding/signup --prd prd.md --days 30
```

## Agent

Uses `.claude/agents/post-launch-reviewer.md`
