# Dashboard Performance — Jira Epic DASH-100

**The epic exactly as it appears in Jira: the one place the team opens to find everything.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | In review | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
This file shows one Jira epic in the format from `docs/reference/document-format.md` §3. The epic is the team's hub: a short summary, who it is for, and a table of links to every handoff output. Everything inside the box below "Description field" is the complete Jira Description, pasted (or synced by `/product-os:jira-sync`) as is. The child stories are in [stories.md](stories.md). The problem, the solution and the success metrics are in the [PRD](../pm/prd.md).

## Next Action
Kenji Mori closes the open Critical and Major design critique findings (C-001, M-001 to M-004) by 2026-11-14, so Hana Kim (QA) can run the Definition of Ready check on DASH-101 to DASH-104.

---

## What Priya chose

The answers to the start questions and the outputs question (`.claude/skills/engineering-handoff.md`), saved in `progress.yaml`:

| Question | Answer |
|----------|--------|
| Who will read what is written? | Engineers |
| What is your role on this project? | Product manager |
| What goes to the team? | The standard handoff |
| What else is attached? | Low-fidelity wireframes |
| Which design is final? | The Claude design (this project has no Figma file) |
| How are tickets organized? | Parent tickets with sub-tasks: frontend, backend, tracking (saved as the team's shape) |

## Jira fields

| Field | Value |
|-------|-------|
| Issue type | Epic |
| Key | [DASH-100](https://example.atlassian.net/browse/DASH-100) |
| Labels | `dashboard-performance`, `platform-performance`, `product-os` |
| Owner | Priya Shah |
| Target release | 2026-12-16 (GA) |
| Web links | One per row of the Handoff table below, so they also show in the epic's links panel |

## Summary field

```text
Dashboard Performance — Enterprise admins can use the dashboard in under 3 seconds
```

## Description field

```markdown
**Enterprise dashboards show their layout instantly, fill in widget by widget, and never break because one widget fails.**

**Start here:** open the handoff prototype for the whole journey, then pick up DASH-107. Everything else you need is in the Handoff table.

## What and why
Enterprise admins wait 16.4 s (p95) at a blank dashboard, and one failed widget breaks the whole page. This epic shows the layout within 1 second, loads each widget on its own, keeps every widget problem inside that widget, and opens very large widgets on the last 30 days. It covers PRD requirements REQ-001 to REQ-010.

## Who it is for
- **Enterprise admin:** opens the dashboard every morning and needs the key numbers right away.
- **Enterprise viewer:** checks weekly summaries and must not be blocked when one widget is unavailable.

## Handoff
| What | Link |
|------|------|
| PRD | Dashboard Performance — PRD |
| Project brief | Dashboard Performance — Project Brief |
| User flows | Dashboard Performance — User Flows (FLOW-001 to FLOW-003) |
| Final design (Claude design) | Dashboard Performance — design screens SCR-001 to SCR-005 |
| UX writing guide | Dashboard Performance — UX Writing Guide (the copy for every screen; the designs already use it) |
| End-to-end prototype | Dashboard Performance — handoff prototype (one path per user) |
| Low-fidelity wireframes | Dashboard Performance — Wireframes |
| Links page | Dashboard Performance (Confluence) |

## Tickets
| Ticket | Summary | Discipline | Points |
|--------|---------|------------|--------|
| DASH-107 | Spike: confirm per-widget loading meets p95 < 3 s on an Acme-sized workspace | backend | 3 (proposed) |
| DASH-101 | Show the dashboard layout instantly while widgets load | frontend | 3 |
| DASH-102 | Load each widget on its own so admins can start before everything is ready | fullstack | 8 |
| DASH-103 | Keep the dashboard usable when one widget fails | frontend | 5 |
| DASH-104 | Open very large widgets on the last 30 days for big accounts | fullstack | 5 |
| DASH-105 | Guide new workspaces to connect a data source | frontend | 2 |
| DASH-106 | Alert on-call when dashboard p95 load time passes 4 seconds | backend | 2 (proposed) |

**Estimate:** 7 tickets · 28 points · about 1.3 sprints at 21 points per sprint

## Dependencies
- Per-widget endpoints (Platform team): in progress. Blocks DASH-102.
- DASH-107 spike result: blocks DASH-101 and DASH-102.

**Feedback:** what was missing, and what was too much? Comment on this epic.
```

## The ticket tree Priya accepted

`/product-os:deliver` proposed this tree, said what it moved, and Priya accepted it before anything was sent to Jira.

```
DASH-100 Dashboard Performance — Enterprise admins can use the dashboard in under 3 seconds
├── DASH-107 Spike: confirm per-widget loading meets p95 < 3 s        3 pts · backend
├── DASH-101 Show the dashboard layout instantly                      3 pts · frontend
├── DASH-102 Load each widget on its own                              8 pts · fullstack
│   ├── [backend]  One request per widget
│   ├── [frontend] Load visible widgets first, the rest on scroll
│   └── [tracking] Fire the load-time events
├── DASH-103 Keep the dashboard usable when one widget fails          5 pts · frontend
├── DASH-104 Open very large widgets on the last 30 days              5 pts · fullstack
│   ├── [backend]  Return the last 30 days for widgets over 50,000 rows
│   └── [frontend] Notice, Load full range and progress
├── DASH-105 Guide new workspaces to connect a data source            2 pts · frontend
└── DASH-106 Alert on-call when p95 load time passes 4 seconds        2 pts · backend
```

What was moved, and why:

1. Merged "Fire the load-time events" into DASH-102: the events cannot ship without per-widget loading.
2. Kept DASH-102 as one ticket of 8 points: the endpoint and the loading order only work together. The reason is in PM notes in [stories.md](stories.md).
3. Put the backend and frontend steps of DASH-102 and DASH-104 under them as sub-tasks instead of separate tickets.

Four of these tickets are written out in full in [stories.md](stories.md) as format examples.
