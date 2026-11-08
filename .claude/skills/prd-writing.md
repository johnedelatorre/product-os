# Skill: PRD Writing

Write comprehensive Product Requirements Documents with PM rigor.

## When to Use

- Starting a new feature or product
- Documenting requirements for an approved intake
- Need a complete PRD with all 19 sections

## Quick Start

```
/product-os:prd --from intake.md
```

## Template

Use `templates/pm/prd.md` as the canonical structure.

## PRD Stages

| Stage | When | Evidence Bar |
|-------|------|--------------|
| **Early** | Exploring | Hypotheses unvalidated |
| **Defined** | Requirements complete | Partial evidence |
| **Delivery-ready** | Ready to build | Evidence gathered |

Mark incomplete sections `[TBD: what's needed]` rather than fabricating.

## PRD Structure

A complete PRD includes these 19 sections:

1. **Header** — Version, status, stakeholders
2. **Problem Statement** — What's broken, with evidence
3. **Background & Evidence** — Market context, research, business case
4. **Goals & Non-Goals** — SMART goals with explicit exclusions
5. **User Types & Personas** — Data-backed, not assumptions
6. **Jobs-to-be-Done** — Functional, emotional, social jobs
7. **Use Cases** — Primary, secondary, edge cases
8. **Functional Requirements** — Numbered (REQ-XXX), MoSCoW prioritized
9. **Non-Functional Requirements** — Performance, security, accessibility
10. **Success Metrics** — Formulas, baselines, targets
11. **Analytics Plan** — Events, properties, dashboards
12. **Technical Needs** — APIs, data, integrations
13. **Infrastructure** — Scaling, monitoring, cost
14. **Dependencies** — Internal and external blockers
15. **Risks & Mitigations** — Probability × Impact matrix
16. **Assumptions** — With validation plans
17. **Open Questions** — With owners and due dates
18. **Rollout Plan** — Feature flags, percentage rollout, rollback

## Requirement Numbering

Use consistent IDs for traceability:

```markdown
| ID | Requirement | Priority | JTBD |
|----|-------------|----------|------|
| REQ-001 | User can register with email | Must | JTBD-1 |
| REQ-002 | Email validation on submit | Must | JTBD-1 |
| REQ-003 | Social login option | Should | JTBD-1 |
```

## MoSCoW Prioritization

| Priority | Definition | Effort Budget |
|----------|------------|---------------|
| **Must** | Required for launch | ~60% |
| **Should** | Important, not critical | ~20% |
| **Could** | Nice to have | ~20% |
| **Won't** | Explicitly out of scope | 0% |

## Success Metrics Formula

Every metric needs:
- **Formula**: How to calculate it
- **Baseline**: Current state
- **Target**: Goal state
- **Timeline**: When to measure

```markdown
| Metric | Formula | Baseline | Target | Timeline |
|--------|---------|----------|--------|----------|
| Conversion rate | Signups / Visitors × 100 | 2.3% | 4.0% | 30 days |
| Time to first value | Median time to first action | 12 min | 5 min | Launch |
```

## Quality Checklist

Before submitting a PRD:

- [ ] Every claim has supporting evidence
- [ ] Goals are SMART (Specific, Measurable, Achievable, Relevant, Time-bound)
- [ ] Requirements have unique IDs
- [ ] Metrics have formulas AND targets
- [ ] Risks have mitigations, not just identification
- [ ] Open questions have owners

## Tips

1. **Start with the problem**, not the solution
2. **Quantify everything** — "improve performance" → "reduce p95 latency to <200ms"
3. **Be explicit about non-goals** — prevents scope creep
4. **Get engineering input early** — on feasibility and estimates
5. **Update, don't rewrite** — PRDs are living documents

## Related

- `/product-os:intake` — Structure requirements before PRD
- `/product-os:brief` — One-page summary from PRD
- `.claude/agents/prd-author.md` — Full agent specification
