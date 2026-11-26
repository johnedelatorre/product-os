# [Project Name] — Design Critique

**Severity-rated critique of the actual [project] designs, for the PM, designer and engineering lead.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [name] | Draft / In review / Approved | [YYYY-MM-DD] |

## Description
[2–4 sentences: which designs were critiqued (see §1 What was reviewed), against what (PRD, design brief, brand), and how to use the findings. Score and counts: §2 Summary.]

## Problem Statement
[One or two lines restating the project's problem from the PRD, and how this critique serves it: catching design issues before build.]

## Solution
[One or two lines restating the project's solution, and the critique's recommendation: Approve / Approve with fixes / Revise.]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Critical findings open | [count] | 0 before delivery | This critique |
| [Project metric from metrics framework] | [value or TBD: who provides it] | [value] | [source / event] |

## Next Action
[One action, one owner, e.g. "Designer fixes C-001 and C-002 in SCR-002, then re-run /product-os:critique".]

---

## 1. What was reviewed

Reviews cover the actual design only. No design available: stop and ask the PM for one.

| Artifact | Path or URL | Screens / elements | How it was reviewed | Version reviewed |
|----------|-------------|--------------------|---------------------|------------------|
| [Clickable prototype / Wireframes / Figma / Screenshot] | [e.g. `initiatives/<initiative>/<project>/prototype.html` or Figma link] | [SCR-### IDs, prototype `scr-###` section IDs, Figma node IDs] | [e.g. opened at 1280 px and 390 px; clicked every link; read the source] | [date or commit] |
| PRD | [link] | [REQ IDs traced] | [Traced each requirement to a screen element] | [status, date] |
| Design brief | [link] | [design goals, principles] | [Checked the design against it] | [status, date] |

**Not reviewed:** [screens or frames that exist but were not covered, or "None"]
**Not Verified:** [checks that could not be made and what is missing, e.g. "Contrast: wireframes are grayscale, needs Figma colours", or "None"]

## 2. Summary

**Overall score:** X.X / 5 ([n] dimensions scored; [dimensions] Not Verified)

| Severity | Count |
|----------|-------|
| Critical | X |
| Major | X |
| Minor | X |

**Key findings**
1. [Most important finding]
2. [Second most important finding]
3. [Third most important finding]

## 3. Scorecard

| Dimension | Score (1-5) | Critical | Major | Minor | Notes |
|-----------|-------------|----------|-------|-------|-------|
| Visual Hierarchy | | | | | |
| Layout & Composition | | | | | |
| Typography | | | | | |
| Color | | | | | |
| Spacing & Alignment | | | | | |
| Component Consistency | | | | | |
| Content & Microcopy | | | | | |
| PRD Alignment | | | | | |
| Brand Alignment | | | | | |
| **Overall** | **X.X** | **X** | **X** | **X** | |

A dimension that could not be inspected shows **Not Verified** instead of a score (for example Color on grayscale wireframes).

Score key: 5 Excellent (no issues) · 4 Good (minor issues only) · 3 Acceptable (some major issues, still functional) · 2 Needs work (multiple major issues) · 1 Critical (cannot ship).

## 4. Findings

Severity is written as text: **Critical** (blocks delivery), **Major** (fix before launch), **Minor** (track). IDs: `C-###`, `M-###`, `m-###`.

### [CRITICAL] C-001 [Finding title]

**Location (required):** [Screen → element, with the file line, e.g. SCR-003, Retry button, `prototype.html` line 226 (`#retry-active`); or Figma frame 12:345 → Header]
**Dimension:** [Category from the scorecard]

**Issue:** [What was observed in the design]
**Impact:** [How this affects users and business outcomes]
**Evidence (required):** [Quoted markup or text, screenshot, frame link or measurement from the reviewed design]
**Recommendation:** [Concrete fix with specifics]
**PRD reference:** [REQ-### / flow step]
**Fixed in:** [Story and AC whose acceptance criteria require the fix, e.g. STORY-003.AC2; or "Design file only"]

### [MAJOR] M-001 [Finding title]

**Location (required):** [Screen → element, file line]
**Dimension:** [Category]

**Issue:** [Description]
**Impact:** [Effect on users]
**Evidence (required):** [Quoted markup, text or screenshot]
**Recommendation:** [Specific fix]
**PRD reference:** [REQ-###]
**Fixed in:** [Story and AC, or "Design file only"]

### [MINOR] m-001 [Finding title]

**Location (required):** [Screen → element, file line]
**Dimension:** [Category]
**Issue / impact:** [Brief description]
**Recommendation:** [Quick fix]
**PRD reference:** [REQ-###]

## 5. What works (keep these)

| ID | Positive | Where |
|----|----------|-------|
| P-1 | [Positive observation] | [Screen, element, file line] |

## 6. PRD alignment

| Requirement | Addressed | Notes |
|-------------|-----------|-------|
| REQ-001 | Yes / Partial / No | [Finding IDs or notes] |
| REQ-002 | Yes / Partial / No | [Finding IDs or notes] |

## 7. Fix tracker

| Finding | Severity | Owner | Due | Fixed in | Status |
|---------|----------|-------|-----|----------|--------|
| C-001 | Critical | [name] | [date] | [STORY-XXX.ACn] | Open / Fixed |
| M-001 | Major | [name] | [date] | [STORY-XXX.ACn] | Open / Fixed |
| m-001 | Minor | [name] | [date or "Visual design"] | — | Open / Fixed |

Critical findings are fixed before delivery, Major before launch, Minor are tracked. After the fixes, re-run `/product-os:critique` on the revised files; the page then shows the new findings only.
