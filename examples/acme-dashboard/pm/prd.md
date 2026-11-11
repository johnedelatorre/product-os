# Dashboard Performance — PRD

**Requirements for making enterprise dashboards usable in under 3 seconds; for product, design and engineering.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | Approved | 2026-11-08 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
This PRD defines what we build to fix slow dashboard loads for enterprise customers, why, and how we will know it worked. Read the header for the 30-second version; sections 1–19 hold the detail engineering and design build from. Design lives in [flows](../design/flows.md), [wireframes](../design/wireframes.md) and the [prototype](../design/prototype.html); delivery lives in [epic DASH-100](../jira/epic.md).

## Problem Statement
Enterprise admins open the dashboard every morning and wait 16 seconds (p95) looking at a blank page before they can do anything. The page makes one blocking call that fetches all 12 widgets at once, so one slow or failed widget stalls or breaks the whole dashboard. Evidence: 47 "slow dashboard" tickets in 30 days at CSAT 2.1/5, and Acme Corp ($2M ARR) is demoing competitors ahead of its QBR in 6 weeks. Doing nothing risks Acme and other enterprise renewals.

## Solution
Show the dashboard layout instantly, load each widget on its own (visible widgets first, the rest as the user scrolls), keep the page usable when one widget fails, and default very large widgets to the last 30 days. Add real-user monitoring and an alert so regressions are caught before customers report them.
**In scope:** skeleton layout, per-widget loading, lazy loading, per-widget error/timeout/no-access states, large-dataset default, empty workspace state, monitoring.
**Out of scope:** new widgets, mobile redesign, real-time refresh ([project brief](project-brief.md)).

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| p95 Time to Interactive, enterprise (MET-001) | 16.4 s | < 3 s at launch | RUM event `dashboard_interactive` |
| Fast dashboard sessions, TTI < 3 s (north star, MET-000) | 18% | ≥ 95% | `dashboard_interactive.tti_ms` |
| Dashboard CSAT (MET-010) | 2.1 / 5 | > 4.0 within 30 days | Zendesk CSAT, tag `dashboard` |
| Dashboard tickets per 30 days (MET-011) | 47 | ≤ 23 (−50%) | Zendesk keyword + tag |

Full definitions, guardrails and stop criteria: [metrics-framework.md](metrics-framework.md).

### Validation: how we know we are right

| Hypothesis | How we validate it | Status | Metric it moves |
|------------|--------------------|--------|-----------------|
| H-1: Per-widget calls bring p95 TTI under 3 s | Staging load test on an Acme-sized synthetic workspace | Partial | MET-001 p95 TTI, MET-003 time to first widget |
| H-2: Showing the layout within 1 s makes the wait feel shorter | Prototype preference test with 8 admins | Unvalidated | MET-002 time to skeleton, MET-005 reload-before-load rate |
| H-3: Isolating widget failures cuts "dashboard is broken" tickets | Ticket tagging 30 days after GA | Unvalidated | MET-011 dashboard tickets |
| H-4: The last 30 days covers first-load needs for very large widgets | `large_dataset_full_range_clicked` rate in beta | Unvalidated | MET-006 large-dataset full-range rate |

Full hypotheses and assumptions: §2 Hypotheses & Validation. Stop criteria: §16 Rollout Plan.

## Next Action
Tomás Ortega (Eng Lead) confirms the per-widget API split estimate (Q-1) by 2026-11-12.

---

## Document Details

| Field | Value |
|-------|-------|
| **Stage** | Defined (key hypotheses have partial evidence; H-2 and H-4 are validated during design and beta) |
| **Created** | Not recorded in this example |
| **Intake Reference** | [intake.md](../intake/intake.md) |

### Stakeholders

| Role | Name | Responsibility |
|------|------|----------------|
| Product Owner | Priya Shah | Final approver |
| Engineering Lead | Tomás Ortega | Feasibility, delivery |
| Design Lead | Kenji Mori | Flows, wireframes, prototype |
| QA Lead | Hana Kim | Test strategy |
| Data | Owen Park | RUM dashboards, baselines |
| Sponsor | Elena Marsh (VP Product) | Executive oversight |

## 1. Problem Statement

### What's Broken
Enterprise admins cannot start their morning review until every widget has loaded. The page shows nothing while it waits, so users assume it has frozen and reload, which restarts the wait.

### Evidence

| Source | Finding | Confidence |
|--------|---------|------------|
| RUM sample, 14 days, enterprise accounts | TTI p50 6.8 s, p95 16.4 s, p99 24.9 s | High |
| Engineering profiling (2026-11-05) | `GET /api/dashboard/summary` returns all 12 widgets in one 4.1 MB response; p95 11.9 s | High |
| Zendesk | 47 "slow dashboard" tickets in 30 days, CSAT 2.1/5 | High |
| Acme QBR notes | 15+ s first load on their network; competitor demos under way | Medium (one account) |
| Session replays (40 sessions) | 31% of sessions reload the page before it finishes | Medium |

