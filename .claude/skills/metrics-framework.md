# Skill: Metrics Framework

Define north-star metrics, guardrails, and success criteria.

## When to Use

- Starting a new initiative
- Defining success for PRD
- Setting up experiment metrics
- Aligning team on goals

## Quick Start

```
/product-os:metrics --from prd.md
```

## Framework Components

### 1. North Star Metric

The one metric that captures value delivery:

```yaml
north_star:
  name: "Weekly Active Completers"
  formula: "COUNT(DISTINCT user_id WHERE completed_workflow = true) per week"
  current: 12500
  target: 15000
```

### 2. Input Metrics (Leading)

Metrics that drive the north star:

```yaml
input_metrics:
  - name: "Signup Completion Rate"
    formula: "signups_completed / signups_started"
    current: 0.66
    target: 0.80
```

### 3. Guardrail Metrics

Metrics that must not degrade:

```yaml
guardrails:
  - name: "Support Tickets"
    threshold: "<= 5% of users"
    action: "Pause rollout, investigate"
```

## Metric Hierarchy

```
🎯 North Star
├── 📈 Input Metric 1
├── 📈 Input Metric 2
├── 📈 Input Metric 3
└── 🛡️ Guardrails
```

## Good Metrics Criteria (SMART)

| Criterion | Meaning |
|-----------|---------|
| Specific | Clearly defined formula |
| Measurable | Can be tracked |
| Achievable | Realistic target |
| Relevant | Tied to business outcome |
| Time-bound | Has deadline |

## Success Criteria Format

```yaml
success_criteria:
  must_have:
    - metric: "Signup Completion"
      condition: ">= 75%"
  should_have:
    - metric: "Time to First Value"
      condition: "<= 3 days"
  guardrails:
    - metric: "Support Tickets"
      condition: "no increase"
```

## Common Guardrails

- Error rate
- Page load time
- Support ticket volume
- Churn rate
- Revenue impact

## Quality Checklist

- [ ] North star defined with formula
- [ ] At least 3 input metrics
- [ ] At least 2 guardrails
- [ ] All metrics have owners
- [ ] Baselines documented
- [ ] Targets are SMART

## Related

- `/product-os:metrics` — Create framework
- `/product-os:tracking` — Implement tracking
- `.claude/agents/metrics-designer.md` — Full spec
