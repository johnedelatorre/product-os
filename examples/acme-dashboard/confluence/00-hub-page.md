# Dashboard Performance

**The project's home page: what we are doing, why, how we measure it, and every document in one place.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | In design review | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
Start here. This page summarizes the Dashboard Performance project and links every document, grouped the way the work flows: Strategy & Definition, Design, Delivery, Decisions & Launch. Each document carries the same header as this page, so the first screen of any page tells you what it is, the problem, the solution and how success is measured.

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

## Documents in this project

| Document | What it is | Status | Owner |
|----------|-----------|--------|-------|
| [Intake](../intake/intake.md) | The raw request, structured into a problem with evidence | Approved | Priya Shah |
| [Project Brief](../pm/project-brief.md) | One-page summary for executives | Approved | Priya Shah |
| [PRD](../pm/prd.md) | Requirements: what we build and why | Approved | Priya Shah |
| [Metrics Framework](../pm/metrics-framework.md) | North star, guardrails, stop criteria, validation plan | Approved | Priya Shah |
| [User Flows](../design/flows.md) | Step-by-step journeys as diagrams | Approved | Kenji Mori |
| [Wireframes & Prototype](../design/wireframes.md) | Low-fi screens and the [clickable prototype](../design/prototype.html) | In review | Kenji Mori |
| [Design Critique](../design/design-critique.md) | Severity-rated review of the actual prototype | In review | Kenji Mori |
| [UX Review](../design/ux-review.md) | Heuristic evaluation of the same prototype | In review | Kenji Mori |
| [Accessibility Audit](../design/accessibility-audit.md) | WCAG 2.2 AA source audit of the same prototype | In review | Kenji Mori |
| [Epic DASH-100](../jira/epic.md) | Delivery scope as it appears in Jira | In review | Priya Shah |
| [Stories](../jira/stories.md) | Child stories with acceptance criteria | Ready for DoR check | Priya Shah |

## 1. Strategy & Definition
- **Intake:** the Customer Success request and its evidence, with the solution bias ("add a loading skeleton") separated from the real problem.
- **Project Brief:** problem, why now, goals, scope and timeline on one page.
- **PRD:** requirements REQ-001 to REQ-010, hypotheses H-1 to H-4, rollout and risks.
- **Metrics Framework:** how we measure success, what we must not break, when we stop, and how each hypothesis is validated.

## 2. Design
- **User Flows:** FLOW-001 happy path, FLOW-002 widget failures, FLOW-003 empty workspace and large dataset, each with a step table.
- **Wireframes & Prototype:** five low-fi screens (SCR-001 to SCR-005) with annotations, and the same screens as a clickable prototype.
- **Design Critique:** 1 Critical, 4 Major, 3 Minor findings, each pointing at the exact element in the prototype; open Critical and Major findings block the stories' Definition of Ready check.
- **UX Review:** Nielsen's heuristics and Laws of UX applied to the same prototype screens.
- **Accessibility Audit:** WCAG 2.2 AA checks that can be made from the prototype source; checks that need a running build or real colours are marked Not Verified.

## 3. Delivery
- **Epic DASH-100:** the Jira epic, seven child issues; In review until the critique's Critical and Major findings are closed.
- **Stories:** DASH-101 to DASH-104 written out with Gherkin acceptance criteria and links to their flows and screens; ready for the Definition of Ready check.

## 4. Decisions & Launch
- No pages yet. The decision log, event tracking plan, release notes and post-launch review are added here as they are written (post-launch review due 2027-01-15, 30 days after GA).

## Key dates

| Milestone | Date |
|-----------|------|
| PRD approved | 2026-11-08 |
| Design complete | 2026-11-15 |
| Development complete | 2026-12-06 |
| Beta (Acme + 5 accounts) | 2026-12-10 to 2026-12-15 |
| Launch (GA) | 2026-12-16 |
