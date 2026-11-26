# Dashboard Performance — Jira Stories

**Four child tickets of DASH-100 exactly as they appear in Jira: short enough to read in under a minute.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | Ready for DoR check | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
Each ticket below follows `docs/reference/document-format.md` §4: the heading line is the Jira Summary, the small fields table holds the Jira fields, and the fenced block is the complete Jira Description (nothing is added below it). A ticket has a user story, a short problem, requirements, a link to its own design screen, a "Done when" checklist and an estimate. Parent epic: [epic.md](epic.md), which links to everything else. The problem, the solution and the success metrics are in the [PRD](../pm/prd.md).

## Next Action
After Kenji Mori closes design critique C-001 and M-001 to M-004 (due 2026-11-14), Hana Kim (QA) checks all four tickets against the Definition of Ready.

---

## Conventions

1. **Done when IDs:** each line is `<KEY>.ACn`, so QA results and pull requests can cite them.
2. **Design links:** each ticket links to its own screen, SCR-###, in the final design and in the [handoff prototype](../design/prototype-handoff.html) at `#scr-###`; FLOW-### is from [flows.md](../design/flows.md).
3. **Backend work:** Product OS says what the backend must do and stops. The engineers fill in "Engineering to complete" and confirm the estimate.
4. **Sub-tasks:** the steps inside a ticket. They carry no points; the ticket holds the estimate.
5. **PM notes:** the reasoning behind each estimate, plus tests, tracking and rollout, are at the end of this file and are never sent to Jira.

## Definition of Ready / Done

- **DoR:** user story, problem line, a "Done when" checklist of 3 or more testable lines, its own design link, discipline, points, dependencies, the ticket tree accepted by the PM, and no open Critical or Major design critique finding on the ticket's screens.
- **DoD:** every "Done when" line passes; unit and integration tests; events verified in the RUM debugger; pull request approved and merged by a human; PM sign-off on staging.

---

## DASH-101 · Show the dashboard layout instantly while widgets load

| Epic | Type | Assignee | Status |
|------|------|----------|--------|
| [DASH-100](epic.md) | Story | Lena Fischer | Ready for DoR check |

**Jira Summary:** `Show the dashboard layout instantly while widgets load`

**Jira Description:**

```markdown
**As an** enterprise admin, **I want** to see the dashboard's layout the moment I open it, **so that** I know it is working and where my numbers will appear.

**Problem:** The page is blank for 16.4 s (p95). 31% of sessions reload before it finishes, which restarts the wait.

## Requirements
- Show a skeleton of the dashboard within 1 second of opening it.
- Build the skeleton from the layout response: same tile count, sizes and order as the loaded page.
- Replace each skeleton block with its widget as the data arrives (DASH-102).

## UX and design requirements
- Components: `SkeletonTile`, `SkeletonWidget` from the design system.
- 3 KPI blocks and 9 widget blocks, not 4 KPI blocks (design critique M-001).
- Screen readers hear "Loading dashboard, 7 widgets", then "Dashboard ready" (M-002).
- The pulse animation stops under `prefers-reduced-motion`.

## Design
Final design: SCR-001 Dashboard, loading · Prototype: `prototype-handoff.html#scr-001` · Flow: FLOW-001 steps 2–3
**Copy:** use the copy in the design as is. It has been through the UX writing pass. UX writing guide: Dashboard Performance — UX Writing Guide, SCR-001.

## Done when
- [ ] DASH-101.AC1 A skeleton in the dashboard layout is visible within 1 second on a typical connection.
- [ ] DASH-101.AC2 The skeleton shows exactly the blocks of the loaded page, and layout shift when widgets load is 0.1 or less.
- [ ] DASH-101.AC3 Loading and "Dashboard ready" are announced to screen readers.
- [ ] DASH-101.AC4 `dashboard_skeleton_shown` fires with `ms_since_nav`.

