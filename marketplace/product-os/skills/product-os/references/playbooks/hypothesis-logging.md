# Skill: Hypothesis Logging

Track product hypotheses from formation through validation.

## When to Use

- Documenting assumptions
- Designing experiments
- Recording validation outcomes
- Building organizational learning

## Quick Start

```
/product-os:hypotheses --project initiatives/onboarding/signup
```

## Hypothesis Format

```yaml
- id: HYP-001
  statement: "Reducing form fields from 8 to 3 will increase signup completion by 15%"
  type: value
  
  belief:
    confidence: medium
    evidence: "Industry benchmarks show 20% lift per field removed"
    assumptions:
      - "Users abandon due to form length"
      
  validation:
    method: ab-test
    metric: signup_completion_rate
    baseline: 0.66
    target: 0.76
    
  outcome:
    status: validated
    actual_lift: 0.18
    learnings: "Mobile users showed 25% lift vs 12% desktop"
```

## Hypothesis Types

| Type | Question |
|------|----------|
| `value` | Will users want this? |
| `usability` | Can users figure it out? |
| `feasibility` | Can we build it? |
| `viability` | Should we build it? |

## Validation Status

| Status | Meaning |
|--------|---------|
| `pending` | Not yet tested |
| `testing` | Experiment in progress |
| `validated` | Hypothesis confirmed |
| `invalidated` | Hypothesis disproven |
| `inconclusive` | Needs more data |

## Good Hypothesis Criteria

1. **Falsifiable** — Can be proven wrong
2. **Specific** — Clear metric and target
3. **Bounded** — Time-limited validation
4. **Actionable** — Informs decisions

## Validation Methods

| Method | When to Use |
|--------|-------------|
| `ab-test` | Feature changes with traffic |
| `survey` | Opinion/preference questions |
| `interview` | Deep qualitative insight |
| `prototype-test` | Pre-build validation |
| `fake-door` | Demand validation |

## Recording Outcomes

Always include:
- Actual result vs expected
- Statistical confidence (p-value)
- Key learnings
- Next steps

## Related

- `/product-os:hypotheses` — Manage log
- `/product-os:experiment` — Design tests
- `.claude/agents/hypothesis-logger.md` — Full spec
