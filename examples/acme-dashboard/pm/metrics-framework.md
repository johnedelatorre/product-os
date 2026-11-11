# Dashboard Performance — Metrics Framework

**What success looks like, how we measure it, and when we stop; for PM, engineering and data.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | Approved | 2026-11-09 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
This page defines the north star, the leading inputs that move it, the guardrails we must not break, the stop criteria, and the validation plan for each PRD hypothesis. Engineering builds the events in §6; data owns the dashboards; the PM reads §5 to decide launch. Source of truth for goals and hypotheses: [prd.md](prd.md) §2, §4, §10.

## Problem Statement
Enterprise dashboards take 16.4 s (p95) to become usable, with a blank page the whole time; this costs CSAT (2.1/5), support load (47 tickets in 30 days) and puts Acme's $2M ARR at risk. Today we only measure server response time, so we cannot see what users actually wait for.

## Solution
Measure what the user experiences (Time to Interactive in the browser) as the north star, track the inputs engineering controls (skeleton time, first widget time, payload size), protect reliability, database load and cost with guardrails, and validate each PRD hypothesis with a named test and a pass threshold before we rely on it.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| MET-000 Fast dashboard sessions (north star) | 18% | ≥ 95% | `dashboard_interactive.tti_ms` < 3000 |
| MET-001 p95 Time to Interactive | 16.4 s | < 3 s | RUM, rolling 7 days |
| MET-010 Dashboard CSAT | 2.1 / 5 | > 4.0 | Zendesk, 30 days post-GA |
| MET-011 Dashboard tickets / 30 days | 47 | ≤ 23 | Zendesk tags |

## Next Action
Owen Park (Data) builds the "Dashboard Performance" RUM dashboard from the §6 events by 2026-11-20.

---

**Reading key**
1. Metric IDs `MET-###` are stable and trace to PRD goals (`G-#`), hypotheses (`H-#`) and requirements (`REQ-###`).
2. **TBD (owner, date)** = no value yet; the named person provides it. It never blocks the document.

## 1. North Star Metric

| Field | Value |
|-------|-------|
| **ID** | MET-000 |
| **Name** | Fast dashboard sessions |
| **Formula** | Enterprise sessions with `tti_ms` < 3000 ÷ all enterprise `dashboard_viewed` sessions |
| **Current Baseline** | 18% (RUM sample, 14 days to 2026-11-05) |
| **Target** | ≥ 95% within 7 days of GA |
| **Measurement Frequency** | Daily, rolling 7 days; segmented by account and network region |
| **Owner** | Priya Shah |

**Rationale:** a session is only useful once the admin can act on it. A share-of-sessions metric is easier to explain to customers than a percentile and moves with every fix; it equals the p95 target when it reaches 95%.

## 2. Input Metrics (Leading)

| ID | Metric | Formula | Baseline | Target | Owner | Traces to |
|----|--------|---------|----------|--------|-------|-----------|
| MET-002 | Time to skeleton | p95 of `dashboard_skeleton_shown.ms_since_nav` | 16.4 s (blank until loaded) | ≤ 1 s | Tomás Ortega | REQ-001, H-2 |
| MET-003 | Time to first widget | p95 of first `widget_rendered.ms_since_nav` | 16.4 s | ≤ 1.5 s | Tomás Ortega | REQ-002, H-1 |
| MET-004 | Above-the-fold payload | bytes for widgets with `above_fold = true` | 4.1 MB (whole summary) | ≤ 500 KB | Tomás Ortega | REQ-002, REQ-003 |
| MET-005 | Reload-before-load rate | sessions with a reload before `dashboard_interactive` ÷ sessions | 31% (replays) | ≤ 5% | Kenji Mori | H-2 |
| MET-006 | Large-dataset full-range rate | `large_dataset_full_range_clicked` ÷ large-dataset widget views | No baseline yet; measured from beta | < 20% | Kenji Mori | REQ-006, H-4 |

## 3. Outcome Metrics (Lagging)

| ID | Metric | Formula | Baseline | Target | Window | Owner |
|----|--------|---------|----------|--------|--------|-------|
| MET-010 | Dashboard CSAT | Mean CSAT on tickets tagged `dashboard` | 2.1 | > 4.0 | 30 days post-GA | Ruth Adeyemi |
| MET-011 | Dashboard tickets | Count tagged `dashboard` per 30 days | 47 | ≤ 23 | 30 days post-GA | Ruth Adeyemi |
| MET-012 | Weekly active enterprise admins | Admins with ≥ 1 `dashboard_viewed` in week ÷ enterprise admins | TBD (Owen Park, 2026-11-20; PRD Q-2) | +10% at 8 weeks | 8 weeks post-GA | Priya Shah |
| MET-013 | Acme renewal intent | Account team rating after QBR | "At risk" | "Committed" | Acme QBR | Ruth Adeyemi |

## 4. Guardrail Metrics

