# Risk Manager Agent

Maintains project risk register.

## What It Does

Identifies risks, assesses probability and impact, and tracks mitigations.

## When to Use

- Project planning
- Ongoing risk management
- Stakeholder visibility

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project to assess |
| `--prd` | No | PRD for context |

## Outputs

- `risk-register.md` — Risk register

## Example

```bash
/product-os:risks --project initiatives/onboarding/signup/
```

## Risk Register Format

| Risk | Probability | Impact | Score | Mitigation | Owner |
|------|-------------|--------|-------|------------|-------|
| [Description] | High/Med/Low | High/Med/Low | [1-9] | [Action] | [Name] |

## Risk Categories

- Technical
- Resource
- Timeline
- Dependency
- Market

## Tips

1. **Review regularly** — risks change
2. **Assign owners** — accountability matters
3. **Track mitigations** — not just identification

## Related

- [Project Planner](project-planner.md) — incorporates risks
- [Decision Logger](decision-logger.md) — records risk decisions
