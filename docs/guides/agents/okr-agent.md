# OKR Agent

Creates and tracks Objectives and Key Results.

## What It Does

Defines OKRs aligned with strategy and creates metric trees showing how product work contributes to business outcomes.

## When to Use

- Quarterly planning
- Connecting projects to strategy
- Defining success metrics

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--objective` | Yes | High-level objective |
| `--context` | No | Strategy docs, PRDs |

## Outputs

- `okrs.md` — OKRs with metric tree

## Example

```bash
/product-os:okrs --objective "Improve customer onboarding"
```

## OKR Structure

```
Objective: [What we want to achieve]
├── KR1: [Measurable result] (baseline → target)
├── KR2: [Measurable result] (baseline → target)
└── KR3: [Measurable result] (baseline → target)
    └── Projects contributing to this KR
```

## Tips

1. **Outcomes over outputs** — measure results, not activity
2. **Stretch but achievable** — 70% success is good
3. **Link to projects** — show how work connects

## Related

- [Strategist](strategist.md) — prioritization
- [Roadmap Agent](roadmap-agent.md) — planning
