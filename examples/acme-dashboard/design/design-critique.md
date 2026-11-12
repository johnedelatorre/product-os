# Dashboard Performance — Design Critique

**Severity-rated review of the actual prototype and wireframes, with a fix for each finding; for design and PM.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Kenji Mori (Design) | In review | 2026-11-10 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
A structured critique of [prototype.html](prototype.html) and [wireframes.md](wireframes.md) (SCR-001 to SCR-005) against the [PRD](../pm/prd.md) and [flows](flows.md). Every finding names the screen, the element and the file line it was observed on, so anyone can open the design and see the same thing. Nothing here is inferred from the PRD alone: if it is not in the design files, it is not a finding.

## Problem Statement
The redesign exists to make the dashboard usable in under 3 s and to keep one widget's failure from blocking the rest ([PRD §1](../pm/prd.md#1-problem-statement)). Design defects that reintroduce full reloads, layout jumps or silent waits would undo those goals before engineering starts.

## Solution
Review the five screens in the prototype and the matching wireframes on 9 dimensions, rate each finding (Critical / Major / Minor), tie it to a requirement, and give a concrete fix. Critical and Major findings are fixed before the H-2 user test.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Open Critical findings | 1 | 0 before the H-2 test (2026-11-13) | This page, §7 |
| Open Major findings | 4 | 0 before design sign-off (2026-11-15) | This page, §7 |
| MET-024 Layout shift (CLS) | Not measured | ≤ 0.1 | Browser CLS in beta ([metrics](../pm/metrics-framework.md)) |

## Next Action
Kenji Mori fixes C-001 and M-001 in prototype.html and wireframes.md by 2026-11-12 (about 1 hour).

---

## 1. What was reviewed

| Artifact | Path | Screens / elements | How it was reviewed | Version reviewed |
|----------|------|--------------------|---------------------|------------------|
| Clickable prototype | [design/prototype.html](prototype.html) | SCR-001 to SCR-005, every link in the prototype bar and each screen's "Prototype:" bar, keys ← → a e r | Opened at 1280 px and 390 px wide; clicked every link and button; read the HTML, CSS and script source | File as of 2026-11-10 |
| Wireframes | [design/wireframes.md](wireframes.md) | SCR-001 to SCR-005 ASCII frames and their annotations | Read each frame against the prototype screen with the same ID | File as of 2026-11-10 |
| User flows | [design/flows.md](flows.md) | FLOW-001 to FLOW-003 step tables | Checked each step has a matching screen state | File as of 2026-11-10 |
| PRD | [pm/prd.md](../pm/prd.md) | REQ-001 to REQ-010, §9 NFRs | Traced each requirement to a screen element | Approved, 2026-11-08 |

**Not reviewed:** visual design (no Figma file exists yet; colour and brand are out of scope at low fidelity) and live code (nothing is built yet). The [UX review](ux-review.md) and [accessibility audit](accessibility-audit.md) review the same files separately.

## 2. Summary

**Overall score:** 3.3 / 5 (7 dimensions scored; Color and Brand not assessed at low fidelity)

| Severity | Count |
|----------|-------|
| Critical | 1 |
| Major | 4 |
| Minor | 3 |

**Key findings**
1. C-001: Retry on the timed-out widget reloads the whole dashboard, which breaks the core promise of REQ-004/005.
2. M-001: the loading skeleton has 4 KPI tiles; the loaded dashboard has 3, so the page jumps when data arrives.
3. M-003: error, timeout and no-access widgets look identical, so users cannot tell which ones they can fix.

## 3. Scorecard

