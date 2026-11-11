# Dashboard Performance — User Flows

**Step-by-step journeys for opening the dashboard, widget failures and edge cases; for design, engineering and QA.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Kenji Mori (Design) | Approved | 2026-11-10 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
Three flows show every path a user can take through the new progressive dashboard: the happy path (FLOW-001), widget problems (FLOW-002) and edge cases (FLOW-003). Each flow has a Mermaid diagram and a step table that names the screen (SCR-### in [wireframes.md](wireframes.md) and [prototype.html](prototype.html)) and the PRD requirement. Source of truth: [flows.yaml](flows.yaml); this page is rendered from it.

## Problem Statement
Enterprise admins wait 16.4 s (p95) at a blank page, and one failed widget breaks the whole dashboard ([PRD §1](../pm/prd.md#1-problem-statement)). The flows must show that users always see progress, and that no single widget can block them.

## Solution
Skeleton first, then per-widget loading; every widget problem stays inside that widget with its own recovery; empty workspaces and very large datasets get a clear next step. Every path ends in a next action (no dead ends).

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| MET-002 Time to skeleton (p95) | 16.4 s | ≤ 1 s | `dashboard_skeleton_shown` |
| MET-020 Widget failure rate | 0.6% of loads fail the whole page | ≤ 1% of widget loads, none page-wide | `widget_failed` |
| MET-006 Large-dataset full-range rate | No baseline yet | < 20% | `large_dataset_full_range_clicked` |

Full framework: [metrics-framework.md](../pm/metrics-framework.md).

## Next Action
Kenji Mori runs the H-2 preference test on the prototype with 8 admins on 2026-11-13.

---

## 1. Notation

| Shape | Meaning |
|---|---|
| `([ ])` | Start / end |
| `[ ]` | System step / screen |
| `{ }` | Decision |
| `[/ /]` | User input |
| `[[ ]]` | Sub-flow (another FLOW) |

| Arrow | Meaning |
|---|---|
| `==>` | Primary (happy) path |
| `-->` | Alternate branch |
| `--x` | Error |

| Colour class | State |
|---|---|
| `loading` (gray) | Waiting on data |
| `success` (green) | Goal reached |
| `error` (red) | Failure with recovery |
| `neutral` (blue) | Empty, notice or permission state |

## 2. Flow index and traceability

| Flow | Name | Type | Screens | PRD refs | Stories |
|------|------|------|---------|----------|---------|
| FLOW-001 | Open the dashboard | Happy path | SCR-001, SCR-002 | REQ-001, 002, 003, 007 | DASH-101, DASH-102 |
| FLOW-002 | Widget fails, times out or has no access | Error | SCR-003 | REQ-004, 005, 010 | DASH-103 |
| FLOW-003 | Empty workspace or large dataset | Edge case | SCR-004, SCR-005 | REQ-006, 009 | DASH-104 |

### Required states coverage

| State | Where | Screen |
|-------|-------|--------|
| Happy path | FLOW-001 | SCR-002 |
| Loading | FLOW-001, FLOW-003 | SCR-001, SCR-004 |
| System error | FLOW-002 | SCR-003 (Revenue by region) |
| Timeout | FLOW-002 | SCR-003 (Active users) |
| Permission denied | FLOW-002 | SCR-003 (Billing) |
| Empty state | FLOW-003 | SCR-005 |
| Validation error | Not applicable: the dashboard takes no form input | — |

## 3. Flows

### FLOW-001: Open the dashboard (happy path)

```mermaid
flowchart TD
    start(["START<br/>Admin opens Dashboard"])
    skeleton["SCR-001 · REQ-001<br/>Layout skeleton shown within 1 s"]:::loading
    has_source{"Workspace has a data source?"}
    above_fold["SCR-001 · REQ-002<br/>Above-the-fold widgets load one by one"]:::loading
    widget_ok{"Widget responds within 10 s<br/>with 50,000 rows or fewer?"}
    interactive["SCR-002<br/>Dashboard interactive"]:::success
    scroll[/"User scrolls"/]
    lazy["SCR-002 · REQ-003<br/>Below-the-fold widgets load within 200 px of the viewport"]:::loading
    done(["END · SCR-002<br/>All widgets show data and Last updated time"]):::success
    flow002[["FLOW-002<br/>Widget fails, times out or has no access"]]
    flow003[["FLOW-003<br/>Empty workspace or large dataset"]]
    start ==> skeleton
    skeleton ==> has_source
    has_source ==>|"Yes"| above_fold
    has_source -->|"No"| flow003
    above_fold ==> widget_ok
    widget_ok ==>|"Yes"| interactive
    widget_ok --x|"Error, timeout or 403"| flow002
    widget_ok -->|"Over 50,000 rows"| flow003
    interactive ==> scroll
    scroll ==> lazy
    lazy ==> done
    classDef loading fill:#e5e7eb,stroke:#4b5563
    classDef success fill:#dcfce7,stroke:#166534
```

| Step | Screen | User action | System response | REQ |
|------|--------|-------------|-----------------|-----|
| 1 | — | Opens Dashboard from the side nav | Requests layout (`/api/dashboard/layout`) | REQ-001 |
| 2 | SCR-001 | Waits | Skeleton in the final layout within 1 s; fires `dashboard_skeleton_shown` | REQ-001, REQ-007 |
| 3 | SCR-001 | Waits | Above-the-fold widgets request data in parallel (≤ 6 in flight) and render as each arrives | REQ-002 |
| 4 | SCR-002 | Reads KPIs, filters, clicks into a widget | Fires `dashboard_interactive` when all above-the-fold widgets render | REQ-007 |
| 5 | SCR-002 | Scrolls | Below-the-fold widgets load when within 200 px of the viewport | REQ-003 |

**Scope line:** enterprise and SMB accounts get the same flow; the flag `dashboard_progressive_load` gates it.

### FLOW-002: Widget fails, times out or has no access (error)

```mermaid
flowchart TD
    start(["START · SCR-001<br/>Widget request in flight"]):::loading
    kind{"Failure kind?"}
    error_state["SCR-003 · REQ-004<br/>Couldn't load Revenue by region + Retry"]:::error
    timeout_state["SCR-003 · REQ-005<br/>Still loading after 10 s + Retry"]:::error
    no_access["SCR-003 · REQ-010<br/>You don't have access to Billing + Request access"]:::neutral
    retry[/"Retry (this widget only)"/]
    retry_ok{"Retry succeeds?"}
    widget_shown(["END · SCR-002<br/>Widget shows data; rest unchanged"]):::success
    still_down["SCR-003<br/>Still unavailable. Other widgets are fine. + status page link"]:::error
    continue_node(["END<br/>User continues with the other widgets"])
    request[/"Request access"/]
    requested(["END · SCR-003<br/>Request sent to workspace owner; widget shows Requested"]):::success
    start --> kind
    kind --x|"Server error"| error_state
    kind --x|"No response in 10 s"| timeout_state
    kind -->|"403 no access"| no_access
    error_state --> retry
    timeout_state --> retry
    retry --> retry_ok
    retry_ok ==>|"Yes"| widget_shown
    retry_ok --x|"No"| still_down
    still_down --> continue_node
    no_access --> request
    request ==> requested
    classDef loading fill:#e5e7eb,stroke:#4b5563
    classDef success fill:#dcfce7,stroke:#166534
    classDef error fill:#fee2e2,stroke:#991b1b
    classDef neutral fill:#dbeafe,stroke:#1e40af
```

| Step | Screen | User action | System response | REQ |
|------|--------|-------------|-----------------|-----|
| 1 | SCR-001 | Waits | One widget request returns 5xx, exceeds 10 s, or returns 403; fires `widget_failed` with `kind` | REQ-004, 005, 010 |
| 2 | SCR-003 | Keeps using other widgets | Only the affected widget shows its problem state; all others stay interactive | REQ-004 |
| 3 | SCR-003 | Selects Retry on that widget | Re-requests that widget only; fires `widget_retry_clicked` | REQ-004, 005 |
| 4a | SCR-002 | — | Retry succeeds: widget renders data in place | REQ-004 |
| 4b | SCR-003 | Reads message | Retry fails: "Still unavailable. Other widgets are fine." with status page link | REQ-004 |
| 5 | SCR-003 | Selects Request access (Billing) | Sends request to the workspace owner; widget shows "Requested" | REQ-010 |

**Scope line:** a failure never reloads or blocks the page; the dashboard header and every other widget stay usable.

### FLOW-003: Empty workspace or large dataset (edge cases)

```mermaid
flowchart TD
    start(["START · SCR-001<br/>Dashboard loading"]):::loading
    has_source{"Workspace has a data source?"}
    empty["SCR-005 · REQ-009<br/>Connect a data source to see your dashboard"]:::neutral
    connect[/"Connect a data source"/]
    setup(["END<br/>Data source setup opens"])
    large{"Widget over 50,000 rows?"}
    normal(["END · SCR-002<br/>Normal load, FLOW-001"]):::success
    last30["SCR-004 · REQ-006<br/>Last 30 days + notice + Load full range"]:::neutral
    need_full{"User needs the full range?"}
    keep30(["END · SCR-004<br/>User works with the last 30 days"]):::success
    load_full[/"Load full range"/]
    progress["SCR-004 · REQ-006<br/>Progress shown inside the widget"]:::loading
    full_ok{"Full range loads within 60 s?"}
    full_shown(["END · SCR-004<br/>Full range shown"]):::success
    flow002[["FLOW-002<br/>Timeout state + Retry"]]
    start --> has_source
    has_source -->|"No"| empty
    empty --> connect
    connect ==> setup
    has_source ==>|"Yes"| large
    large ==>|"No"| normal
    large -->|"Yes"| last30
    last30 --> need_full
    need_full ==>|"No"| keep30
    need_full -->|"Yes"| load_full
    load_full --> progress
    progress --> full_ok
    full_ok ==>|"Yes"| full_shown
    full_ok --x|"No"| flow002
    classDef loading fill:#e5e7eb,stroke:#4b5563
    classDef success fill:#dcfce7,stroke:#166534
    classDef neutral fill:#dbeafe,stroke:#1e40af
```

| Step | Screen | User action | System response | REQ |
|------|--------|-------------|-----------------|-----|
| 1a | SCR-005 | Opens a workspace with no data source | Empty state with "Connect a data source" (primary) | REQ-009 |
| 1b | SCR-004 | Opens a workspace where "Orders" has 2.3M rows | Widget loads the last 30 days and shows "Showing the last 30 days (2.3M rows in total)" | REQ-006 |
| 2 | SCR-004 | Selects Load full range | Progress inside the widget; fires `large_dataset_full_range_clicked` | REQ-006 |
| 3a | SCR-004 | — | Full range renders within 60 s | REQ-006 |
| 3b | SCR-003 | — | Over 60 s: timeout state with Retry (FLOW-002) | REQ-005 |

**Scope line:** the 50,000-row threshold is open (PRD Q-3); beta data for H-4 decides.

## 4. Completeness checklist

- [x] All entry points documented (side nav, direct URL; both start at FLOW-001 step 1)
- [x] Every decision has 2+ exits
- [x] Happy path marked with `==>`
- [x] Every error path has a recovery (Retry, Request access, status page)
- [x] Empty state has a CTA
- [x] No dead ends
- [x] Every REQ-001 to REQ-010 traced (REQ-008 alerting has no user-facing flow)
