# /product-os:tracking

Create an event tracking plan for analytics platforms.

## Usage

```
/product-os:tracking --from <source> [--platform <platform>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | PRD, flows, or metrics framework |
| `--platform` | No | `pendo`, `amplitude`, `mixpanel`, `segment` (default: generic) |

## Examples

```bash
# Generic tracking plan
/product-os:tracking --from prd.md

# Amplitude-specific plan
/product-os:tracking --from flows.yaml --platform amplitude
```

## Agent

Uses `.claude/agents/event-tracker.md`