| ID | Metric | Threshold | Action if Breached | Owner |
|----|--------|-----------|-------------------|-------|
| MET-020 | Widget failure rate (`widget_failed` ÷ widget loads) | ≤ 1% (baseline: 0.6% of loads fail the whole page) | Pause rollout, investigate top failing `widget_id` | Tomás Ortega |
| MET-021 | Reporting DB p95 query time | ≤ +10% vs 2026-11-05 baseline | Lower in-flight cap from 6 to 3 | Tomás Ortega |
| MET-022 | Infrastructure cost for dashboard services | ≤ +15% month on month | Review caching and query plans | Tomás Ortega |
| MET-023 | Data freshness ("Last updated" age at render) | ≤ 5 min p95, same as today | Block any caching change that breaks it | Priya Shah |
| MET-024 | Layout shift when widgets load (CLS) | ≤ 0.1 | Fix skeleton sizes before next phase | Kenji Mori |

## 5. Stop Criteria and Success Criteria

| ID | Condition | Action | Owner | SLA |
|----|-----------|--------|-------|-----|
| STOP-1 | MET-020 > 3% for 1 hour in any phase | Flag `dashboard_progressive_load` off | Tomás Ortega | ≤ 15 min |
| STOP-2 | MET-001 worse than baseline for the flagged cohort for 24 h | Roll back to previous phase | Tomás Ortega | ≤ 1 h |
| STOP-3 | MET-001 still > 6 s after phase 2 | Stop; decide on reporting-backend rewrite | Elena Marsh | Decision within 1 week |
| STOP-4 | MET-021 > +25% for 1 h | Flag off for largest accounts | Tomás Ortega | ≤ 30 min |

### Must have (launch decision)
- [ ] MET-000 ≥ 95% and MET-001 < 3 s for 7 days at GA
- [ ] MET-020 ≤ 1% throughout rollout
- [ ] MET-024 ≤ 0.1

### Should have (30-day review)
- [ ] MET-010 > 4.0
- [ ] MET-011 ≤ 23 tickets
- [ ] MET-006 < 20%

## 6. Measurement Plan

| Metric(s) | Data source | Exists today? | Dashboard | Owner |
|-----------|-------------|---------------|-----------|-------|
| MET-000–005 | RUM events `dashboard_viewed`, `dashboard_skeleton_shown`, `widget_rendered`, `dashboard_interactive` | **New** (REQ-007) | Dashboard Performance | Tomás Ortega (events), Owen Park (dashboard) |
| MET-006 | `large_dataset_full_range_clicked` | **New** | Dashboard Performance | Owen Park |
| MET-010, 011 | Zendesk tags and CSAT | Existing | Dashboard Outcomes | Ruth Adeyemi |
| MET-012 | `dashboard_viewed` + account roster | **New** event, existing roster | Dashboard Outcomes | Owen Park |
| MET-020 | `widget_failed` | **New** | Dashboard Performance + on-call alert | Tomás Ortega |
| MET-021, 022 | Database monitoring, cloud billing | Existing | Platform Health | Tomás Ortega |
| MET-023, 024 | `widget_rendered.data_age_s`; browser CLS | **New** | Dashboard Performance | Tomás Ortega |

Segment every metric by account tier (enterprise / SMB), account and network region. Event definitions: [PRD §11](prd.md#11-analytics--instrumentation).

### Baseline Notes

| Metric | Baseline date | Data quality | Notes |
|--------|---------------|--------------|-------|
| MET-000, 001 | 2026-11-05 | High | 14-day RUM sample from a temporary script; replaced by REQ-007 events |
| MET-005 | 2026-11-04 | Medium | 40 session replays, not a full population |
| MET-006 | — | — | No large-dataset default exists yet; measured from beta |
| MET-012 | — | — | Q-2: Owen Park provides by 2026-11-20 |

## 7. Validation Plan

Each PRD hypothesis is tested before we rely on it. A failed test changes the plan; it does not get re-run until it passes.

| Hypothesis | Experiment / test | When | Success threshold | Decision if it passes | Decision if it fails |
|------------|-------------------|------|-------------------|-----------------------|----------------------|
| H-1 Per-widget calls bring p95 TTI under 3 s | Staging load test on an Acme-sized synthetic workspace (12 widgets, 2M rows), 200 runs | Spike, by 2026-11-12 | p95 TTI < 3 s; MET-021 ≤ +10% | Build REQ-002/003 as specified | Add server-side caching to scope; re-plan with Elena Marsh |
| H-2 Skeleton within 1 s makes the wait feel shorter | Preference test with 8 enterprise admins: [prototype](../design/prototype.html) SCR-001 vs a blank page at equal wait | Design, 2026-11-13 to 11-14 | ≥ 6 of 8 say SCR-001 "feels faster" | Ship REQ-001 first, ahead of backend work | Keep skeleton (accessibility), drop it from the perception claim |
| H-3 Isolated widget failures cut "broken" tickets | Ticket tagging, 30 days pre vs post GA | GA + 30 days | "Dashboard broken" tickets −50% (9 → ≤ 4) | Keep per-widget states as the platform pattern | Review SCR-003 copy with support; run a UX review |
| H-4 Last 30 days covers first-load needs | MET-006 in beta phase 2 (Acme + 5 accounts) | 2026-12-10 to 12-15 | MET-006 < 20% | Keep 30-day default | ≥ 40%: default to full range with progress; 20–40%: test 90 days |

Results are logged in the hypothesis log and summarized on the hub page; the post-launch review reads §5 and §7 together.
