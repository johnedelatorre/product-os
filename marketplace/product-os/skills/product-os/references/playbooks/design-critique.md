# Skill: Design Critique

Perform structured visual design critique with severity-rated findings.

## When to Use

- Reviewing wireframes before handoff
- Evaluating prototypes before user testing
- Auditing Figma designs against PRD
- Quality gate before development

## Ground Rule: Review the Real Design Only

1. **Input is the actual design:** a Figma file/frame link (via the Figma MCP), screenshots, `prototype.html` or a prototype URL, or `wireframes.md`. A PRD, design brief or description of a screen is not a design.
2. **No design, stop and ask.** "I need the design to critique: a Figma link, screenshots, `prototype.html` or `wireframes.md`. Which can you share?" Never critique an imagined or assumed screen.
3. **Record what was reviewed** in §1 "What was reviewed", right after the standard header: sources, screen IDs (`SCR-###`, prototype `#scr-###`, Figma node IDs), version, review date.
4. **Cite every finding:** exact screen, frame and element, with a screenshot or frame link where possible. No citation, no finding.
5. **Not Verified, never guessed:** anything you could not inspect is marked Not Verified with what is missing. Grayscale wireframes leave Color, Typography and Brand Not Verified.

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

**Location:** `wireframes.md` SCR-002 Registration Form → "Create Account" button, below form
**Dimension:** Visual Hierarchy

**Issue:**
The "Create Account" button has the same visual weight as 
the "Already have account?" link. Primary action is not clear.

**Impact:**
Users may not see the submit button, increasing form abandonment.

**Evidence:**
SCR-002 draws the button with the secondary (outline) style instead of primary (filled); see the wireframe block for SCR-002.

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

- [ ] Real design reviewed; "What was reviewed" table filled
- [ ] Every finding cites screen/frame/element
- [ ] Uninspectable items marked Not Verified
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
