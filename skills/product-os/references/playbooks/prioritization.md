# Skill: Prioritization (RICE/WSJF/MoSCoW/Kano)

Apply rigorous prioritization frameworks to decide what to build.

## When to Use

- Comparing multiple feature requests
- Scoping a release
- Justifying prioritization decisions to stakeholders
- Backlog grooming

## Quick Start

```
/product-os:prioritize --items prd.md --framework rice
```

## Frameworks

### RICE Scoring

**Formula:** `(Reach × Impact × Confidence) ÷ Effort`

| Factor | Definition | Scale |
|--------|------------|-------|
| **Reach** | Users/events affected per quarter | Number (e.g., 5000) |
| **Impact** | Effect per user | 0.25 (Minimal) → 3 (Massive) |
| **Confidence** | Certainty in estimates | 50% / 80% / 100% |
| **Effort** | Person-months to build | Number (e.g., 2) |

**Example:**
```
Feature A: (5000 × 2 × 0.8) ÷ 3 = 2667
Feature B: (2000 × 1 × 1.0) ÷ 1 = 2000
→ Feature A wins
```

**When to use:** Comparing unrelated features, general prioritization

---

### WSJF (Weighted Shortest Job First)

**Formula:** `Cost of Delay ÷ Job Duration`

**Cost of Delay** = User Value + Time Criticality + Risk Reduction

| Component | Definition | Scale |
|-----------|------------|-------|
| **User Value** | Benefit to users | 1-10 |
| **Time Criticality** | Urgency/deadline pressure | 1-10 |
| **Risk Reduction** | Reduces risk if done | 1-10 |
| **Job Duration** | Relative size | Fibonacci |

**Example:**
```
Feature A: (8 + 5 + 3) ÷ 5 = 3.2
Feature B: (5 + 9 + 2) ÷ 2 = 8.0
→ Feature B wins (high time criticality, small job)
```

**When to use:** Backlog with deadlines, time-sensitive decisions

---

### MoSCoW

**Categories:**

| Category | Definition | Budget |
|----------|------------|--------|
| **Must** | Cannot ship without | ~60% |
| **Should** | Important but workaround exists | ~20% |
| **Could** | Nice to have | ~20% |
| **Won't** | Explicitly out of scope | 0% |

**Criteria for Must:**
- Regulatory/legal requirement
- Core value proposition
- Safety/security critical
- No workaround exists

**When to use:** Scoping a release, defining MVP

---

### Kano Model

**Categories:**

| Type | If Present | If Absent |
|------|------------|-----------|
| **Basic** | Expected, no extra joy | Strong dissatisfaction |
| **Performance** | More = better | Less = worse |
| **Delighter** | Unexpected joy | No disappointment |

**Strategic implications:**
- **Basic:** Fix gaps, but don't over-invest
- **Performance:** Differentiate here
- **Delighter:** Innovation bets, limited scope

**When to use:** Understanding user expectations, competitive positioning

---

## Combining Frameworks

For important decisions, use multiple frameworks:

```markdown
| Feature | RICE | WSJF | MoSCoW | Kano | Final |
|---------|------|------|--------|------|-------|
| Auth | 2667 | 3.2 | Must | Basic | P0 |
| Dashboard | 2000 | 8.0 | Must | Performance | P0 |
| Dark mode | 800 | 1.5 | Could | Delighter | P2 |
```

## Quality Checklist

- [ ] All items scored with same criteria
- [ ] Rationale documented for each score
- [ ] Assumptions stated
- [ ] High-uncertainty items flagged
- [ ] Results align with strategy

## Tips

1. **Calibrate as a team** — score a few items together first
2. **Document rationale** — "Reach: 5000 because monthly active users on this page"
3. **Re-score quarterly** — context changes
4. **Don't over-precision** — 2567 vs 2589 doesn't matter
5. **Confidence matters** — low confidence = spike first

## Related

- `/product-os:prioritize` — Run prioritization
- `.claude/agents/strategist.md` — Full agent specification
