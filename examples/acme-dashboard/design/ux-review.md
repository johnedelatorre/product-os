# Dashboard Performance — UX Review

**Heuristic evaluation of the actual prototype and wireframes, with a fix for each finding; for design and PM.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Kenji Mori (Design) | In review | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
A heuristic evaluation of [prototype.html](prototype.html) and [wireframes.md](wireframes.md) (SCR-001 to SCR-005) against Nielsen's 10 heuristics, Laws of UX and dashboard pattern practice, walked along the [flows](flows.md). It reviews the same files as the [design critique](design-critique.md); where a finding overlaps a critique finding, it names it instead of repeating it. Every finding names the screen, the element and the file line.

## Problem Statement
Admins wait 16.4 s (p95) at a blank page and one failed widget breaks the whole dashboard ([PRD §1](../pm/prd.md#1-problem-statement)). Usability problems that hide progress, remove the user's control or blur which problems they can fix would undo the redesign before it is built.

## Solution
Walk every flow step in the prototype, rate each screen against the heuristics, and give a concrete fix per finding. Recommendation: approve with fixes; the Critical finding is fixed before the H-2 user test.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Open Critical UX findings | 1 | 0 before the H-2 test (2026-11-13) | This page, §4 |
| Open Major UX findings | 2 | 0 before design sign-off (2026-11-15) | This page, §4 |
| MET-005 Reload-before-load rate | 31% (replays) | ≤ 5% | `dashboard_interactive` vs reloads ([metrics](../pm/metrics-framework.md)) |

## Next Action
Kenji Mori fixes UX-001 together with critique C-001 (one change: widget-only Retry on SCR-003) by 2026-11-12.

---

## 1. What was reviewed

| Artifact | Path | Screens / elements | How it was reviewed | Version reviewed |
|----------|------|--------------------|---------------------|------------------|
| Clickable prototype | [design/prototype.html](prototype.html) | SCR-001 to SCR-005 (`#scr-001` to `#scr-005`), every link, button, select and script handler | Read the HTML, CSS and script source; followed every `href` and click handler along FLOW-001 to FLOW-003 | File as of 2026-11-11 |
| Wireframes | [design/wireframes.md](wireframes.md) | SCR-001 to SCR-005 frames and annotations | Read each frame against the prototype screen with the same ID | File as of 2026-11-11 |
| User flows | [design/flows.md](flows.md) | FLOW-001 to FLOW-003 step tables | Checked every step has a screen state and a way forward | File as of 2026-11-11 |
| PRD | [pm/prd.md](../pm/prd.md) | REQ-001 to REQ-010 | Traced each requirement to a screen | Approved, 2026-11-08 |

**Not reviewed:** visual design (no Figma file yet) and live code (nothing is built yet).
**Not Verified:** rendering at 390 px (the mobile CSS at prototype.html lines 94–100 was read, not seen; needs the prototype opened in a browser at phone width); whether the skeleton feels faster (needs the H-2 preference test with 8 admins on 2026-11-13).

## 2. Summary

| Severity | Count |
|----------|-------|
| Critical | 1 |
| Major | 2 |
| Minor | 4 |

| Aspect | Status | Issues |
|--------|--------|--------|
| Heuristics | Fail | 7 (UX-001 to UX-007) |
| Laws of UX and patterns | Pass | 0 new (Hick's Law issue on SCR-005 is critique m-001) |
| Consistency | Fail | 2 (UX-003, UX-005) |

## 3. Nielsen's heuristics

| Heuristic | Status | Finding |
|-----------|--------|---------|
| 1. Visibility of system status | Fail | UX-002: Load full range shows static text with no progress. Skeleton (SCR-001) and "Last updated" captions work well |
| 2. Match to real world | Minor issues | UX-004: "Orders · 58,204" next to "2.3M rows in total" with no label for either range |
| 3. User control and freedom | Fail | UX-001: Retry on one widget reloads the whole page. UX-006: SCR-004's date range cannot switch back |
| 4. Consistency and standards | Minor issues | UX-005: loaded widgets on SCR-003 drop the change and freshness lines shown on SCR-002 |
| 5. Error prevention | Pass | No destructive actions; the dashboard takes no form input (flows.md: validation error not applicable) |
| 6. Recognition over recall | Pass | The 30-day notice says why the data is partial (prototype.html line 256) |
| 7. Flexibility and efficiency | Not Verified | Saved views and shortcuts are not part of this prototype; needs the built product |
| 8. Aesthetic and minimal design | Minor issues | Two primary buttons on SCR-005 and SCR-004 (critique m-001, m-003) |
| 9. Error recovery | Fail | UX-003: error, timeout and no access look the same, so users cannot tell which they can fix. The second-failure message is clear |
| 10. Help and documentation | Minor issues | UX-007: Help in the top bar and the status page link go nowhere in the prototype |

## 4. Findings

| ID | Severity | Issue | Location (screen → element, file line) | Heuristic / law | Recommendation | Fixed in |
|----|----------|-------|-----------------------------------------|-----------------|----------------|----------|
| UX-001 | Critical | Retry on the timed-out Active users widget is a link to `#scr-001`, so one widget's retry restarts the whole dashboard load. Same defect as critique C-001; the wireframe annotation says the same | SCR-003 → Active users → Retry, `prototype.html` line 226; `wireframes.md` SCR-003 Interactions | 3 User control; 9 Error recovery | Re-request that widget only, as Revenue by region's Retry already does (line 223, handler lines 337–353) | [DASH-103.AC2](../jira/stories.md#dash-103--keep-the-dashboard-usable-when-one-widget-fails) |
| UX-002 | Major | Load full range hides the notice and the 30-day rows, then shows static "Loading full range…" for the whole wait, with no progress and no way to cancel. Overlaps critique M-004, which covers progress; the missing Cancel is new here | SCR-004 → Orders → Load full range, `prototype.html` lines 257, 362–372; `wireframes.md` SCR-004 Interactions | 1 Visibility of system status; 3 User control | Keep the 30-day rows visible, show rows loaded out of 2.3M, and add Cancel that returns to the 30-day view | [DASH-104.AC2](../jira/stories.md#dash-104--open-very-large-widgets-on-the-last-30-days-for-big-accounts) |
| UX-003 | Major | Error, timeout and no access share one dashed box and one ⚠ icon, so users cannot tell "retry now" from "ask for access". Same defect as critique M-003 | SCR-003 → Revenue by region, Active users, Billing, `prototype.html` lines 73, 221–233 | 9 Error recovery; 4 Consistency | Three variants with distinct icon and heading; no-access without the dashed "broken" look | [DASH-103 Solution, AC1, AC4](../jira/stories.md#dash-103--keep-the-dashboard-usable-when-one-widget-fails) |
| UX-004 | Minor | The Orders header shows "58,204" while the notice says "2.3M rows in total"; neither number says which range it counts, and SCR-002 labels the same widget "Orders (last 7 days)" | SCR-004 → Orders header and notice, `prototype.html` lines 255–256; `wireframes.md` SCR-004 frame | 2 Match to real world | Label the header figure with its range ("Orders, last 30 days · 58,204") | Design file only |
| UX-005 | Minor | On SCR-003 the KPI tiles lose their change lines ("▲ up 6%") and the Orders widget loses "Last updated", which SCR-002 shows; freshness disappears exactly when users are judging what still works | SCR-003 → KPI row and Orders, `prototype.html` lines 216–218, 229–230 vs SCR-002 lines 165–167, 178–180; `wireframes.md` SCR-003 frame | 4 Consistency | Loaded widgets look the same on every screen; only the failed widget changes | Design file only |
| UX-006 | Minor | Choosing "Last 12 months" on SCR-002 opens SCR-004, but SCR-004's date range offers only "Last 12 months", so test participants cannot switch back with the control they just used | SCR-004 → Date range select, `prototype.html` line 249; handler lines 375–377 | 3 User control | Add "Last 7 days" to SCR-004's select and route it to SCR-002 | Prototype only (not a product change) |
| UX-007 | Minor | "Help" in the top bar is plain text, not a control, and the second-failure "Status page" link points back to `#scr-003` | All screens → top bar Help, `prototype.html` line 118; SCR-003 → Status page link, line 350 | 10 Help and documentation | Make Help a link; point Status page at a placeholder page so H-2 participants see where it goes | Prototype only (not a product change) |

## 5. What works (keep these)

- Skeleton in the final layout on SCR-001 shows progress at once (FLOW-001 step 2; `prototype.html` lines 129–143).
- Failure isolation is visible: Orders and the KPI tiles stay usable beside failed widgets (SCR-003).
- The second-failure message "Still unavailable. Other widgets are fine." tells users what still works (SCR-003, script line 350).
- Every button and select is at least 44 px high, so targets are easy to hit (Fitts's Law; CSS lines 42, 44).
- SCR-005 hides Export and the date range when there is no data, leaving one clear job (`wireframes.md` SCR-005 States; `prototype.html` line 277).

## 6. PRD alignment

| REQ ID | Addressed | Notes |
|--------|-----------|-------|
| REQ-001 | Partial | Skeleton works; layout mismatch is critique M-001 |
| REQ-002, REQ-003 | Yes | SCR-001 → SCR-002, lazy grid on SCR-002 |
| REQ-004, REQ-005 | Partial | UX-001, UX-003 |
| REQ-006 | Partial | UX-002, UX-004 |
| REQ-009 | Yes | One clear next step; button weight is critique m-001 |
| REQ-010 | Partial | UX-003 |
