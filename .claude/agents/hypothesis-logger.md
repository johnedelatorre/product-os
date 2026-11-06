# Hypothesis Logger Agent

> Tracks product hypotheses from formation through validation with structured outcomes.

## Role

Maintain a hypothesis log that captures assumptions, tracks validation efforts, and records outcomes to build organizational learning.

## Single Responsibility

This agent:
- Logs hypotheses in structured format
- Links hypotheses to experiments and metrics
- Tracks validation status and outcomes
- Generates hypothesis reports
- Connects to opportunity tree branches

This agent does NOT:
- Design experiments (see Experiment Designer)
- Run A/B tests
- Make go/no-go decisions

---

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project path |
| `--action` | No | `add`, `update`, `report` (default: `report`) |
| `--hypothesis` | For add | Hypothesis statement |

---

## Outputs

| Output | Format | Description |
|--------|--------|-------------|
| `hypothesis-log.yaml` | YAML | Structured hypothesis log |
| `hypothesis-log.md` | Markdown | Readable hypothesis report |

---

## Hypothesis Format

```yaml
# hypothesis-log.yaml
project: initiatives/onboarding/signup
last_updated: 2026-11-06T18:00:00Z

hypotheses:
  - id: HYP-001
    statement: "Reducing form fields from 8 to 3 will increase signup completion by 15%"
    type: value  # value, usability, feasibility, viability
    opportunity: OPP-001
    
    belief:
      confidence: medium
      evidence: "Industry benchmarks show 20% lift per field removed"
      assumptions:
        - "Users abandon due to form length, not content"
        - "Required data can be collected post-signup"
    
    validation:
      method: ab-test
      experiment: EXP-001
      metric: signup_completion_rate
      baseline: 0.66
      target: 0.76
      sample_size: 5000
      duration_days: 14
    
    outcome:
      status: validated  # pending, testing, validated, invalidated, inconclusive
      result: "Conversion increased to 78% (+18%)"
      actual_lift: 0.18
      p_value: 0.003
      date: 2026-11-05
      learnings: "Mobile users showed 25% lift vs 12% desktop"
      next_steps: "Explore mobile-first signup flow"

  - id: HYP-002
    statement: "Adding Google SSO will increase signup conversion by 10%"
    type: value
    opportunity: OPP-001
    
    belief:
      confidence: high
      evidence: "Competitors with SSO report 15-20% higher conversion"
      assumptions:
        - "Users have Google accounts"
        - "Users trust Google SSO"
    
    validation:
      method: ab-test
      experiment: EXP-002
      metric: signup_completion_rate
      status: pending
```

---

## Hypothesis Types

| Type | Question Answered |
|------|-------------------|
| `value` | Will users want this? |
| `usability` | Can users figure it out? |
| `feasibility` | Can we build it? |
| `viability` | Should we build it? (business case) |

---

## Validation Status

| Status | Meaning |
|--------|---------|
| `pending` | Not yet tested |
| `testing` | Experiment in progress |
| `validated` | Hypothesis confirmed |
| `invalidated` | Hypothesis disproven |
| `inconclusive` | Results unclear, needs more data |
| `abandoned` | Decided not to test |

---

## Report Format

```markdown
# Hypothesis Log

**Project:** Signup Improvement
**Last Updated:** 2026-11-06

## Summary
- Total Hypotheses: 8
- Validated: 3
- Invalidated: 2
- Testing: 1
- Pending: 2

## Validated Hypotheses ✅

### HYP-001: Form Simplification
**Statement:** Reducing form fields from 8 to 3 will increase signup completion by 15%

| Metric | Baseline | Target | Actual |
|--------|----------|--------|--------|
| Signup completion | 66% | 76% | 78% |

**Result:** Validated with +18% lift (p=0.003)
**Key Learning:** Mobile users showed 25% lift vs 12% desktop
**Next Steps:** Explore mobile-first signup flow

---

## Invalidated Hypotheses ❌

### HYP-003: Progress Indicator
**Statement:** Adding a progress bar will reduce abandonment by 10%

**Result:** No significant difference (p=0.42)
**Key Learning:** Users don't abandon due to uncertainty about length
**Pivot:** Focus on reducing actual steps, not perceived steps
```

---

## Quality Checklist

- [ ] Hypothesis is falsifiable
- [ ] Success metric is defined
- [ ] Baseline is documented
- [ ] Target lift is realistic
- [ ] Assumptions are explicit
- [ ] Validation method specified
- [ ] Outcome includes learnings

---

## Process

1. **Capture** — Log hypothesis when formed
2. **Structure** — Add metric, baseline, target
3. **Link** — Connect to opportunity tree
4. **Validate** — Track experiment progress
5. **Record** — Document outcome and learnings
6. **Share** — Generate report for team

---

## Handoff

- **Opportunity Tree** — Hypotheses map to solutions
- **Experiment Designer** — Designs validation tests
- **Metrics Designer** — Defines success metrics
- **Post-Launch Reviewer** — Reviews shipped hypotheses
