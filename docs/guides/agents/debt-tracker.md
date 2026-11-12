# Debt Tracker Agent

Maintains technical and design debt register with prioritization.

## What It Does

Tracks, categorizes, and prioritizes tech and design debt to enable informed decisions about when to pay it down.

## When to Use

- Documenting known debt
- Sprint planning (allocation)
- Quarterly planning
- Risk assessment

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | No | Project scope (or all) |
| `--action` | No | `add`, `update`, `report` |
| `--type` | For add | `tech` or `design` |

## Outputs

- `debt-register.md` — Full register
- `debt-register.yaml` — Machine-readable
- `debt-summary.md` — Executive summary

## Example

```bash
/product-os:debt --action report
```

## Tips

1. **Calculate interest** — What's the ongoing cost?
2. **Prioritize by impact** — Fix what hurts most
3. **Allocate capacity** — 10-20% for paydown
4. **Track trends** — Is debt growing or shrinking?

## Related

- [Debt Tracking Skill](../../../.claude/skills/debt-tracking.md)
- [Risk Manager](risk-manager.md)
