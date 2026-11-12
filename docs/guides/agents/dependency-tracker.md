# Dependency Tracker Agent

Maintains risk and dependency register with RACI integration.

## What It Does

Tracks internal and external dependencies, integrates with risk management, and links to RACI for clear ownership.

## When to Use

- Project planning
- Risk assessment
- Weekly status updates
- Identifying blockers

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project path |
| `--action` | No | `add`, `update`, `report` |
| `--raci` | No | RACI file to link |

## Outputs

- `dependency-register.md` — Full register
- `dependency-register.yaml` — Machine-readable
- `blocked-items.md` — Current blockers

## Example

```bash
/product-os:dependencies --project initiatives/onboarding/signup
```

## Tips

1. **Update weekly** — Dependencies change
2. **Link to RACI** — Clear ownership
3. **Mitigations ready** — Plan for delays
4. **Escalate early** — Don't wait on blockers

## Related

- [Dependency Tracking Skill](../../../.claude/skills/dependency-tracking.md)
- [Risk Manager](risk-manager.md)
