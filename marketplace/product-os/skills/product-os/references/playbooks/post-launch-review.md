# Skill: Post-Launch Review

Evaluate shipped features against PRD goals and close the learning loop.

## When to Use

- 14+ days after launch
- Evaluating feature success
- Creating follow-up intake
- Building organizational learning

## Quick Start

```
/product-os:review-launch --project initiatives/onboarding/signup --prd prd.md
```

## Review Framework

### 1. Goal Achievement

Compare actual results to PRD targets:

```yaml
- goal: "Increase signup completion to 80%"
  baseline: 0.66
  target: 0.80
  actual: 0.78
  status: partial  # met, partial, missed
```

### 2. Hypothesis Outcomes

```yaml
- hypothesis: "Form simplification increases completion"
  outcome: validated
  expected_lift: 0.15
  actual_lift: 0.18
```

### 3. Unexpected Findings

```yaml
- finding: "Mobile 2x better than desktop"
  type: positive
  implication: "Mobile-first approach has potential"
  action: "Create mobile-first intake"
```

### 4. Follow-up Items

```yaml
- title: "Mobile-first optimization"
  type: opportunity
  priority: high
  evidence: "Mobile showed 2x lift"
```

## Goal Status

| Status | Meaning |
|--------|---------|
| `met` | Hit or exceeded target |
| `partial` | Significant progress, below target |
| `missed` | Did not achieve meaningful progress |

## Timing

| Review Type | When |
|-------------|------|
| Quick check | 7 days |
| Standard review | 14 days |
| Extended review | 30 days |
| Long-term | 90 days |

## Learning Loop

```
Launch → Measure → Review → Learn → New Intake → Next Launch
```

Post-launch review creates intake items that feed the next cycle.

## Review Questions

1. Did we hit our goals? Why or why not?
2. What surprised us?
3. What would we do differently?
4. What should we do next?

## Quality Checklist

- [ ] All PRD goals reviewed
- [ ] Actual metrics collected
- [ ] Hypothesis outcomes documented
- [ ] Surprises identified
- [ ] Learnings are actionable
- [ ] Follow-up items created

## Related

- `/product-os:review-launch` — Run review
- `/product-os:intake` — Create follow-ups
- `.claude/agents/post-launch-reviewer.md` — Full spec
