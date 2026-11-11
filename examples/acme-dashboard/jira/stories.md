# Dashboard Performance — Jira Stories

**Four child stories of DASH-100 exactly as they appear in Jira: Summary, then Description.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | Ready for DoR check | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
Each story below follows `docs/reference/document-format.md` §4: the heading line is the Jira Summary, the small fields table holds the Jira fields, and the fenced block is the complete Jira Description (nothing is added below it). Every story links back to the PRD requirement, the flow step and the prototype screen it implements. Parent epic: [epic.md](epic.md).

## Problem Statement
Enterprise admins wait 16.4 s (p95) at a blank dashboard and one failed widget breaks the whole page ([PRD §1](../pm/prd.md#1-problem-statement)).

## Solution
Four stories that together deliver the loading core and the problem states: skeleton (DASH-101), per-widget loading (DASH-102), widget problem states (DASH-103) and the large-dataset default (DASH-104).

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| p95 Time to Interactive (MET-001) | 16.4 s | < 3 s | RUM `dashboard_interactive` |
| Widget failure rate (MET-020, guardrail) | 0.6% of loads fail the page | ≤ 1% of widget loads | `widget_failed` |

## Next Action
After Kenji Mori closes design critique C-001 and M-001 to M-004 (due 2026-11-14), Hana Kim (QA) checks all four stories against the Definition of Ready.

---

## Conventions

1. **Test IDs:** each Gherkin scenario is `<KEY>.ACn`, so QA results and PR descriptions can cite them.
2. **Design refs:** SCR-### from [wireframes.md](../design/wireframes.md), opened in [prototype.html](../design/prototype.html) at `#scr-###`; FLOW-### from [flows.md](../design/flows.md). Where the [design critique](../design/design-critique.md) has an open finding on a screen, the acceptance criteria state the fixed behaviour.
3. **Events:** names from [PRD §11](../pm/prd.md#11-analytics--instrumentation).
4. **Rollout:** every story ships behind `dashboard_progressive_load` (default Off).
5. **Points:** Fibonacci, team-calibrated (velocity 21 points per sprint); rationale under Details in each story.

## Definition of Ready / Done

- **DoR:** user story, ≥ 3 Gherkin scenarios, design refs, discipline, points, dependencies, and no open Critical or Major design critique finding on the story's screens.
- **DoD:** acceptance criteria pass; unit and integration tests; events verified in the RUM debugger; PR approved and merged by a human; PM sign-off on staging.

---

## DASH-101 · Show the dashboard layout instantly while widgets load

| Epic | Type | Assignee | Status |
|------|------|----------|--------|
| [DASH-100](epic.md) | Story | Lena Fischer | Ready for DoR check |

**Jira Summary:** `Show the dashboard layout instantly while widgets load`

**Jira Description:**

````markdown
**As an** enterprise admin, **I want** to see the dashboard's layout the moment I open it, **so that** I know it is working and where my numbers will appear.

## Description
Render a skeleton of the dashboard within 1 s of navigation, built from the layout response so it matches the loaded page exactly. Each block is replaced by its widget as data arrives (DASH-102).

## Problem Statement
Today the page is blank for 16.4 s (p95); 31% of sessions reload before it finishes, which restarts the wait.

## Solution
A skeleton built from `/api/dashboard/layout`: same tile count, sizes and order as the loaded dashboard. Loading is announced to screen readers.

## Acceptance Criteria
```gherkin
Feature: Dashboard skeleton

  Scenario: DASH-101.AC1 Skeleton within 1 second
    Given an enterprise admin on a typical connection
    When they open the Dashboard
    Then a skeleton in the dashboard layout is visible within 1 second
    And the event dashboard_skeleton_shown fires with ms_since_nav

  Scenario: DASH-101.AC2 Skeleton matches the loaded layout
    Given a dashboard with 3 KPI tiles and 9 chart or table widgets
    When the skeleton is shown
    Then it shows exactly 3 KPI blocks and 9 widget blocks in the loaded positions
    And layout shift when widgets load is 0.1 or less

  Scenario: DASH-101.AC3 Loading is announced
    Given a screen-reader user opens the Dashboard
    When the skeleton is shown
    Then the dashboard region has aria-busy set to true
    And a polite live region announces "Loading dashboard, 7 widgets"
    And it announces "Dashboard ready" when all above-the-fold widgets have rendered
```

## Design
**Use cases:** UC-1 Open the dashboard; JTBD-1.
**Flow and screens:** FLOW-001 steps 2–3; SCR-001 in the wireframes and the prototype (`#scr-001`).
**States:** loading skeleton (AC1, AC2); loading announced and "Dashboard ready" (AC3). Widget problems are DASH-103; the empty workspace is DASH-105.
**UX requirements:** build to these acceptance criteria, which include the fixes for design critique M-001 (prototype shows 4 KPI blocks; build 3, AC2) and M-002 (loading announcement, AC3). Skeleton blocks stay `aria-hidden`; the pulse stops under `prefers-reduced-motion`; WCAG 2.2 AA (PRD §9).

## Validation
| Check | What proves it |
|-------|----------------|
| Tests | Unit: skeleton renders from a layout fixture. E2E: skeleton visible < 1 s on throttled "Fast 3G". axe scan of SCR-001 |
| Observability | `dashboard_skeleton_shown` |
| Rollout / rollback | Flag on per phase; off restores the current page |
| Success metric | MET-002 time to skeleton (≤ 1 s p95), MET-024 layout shift (≤ 0.1), MET-005 reload-before-load rate |

## Details
| Discipline | Points | Confidence | Dependencies |
|------------|--------|------------|--------------|
| frontend | 3 | TBD: team sets at the DoR check | `/api/dashboard/layout` (DASH-107) |

**Estimate rationale:** one layout call plus a skeleton component; no backend change.
**Out of scope:** loading the widget data itself (DASH-102).

## Links
Epic: DASH-100 · PRD requirements: REQ-001, NFR accessibility · Confluence: Dashboard Performance — Epics & Stories
````

---

## DASH-102 · Load each widget on its own so admins can start before everything is ready

| Epic | Type | Assignee | Status |
|------|------|----------|--------|
| [DASH-100](epic.md) | Story | Lena Fischer | Ready for DoR check |

**Jira Summary:** `Load each widget on its own so admins can start before everything is ready`

**Jira Description:**

````markdown
**As an** enterprise admin, **I want** each widget to appear as soon as its own data is ready, **so that** I can start reading the top numbers without waiting for the whole page.

## Description
Replace the single `GET /api/dashboard/summary` call with one `GET /api/widgets/{id}` request per widget. Above-the-fold widgets load first, at most 6 in flight; below-the-fold widgets load when within 200 px of the viewport. Adds the RUM events the north star depends on.

## Problem Statement
One 4.1 MB response blocks every widget until the slowest one is ready (p95 11.9 s for the call alone).

## Solution
Per-widget requests with a 6-request cap, above-the-fold priority and lazy loading below the fold. Events: `widget_rendered`, `dashboard_interactive`, `dashboard_viewed`. The summary endpoint stays live behind the flag until GA + 30 days.

## Acceptance Criteria
```gherkin
Feature: Progressive widget loading

  Scenario: DASH-102.AC1 Widgets render as their data arrives
    Given the skeleton is shown
    When the Revenue widget's data returns before the Orders widget's data
    Then Revenue renders immediately while Orders still shows its skeleton block

  Scenario: DASH-102.AC2 Above-the-fold first, capped in flight
    Given a dashboard with 12 widgets, 7 above the fold
    When the page loads
    Then the 7 above-the-fold widgets are requested first
    And no more than 6 widget requests are in flight at once

  Scenario: DASH-102.AC3 Lazy loading below the fold
    Given the dashboard is interactive
    When the user scrolls a below-the-fold widget to within 200 px of the viewport
    Then that widget is requested and renders in place of its skeleton block

  Scenario: DASH-102.AC4 Time to Interactive is recorded
    Given all above-the-fold widgets have rendered
    Then dashboard_interactive fires once with tti_ms
    And each widget fires widget_rendered with widget_id, rows and above_fold
```

## Design
**Use cases:** UC-1 Open the dashboard; JTBD-1.
**Flow and screens:** FLOW-001 steps 3–5; SCR-001 to SCR-002 in the prototype (`#scr-001`, `#scr-002`; scroll SCR-002 to see lazy loading).
**States:** loading per widget (AC1); loaded and interactive (AC4); below-the-fold loading on scroll (AC3). Failure states are DASH-103.
**UX requirements:** each widget is a region named by its title; skeleton blocks keep their size so widgets fill in without layout shift (DASH-101.AC2).

## Validation
| Check | What proves it |
|-------|----------------|
| Tests | Unit. Integration: request order and cap against a 12-widget fixture. Load test on the Acme-sized staging workspace: p95 TTI < 3 s, reporting DB p95 ≤ +10% (MET-021) |
| Observability | 4 RUM events; MET-021 DB dashboard |
| Rollout / rollback | Phase 1 internal → phase 2 Acme + 5 → GA; STOP-1/2 roll back via flag |
| Success metric | MET-000 north star, MET-001 p95 TTI, MET-003, MET-004 |

## Details
| Discipline | Points | Confidence | Dependencies |
|------------|--------|------------|--------------|
| frontend + backend | 8 | TBD: team sets at the DoR check | DASH-101; DASH-107 spike result |

**Estimate rationale:** new per-widget endpoint, request scheduler, lazy loading and 4 events.
**Out of scope:** failure states (DASH-103).

## Links
Epic: DASH-100 · PRD requirements: REQ-002, REQ-003, REQ-007 · Confluence: Dashboard Performance — Epics & Stories
````

---

## DASH-103 · Keep the dashboard usable when one widget fails

| Epic | Type | Assignee | Status |
|------|------|----------|--------|
| [DASH-100](epic.md) | Story | Marco Silva | Ready for DoR check |

**Jira Summary:** `Keep the dashboard usable when one widget fails`

**Jira Description:**

````markdown
**As an** enterprise admin, **I want** a failed widget to show what went wrong inside that widget only, **so that** I can keep using the rest of the dashboard and fix or report the one problem.

## Description
Each widget handles its own failure: server error, timeout after 10 s, or no access. Error and timeout offer Retry for that widget only; no access offers Request access. The rest of the page is never blocked or reloaded.

## Problem Statement
Today one failed widget breaks the whole dashboard (0.6% of loads); 9 of 47 tickets in 30 days were "dashboard broken" caused by a single widget.

## Solution
A widget problem component with three visually distinct variants: error ("Couldn't load" + Retry), timeout ("Taking longer than usual" + Retry), no access (lock icon, "You don't have access" + Request access). A second failed retry shows "Still unavailable. Other widgets are fine." with a status page link.

## Acceptance Criteria
```gherkin
Feature: Widget problem states

  Scenario: DASH-103.AC1 Error stays inside the widget
    Given the Revenue by region request returns a server error
    When the dashboard renders
    Then Revenue by region shows the error variant with Retry
    And every other widget stays interactive
    And widget_failed fires with kind "error"

  Scenario: DASH-103.AC2 Retry reloads only that widget
    Given Active users shows the timeout variant
    When the user selects Retry on Active users
    Then only the Active users widget is requested again
    And the page and the other widgets do not reload
    And widget_retry_clicked fires with widget_id and result

  Scenario: DASH-103.AC3 Second failure is explained
    Given a widget's retry has failed
    When the user retries again and it fails
    Then the widget shows "Still unavailable. Other widgets are fine." and a status page link

  Scenario: DASH-103.AC4 No access asks the right person
    Given the user may not view Billing
    When the dashboard renders
    Then Billing shows the no-access variant with Request access and no Retry
    When the user selects Request access
    Then the workspace owner receives a request and the button reads "Requested"
```

## Design
**Use cases:** UC-2 A widget fails; JTBD-2.
**Flow and screens:** FLOW-002 steps 1–5; SCR-003 in the wireframes and the prototype (`#scr-003`).
**States:** error (AC1), timeout with widget-only retry (AC2), second failure (AC3), no access and Requested (AC4), loaded widgets alongside (AC1).
**UX requirements:** build to these acceptance criteria, which include the fixes for design critique C-001 (prototype's Active users Retry reloads the page; build widget-only retry, AC2) and M-003 (three distinct variants, Solution and AC1, AC4). Retry buttons are named per widget for screen readers ("Retry Revenue by region"); problem text is announced in a polite live region.

## Validation
| Check | What proves it |
|-------|----------------|
| Tests | Unit: each variant from a mocked response (500, 10 s timeout, 403). E2E with fault injection: failing one widget leaves the others interactive |
| Observability | `widget_failed`, `widget_retry_clicked`; on-call alert at STOP-1 |
| Rollout / rollback | Same flag as DASH-102 |
| Success metric | MET-020 widget failure rate (guardrail); H-3 ticket reduction measured at GA + 30 days |

## Details
| Discipline | Points | Confidence | Dependencies |
|------------|--------|------------|--------------|
| frontend | 5 | TBD: team sets at the DoR check | DASH-102 |

**Estimate rationale:** one problem component with 3 variants, plus retry and request-access calls.
**Out of scope:** the status page itself.

## Links
Epic: DASH-100 · PRD requirements: REQ-004, REQ-005, REQ-010 · Confluence: Dashboard Performance — Epics & Stories
````

---

## DASH-104 · Open very large widgets on the last 30 days for big accounts

| Epic | Type | Assignee | Status |
|------|------|----------|--------|
| [DASH-100](epic.md) | Story | Marco Silva | Ready for DoR check |

**Jira Summary:** `Open very large widgets on the last 30 days for big accounts`

**Jira Description:**

````markdown
**As an** enterprise admin with very large datasets, **I want** big widgets to open on the last 30 days, **so that** I get a useful view fast and load the full range only when I need it.

## Description
Widgets whose data exceeds 50,000 rows load the last 30 days by default and say so, with a "Load full range" action that shows progress while the full range loads.

## Problem Statement
Acme's Orders widget holds 2.3M rows; loading all of them on every visit is a large part of their 15+ s wait, though most visits only need recent orders.

## Solution
`GET /api/widgets/{id}?range=30d` when the row count is over 50,000; notice "Showing the last 30 days (2.3M rows in total)"; Load full range keeps the 30-day rows visible and shows a progress bar with rows loaded and Cancel. Over 60 s → timeout variant (DASH-103). The threshold is a server setting.

## Acceptance Criteria
```gherkin
Feature: Large dataset default

  Scenario: DASH-104.AC1 Default to the last 30 days
    Given the Orders widget has 2.3M rows for Last 12 months
    When the dashboard loads
    Then Orders shows the last 30 days
    And a notice reads "Showing the last 30 days (2.3M rows in total)"

  Scenario: DASH-104.AC2 Load full range with progress
    Given Orders shows the 30-day notice
    When the user selects Load full range
    Then the 30-day rows stay visible
    And a progress bar shows rows loaded out of 2.3M with a Cancel link
    And progress is announced in a polite live region
    And large_dataset_full_range_clicked fires with widget_id and rows

  Scenario: DASH-104.AC3 Full range times out
    Given the full range has not loaded after 60 seconds
    Then Orders shows the timeout variant with Retry from DASH-103
```

## Design
**Use cases:** UC-3 Large dataset or empty workspace; JTBD-3.
**Flow and screens:** FLOW-003 steps 1b–3a on SCR-004 in the wireframes and the prototype (`#scr-004`; choose "Last 12 months" on SCR-002). Step 3b (timeout) uses the SCR-003 timeout variant from DASH-103.
**States:** 30-day default with notice (AC1), loading full range with progress (AC2), full range shown, timeout (AC3).
**UX requirements:** build to these acceptance criteria, which include the fix for design critique M-004 (prototype hides the rows and shows static text; AC2). Progress is announced in a polite live region.

## Validation
| Check | What proves it |
|-------|----------------|
| Tests | Unit. Integration: threshold boundary at 50,000 and 50,001 rows. Beta read-out |
| Observability | `large_dataset_full_range_clicked`, MET-006 |
| Rollout / rollback | Same flag; the threshold is a server setting, changeable without a deploy |
| Success metric | MET-006 full-range rate < 20% validates H-4; ≥ 40% reverts the default (metrics framework §7) |

## Details
| Discipline | Points | Confidence | Dependencies |
|------------|--------|------------|--------------|
| frontend + backend | 5 | TBD: team sets at the DoR check | DASH-102 |

**Estimate rationale:** `range` parameter, row count check, notice and progress.
**Out of scope:** changing the threshold per account (PRD Q-3 decides the default).

## Links
Epic: DASH-100 · PRD requirement: REQ-006 · Confluence: Dashboard Performance — Epics & Stories
````
