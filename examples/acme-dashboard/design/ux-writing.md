# Dashboard Performance — UX Writing Guide

**The voice, the words and the final copy for every dashboard screen, for the PM, the designer and the engineers.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Kenji Mori (Design) | In review | 2026-11-12 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
The UX writing pass covered the five dashboard screens (SCR-001 to SCR-005) in [prototype-handoff.html](prototype-handoff.html) and [wireframes.md](wireframes.md), together with the [design critique](design-critique.md). The voice was taken from three screenshots of the current dashboard that Priya Shah supplied. The designs already carry this copy: build it as it appears in the design.

## Problem Statement
Enterprise admins wait 16.4 s (p95) at a blank dashboard, and one failed widget breaks the whole page. When something is slow or missing, the copy has to say which widget, why, and what to do next.

## Solution
The layout shows within 1 second and each widget loads, fails and retries on its own. The copy keeps every message inside its widget, names the action on the button, and never blames the user.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Screens with approved copy applied in the design | 0 of 5 | 5 of 5 before delivery | §5 Copy by screen |
| Dashboard load time (p95) for enterprise workspaces | 16.4 s | Under 3 s | PRD success metrics |

## Next Action
Priya Shah checks that DASH-101 to DASH-105 carry the Copy line before the Jira sync, now that all five screens are marked applied.

---

## 1. What was reviewed

| Artifact | Path or URL | Screens | Version reviewed |
|----------|-------------|---------|------------------|
| Handoff prototype | [prototype-handoff.html](prototype-handoff.html) | SCR-001 to SCR-004 | 2026-11-12 |
| Wireframes | [wireframes.md](wireframes.md) | SCR-005 | 2026-11-12 |
| Full prototype | [prototype.html](prototype.html) | SCR-003, second failed retry | 2026-11-12 |
| PRD | [prd.md](../pm/prd.md) | REQ-001 to REQ-010 | 2026-11-11 |
| Prior designs, screenshots or a style guide | Three screenshots of the current dashboard, supplied by Priya Shah. Acme has no written style guide. | — | 2026-11-11 |
| Design critique | [design-critique.md](design-critique.md) | Content & Microcopy: no open findings. Practice P-2 (honest copy on a second failed retry) is kept. | 2026-11-10 |

**Not reviewed:** None

## 2. Voice and tone

| Rule | Example |
|------|---------|
| Plain words an admin already uses | "Last 30 days", not "Trailing 30-day window" |
| Say what is happening, not that something is wrong | "Taking longer than usual" |
| Keep a problem inside its widget | "Couldn't load", on the widget, not as a page banner |
| The button names the next step | "Request access" |

**Readers:** Enterprise admins and viewers who open the dashboard daily or weekly. They scan numbers and do not read paragraphs.
**Languages:** English is the source. No translation in this release.

## 3. Words we use

| Thing | Use | Do not use | Why |
|-------|-----|------------|-----|
| One block on the dashboard | widget | tile, card, panel | Matches the current dashboard and the help center |
| The page | dashboard | home, overview | Matches the side navigation |
| A customer's space | workspace | account, org | Matches the workspace switcher in the top bar |
| Where data comes from | data source | integration, connector | Matches the Data sources page |
| Loading the rest of a large widget | Load full range | Show all, Load more | Says exactly what loads |

## 4. Patterns

| Element | Rule for this product | Example |
|---------|-----------------------|---------|
| Button | Verb plus object, or the one verb that fits a widget | "Retry", "Connect a data source" |
| Slow widget | Say it is slow, offer the action | "Taking longer than usual" · "Retry" |
| Failed widget | Say it did not load, offer the action | "Couldn't load" · "Retry" |
| No permission | Say what the user lacks, offer the request | "You don't have access" · "Request access" |
| Reduced data | Say what is shown and how much exists | "Showing the last 30 days (2.3M rows in total)" |
| Empty state | What to do first, then what happens after | "Connect a data source to see your dashboard" |

## 5. Copy by screen

The copy here is final: build it as written.

### SCR-001 Dashboard, loading

**Applied in the design:** Yes, 2026-11-12

| Element | Final copy |
|---------|------------|
| Page title | Dashboard |
| Date range | Last 30 days |
| Widget placeholders | No text. The layout blocks stand in for each widget. |

### SCR-002 Dashboard, loaded

**Applied in the design:** Yes, 2026-11-12

| Element | Final copy |
|---------|------------|
| Page title | Dashboard |
| Date range | Last 30 days |
| Widget titles | Revenue · Orders · Active users · Revenue by region · Orders over time · Top accounts · Billing |
| Widget caption | Last updated 09:02 |

### SCR-003 Dashboard, one widget has a problem

**Applied in the design:** Yes, 2026-11-12

| Element | Final copy |
|---------|------------|
| Slow widget, message | Taking longer than usual |
| Slow widget, button | Retry |
| Failed widget, message | Couldn't load |
| Failed widget, button | Retry |
| Second failed retry, message | Still unavailable. Other widgets are fine. |
| No-access widget, message | You don't have access |
| No-access widget, button | Request access |

### SCR-004 Dashboard, very large widget

**Applied in the design:** Yes, 2026-11-12

| Element | Final copy |
|---------|------------|
| Widget title | Orders |
| Date range | Last 12 months |
| Reduced-data notice | Showing the last 30 days (2.3M rows in total) |
| Button | Load full range |

### SCR-005 Dashboard, empty workspace

**Applied in the design:** Yes, 2026-11-12

| Element | Final copy |
|---------|------------|
| Heading | Connect a data source to see your dashboard |
| Supporting line | Your widgets fill in automatically once data arrives. |
| Primary button | Connect a data source |
| Secondary button | Invite a teammate |

## 6. Open items

None.
