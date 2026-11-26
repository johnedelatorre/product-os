# Skill: Estimation

Distinguish early-stage sizing from sprint-ready estimates. Use appropriate precision for each phase.

## When to Use

- Initiative planning (T-shirt / ranges)
- Epic estimation (ranges with confidence)
- Sprint planning (Fibonacci points)
- Capacity planning (velocity-based)

---

## Estimation Phases

| Phase | Method | Who Estimates | Purpose |
|-------|--------|---------------|---------|
| **Initiative** | T-shirt (S/M/L/XL) | PM + Tech Lead | Roadmap sequencing |
| **Epic** | Range (weeks) with confidence | Tech Lead + senior eng | Resource planning |
| **Story** | Fibonacci (1-13) | Delivery team | Sprint commitment |

> **Note:** Precision varies by team and domain. Early estimates have high uncertainty; sprint-ready estimates should be lower. Actual precision depends on your team's calibration—don't assume universal accuracy.

### Key Principle

**Never convert early estimates to precise points.** T-shirt sizes inform prioritization, not sprint planning. Refinement happens closer to execution when uncertainty is lower.

---

## Initiative-Level Sizing (T-Shirt)

Use for roadmap planning and prioritization. T-shirt sizes are relative—calibrate to your team's velocity and domain.

### Example Calibration (Illustrative)

> This is one team's calibration. Your team should define its own based on historical data.

| Size | Scope Description | Confidence |
|------|-------------------|------------|
| **S** | Single feature, clear scope | High |
| **M** | Multiple features, some unknowns | Medium |
| **L** | Large scope, cross-team | Low |
| **XL** | Major initiative, high uncertainty | Very Low |

### T-Shirt Estimation Template

```markdown
| Initiative | Size | Range | Confidence | Key Unknowns |
|------------|------|-------|------------|--------------|
| Signup redesign | M | 4-6 weeks | Medium | Third-party auth integration |
| Dashboard v2 | L | 8-12 weeks | Low | Data model TBD |
| Quick fix: button | S | 1-2 days | High | None |
```

### What T-Shirt Sizing Is NOT

- ❌ A commitment to delivery dates
- ❌ Convertible to story points
- ❌ A substitute for team estimation
- ❌ Precise enough for sprint planning

---

## Epic-Level Estimation (Ranges)

Use for release planning and dependency coordination.

### Range Format

```markdown
| Epic | Optimistic | Expected | Pessimistic | Confidence | Unknowns |
|------|------------|----------|-------------|------------|----------|
| EPIC-001 | 2 weeks | 3 weeks | 5 weeks | Medium | API design pending |
| EPIC-002 | 1 week | 2 weeks | 2 weeks | High | Clear scope |
| EPIC-003 | 3 weeks | 6 weeks | 10 weeks | Low | Needs spike |
```

### Confidence Levels

| Level | Meaning | When to Use |
|-------|---------|-------------|
| **High** | Requirements clear, similar past work, team familiar | Well-understood domains |
| **Medium** | Some unknowns, but bounded | Most new features |
| **Low** | Significant uncertainty, estimates could double | New technology, unclear scope |
| **Very Low** | Spike required before real estimate | Unknown unknowns |

### When Confidence is Low

1. **Identify unknowns** — What don't we know?
2. **Plan spikes** — Time-boxed research stories
3. **Re-estimate after spike** — Don't commit until uncertainty reduced
4. **Communicate ranges** — "3-10 weeks depending on X"

---

## Story-Level Estimation (Fibonacci)

Use for sprint planning and commitment.

### Fibonacci Scale

| Points | Complexity | Uncertainty | Typical Work |
|--------|------------|-------------|--------------|
| **1** | Trivial | None | Config change, copy update |
| **2** | Simple | Low | Single component, clear spec |
| **3** | Moderate | Low | Multiple components, integration |
| **5** | Complex | Medium | New feature, API integration |
| **8** | Very Complex | High | Cross-system, architecture |
| **13** | Too Large | Very High | Split or spike first |

### Story Estimation Rationale

Always document why:

