# Dashboard Performance — Low-Fidelity Wireframes

**Structure, content and states for the five dashboard screens; for design review, engineering and QA.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Kenji Mori (Design) | In review | 2026-11-10 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
Low-fi ASCII wireframes for every screen in the [user flows](flows.md): loading, loaded, widget problems, large dataset and empty workspace. Each screen lists its flow and PRD references, and annotations for interactions, responsive behaviour, accessibility and states. The same screens are clickable in [prototype.html](prototype.html); the [design critique](design-critique.md) reviews both.

## Problem Statement
Admins wait 16.4 s (p95) at a blank page and one failed widget breaks the whole dashboard ([PRD §1](../pm/prd.md#1-problem-statement)). The screens must show progress immediately and contain every failure inside its widget.

## Solution
A skeleton in the final layout, widgets that fill in one by one, a distinct in-widget state for each problem, a 30-day default for very large widgets and an empty workspace with one clear next step.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| MET-002 Time to skeleton (p95) | 16.4 s | ≤ 1 s | `dashboard_skeleton_shown` |
| MET-024 Layout shift (CLS) | Not measured (page is blank until loaded) | ≤ 0.1 | Browser CLS |
| H-2 preference test | — | ≥ 6 of 8 admins say SCR-001 feels faster | Prototype session |

## Next Action
Kenji Mori resolves the critique findings C-001 and M-001 to M-004 ([design-critique.md](design-critique.md)) before the H-2 test on 2026-11-13.

---

**Look:** grayscale, system font, 44 px targets, desktop frame 1280 wide; mobile notes per screen. Bottom caption on every screen: screen ID, one-line note.

**ASCII conventions:** `[ Button ]` = primary; `( link )` = secondary / text link; `░░░` = skeleton block; `▢` = logo or icon; `⚠` = problem icon; `▾` = menu.

**Sample content:** workspace "Acme Corp", 12 widgets (3 KPI tiles, 9 charts and tables), figures are fictional.

## 1. Screen inventory

| ID | Name | Breakpoints | Flow | Step | PRD refs |
|----|------|-------------|------|------|----------|
| SCR-001 | Dashboard — loading | Desktop + mobile | FLOW-001, FLOW-002, FLOW-003 | 2–3 | REQ-001, REQ-002 |
| SCR-002 | Dashboard — loaded | Desktop + mobile | FLOW-001 | 4–5 | REQ-002, REQ-003, REQ-007 |
| SCR-003 | Dashboard — widget problems | Desktop + mobile | FLOW-002 | 1–5 | REQ-004, REQ-005, REQ-010 |
| SCR-004 | Dashboard — large dataset | Desktop | FLOW-003 | 1b–3a | REQ-006 |
| SCR-005 | Dashboard — empty workspace | Desktop + mobile | FLOW-003 | 1a | REQ-009 |

## 2. Shared anatomy

**App shell (all screens):** top bar (logo, workspace "Acme Corp ▾", help, avatar); side nav (Dashboard, Reports, Data sources, Settings); page header "Dashboard" with date range "Last 7 days ▾", ( Refresh ) and [ Export ].

**Widget card:** title, body (chart or table), caption "Last updated 2 min ago" bottom right. Every widget loads, fails and retries on its own.

## 3. Screens

### SCR-001 · Dashboard — loading

**Flow:** FLOW-001 steps 2–3 · **Refs:** REQ-001, REQ-002

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│ ▢ Logo   Acme Corp ▾                                                   ( Help )  (◯)    │
├────────────┬────────────────────────────────────────────────────────────────────────────┤
│ Dashboard  │ Dashboard            Last 7 days ▾                  ( Refresh ) [ Export ] │
│ Reports    │                                                                            │
│ Data       │ ┌───────────────┐ ┌───────────────┐ ┌───────────────┐ ┌───────────────┐    │
│  sources   │ │ ░░░░░░░░      │ │ ░░░░░░░░      │ │ ░░░░░░░░      │ │ ░░░░░░░░      │    │
│ Settings   │ │ ░░░░░░░░░░░░  │ │ ░░░░░░░░░░░░  │ │ ░░░░░░░░░░░░  │ │ ░░░░░░░░░░░░  │    │
│            │ └───────────────┘ └───────────────┘ └───────────────┘ └───────────────┘    │
│            │ ┌──────────────────────────────────┐ ┌──────────────────────────────────┐  │
│            │ │ ░░░░░░░░░░░                      │ │ ░░░░░░░░░░░                      │  │
│            │ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │  │
│            │ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │  │
│            │ └──────────────────────────────────┘ └──────────────────────────────────┘  │
│            │ ┌──────────────────────────────────┐ ┌──────────────────────────────────┐  │
│            │ │ ░░░░░░░░░░░                      │ │ ░░░░░░░░░░░                      │  │
│            │ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │  │
│            │ └──────────────────────────────────┘ └──────────────────────────────────┘  │
├────────────┴────────────────────────────────────────────────────────────────────────────┤
│ SCR-001 · Skeleton in under 1 s; widgets replace their block as data arrives            │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

- **Interactions:** page header controls are live while widgets load; each skeleton block is replaced by its widget as data arrives (→ SCR-002).
- **Responsive:** mobile (< 768 px): one column, KPI tiles in a 2 × 2 grid.
- **Accessibility:** skeleton blocks are decorative (`aria-hidden`); focus order: side nav → date range → Refresh → Export.
- **States:** default as shown; if a widget fails → SCR-003; if the workspace has no data source → SCR-005.

### SCR-002 · Dashboard — loaded

**Flow:** FLOW-001 steps 4–5 · **Refs:** REQ-002, REQ-003, REQ-007

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│ ▢ Logo   Acme Corp ▾                                                   ( Help )  (◯)    │
├────────────┬────────────────────────────────────────────────────────────────────────────┤
│ Dashboard  │ Dashboard            Last 7 days ▾                  ( Refresh ) [ Export ] │
│ Reports    │                                                                            │
│ Data       │ ┌──────────────────────┐ ┌──────────────────────┐ ┌──────────────────────┐ │
│  sources   │ │ Active users         │ │ Revenue              │ │ Open tickets         │ │
│ Settings   │ │ 1,284   ▲ 6% vs prev │ │ $412,900  ▲ 3%       │ │ 37   ▼ 12%           │ │
│            │ └──────────────────────┘ └──────────────────────┘ └──────────────────────┘ │
│            │ ┌──────────────────────────────────┐ ┌──────────────────────────────────┐  │
│            │ │ Revenue by region                │ │ Active users (daily)             │  │
│            │ │ NA   ████████████  $198k         │ │     ╱╲    ╱╲__╱                  │  │
│            │ │ EMEA ████████      $131k         │ │ ╱╲_╱  ╲__╱                       │  │
│            │ │ APAC █████         $84k          │ │ Mon  Tue  Wed  Thu  Fri  Sat  Sun │ │
│            │ │            Last updated 2 min ago│ │            Last updated 2 min ago│  │
│            │ └──────────────────────────────────┘ └──────────────────────────────────┘  │
│            │ ┌──────────────────────────────────┐ ┌──────────────────────────────────┐  │
│            │ │ Orders (last 7 days)     3,912   │ │ Billing                          │  │
│            │ │ #10482  Northgate Ltd   $1,240   │ │ Next invoice  Dec 1   $18,400    │  │
│            │ │ #10481  Brightwater Co    $860   │ │ Plan          Enterprise         │  │
│            │ │            Last updated 2 min ago│ │            Last updated 2 min ago│  │
│            │ └──────────────────────────────────┘ └──────────────────────────────────┘  │
│            │ ▼ 5 more widgets load as you scroll (Top accounts, Usage by feature, ...)  │
├────────────┴────────────────────────────────────────────────────────────────────────────┤
│ SCR-002 · Interactive once the 7 above-the-fold widgets render                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

- **Interactions:** date range → reloads every widget (each with its own skeleton); Refresh → same; a widget title → its report; scrolling → below-the-fold widgets load within 200 px of the viewport.
- **Responsive:** mobile: one column; tables show 3 rows and "View all".
- **Accessibility:** each widget is a `region` named by its title; KPI change uses ▲/▼ and text ("up 6%"), not colour alone.
- **States:** default as shown; widget problems → SCR-003; large dataset → SCR-004.

### SCR-003 · Dashboard — widget problems

**Flow:** FLOW-002 steps 1–5 · **Refs:** REQ-004, REQ-005, REQ-010

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│ ▢ Logo   Acme Corp ▾                                                   ( Help )  (◯)    │
├────────────┬────────────────────────────────────────────────────────────────────────────┤
│ Dashboard  │ Dashboard            Last 7 days ▾                  ( Refresh ) [ Export ] │
│ Reports    │ ┌──────────────────────┐ ┌──────────────────────┐ ┌──────────────────────┐ │
│ Data       │ │ Active users  1,284  │ │ Revenue  $412,900    │ │ Open tickets  37     │ │
│  sources   │ └──────────────────────┘ └──────────────────────┘ └──────────────────────┘ │
│ Settings   │ ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐ ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐    │
│            │   Revenue by region                    Active users (daily)                │
│            │   ⚠ Couldn't load this widget.         ⚠ Still loading after 10 seconds.   │
│            │   ( Retry )                            ( Retry )                           │
│            │ └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘ └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘    │
│            │ ┌──────────────────────────────────┐ ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐   │
│            │ │ Orders (last 7 days)     3,912   │   Billing                             │
│            │ │ #10482  Northgate Ltd   $1,240   │   ⚠ You don't have access to Billing. │
│            │ │ #10481  Brightwater Co    $860   │   ( Request access )                  │
│            │ └──────────────────────────────────┘ └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘   │
├────────────┴────────────────────────────────────────────────────────────────────────────┤
│ SCR-003 · One widget's problem never blocks the others                                  │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

- **Interactions:** ( Retry ) on Revenue by region → re-requests that widget only; ( Retry ) on Active users → reloads the dashboard (SCR-001); ( Request access ) → sends a request to the workspace owner, label changes to "Requested". Second failure → "Still unavailable. Other widgets are fine." + ( Status page ).
- **Responsive:** mobile: same states, full width; Retry is a full-width 44 px button.
- **Accessibility:** problem text is announced in a polite live region; Retry is focusable and named "Retry Revenue by region".
- **States:** error (Revenue by region), timeout (Active users), no access (Billing), loaded (Orders, KPI tiles).

### SCR-004 · Dashboard — large dataset

**Flow:** FLOW-003 steps 1b–3a · **Refs:** REQ-006

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│ ▢ Logo   Acme Corp ▾                                                   ( Help )  (◯)    │
├────────────┬────────────────────────────────────────────────────────────────────────────┤
│ Dashboard  │ Dashboard            Last 12 months ▾               ( Refresh ) [ Export ] │
│ Reports    │ ┌──────────────────────────────────────────────────────────────────────┐   │
│ Data       │ │ Orders                                                       58,204  │   │
│  sources   │ │ ┌──────────────────────────────────────────────────────────────────┐ │   │
│ Settings   │ │ │ ▢ Showing the last 30 days (2.3M rows in total).                 │ │   │
│            │ │ │                                         [ Load full range ]      │ │   │
│            │ │ └──────────────────────────────────────────────────────────────────┘ │   │
│            │ │ #10482  Northgate Ltd        Nov 10     $1,240                       │   │
│            │ │ #10481  Brightwater Co       Nov 10       $860                       │   │
│            │ │ #10480  Halcyon Foods        Nov 9      $2,115                       │   │
│            │ │                                          Last updated 2 min ago      │   │
│            │ └──────────────────────────────────────────────────────────────────────┘   │
│            │ After [ Load full range ]:  Orders — "Loading full range…"                 │
├────────────┴────────────────────────────────────────────────────────────────────────────┤
│ SCR-004 · Very large widgets open on the last 30 days; full range on request            │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

- **Interactions:** [ Load full range ] → widget body replaced by "Loading full range…"; on success the full table shows; over 60 s → timeout state (SCR-003).
- **Responsive:** mobile: notice stacks above the table; button full width.
- **Accessibility:** notice is plain text inside the widget region, read before the table.
- **States:** 30-day default (shown), loading full range, full range shown, timeout.

### SCR-005 · Dashboard — empty workspace

**Flow:** FLOW-003 step 1a · **Refs:** REQ-009

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│ ▢ Logo   Acme Corp ▾                                                   ( Help )  (◯)    │
├────────────┬────────────────────────────────────────────────────────────────────────────┤
│ Dashboard  │ Dashboard                                                                  │
│ Reports    │                                                                            │
│ Data       │                ▢                                                           │
│  sources   │                Connect a data source to see your dashboard                 │
│ Settings   │                Your widgets fill in automatically once data arrives.       │
│            │                                                                            │
│            │                [ Connect a data source ]   [ Invite a teammate ]           │
│            │                                                                            │
├────────────┴────────────────────────────────────────────────────────────────────────────┤
│ SCR-005 · No data source yet: one next step                                             │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

- **Interactions:** [ Connect a data source ] → data source setup; [ Invite a teammate ] → invite dialog.
- **Responsive:** mobile: centred, buttons stacked full width.
- **Accessibility:** heading level 2 for the message; buttons in reading order.
- **States:** shown only when the workspace has no data source; Export and date range are hidden.

## 4. Click paths (walk these in the prototype)

1. SCR-001 → SCR-002 (load completes) → scroll.
2. SCR-002 → SCR-003 (simulate a widget failure) → Retry → SCR-002.
3. SCR-002 → SCR-004 (switch to Last 12 months) → Load full range.
4. SCR-005 → Connect a data source.

## 5. Quality checklist

- [x] Every flow screen has a wireframe (SCR-001 to SCR-005)
- [x] Realistic content (fictional Acme figures, no lorem ipsum)
- [x] Annotations: interactions, responsive, accessibility, states
- [x] Flow and PRD references on every screen
- [ ] Critique findings resolved (see [design-critique.md](design-critique.md))
