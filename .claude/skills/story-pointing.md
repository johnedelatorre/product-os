# Skill: Story Pointing

Estimate stories using Fibonacci scale with documented rationale.

## When to Use

- Sprint planning
- Backlog refinement
- Capacity planning
- Release scoping

## Quick Start

```
/product-os:deliver --from prd.md --designs wireframes.md
```

## Story Point Rubric

Use Fibonacci sequence (1, 2, 3, 5, 8, 13):

| Points | Complexity | Uncertainty | Typical Work |
|--------|------------|-------------|--------------|
| **1** | Trivial | None | Copy change, config update, simple bug |
| **2** | Simple | Low | Single component, clear spec |
| **3** | Moderate | Low | Multiple components, some integration |
| **5** | Complex | Medium | New feature area, API integration |
| **8** | Very Complex | High | Cross-system, significant architecture |
| **13** | Extremely Complex | Very High | Major architecture, spike needed first |

## Estimation Guidelines

### What Points Include
- Development time
- Unit testing
- Code review
- Documentation updates

### What Points Exclude
- QA testing (separate track)
- Deployment (separate track)
- Meetings/ceremonies

### Rationale Format

Always document why:

```markdown
**Story Points:** 5

**Estimation Rationale:**
- Complexity: Medium — New API endpoint + frontend component
- Uncertainty: Medium — Third-party API behavior unclear
- Dependencies: Auth service must be deployed first
- Similar past work: Like PROJ-234 which took 4 days
```

## Estimation Techniques

### Planning Poker
1. Present story
2. Everyone votes simultaneously
3. Discuss outliers
4. Re-vote until consensus

### Relative Sizing
1. Pick a reference story (your "3")
2. Compare all stories: "Bigger or smaller than reference?"
3. Place in Fibonacci buckets

### T-Shirt Sizing (then convert)
| T-Shirt | Points |
|---------|--------|
| XS | 1 |
| S | 2 |
| M | 3 |
| L | 5 |
| XL | 8 |
| XXL | 13 (consider splitting) |

## When to Split Stories

Split if:
- Points > 8 (too large for one sprint)
- Multiple acceptance criteria could ship independently
- Different disciplines needed (FE vs BE)
- High uncertainty (spike first, then implement)

**Bad split:** Technical layers (API, then UI)
**Good split:** User value slices (basic flow, then edge cases)

## Velocity Calculation

```
Velocity = Average points completed per sprint

Example:
- Sprint 1: 34 points
- Sprint 2: 38 points
- Sprint 3: 36 points
- Velocity: 36 points/sprint

Sprint capacity = Velocity × (1 - risk buffer)
               = 36 × 0.85 = 30 points
```

## Quality Checklist

- [ ] All stories estimated
- [ ] Fibonacci scale used consistently
- [ ] Rationale documented
- [ ] Similar stories have similar points
- [ ] No story > 13 points
- [ ] High-uncertainty items flagged

## Tips

1. **Estimate complexity, not time** — a 5-point story isn't "5 days"
2. **Consistency matters more than accuracy** — calibrate with team
3. **Re-estimate when scope changes** — don't carry stale estimates
4. **Track actuals** — compare estimates to outcomes, adjust calibration
5. **Flag unknowns** — "5 points, but needs spike" is valid

## Common Pitfalls

| Pitfall | Fix |
|---------|-----|
| Estimating in hours | Use relative complexity |
| One person estimates | Whole team participates |
| Never updating | Re-estimate when scope changes |
| Ignoring uncertainty | Higher points for unknowns |
| 13+ point stories | Split them |

## Related

- `/product-os:deliver` — Generate stories with points
- `discipline-labeling.md` — Assign frontend/backend labels
- `.claude/agents/delivery-agent.md` — Full agent specification