| Dimension | Score (1-5) | Critical | Major | Minor | Notes |
|-----------|-------------|----------|-------|-------|-------|
| Visual Hierarchy | 3 | 0 | 0 | 2 | m-001, m-003 |
| Layout & Composition | 3 | 0 | 1 | 0 | M-001 |
| Typography | 4 | 0 | 0 | 1 | m-002 |
| Color | Not assessed | — | — | — | Grayscale on purpose (low-fi) |
| Spacing & Alignment | 4 | 0 | 0 | 0 | Consistent 12 px grid gap |
| Component Consistency | 3 | 0 | 1 | 0 | M-003 |
| Content & Microcopy | 4 | 0 | 0 | 0 | Clear, honest copy (P-2) |
| PRD Alignment | 2 | 1 | 2 | 0 | C-001, M-002, M-004 |
| Brand Alignment | Not assessed | — | — | — | No brand applied at low fidelity |
| **Overall** | **3.3** | **1** | **4** | **3** | |

## 4. Findings

### [CRITICAL] C-001 Retry on the timed-out widget reloads the whole dashboard

**Location:** SCR-003, "Active users (daily)" widget, Retry button. `prototype.html` line 226 (`#retry-active`); `wireframes.md` SCR-003 Interactions note.
**Dimension:** PRD Alignment

