# Skill: WCAG 2.2 Accessibility Audit

Comprehensive accessibility evaluation with automated and manual testing.

## When to Use

- Before launch (required)
- After major UI changes
- Compliance verification
- Quality gate for prototypes

## Ground Rule: Review the Real Design Only

1. **Input is the actual design:** `prototype.html` in a browser or a live URL (full audit); a Figma link, screenshots or `wireframes.md` (static checks only). A PRD, design brief or description of a screen is not a design.
2. **No design, stop and ask.** "I need the design to audit: `prototype.html`, a live URL, a Figma link, screenshots or `wireframes.md`. Which can you share?" Never audit an imagined or assumed screen.
3. **Record what was reviewed** in §1 "What was reviewed", right after the standard header: sources, screen IDs (`SCR-###`, prototype `#scr-###`, Figma node IDs), version, review date.
4. **Cite every finding:** exact screen, frame and element, with a screenshot or frame link where possible. No citation, no finding.
5. **Not Verified, never guessed:** anything you could not inspect is marked Not Verified with what is missing.
6. **Running build required** for axe-core, pa11y, Lighthouse, keyboard and screen reader checks. Without `prototype.html` in a browser or a live URL, these are Not Verified and no scan counts are reported.
7. **Real colours required** for contrast. On grayscale wireframes, contrast is Not Verified.

## Quick Start

```
/product-os:a11y --target prototype.html --wcag AA
```

## WCAG 2.2 AA Checklist Summary

### Perceivable

| Criterion | Check | How to Test |
|-----------|-------|-------------|
| 1.1.1 Non-text Content | Images have alt text | Inspect `alt` attributes |
| 1.3.1 Info and Relationships | Headings use h1-h6 | Check semantic HTML |
| 1.3.5 Identify Input Purpose | Autocomplete attributes | Inspect form fields |
| 1.4.3 Contrast (Minimum) | Text ≥ 4.5:1, large ≥ 3:1 | Contrast checker |
| 1.4.11 Non-text Contrast | UI components ≥ 3:1 | Check buttons, inputs |
| 1.4.12 Text Spacing | Works with increased spacing | Apply CSS test |

### Operable

| Criterion | Check | How to Test |
|-----------|-------|-------------|
| 2.1.1 Keyboard | All functions via keyboard | Tab through everything |
| 2.1.2 No Keyboard Trap | Can navigate away | Tab into and out of all areas |
| 2.4.3 Focus Order | Logical tab order | Tab sequence matches visual |
| 2.4.7 Focus Visible | Clear focus indicator | Tab and observe |
| 2.5.8 Target Size | ≥ 24×24 CSS pixels (44×44 recommended) | Measure touch targets |

### Understandable

| Criterion | Check | How to Test |
|-----------|-------|-------------|
| 3.1.1 Language of Page | `lang` attribute | Check `<html lang="en">` |
| 3.2.3 Consistent Navigation | Same nav everywhere | Compare pages |
| 3.3.1 Error Identification | Errors described in text | Submit bad form |
| 3.3.2 Labels or Instructions | Inputs have labels | Check form fields |

### Robust

| Criterion | Check | How to Test |
|-----------|-------|-------------|
| 4.1.2 Name, Role, Value | Custom controls accessible | Screen reader test |

---

## Contrast Ratio

**Formula:**
```
Contrast = (L1 + 0.05) / (L2 + 0.05)

Where L = relative luminance
L = 0.2126×R + 0.7152×G + 0.0722×B
```

**Requirements:**

| Content | Minimum Ratio |
|---------|---------------|
| Normal text (<18pt) | 4.5:1 |
| Large text (≥18pt or ≥14pt bold) | 3:1 |
| UI components | 3:1 |
| Graphical objects | 3:1 |

**Tools:**
- WebAIM Contrast Checker
- Figma plugins (Stark, A11y)
- Browser DevTools

---

## Automated Testing

### axe-core

```javascript
// Install: npm install @axe-core/puppeteer puppeteer
const { AxePuppeteer } = require('@axe-core/puppeteer');
const puppeteer = require('puppeteer');

async function audit(url) {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto(url);
  
  const results = await new AxePuppeteer(page)
    .withTags(['wcag2a', 'wcag2aa', 'wcag22aa'])
    .analyze();
  
  console.log('Violations:', results.violations.length);
  results.violations.forEach(v => {
    console.log(`[${v.impact}] ${v.id}: ${v.description}`);
  });
  
  await browser.close();
}
```

### pa11y

```bash
npm install -g pa11y
pa11y --standard WCAG2AA http://localhost:3000
```

### Lighthouse

```bash
lighthouse http://localhost:3000 --only-categories=accessibility
```

---

## Manual Testing

### Keyboard Navigation

1. Put mouse aside
2. Tab through entire page
3. Check:
   - Can reach all interactive elements?
   - Focus indicator visible?
   - Tab order logical?
   - Can activate buttons with Enter/Space?
   - Can escape modals with Esc?

### Screen Reader Testing

| Screen Reader | Browser | OS |
|---------------|---------|-----|
| VoiceOver | Safari | macOS |
| NVDA | Chrome/Firefox | Windows |
| TalkBack | Chrome | Android |

**Basic test:**
1. Turn on screen reader
2. Navigate through page
3. Can you understand the content?
4. Are images described?
5. Are form fields labeled?

---

## Issue Log Format

```markdown
| ID | WCAG | Issue | Location | Severity | Fix |
|----|------|-------|----------|----------|-----|
| A11Y-001 | 1.4.3 | Contrast 2.8:1 | Figma frame 12:345 → Header title text | Critical | Darken to #374151 |
| A11Y-002 | 2.4.7 | No focus indicator | `prototype.html` SCR-002 `#scr-002` → all buttons | Critical | Add outline style |
| A11Y-003 | 1.1.1 | Missing alt text | `prototype.html` SCR-001 `#scr-001` → hero image | Major | Add descriptive alt |

Location = source → screen/frame ID → element. Every row needs one.
```

---

## Quality Checklist

- [ ] Real design audited; "What was reviewed" table filled (incl. methods that ran)
- [ ] Every issue cites screen/frame/element
- [ ] Checks needing a running build or real colours marked Not Verified when those were unavailable
- [ ] Automated scan run (axe-core) on a running build
- [ ] Contrast ratios verified
- [ ] Keyboard navigation tested
- [ ] Screen reader tested (at least one)
- [ ] All issues logged with severity
- [ ] Remediation guidance provided
- [ ] Critical issues have fixes

---

## Tips

1. **Test early** — accessibility is easier to build in than retrofit
2. **Use real screen readers** — automated tools miss things
3. **Check on mobile** — touch targets, zoom, orientation
4. **Include in QA** — not just a one-time audit
5. **Document exceptions** — if something can't be fixed, document why

---

## Related

- `/product-os:a11y` — Run accessibility audit
- `.claude/agents/accessibility-auditor.md` — Full agent specification