## Estimate
3 points · frontend · PRD: REQ-001 · Depends on: DASH-107
```

---

## DASH-102 · Load each widget on its own so admins can start before everything is ready

| Epic | Type | Assignee | Status |
|------|------|----------|--------|
| [DASH-100](epic.md) | Story | Lena Fischer | Ready for DoR check |

**Jira Summary:** `Load each widget on its own so admins can start before everything is ready`

**Jira Description:**

```markdown
**As an** enterprise admin, **I want** each widget to appear as soon as its own data is ready, **so that** I can start reading the top numbers without waiting for the whole page.

**Problem:** One large response blocks every widget until the slowest one is ready.

## Requirements
- Load each widget with its own request instead of one request for the whole page (PRD REQ-002).
- Load the widgets visible on screen first, at most 6 at a time.
- Load widgets below the fold when they are within 200 px of the screen (REQ-003).
- Record when the dashboard becomes usable (REQ-007).

## UX and design requirements
- Each widget is a region named by its title.
- Skeleton blocks keep their size, so widgets fill in without the page jumping.

## Design
Final design: SCR-001 and SCR-002 Dashboard, loaded · Prototype: `prototype-handoff.html#scr-002` · Flow: FLOW-001 steps 3–5
**Copy:** use the copy in the design as is. It has been through the UX writing pass. UX writing guide: Dashboard Performance — UX Writing Guide, SCR-001 and SCR-002.

## Done when
- [ ] DASH-102.AC1 A widget renders as soon as its own data returns, while slower widgets still show their skeleton block.
- [ ] DASH-102.AC2 With 12 widgets and 7 on screen, the 7 are requested first and no more than 6 requests run at once.
- [ ] DASH-102.AC3 A widget below the fold loads when scrolled to within 200 px of the screen.
- [ ] DASH-102.AC4 `dashboard_interactive` fires once with `tti_ms` when the on-screen widgets have rendered.

## Estimate
8 points (proposed; engineering confirms the backend part) · fullstack · PRD: REQ-002, REQ-003, REQ-007 · Depends on: DASH-101, DASH-107

## Sub-tasks
- [backend] One request per widget
- [frontend] Load visible widgets first, the rest on scroll
- [tracking] Fire the load-time events

## Engineering to complete
- **Approach:**
- **API and data changes:**
- **Risks and unknowns:**
```

---

## DASH-103 · Keep the dashboard usable when one widget fails

| Epic | Type | Assignee | Status |
|------|------|----------|--------|
| [DASH-100](epic.md) | Story | Marco Silva | Ready for DoR check |

**Jira Summary:** `Keep the dashboard usable when one widget fails`

**Jira Description:**

```markdown
**As an** enterprise admin, **I want** a failed widget to show what went wrong inside that widget only, **so that** I can keep using the rest of the dashboard and fix or report the one problem.

**Problem:** One failed widget breaks the whole dashboard today (0.6% of loads). 9 of 47 tickets in 30 days were "dashboard broken" caused by a single widget.

## Requirements
- Each widget handles its own failure: server error, timeout after 10 seconds, or no access.
- Error and timeout offer Retry for that widget only. No access offers Request access.
- A second failed retry shows "Still unavailable. Other widgets are fine." with a link to the status page.
- The rest of the page is never blocked or reloaded.

## UX and design requirements
- Component: `WidgetProblem`, with three variants that look different: error, timeout, no access (design critique M-003).
- Labels: "Couldn't load", "Taking longer than usual", "You don't have access". Buttons: "Retry", "Request access", then "Requested".
- Retry buttons are named per widget for screen readers ("Retry Revenue by region").

## Design
Final design: SCR-003 Dashboard, widget problems · Prototype: `prototype-handoff.html#scr-003` · Flow: FLOW-002 steps 1–5
**Copy:** use the copy in the design as is. It has been through the UX writing pass. UX writing guide: Dashboard Performance — UX Writing Guide, SCR-003.

## Done when
- [ ] DASH-103.AC1 A widget that returns a server error shows the error variant with Retry, and every other widget stays usable.
- [ ] DASH-103.AC2 Retry requests only that widget again; the page and the other widgets do not reload (design critique C-001).
- [ ] DASH-103.AC3 A second failed retry shows "Still unavailable. Other widgets are fine." and the status page link.
- [ ] DASH-103.AC4 A widget the user may not view shows the no-access variant with Request access and no Retry.
- [ ] DASH-103.AC5 `widget_failed` and `widget_retry_clicked` fire with the widget ID.