```markdown
**Story Points:** 5

**Rationale:**
- Complexity: Medium — New endpoint + UI component
- Uncertainty: Medium — Third-party API behavior unclear
- Dependencies: Must wait for auth service deploy
- Reference: Similar to PROJ-234 (was 5 points, took 4 days)
```

### What Points Include

- Development
- Unit tests
- Code review
- Documentation updates

### What Points Exclude

- QA testing (separate track)
- Deployment (ops work)
- Meetings (team overhead)

---

## Handling Unknowns

### Use Spikes

When uncertainty is high, create a time-boxed spike:

```markdown
## SPIKE-001: Evaluate third-party auth options

**Time-box:** 2 days
**Goal:** Determine which auth provider to use and estimate integration effort

**Questions to Answer:**
1. Which providers support our requirements?
2. What's the integration complexity?
3. Are there licensing/cost concerns?

**Output:** Recommendation + revised epic estimate
```

### Provisional Estimates

When estimation is blocked:

```markdown
| Story | Points | Status | Blocker |
|-------|--------|--------|---------|
| STORY-001 | 3 | Ready | — |
| STORY-002 | ? | Provisional: 5-8 | Needs SPIKE-001 results |
| STORY-003 | TBD | Blocked | Waiting on API spec |
```

### Never Fabricate Precision

❌ "This is exactly 5 points"
✅ "This is 5-8 points depending on X; we'll refine after the spike"

---

## Velocity and Capacity

### Velocity Calculation

```
Velocity = Rolling average of completed points per sprint

Last 3 sprints: 34, 38, 36
Average velocity: 36 points/sprint
```

### Capacity Planning

```
Sprint capacity = Velocity × buffer factor

Buffer factors:
- Normal sprint: 0.85 (15% buffer)
- Sprint with holiday: 0.70
- New team member: 0.75
```

### Don't Fake Velocity

- ❌ "We'll do 40 points because that's the target"
- ✅ "Our velocity is 36; we'll commit to 30-32"

Velocity is measured, not decided.

---

## Connecting Estimates

### Initiative → Epic → Story Flow

```
Initiative: Signup Redesign (M, 4-6 weeks)
├── Epic: New registration flow (2-3 weeks, Medium confidence)
│   ├── STORY-001: Registration form UI (3 pts)
│   ├── STORY-002: Email validation API (5 pts)
│   └── STORY-003: Confirmation page (2 pts)
├── Epic: Social login (2-4 weeks, Low confidence)
│   └── SPIKE-001: Evaluate auth providers (2 days)
└── Epic: Migration (1-2 weeks, High confidence)
    ├── STORY-010: Data migration script (5 pts)
    └── STORY-011: Rollback procedure (3 pts)
```

### Estimate Refinement

| Stage | Estimate Type | Updates When |
|-------|---------------|--------------|
| Roadmap planning | T-shirt | Scope changes significantly |
| Release planning | Epic ranges | After spikes complete |
| Sprint planning | Story points | Story scope changes |

---

## Common Pitfalls

| Pitfall | Problem | Fix |
|---------|---------|-----|
| Hours-to-points | "1 day = 1 point" | Points are complexity, not time |
| PM estimates alone | No team buy-in | Team estimates together |
| Never updating | Stale estimates | Re-estimate on scope change |
| Precision theater | "4.5 points" | Use Fibonacci |
| Ignoring unknowns | Underestimating | Flag uncertainty, use spikes |
| 13+ point stories | Unplannable | Split them |
| Velocity targets | Gaming metrics | Velocity is measured |

---

## Quality Checklist

- [ ] Initiative estimates are T-shirt with ranges
- [ ] Epic estimates include confidence levels
- [ ] Low-confidence items have spikes planned
- [ ] Story estimates use Fibonacci
- [ ] Rationale documented for complex estimates
- [ ] Unknowns flagged, not hidden
- [ ] Velocity based on actuals, not wishes

---

## Related

- `story-pointing.md` — Fibonacci scale details
- `discipline-labeling.md` — Frontend/backend labels
- `.claude/agents/delivery-agent.md` — Story creation
- `.claude/agents/project-planner.md` — Timeline integration
