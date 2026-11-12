# Dashboard Performance — Accessibility Audit

**WCAG 2.2 AA audit of the actual prototype and wireframes, from their source; for design, PM and engineering.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Kenji Mori (Design) | In review | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
An audit of [prototype.html](prototype.html) and [wireframes.md](wireframes.md) (SCR-001 to SCR-005) against WCAG 2.2 AA. Only a source review ran: the HTML, ARIA, CSS and script were read line by line. Checks that need a running build or real colours (automated scan, keyboard pass, screen reader, contrast) are marked Not Verified with what is needed. Every issue names the screen, the element and the file line.

## Problem Statement
The PRD requires WCAG 2.2 AA and loading announced to screen readers ([PRD §9](../pm/prd.md#9-non-functional-requirements)). A dashboard that loads in pieces is only faster for everyone if each piece, each failure and each wait is announced and reachable by keyboard.

## Solution
Check every criterion the source can prove, log each failure with a fix and the story that carries it, and list what must be tested once the prototype runs in a browser. Recommendation: fix the Major issues before the stories' Definition of Ready check; run the Not Verified checks on the revised prototype.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| WCAG 2.2 AA failures open | 3 criteria (1.3.1, 2.4.3, 4.1.3) | 0 before launch | This audit, §4 |
| Criteria Not Verified | 5 (1.4.3, 1.4.4, 2.1.1, 2.1.2, 2.4.7) | 0 before launch | This audit, §4 |

## Next Action
Priya Shah adds focus-handling and table-header acceptance criteria for A11Y-003 and A11Y-004 to DASH-102, DASH-103 and DASH-104 before the Definition of Ready check.

---

## 1. What was reviewed

| Artifact | Path | Screens / elements | How it was reviewed | Version reviewed |
|----------|------|--------------------|---------------------|------------------|
| Clickable prototype | [design/prototype.html](prototype.html) | SCR-001 to SCR-005 (`#scr-001` to `#scr-005`): markup, ARIA attributes, CSS and every script handler | Source review, line by line | File as of 2026-11-11 |
| Wireframes | [design/wireframes.md](wireframes.md) | SCR-001 to SCR-005 Accessibility annotations | Compared each annotation with the prototype markup | File as of 2026-11-11 |

**Not reviewed:** visual design (no Figma file yet) and live code (nothing is built yet). The prototype bar and "Prototype:" bars are test chrome, not part of the design.
**Not Verified:** contrast (the prototype is grayscale on purpose; needs the visual design colours), resize and reflow, keyboard operation, focus visibility and screen reader output (all need the prototype opened in a browser with a keyboard and a screen reader), automated scan (needs axe-core run against the page in a browser).

## 2. Testing methods

| Method | Ran? | Against | Notes |
|--------|------|---------|-------|
| Source review (HTML, ARIA, wireframe annotations) | Yes | prototype.html, wireframes.md | All findings below come from this |
| Automated (axe-core, WAVE) | Not Verified | — | Needs prototype.html open in a browser with axe-core or WAVE |
| Keyboard navigation | Not Verified | — | Needs a browser; the source uses native links, buttons and selects throughout |
| Screen reader | Not Verified | — | Needs VoiceOver or NVDA with a browser |
| Color contrast checker | Not Verified | — | Needs the visual design; low-fi greys are not the final colours |

## 3. Summary

| Standard | Target | Result |
|----------|--------|--------|
| WCAG version | 2.2 | |
| Level | AA | Fail (3 criteria fail; 5 Not Verified) |
| Critical issues | 0 | 0 |
| Major issues | 0 | 4 |

## 4. WCAG 2.2 AA checklist

### Perceivable

| Criterion | Status | Notes |
|-----------|--------|-------|
| 1.1.1 Non-text Content | Pass | Line chart has `role="img"` and a text alternative (line 175); logo and empty-state icon are decorative and `aria-hidden` (lines 118, 280) |
| 1.2.1 Audio/Video | N/A | No media |
| 1.3.1 Info and Relationships | Fail | A11Y-004: data tables have no header cells |
| 1.4.1 Use of Color | Pass | KPI change uses ▲/▼ and words (lines 165–167); problem states use text, not colour alone |
| 1.4.3 Contrast (Minimum) | Not Verified | Grayscale low-fi; needs visual design colours. The 11 px caption (CSS line 62, critique m-002) should be checked first |
| 1.4.4 Resize Text | Not Verified | Needs 200% zoom in a browser |

### Operable

| Criterion | Status | Notes |
|-----------|--------|-------|
| 2.1.1 Keyboard | Not Verified | Needs a keyboard pass; every action in the source is a native `<a href>`, `<button>` or `<select>` |
| 2.1.2 No Keyboard Trap | Not Verified | Needs a keyboard pass |
| 2.4.1 Bypass Blocks | Pass | Each screen has `<nav aria-label="Main">` and `<main>` landmarks and an `<h1>` (e.g. lines 120–123) |
| 2.4.3 Focus Order | Fail | A11Y-003: focus is lost when the activated button is hidden |
| 2.4.4 Link Purpose | Pass | Link text names its destination; Retry buttons are named per widget (line 223) |
| 2.4.7 Focus Visible | Not Verified | The CSS never removes outlines, so browser focus rings remain; needs a visual check |

### Understandable

| Criterion | Status | Notes |
|-----------|--------|-------|
| 3.1.1 Language of Page | Pass | `<html lang="en">` (line 2) |
| 3.2.1 On Focus | Pass | No script runs on focus |
| 3.3.1 Error Identification | Pass | Each widget problem is described in text (lines 222, 225, 232) |
| 3.3.2 Labels or Instructions | Pass | Date range select is labelled "Date range" (lines 124, 158) |

### Robust

| Criterion | Status | Notes |
|-----------|--------|-------|
| 4.1.1 Parsing | N/A | Removed from WCAG 2.2 |
| 4.1.2 Name, Role, Value | Pass with one issue | Buttons are named; the annotations toggle exposes `aria-pressed` (line 112). A11Y-005: one Retry is a link |
| 4.1.3 Status Messages | Fail | A11Y-001 (loading not announced), A11Y-002 (full-range progress not announced). Widget problems (lines 222, 225, 232) and the invite status (line 287) are live regions |

## 5. Findings

| ID | Severity | Issue | WCAG | Location (screen → element, file line) | Fix | Fixed in |
|----|----------|-------|------|-----------------------------------------|-----|----------|
| A11Y-001 | Major | Loading is silent: every skeleton block is `aria-hidden`, the dashboard sets no `aria-busy`, and SCR-001 has no live region. Same defect as critique M-002 | 4.1.3 | SCR-001 → `<section id="scr-001">` line 117, skeleton blocks lines 131–142; `wireframes.md` SCR-001 Accessibility note | `aria-busy="true"` on the dashboard region while loading; one polite live region: "Loading dashboard, 7 widgets", then "Dashboard ready" | [DASH-101.AC3](../jira/stories.md#dash-101--show-the-dashboard-layout-instantly-while-widgets-load) |
| A11Y-002 | Major | `#full-status` shows "Loading full range…" and then the result, but it is not a live region, so screen-reader users hear neither | 4.1.3 | SCR-004 → Orders → `#full-status`, line 258; script lines 367, 369 | Make the status `aria-live="polite"` and announce progress and completion | [DASH-104.AC2](../jira/stories.md#dash-104--open-very-large-widgets-on-the-last-30-days-for-big-accounts) |
| A11Y-003 | Major | Activating a button hides it, so keyboard focus falls back to the page: Load full range hides the notice that contains it, and a successful Retry hides the Retry button | 2.4.3 | SCR-004 → Load full range, lines 256–257, script line 365; SCR-003 → Revenue by region Retry, line 223, script line 348 | Move focus to the widget heading (or keep a visible control such as Cancel) whenever the focused button disappears | Not yet in a story: add an AC to DASH-103 and DASH-104 |
| A11Y-004 | Major | Data tables use only `<td>` cells, so columns (for example order, customer, date, amount on SCR-004) have no headers for screen readers | 1.3.1 | SCR-002 → Orders and Billing, lines 179, 182; SCR-003 → Orders, line 230; SCR-004 → `#orders-table`, lines 259–263 | Add a header row with `<th scope="col">` (visually hidden if the design hides it) | Not yet in a story: add an AC to DASH-102 and DASH-104 |
| A11Y-005 | Minor | Retry on Active users is a link (`<a href="#scr-001">`), so it is announced as a link that navigates rather than a button that retries | 4.1.2 | SCR-003 → Active users → Retry, line 226 | Make it a `<button>`, as Retry on Revenue by region already is (line 223) | [DASH-103.AC2](../jira/stories.md#dash-103--keep-the-dashboard-usable-when-one-widget-fails) |
