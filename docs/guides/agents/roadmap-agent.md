# Roadmap Agent

Creates Now/Next/Later roadmaps.

## What It Does

Organizes initiatives into time horizons with strategic rationale, avoiding precise dates that create false certainty.

## When to Use

- Planning discussions
- Stakeholder alignment
- Portfolio view

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--items` | Yes | Initiatives to roadmap |
| `--format` | No | `timeline`, `kanban`, `table` |

## Outputs

- `roadmap.md` — Now/Next/Later roadmap

## Example

```bash
/product-os:roadmap --items "Feature A, Feature B, Feature C"
```

## Time Horizons

| Horizon | Meaning |
|---------|---------|
| Now | Current quarter, committed |
| Next | Next quarter, planned |
| Later | Future, considering |

## Tips

1. **Avoid false precision** — horizons over dates
2. **Include rationale** — why this order?
3. **Update regularly** — roadmaps are living documents

## Related

- [Strategist](strategist.md) — provides prioritization
- [OKR Agent](okr-agent.md) — connects to objectives
