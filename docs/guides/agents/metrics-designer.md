# Metrics Designer Agent

Defines north-star metrics, guardrails, and success criteria.

## What It Does

Creates comprehensive metrics frameworks with input/output metrics, guardrails, and success criteria for initiatives.

## When to Use

- Starting a new initiative
- Defining PRD success metrics
- Setting up experiment metrics
- Aligning team on goals

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | PRD or project brief |
| `--goals` | No | Specific goals to measure |

## Outputs

- `metrics-framework.md` — Full framework
- `metrics.yaml` — Machine-readable spec

## Example

```bash
/product-os:metrics --from prd.md
```

## Tips

1. **One north star** — Pick the metric that matters most
2. **Input metrics drive output** — What leads to success?
3. **Guardrails protect** — What must not degrade?
4. **Owners assigned** — Who's responsible?

## Related

- [Metrics Framework Skill](../../.claude/skills/metrics-framework.md)
- [Event Tracker](event-tracker.md)