### Impact
- **Who:** enterprise admins (primary), enterprise viewers (secondary).
- **How many:** ~500 admins daily, ~2,000 viewers weekly.
- **Severity:** high; the dashboard is the first screen of the day.
- **Business cost:** $2M ARR at risk (Acme), plus support load and NPS drag.

## 2. Hypotheses & Validation

| ID | Hypothesis | Evidence Status | Validation Method |
|----|------------|-----------------|-------------------|
| H-1 | Splitting the single summary call into per-widget calls brings p95 TTI under 3 s, because 73% of load time is the blocking call. | Partial (profiling) | Staging load test on an Acme-sized synthetic workspace; pass = p95 TTI < 3 s |
| H-2 | Showing the layout within 1 s makes the wait feel shorter even before real speed improves. | Unvalidated | Prototype preference test, 8 admins (SCR-001 vs blank page); pass = 6 of 8 |
| H-3 | Isolating widget failures cuts "dashboard is broken" tickets. | Unvalidated | Ticket tagging 30 days after GA; pass = −50% tickets |
| H-4 | The last 30 days covers what admins need on first load of very large widgets. | Unvalidated | `large_dataset_full_range_clicked` rate in beta; pass = < 20% of large-dataset views |

The full validation plan (experiment → threshold → decision) is in [metrics-framework.md §7](metrics-framework.md#7-validation-plan).

### Assumptions & Provenance

| ID | Assumption | Source | Confidence | Validation Plan |
|----|------------|--------|------------|-----------------|
| A-1 | Widget queries can run in parallel without overloading the reporting database | Tomás Ortega | Medium | Load test in spike (Q-1) |
| A-2 | Viewers tolerate below-the-fold widgets appearing on scroll | Kenji Mori | Medium | Prototype test (H-2 sessions) |
| A-3 | Acme's slow network adds ~2 s over the median account | Acme QBR notes | Low | RUM segment by account |

## 3. Background & Evidence

### Market Context
Competitors Acme is demoing render dashboards progressively; first content appears in about 1 s in their trials (CS notes).

### Research Findings

| Study | Method | Key Finding | Limitations |
|-------|--------|-------------|-------------|
| Session replay review | 40 enterprise sessions | Users reload during the blank wait; most look only at the top 4 widgets first | Small sample |
| Support ticket review | 47 tickets coded by theme | 38 slow load, 9 "dashboard broken" (a single widget failure) | Self-reported |

### Strategic Alignment
- **Company goal:** retain enterprise revenue (FY27 net revenue retention ≥ 110%).
- **Product strategy:** Platform Performance initiative, quality before new features.
- **Why now:** Acme QBR in 6 weeks; ticket volume rising week on week.

## 4. Goals & Non-Goals

### Goals

| ID | Goal | Success Metric | Target | Timeline | Evidence Required |
|----|------|----------------|--------|----------|-------------------|
| G-1 | Reduce load time | p95 TTI, enterprise | < 3 s | Launch | RUM, 7 days post-GA |
| G-2 | Improve perception | Dashboard CSAT | > 4.0 | 30 days post-launch | Zendesk CSAT |
| G-3 | Reduce support load | Dashboard tickets | −50% | 30 days post-launch | Zendesk tags |

### Non-Goals

| Exclusion | Rationale |
|-----------|-----------|
| New widgets | Performance first; feature work waits for the fix |
| Mobile dashboard redesign | Separate initiative; enterprise use is desktop |
| Real-time refresh | Future phase; adds load we are trying to remove |

## 5. User Types & Personas

| Persona | Description | Primary JTBD | Evidence Source |
|---------|-------------|--------------|-----------------|
| Enterprise admin | Opens the dashboard daily to check account health | JTBD-1 | Session replays, tickets |
| Enterprise viewer | Checks weekly summaries | JTBD-2 | Usage logs |

## 6. Jobs-to-be-Done

| ID | When I... | I want to... | So that I... | Priority | Evidence |
|----|-----------|--------------|--------------|----------|----------|
| JTBD-1 | start my day | see the key numbers right away | can spot problems before my standup | Must | Replays, QBR |
| JTBD-2 | one widget's data is unavailable | still use the rest of the dashboard | am not blocked by one failure | Must | 9 "broken" tickets |
| JTBD-3 | my account has very large datasets | get a useful view fast and choose to load more | don't wait for data I didn't need | Should | Acme QBR |

## 7. Use Cases

### UC-1: Open the dashboard (FLOW-001)
**Actor:** Enterprise admin · **Preconditions:** signed in, workspace has data · **Trigger:** opens Dashboard.
**Main Flow:** 1. Layout skeleton appears (SCR-001). 2. Above-the-fold widgets load one by one. 3. Dashboard becomes interactive (SCR-002). 4. Below-the-fold widgets load as the user scrolls.
**Postconditions:** all visible widgets show data with a "Last updated" time.
**Alternative Flows:** very large widget → last 30 days with notice (UC-3).
**Exception Flows:** a widget fails or times out → UC-2.

### UC-2: A widget fails (FLOW-002)
**Main Flow:** the failed widget shows its own problem state with Retry (SCR-003); every other widget keeps working. Retry reloads that widget only. No-access widgets explain why and offer "Request access".

### UC-3: Large dataset or empty workspace (FLOW-003)
**Main Flow:** a widget over 50,000 rows loads the last 30 days and shows a notice with "Load full range" (SCR-004). A workspace with no data source shows an empty state with "Connect a data source" (SCR-005).

## 8. Functional Requirements

| ID | Requirement | Priority | JTBD | Stage | Notes |
|----|-------------|----------|------|-------|-------|
| REQ-001 | Render the dashboard layout skeleton within 1 s of navigation, matching the loaded layout | Must | JTBD-1 | Defined | SCR-001 |
| REQ-002 | Load each widget through its own request; above-the-fold widgets first | Must | JTBD-1 | Defined | SCR-002; depends on DEP-1 |
| REQ-003 | Lazy-load below-the-fold widgets when within 200 px of the viewport | Must | JTBD-1 | Defined | SCR-002 |
| REQ-004 | A failed widget shows an error state with Retry that reloads that widget only; the rest stays usable | Must | JTBD-2 | Defined | SCR-003 |
| REQ-005 | A widget with no response after 10 s shows a timeout state with Retry | Must | JTBD-2 | Defined | SCR-003 |
| REQ-006 | Widgets over 50,000 rows default to the last 30 days, with a notice and "Load full range" showing progress | Should | JTBD-3 | Defined | SCR-004 |
| REQ-007 | Send RUM events for skeleton, widget render, interactive and widget failure | Must | — | Defined | §11 |
| REQ-008 | Alert on-call when p95 TTI > 4 s for 30 minutes | Should | — | Defined | Ops tooling |
| REQ-009 | A workspace with no data source shows an empty state with "Connect a data source" | Should | JTBD-1 | Defined | SCR-005 |
| REQ-010 | A widget the user may not view shows a no-access state with "Request access" | Should | JTBD-2 | Defined | SCR-003 |

## 9. Non-Functional Requirements

| Category | Requirement | Target | Current | Priority |
|----------|-------------|--------|---------|----------|
| Performance | p95 Time to Interactive, enterprise | < 3 s | 16.4 s | Must |
| Performance | p95 time to skeleton | ≤ 1 s | 16.4 s (blank until loaded) | Must |
| Scalability | Parallel widget requests per page | ≤ 6 in flight | 1 | Must |
| Accessibility | WCAG level; loading announced to screen readers | 2.2 AA | Not announced | Must |
| Reliability | Dashboard availability | 99.9% | 99.4% (one failure breaks all) | Must |

## 10. Success Metrics

### Primary Metrics

| Metric | Formula | Baseline | Target | Measurement Window |
|--------|---------|----------|--------|--------------------|
| MET-000 Fast dashboard sessions | sessions with `tti_ms` < 3000 ÷ all sessions, enterprise | 18% | ≥ 95% | Rolling 7 days |
| MET-001 p95 TTI | p95 of `dashboard_interactive.tti_ms` | 16.4 s | < 3 s | Rolling 7 days |
| MET-010 Dashboard CSAT | mean CSAT on `dashboard` tickets | 2.1 | > 4.0 | 30 days post-GA |
| MET-011 Dashboard tickets | count per 30 days | 47 | ≤ 23 | 30 days post-GA |

### Guardrail Metrics

| Metric | Threshold | Stop Criteria | Action if Breached |
|--------|-----------|---------------|-------------------|
| MET-020 Widget failure rate | ≤ 1% of widget loads | > 3% for 1 h | Flag off, investigate |
| MET-021 Reporting DB p95 query time | ≤ +10% vs baseline | > +25% for 1 h | Lower parallel cap to 3 |
| MET-022 Infra cost | ≤ +15% | > +25% for 7 days | Review caching plan |

### Instrumentation vs Outcomes

| Metric Type | Example | What It Proves |
|-------------|---------|----------------|
| Instrumentation | `widget_rendered` fires once per widget | Tracking works |
| Adoption | 100% of enterprise sessions on progressive load | Rollout reached users |
| Outcome | CSAT > 4.0, tickets −50% | Customers feel the difference |

## 11. Analytics & Instrumentation

### Events

| Event Name | Trigger | Properties | Purpose |
|------------|---------|------------|---------|
| `dashboard_viewed` | Navigation to Dashboard | `account_tier`, `widget_count` | Session denominator |
| `dashboard_skeleton_shown` | Skeleton painted | `ms_since_nav` | REQ-001 |
| `widget_rendered` | A widget shows data | `widget_id`, `ms_since_nav`, `rows`, `above_fold` | REQ-002/003 |
| `dashboard_interactive` | All above-the-fold widgets rendered | `tti_ms` | MET-000, MET-001 |
| `widget_failed` | Error, timeout or no access | `widget_id`, `kind` (error/timeout/no_access) | MET-020 |
| `widget_retry_clicked` | Retry on a widget | `widget_id`, `result` | REQ-004/005 |
| `large_dataset_full_range_clicked` | "Load full range" | `widget_id`, `rows` | H-4 |

### Dashboards

| Dashboard | Metrics | Audience | Update Frequency |
|-----------|---------|----------|------------------|
| Dashboard Performance | MET-000, 001, 020–022 | Eng, PM | Real time |
| Dashboard Outcomes | MET-010, 011 | PM, CS, Sponsor | Weekly |

## 12. Technical Needs

| Endpoint | Method | Purpose | Owner |
|----------|--------|---------|-------|
| `/api/dashboard/layout` | GET | Widget list and positions for the skeleton | Platform team |
| `/api/widgets/{id}` | GET | One widget's data; `range` param for large datasets | Platform team |

`/api/dashboard/summary` stays live behind the flag until GA + 30 days.

## 13. Dependencies

| ID | Dependency | Team/System | Status | Risk Level | Mitigation |
|----|------------|-------------|--------|------------|------------|
| DEP-1 | Per-widget endpoints | Platform team | In progress | Medium | Spike first (Q-1) |
| DEP-2 | RUM collector supports custom events | Observability | Done | Low | — |

## 14. Risks & Mitigations

| ID | Risk | Probability | Impact | Score | Mitigation | Owner |
|----|------|-------------|--------|-------|------------|-------|
| R-1 | Backend split takes longer than planned | M | H | 6 | Early spike; ship skeleton first | Tomás Ortega |
| R-2 | Acme QBR lands before GA | M | H | 6 | Acme in beta phase 2 | Ruth Adeyemi |
| R-3 | Parallel queries overload the reporting DB | L | H | 3 | Cap at 6 in flight; MET-021 guardrail | Tomás Ortega |

## 15. Alternatives Considered

| Option | Description | Pros | Cons | Why Not Selected |
|--------|-------------|------|------|------------------|
| Progressive per-widget load + skeleton | This PRD | Fixes cause and perception | Backend work | **Selected** |
| Skeleton only | The intake's original ask | 1 week | p95 stays 16 s | Treats the symptom |
| Cache the summary response | Precompute nightly | Fast reads | Stale data; breaks freshness promise | Freshness guardrail |

## 16. Rollout Plan

| Phase | Scope | Success Criteria | Rollback Trigger |
|-------|-------|------------------|------------------|
| 1 | Internal workspaces, from 2026-12-09 | p95 TTI < 3 s; MET-020 ≤ 1% | Any guardrail breach |
| 2 | Acme + 5 enterprise accounts, 2026-12-10 to 12-15 | Same, plus no P1 bugs | Guardrail breach or Acme escalation |
| GA | 100%, 2026-12-16 | Same for 7 days | Guardrail breach |

**Feature flag:** `dashboard_progressive_load`, default Off, rollback owner Tomás Ortega (SLA 15 min).
**Stop criteria:** if p95 TTI is still > 6 s after phase 2, Elena Marsh decides whether to stop and re-scope to a reporting-backend rewrite.

## 17. Open Questions

| ID | Question | Owner | Due Date | Resolution | Status |
|----|----------|-------|----------|------------|--------|
| Q-1 | Can the per-widget split ship by Dec 6? | Tomás Ortega | 2026-11-12 | — | Open |
| Q-2 | Weekly active enterprise admins baseline | Owen Park | 2026-11-20 | — | Open |
| Q-3 | Is 50,000 rows the right large-dataset threshold? | Kenji Mori | 2026-11-15 | H-4 beta data decides | Open |

## 18. AI Feature Specification
Not applicable: no AI or ML component.

## 19. Appendix
Intake: [intake.md](../intake/intake.md) · Brief: [project-brief.md](project-brief.md) · Profiling notes: Platform team Confluence page "Dashboard summary call profile".
