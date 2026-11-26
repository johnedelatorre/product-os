# [Project Name] — Accessibility Audit

**WCAG 2.2 AA audit of the actual [project] designs, for the PM, designer and engineering.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [name] | Draft / In review / Approved | [YYYY-MM-DD] |

## Description
[2–4 sentences: which designs were audited (see §1 What was reviewed), which test methods ran (§2), the WCAG level, and how to use the findings. Counts: §3 Summary.]

## Problem Statement
[One or two lines restating the project's problem from the PRD, and how this audit serves it: every user can complete the flows.]

## Solution
[One or two lines restating the project's solution, and the audit's recommendation: Approve / Fix critical issues / Full remediation needed.]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| WCAG 2.2 AA failures open | [count] | 0 before launch | This audit |
| Criteria Not Verified | [count] | 0 before launch | This audit |

## Next Action
[One action, one owner.]

---

## 1. What was reviewed

Reviews cover the actual design only. No design available: stop and ask the PM for one.

| Artifact | Path or URL | Screens / elements | How it was reviewed | Version reviewed |
|----------|-------------|--------------------|---------------------|------------------|
| [Clickable prototype / Wireframes / Figma / Live build] | [e.g. `initiatives/<initiative>/<project>/prototype.html`, Figma link or URL] | [SCR-### IDs, prototype `scr-###` section IDs, Figma node IDs] | [e.g. read the HTML source; keyboard pass in a browser] | [date or commit] |

**Not reviewed:** [screens or frames that exist but were not covered, or "None"]
**Not Verified:** [checks that could not be made and what is missing, e.g. "Contrast: wireframes are grayscale, needs Figma colours", or "None"]

## 2. Testing methods

Automated scans, keyboard and screen reader checks need a running build (`prototype.html` in a browser or a live URL); contrast needs real colours (Figma or the built UI). A method that did not run is **Not Verified**, with no results reported.

| Method | Ran? | Against | Notes |
|--------|------|---------|-------|
| Source review (HTML, ARIA, wireframe annotations) | Yes / Not Verified | [prototype.html / wireframes.md] | |
| Automated (axe-core, WAVE) | Yes / Not Verified | [prototype.html / URL] | [what is missing if not run] |
| Keyboard navigation | Yes / Not Verified | [prototype.html / URL] | |
| Screen reader | Yes / Not Verified | [AT + browser] | |
| Color contrast checker | Yes / Not Verified | [Figma / built UI] | |

## 3. Summary

| Standard | Target | Result |
|----------|--------|--------|
| WCAG version | 2.2 | |
| Level | AA | Pass / Fail / Not Verified |
| Critical issues | 0 | [Count] |
| Major issues | 0 | [Count] |

## 4. WCAG 2.2 AA checklist

Status is text: **Pass**, **Fail**, **N/A** or **Not Verified** (say what is needed).

### Perceivable

| Criterion | Status | Notes |
|-----------|--------|-------|
| 1.1.1 Non-text Content | | |
| 1.2.1 Audio/Video | | |
| 1.3.1 Info and Relationships | | |
| 1.4.1 Use of Color | | |
| 1.4.3 Contrast (Minimum) | | |
| 1.4.4 Resize Text | | |

### Operable

| Criterion | Status | Notes |
|-----------|--------|-------|
| 2.1.1 Keyboard | | |
| 2.1.2 No Keyboard Trap | | |
| 2.4.1 Bypass Blocks | | |
| 2.4.3 Focus Order | | |
| 2.4.4 Link Purpose | | |
| 2.4.7 Focus Visible | | |

### Understandable

| Criterion | Status | Notes |
|-----------|--------|-------|
| 3.1.1 Language of Page | | |
| 3.2.1 On Focus | | |
| 3.3.1 Error Identification | | |
| 3.3.2 Labels or Instructions | | |

### Robust

| Criterion | Status | Notes |
|-----------|--------|-------|
| 4.1.1 Parsing | | |
| 4.1.2 Name, Role, Value | | |
| 4.1.3 Status Messages | | |

## 5. Findings

Every issue cites screen, element and file line. Severity is text: **Critical** (blocks a user from completing a flow), **Major** (serious barrier), **Minor**.

| ID | Severity | Issue | WCAG | Location (screen → element, file line; required) | Fix | Fixed in |
|----|----------|-------|------|---------------------------------------------------|-----|----------|
| A11Y-001 | Critical | | | [SCR-### → element, `prototype.html` line n] | | [STORY-XXX.ACn or "Design file only"] |
| A11Y-002 | Major | | | | | |