## Estimate
5 points · frontend · PRD: REQ-004, REQ-005, REQ-010 · Depends on: DASH-102
```

---

## DASH-104 · Open very large widgets on the last 30 days for big accounts

| Epic | Type | Assignee | Status |
|------|------|----------|--------|
| [DASH-100](epic.md) | Story | Marco Silva | Ready for DoR check |

**Jira Summary:** `Open very large widgets on the last 30 days for big accounts`

**Jira Description:**

```markdown
**As an** enterprise admin with very large datasets, **I want** big widgets to open on the last 30 days, **so that** I get a useful view fast and load the full range only when I need it.

**Problem:** Acme's Orders widget holds 2.3M rows. Loading all of them on every visit is a large part of their wait, though most visits only need recent orders.

## Requirements
- A widget with more than 50,000 rows opens on the last 30 days and says so (PRD REQ-006).
- "Load full range" keeps the 30-day rows on screen while the rest loads, with progress and Cancel.
- If the full range has not loaded after 60 seconds, show the timeout variant from DASH-103.
- The 50,000-row threshold can be changed without a release.

## UX and design requirements
- Notice text: "Showing the last 30 days (2.3M rows in total)". Button: "Load full range".
- A progress bar shows rows loaded out of the total; progress is announced to screen readers (design critique M-004).

## Design
Final design: SCR-004 Dashboard, large dataset · Prototype: `prototype-handoff.html#scr-004` · Flow: FLOW-003 steps 1b–3a
**Copy:** use the copy in the design as is. It has been through the UX writing pass. UX writing guide: Dashboard Performance — UX Writing Guide, SCR-004.

## Done when
- [ ] DASH-104.AC1 The Orders widget with 2.3M rows opens on the last 30 days with the notice.
- [ ] DASH-104.AC2 Load full range keeps the 30-day rows visible and shows rows loaded out of the total, with Cancel.
- [ ] DASH-104.AC3 After 60 seconds without the full range, the widget shows the timeout variant with Retry.
- [ ] DASH-104.AC4 `large_dataset_full_range_clicked` fires with the widget ID and row count.

## Estimate
5 points (proposed; engineering confirms the backend part) · fullstack · PRD: REQ-006 · Depends on: DASH-102

## Sub-tasks
- [backend] Return the last 30 days for widgets over 50,000 rows
- [frontend] Notice, Load full range and progress

## Engineering to complete
- **Approach:**
- **API and data changes:**
- **Risks and unknowns:**
```

---

## PM notes (not sent to Jira)

These stay with the PM. `/product-os:jira-sync` never copies this section.

| Ticket | Why this estimate | Tests, tracking and rollout | Metric it moves |
|--------|-------------------|-----------------------------|-----------------|
| DASH-101 | One layout call plus a skeleton component; no backend change. | Unit test from a layout fixture; skeleton visible in under 1 s on throttled "Fast 3G"; axe scan of SCR-001. Flag `dashboard_progressive_load`. | MET-002 time to skeleton, MET-024 layout shift |
| DASH-102 | 8 points, kept as one ticket: per-widget loading, the request order and the events only work together. Splitting it would leave a ticket that cannot ship alone. | Request order and cap against a 12-widget fixture; load test on the Acme-sized staging workspace (p95 under 3 s). Rollout: internal, then Acme plus 5 accounts, then GA; the flag rolls it back. | MET-000 north star, MET-001 p95 time to interactive |
| DASH-103 | One problem component with 3 variants, plus retry and request-access calls. | Each variant from a mocked response (500, 10 s timeout, 403); fault injection on one widget leaves the others usable. Same flag as DASH-102. | MET-020 widget failure rate (guardrail) |
| DASH-104 | A range rule, a row-count check, the notice and progress. | Threshold boundary at 50,000 and 50,001 rows; beta read-out. Same flag; the threshold is a server setting. | MET-006 full-range rate (under 20% validates H-4) |
