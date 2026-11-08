# Skill: Design Critique

Perform structured visual design critique with severity-rated findings.

## When to Use

- Reviewing wireframes before handoff
- Evaluating prototypes before user testing
- Auditing Figma designs against PRD
- Quality gate before development

## Quick Start

```
/product-os:critique --designs wireframes.md --prd prd.md
```

## Evaluation Dimensions

### 1. Visual Hierarchy
- Primary focal point is clear
- CTA prominence matches business goals
- Information priority matches user needs

### 2. Layout & Composition
- Grid alignment consistent
- White space appropriate
- Content grouping follows Gestalt principles

### 3. Typography
- Clear type hierarchy (H1 > H2 > body)
- Line length 45-75 characters
- Line height 1.4-1.6 for body

### 4. Color
- Contrast ratios meet WCAG
- Color meaning consistent (red = error)
- Color not sole indicator

### 5. Spacing & Alignment
- Consistent spacing scale
- Elements on grid
- Optical alignment where needed

### 6. Component Consistency
- Same component = same appearance
- States consistent (hover, disabled)
- Icon style consistent

### 7. Content & Microcopy
- Labels are action-oriented
- Error messages are helpful
- Empty states guide action

### 8. PRD Alignment
- Every requirement has UI
- No scope creep (extra features)

### 9. Brand Alignment
- Colors match brand
- Typography matches brand
- Tone matches brand voice

## Severity Levels

| Level | Definition | Action |
|-------|------------|--------|
| **Critical (P0)** | Blocks launch, user harm | Must fix |
| **Major (P1)** | Significant UX impact | Should fix before launch |
| **Minor (P2)** | Polish issue | Fix if time permits |

## Finding Format

```markdown
### [CRITICAL] Missing primary CTA

**Location:** Registration screen, below form
**Dimension:** Visual Hierarchy

**Issue:**
The "Create Account" button has the same visual weight as 
the "Already have account?" link. Primary action is not clear.

**Impact:**
Users may not see the submit button, increasing form abandonment.

**Evidence:**
Button uses secondary style (outline) instead of primary (filled).

**Recommendation:**
Change "Create Account" to filled primary button style. 
Keep "Already have account?" as text link.

**PRD Reference:** REQ-001
```

## Scorecard Template

```markdown
| Dimension | Score (1-5) | Critical | Major | Minor |
|-----------|-------------|----------|-------|-------|
| Visual Hierarchy | 3 | 1 | 2 | 0 |
| Layout | 4 | 0 | 1 | 2 |
| Typography | 4 | 0 | 0 | 3 |
| Color | 3 | 1 | 1 | 0 |
| Spacing | 4 | 0 | 1 | 1 |
| Consistency | 5 | 0 | 0 | 0 |
| Content | 3 | 0 | 2 | 1 |
| PRD Alignment | 4 | 0 | 1 | 0 |
| Brand | 4 | 0 | 0 | 1 |
| **Overall** | **3.8** | **2** | **8** | **8** |
```

### Score Key
- 5: Excellent — Best practices exemplified
- 4: Good — Minor issues only
- 3: Acceptable — Some major issues
- 2: Needs Work — Multiple major issues
- 1: Critical — Cannot ship

## Quality Checklist

- [ ] All 9 dimensions evaluated
- [ ] Every finding has evidence
- [ ] Severity calibrated correctly
- [ ] Fixes are concrete (not vague)
- [ ] PRD requirements traced
- [ ] Positives also noted
- [ ] Scorecard complete

## Tips

1. **Be specific** — "Button too small" → "Button is 20px, below the 24×24px WCAG 2.2 AA minimum (44px recommended)"
2. **Provide fixes** — Don't just identify problems
3. **Note positives** — What's working well
4. **Calibrate severity** — Critical = truly blocks launch
5. **Link to PRD** — Ground critique in requirements

## Related

- `/product-os:critique` — Run design critique
- `/product-os:ux-review` — Heuristics evaluation
- `/product-os:a11y` — Accessibility audit
- `.claude/agents/design-critic.md` — Full agent specification
