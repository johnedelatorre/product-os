# Skill: WCAG 2.2 Accessibility Audit

Comprehensive accessibility evaluation with automated and manual testing.

## When to Use

- Before launch (required)
- After major UI changes
- Compliance verification
- Quality gate for prototypes

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
| 2.5.8 Target Size | ≥ 24×24 CSS pixels | Measure touch targets |

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
| A11Y-001 | 1.4.3 | Contrast 2.8:1 | Header text | Critical | Darken to #374151 |
| A11Y-002 | 2.4.7 | No focus indicator | Buttons | Critical | Add outline style |
| A11Y-003 | 1.1.1 | Missing alt text | Hero image | Major | Add descriptive alt |
```

---

## Quality Checklist

- [ ] Automated scan run (axe-core)
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
