# Dashboard Performance

**The project's links page: what we are doing, why, how we measure it, and the handoff the team needs, in one table.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | In design review | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
This is the project's page in Confluence. It summarizes the Dashboard Performance project and lists the handoff: the few outputs engineering and the head of product need. The same links are in the Jira epic, [DASH-100](../jira/epic.md), which is where the team starts. The documents Priya asked for herself sit under the PM workspace page and are not listed here.

## Problem Statement
Enterprise admins wait 16.4 s (p95) at a blank dashboard before they can work, and one failed widget breaks the whole page. Support logged 47 "slow dashboard" tickets in 30 days (CSAT 2.1/5), and Acme Corp ($2M ARR) is evaluating competitors ahead of its QBR. Doing nothing puts Acme and other enterprise renewals at risk.

## Solution
Show the dashboard layout within 1 s, load each widget on its own (visible ones first), keep every widget failure inside that widget with its own recovery, open very large widgets on the last 30 days, and monitor real load times. Out of scope: new widgets, mobile redesign, real-time refresh. Launch: 2026-12-16 behind the `dashboard_progressive_load` flag.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Fast dashboard sessions, TTI < 3 s (north star) | 18% | ≥ 95% | RUM `dashboard_interactive` |
| p95 Time to Interactive, enterprise | 16.4 s | < 3 s at launch | RUM, rolling 7 days |
| Dashboard CSAT | 2.1 / 5 | > 4.0 within 30 days | Zendesk |
| Dashboard tickets per 30 days | 47 | ≤ 23 | Zendesk tags |

Definitions, guardrails, stop criteria and the validation plan: [Metrics Framework](../pm/metrics-framework.md).

## Next Action
Kenji Mori fixes design critique C-001 and M-001 by 2026-11-12, before the H-2 user test on 2026-11-13, and closes M-002 to M-004 by 2026-11-14; Hana Kim (QA) then runs the Definition of Ready check on DASH-101 to DASH-104.

---

## Handoff

Start from the epic: [DASH-100](../jira/epic.md). It has the same links.

| What | Link | Status |
|------|------|--------|
| PRD | [Dashboard Performance — PRD](../pm/prd.md) | Approved |
| Project brief | [Dashboard Performance — Project Brief](../pm/project-brief.md) | Approved |
| User flows | [Dashboard Performance — User Flows](../design/flows.md) | Approved |
| Final design (Claude design) | Screens SCR-001 to SCR-005 | In review |
| UX writing guide | [Dashboard Performance — UX Writing Guide](../design/ux-writing.md): the copy for every screen | In review |
| End-to-end prototype | [Handoff prototype](../design/prototype-handoff.html): pick a user, then one straight path | In review |
| Low-fidelity wireframes (attached by the PM) | [Dashboard Performance — Wireframes](../design/wireframes.md) | In review |
| Epics & Stories | [Epic DASH-100](../jira/epic.md) and its [tickets](../jira/stories.md) | Ready for DoR check |

## Key dates

| Milestone | Date |
|-----------|------|
| PRD approved | 2026-11-08 |
| Design complete | 2026-11-15 |
| Development complete | 2026-12-06 |
| Beta (Acme + 5 accounts) | 2026-12-10 to 2026-12-15 |
| Launch (GA) | 2026-12-16 |