**Issue:** the Revenue by region Retry (`#retry-revenue`, line 223) reloads only its widget, but the Active users Retry is a link to `#scr-001`, the full loading screen. The wireframe annotation says the same: "( Retry ) on Active users → reloads the dashboard (SCR-001)".
**Impact:** a timeout on one widget makes the user wait for all 12 again, the exact behaviour behind 31% of sessions reloading today. It breaks REQ-004/005 and undermines H-3.
**Evidence:** `<a class="btn" id="retry-active" href="#scr-001" aria-label="Retry Active users">Retry</a>`.
**Recommendation:** make it a `<button>` that re-requests the Active users widget in place, using the same handler as `#retry-revenue`; update the wireframe annotation to "re-requests that widget only".
**PRD reference:** REQ-004, REQ-005; FLOW-002 step 3.
**Fixed in:** [DASH-103.AC2](../jira/stories.md#dash-103--keep-the-dashboard-usable-when-one-widget-fails) (Retry reloads only that widget).

### [MAJOR] M-001 Skeleton KPI row does not match the loaded layout

**Location:** SCR-001 KPI row, `prototype.html` lines 130–134 (`.kpi-row.four`, 4 tiles) vs SCR-002 line 164 (`.kpi-row.three`, 3 tiles); `wireframes.md` SCR-001 vs SCR-002 frames.
**Dimension:** Layout & Composition

**Issue:** the skeleton shows four KPI tiles; the dashboard has three (Active users, Revenue, Open tickets). Every tile resizes from 25% to 33% width when data arrives.
**Impact:** visible layout jump at the moment users start reading; breaks REQ-001 ("matching the loaded layout") and risks the MET-024 guardrail (CLS ≤ 0.1).
**Evidence:** `<div class="kpi-row four">` with four `.widget.skeleton` children; `<div class="kpi-row three">` on SCR-002.
**Recommendation:** build the skeleton from the same layout response as the loaded page (`/api/dashboard/layout`, PRD §12) so tile count and sizes always match; change SCR-001 to three tiles.
**PRD reference:** REQ-001; MET-024.
**Fixed in:** [DASH-101.AC2](../jira/stories.md#dash-101--show-the-dashboard-layout-instantly-while-widgets-load) (exactly 3 KPI blocks; layout shift ≤ 0.1).

### [MAJOR] M-002 Loading is silent for screen-reader users

**Location:** SCR-001, `<section id="scr-001">` (line 117) and every skeleton block (lines 131–134, `aria-hidden="true"`); `wireframes.md` SCR-001 Accessibility note ("skeleton blocks are decorative").
**Dimension:** PRD Alignment (accessibility NFR)

**Issue:** all skeleton blocks are hidden from assistive technology, the screen sets no `aria-busy`, and there is no live region, so a screen-reader user hears nothing until widgets appear.
**Impact:** fails the PRD §9 requirement "loading announced to screen readers" (WCAG 2.2 AA, 4.1.3 Status Messages).
**Evidence:** no `aria-busy` or `aria-live` anywhere inside `#scr-001`.
**Recommendation:** set `aria-busy="true"` on the dashboard region while loading and add one polite live region: "Loading dashboard, 7 widgets" then "Dashboard ready". Keep the blocks themselves `aria-hidden`.
**PRD reference:** PRD §9 Accessibility.
**Fixed in:** [DASH-101.AC3](../jira/stories.md#dash-101--show-the-dashboard-layout-instantly-while-widgets-load) (`aria-busy` and polite live region).

### [MAJOR] M-003 Three different problem states share one look

**Location:** SCR-003 widgets Revenue by region (error), Active users (timeout), Billing (no access). CSS `.widget.problem` (line 73); text at lines 222, 225, 232; `wireframes.md` SCR-003 frame (all three use the same dashed box and ⚠).
**Dimension:** Component Consistency

**Issue:** one dashed border, one grey fill and one ⚠ icon for three states that need different responses: retry now, wait and retry, or ask someone for access.
**Impact:** users scanning the page cannot tell which widgets they can fix themselves; no-access looks like an outage and will generate "dashboard broken" tickets (H-3).
**Evidence:** `class="widget problem"` on `#w03-revenue`, `#w03-active` and `#w03-billing`; each message starts with "⚠".
**Recommendation:** three variants with distinct icon and heading: error "Couldn't load" + Retry; timeout "Taking longer than usual" + Retry; no access (lock icon, no dashed border) "You don't have access" + Request access. Name the variants in the design brief so engineering builds one component with three states.
**PRD reference:** REQ-004, REQ-005, REQ-010.
**Fixed in:** [DASH-103](../jira/stories.md#dash-103--keep-the-dashboard-usable-when-one-widget-fails) Solution, AC1 and AC4 (three distinct variants).

### [MAJOR] M-004 "Load full range" hides the data and shows no progress

**Location:** SCR-004 Orders widget, `#load-full` (line 257), `#full-status` (line 258) and the click handler (lines 365–367); `wireframes.md` SCR-004 Interactions note ("widget body replaced by 'Loading full range…'").
**Dimension:** PRD Alignment

**Issue:** clicking Load full range hides the 30-day table and the notice, then shows static text "Loading full range…" for the whole wait. There is no progress indicator, no estimate, and `#full-status` is not a live region.
**Impact:** REQ-006 requires progress; a 2.3M-row load can take up to 60 s, and an empty widget with static text looks frozen, which is the original complaint.
**Evidence:** `document.getElementById('large-notice').hidden = true; table.hidden = true; status.textContent = 'Loading full range…';`.
**Recommendation:** keep the 30-day rows visible while loading; show a progress bar with rows loaded ("640,000 of 2.3M rows"), a Cancel link, and make `#full-status` `aria-live="polite"`.
**PRD reference:** REQ-006; FLOW-003 step 2.
**Fixed in:** [DASH-104.AC2](../jira/stories.md#dash-104--open-very-large-widgets-on-the-last-30-days-for-big-accounts) (rows stay visible, progress bar, Cancel, live region).

### [MINOR] m-001 Two primary buttons compete on the empty state

**Location:** SCR-005, `#connect-source` and `#invite-teammate` (lines 284–285), both `.btn-primary`; `wireframes.md` SCR-005 shows both as `[ ]` primary.
**Dimension:** Visual Hierarchy
**Issue / impact:** the screen's one job is "Connect a data source"; an equal-weight Invite button splits attention on first run.
**Recommendation:** make Invite a secondary `.btn` or a text link below the primary.
**PRD reference:** REQ-009.

### [MINOR] m-002 "Last updated" caption is 11 px

**Location:** SCR-002 and SCR-004 widget captions, CSS `.updated` (line 62, `font-size:11px`).
**Dimension:** Typography
**Issue / impact:** freshness is a guardrail (MET-023) and the only signal that data is current; 11 px grey text is hard to read.
**Recommendation:** 13 px minimum in visual design; keep its position.
**PRD reference:** MET-023.

### [MINOR] m-003 "Load full range" carries the same weight as Export

**Location:** SCR-004, `#load-full` (line 257, `.btn-primary`) and the page header Export (`.btn-primary`).
**Dimension:** Visual Hierarchy
**Issue / impact:** two filled buttons on one screen; the in-widget action reads as the page's main action. H-4 expects fewer than 20% of users to need it.
**Recommendation:** secondary style inside the notice.
**PRD reference:** REQ-006; H-4.

## 5. What works (keep these)

| ID | Positive | Where |
|----|----------|-------|
| P-1 | Failure isolation is visible: Orders and KPI tiles stay live next to failed widgets | SCR-003 |
| P-2 | Honest copy: "Still unavailable. Other widgets are fine." | SCR-003 second Retry (script) |
| P-3 | KPI change uses ▲/▼ and words ("up 6%"), not colour alone | SCR-002 line 165 |
| P-4 | Retry buttons are named per widget for screen readers ("Retry Revenue by region") | SCR-003 line 223 |
| P-5 | Skeleton pulse respects `prefers-reduced-motion` | CSS line 70 |

## 6. PRD alignment

| Requirement | Addressed | Notes |
|-------------|-----------|-------|
| REQ-001 Skeleton matching the loaded layout | Partial | M-001: 4 KPI blocks in the skeleton, 3 when loaded |
| REQ-002 Per-widget loading | Yes | SCR-001 → SCR-002 |
| REQ-003 Lazy loading below the fold | Yes | SCR-002 `#lazy-grid` |
| REQ-004 Error state, widget-only Retry | Partial | C-001 (Active users Retry), M-003 |
| REQ-005 Timeout state with Retry | Partial | C-001, M-003 |
| REQ-006 30-day default with progress | Partial | M-004, m-003 |
| REQ-007 RUM events | Not a design element | Annotated on SCR-002 (`dashboard_interactive`) |
| REQ-008 p95 alert | Not a design element | No user-facing screen |
| REQ-009 Empty workspace | Yes | m-001 (two primary buttons) |
| REQ-010 No-access state | Partial | M-003 |
| PRD §9 Accessibility | Partial | M-002 |

## 7. Fix tracker

| Finding | Severity | Owner | Due | Fixed in | Status |
|---------|----------|-------|-----|----------|--------|
| C-001 | Critical | Kenji Mori | 2026-11-12 | [DASH-103.AC2](../jira/stories.md#dash-103--keep-the-dashboard-usable-when-one-widget-fails) | Open |
| M-001 | Major | Kenji Mori | 2026-11-12 | [DASH-101.AC2](../jira/stories.md#dash-101--show-the-dashboard-layout-instantly-while-widgets-load) | Open |
| M-002 | Major | Kenji Mori | 2026-11-14 | [DASH-101.AC3](../jira/stories.md#dash-101--show-the-dashboard-layout-instantly-while-widgets-load) | Open |
| M-003 | Major | Kenji Mori | 2026-11-14 | [DASH-103 AC1, AC4](../jira/stories.md#dash-103--keep-the-dashboard-usable-when-one-widget-fails) | Open |
| M-004 | Major | Kenji Mori | 2026-11-14 | [DASH-104.AC2](../jira/stories.md#dash-104--open-very-large-widgets-on-the-last-30-days-for-big-accounts) | Open |
| m-001 to m-003 | Minor | Kenji Mori | Visual design | Design file only | Open |

The stories already require the fixed behaviour; the open items are the prototype and wireframes. DASH-101, DASH-103 and DASH-104 stay at "Ready for DoR check" until C-001 and M-001 to M-004 are fixed in the design files.

After the fixes, re-run `/product-os:critique` on the revised files; this page then shows the new findings only.
