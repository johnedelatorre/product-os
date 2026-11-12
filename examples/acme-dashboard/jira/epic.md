# Dashboard Performance — Jira Epic DASH-100

**The epic exactly as it appears in Jira: Summary field, then the Description field.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | In review | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
This file shows one Jira epic in the format from `docs/reference/document-format.md` §3. Everything inside the box below "Description field" is the complete Jira Description, pasted (or synced by `/product-os:jira-sync`) as is; the line under "Summary field" is the Jira Summary. The epic stays In review until the design critique's Critical and Major findings are closed. The child stories are in [stories.md](stories.md).

## Problem Statement
Enterprise admins wait 16.4 s (p95) at a blank dashboard, and one failed widget breaks the whole page; Acme Corp ($2M ARR) is evaluating competitors ([PRD §1](../pm/prd.md#1-problem-statement)).

## Solution
One epic that delivers the PRD's Must and Should requirements (REQ-001 to REQ-010), split into seven child issues that each ship behind the `dashboard_progressive_load` flag.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| p95 Time to Interactive (MET-001) | 16.4 s | < 3 s | RUM `dashboard_interactive` |
| Dashboard CSAT (MET-010) | 2.1 / 5 | > 4.0 | Zendesk |

## Next Action
Kenji Mori closes the open Critical and Major design critique findings (C-001, M-001 to M-004) by 2026-11-14, so Hana Kim (QA) can run the Definition of Ready check on DASH-101 to DASH-104.

---

## Jira fields

| Field | Value |
|-------|-------|
| Issue type | Epic |
| Key | [DASH-100](https://example.atlassian.net/browse/DASH-100) |
| Labels | `dashboard-performance`, `platform-performance`, `product-os` |
| Owner | Priya Shah |
| Target release | 2026-12-16 (GA) |

## Summary field

```text
Dashboard Performance — Enterprise admins can use the dashboard in under 3 seconds
```

## Description field

```markdown
**Enterprise dashboards show their layout instantly, fill in widget by widget, and never break because one widget fails.**

## Description
This epic replaces the single blocking dashboard request with a skeleton layout and per-widget loading, adds a separate state for every widget problem, defaults very large widgets to the last 30 days, and adds monitoring so slow loads are caught before customers report them. It covers PRD requirements REQ-001 to REQ-010.

## Problem Statement
Enterprise admins (~500 daily) wait 16.4 s (p95) at a blank page before the dashboard is usable, and one failed widget breaks the whole page. Evidence: 47 "slow dashboard" tickets in 30 days (CSAT 2.1/5), 31% of sessions reload before the page finishes, and Acme Corp ($2M ARR) is demoing competitors ahead of its QBR.

## Solution
**In scope:** skeleton layout (REQ-001), per-widget and lazy loading (REQ-002, REQ-003), per-widget error, timeout and no-access states (REQ-004, REQ-005, REQ-010), 30-day default for widgets over 50,000 rows (REQ-006), empty workspace state (REQ-009), RUM events and a p95 alert (REQ-007, REQ-008).
**Out of scope:** new widgets, mobile redesign, real-time refresh.

## Success Metrics
| Metric | Baseline | Target |
|--------|----------|--------|
| Fast dashboard sessions, TTI < 3 s (north star) | 18% | ≥ 95% |
| p95 Time to Interactive, enterprise | 16.4 s | < 3 s |
| Dashboard CSAT | 2.1 / 5 | > 4.0 (30 days post-GA) |
| Dashboard tickets per 30 days | 47 | ≤ 23 |
| Guardrail: widget failure rate | 0.6% of loads fail the page | ≤ 1% of widget loads |

## Stories
Spike first (DASH-107), then the loading core (DASH-101, DASH-102), then states (DASH-103, DASH-104, DASH-105) and the alert (DASH-106). All seven ship behind `dashboard_progressive_load`.

| Story | Summary | Discipline | Points | Status |
|-------|---------|------------|--------|--------|
| DASH-107 | Spike: confirm per-widget endpoints meet p95 < 3 s on an Acme-sized workspace | TBD: Tomás Ortega | 3 | TBD: Tomás Ortega |
| DASH-101 | Show the dashboard layout instantly while widgets load | frontend | 3 | Ready for DoR check |
| DASH-102 | Load each widget on its own so admins can start before everything is ready | frontend + backend | 8 | Ready for DoR check |
| DASH-103 | Keep the dashboard usable when one widget fails | frontend | 5 | Ready for DoR check |
| DASH-104 | Open very large widgets on the last 30 days for big accounts | frontend + backend | 5 | Ready for DoR check |
| DASH-105 | Guide new workspaces to connect a data source | TBD: Marco Silva | 2 | TBD: Marco Silva |
| DASH-106 | Alert on-call when dashboard p95 load time passes 4 seconds | TBD: Tomás Ortega | 2 | TBD: Tomás Ortega |

**Estimation:** 7 issues · 28 points · confidence TBD: set by the team at the DoR check · about 1.3 sprints at 21 points per sprint

## Dependencies
| Dependency | Type | Status |
|------------|------|--------|
| DEP-1 Per-widget endpoints (Platform team) | External | In progress |
| DEP-2 RUM collector supports custom events (Observability) | External | Done |
| DASH-107 spike result | Blocks DASH-101, DASH-102 | TBD: Tomás Ortega |

## Links
PRD: Dashboard Performance — PRD (goals G-1 to G-3; REQ-001 to REQ-010) · Design: User Flows (FLOW-001 to FLOW-003), Wireframes & Prototype (SCR-001 to SCR-005), Design Critique, UX Review, Accessibility Audit · Confluence hub: Dashboard Performance · Metrics: Dashboard Performance — Metrics Framework
```

## Child issues

Jira fields of the child issues (summary, discipline, points and status are in the Description above):

| Key | Type | REQ | Assignee |
|-----|------|-----|----------|
| [DASH-107](https://example.atlassian.net/browse/DASH-107) | Spike | H-1, Q-1 | Tomás Ortega |
| [DASH-101](stories.md#dash-101--show-the-dashboard-layout-instantly-while-widgets-load) | Story | REQ-001 | Lena Fischer |
| [DASH-102](stories.md#dash-102--load-each-widget-on-its-own-so-admins-can-start-before-everything-is-ready) | Story | REQ-002, 003, 007 | Lena Fischer |
| [DASH-103](stories.md#dash-103--keep-the-dashboard-usable-when-one-widget-fails) | Story | REQ-004, 005, 010 | Marco Silva |
| [DASH-104](stories.md#dash-104--open-very-large-widgets-on-the-last-30-days-for-big-accounts) | Story | REQ-006 | Marco Silva |
| [DASH-105](https://example.atlassian.net/browse/DASH-105) | Story | REQ-009 | Marco Silva |
| [DASH-106](https://example.atlassian.net/browse/DASH-106) | Story | REQ-008 | Tomás Ortega |

Four of these are written out in full in [stories.md](stories.md) as format examples.
