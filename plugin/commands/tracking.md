---
description: "Create an event tracking plan for analytics platforms."
argument-hint: "--from <source> [--platform <platform>]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:tracking

Create an event tracking plan for analytics platforms.

## Usage

```
/jdlt-product-os:tracking --from <source> [--platform <platform>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | PRD, flows, or metrics framework |
| `--platform` | No | `pendo`, `amplitude`, `mixpanel`, `segment` (default: generic) |

## Examples

```bash
# Generic tracking plan
/jdlt-product-os:tracking --from prd.md

# Amplitude-specific plan
/jdlt-product-os:tracking --from flows.yaml --platform amplitude
```

## Agent

Uses `.claude/agents/event-tracker.md`
