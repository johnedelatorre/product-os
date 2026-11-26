# [Project Name] — UX Review

**Heuristic evaluation of the actual [project] designs, for the PM and designer.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [name] | Draft / In review / Approved | [YYYY-MM-DD] |

## Description
[2–4 sentences: which designs were reviewed (see §1 What was reviewed), against Nielsen's 10 heuristics, Laws of UX and pattern best practices, and how to use the findings. Counts and status per heuristic: §2 Summary.]

## Problem Statement
[One or two lines restating the project's problem from the PRD, and how this review serves it: finding usability issues before build.]

## Solution
[One or two lines restating the project's solution, and the review's recommendation: Approve / Approve with fixes / Revise.]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Critical UX issues open | [count] | 0 before delivery | This review |
| [Project metric from metrics framework, e.g. task completion] | [value or TBD: who provides it] | [value] | [source / event] |

## Next Action
[One action, one owner.]

---

## 1. What was reviewed

Reviews cover the actual design only. No design available: stop and ask the PM for one.

| Artifact | Path or URL | Screens / elements | How it was reviewed | Version reviewed |
|----------|-------------|--------------------|---------------------|------------------|
| [Clickable prototype / Wireframes / Figma / Screenshot] | [e.g. `initiatives/<initiative>/<project>/prototype.html` or Figma link] | [SCR-### IDs, prototype `scr-###` section IDs, Figma node IDs] | [e.g. clicked every path in the flows; read the source] | [date or commit] |
| User flows | [flows.md] | [FLOW-### step tables] | [Walked each step in the prototype] | [date] |
| PRD | [link] | [REQ IDs] | [Traced each requirement to a screen] | [status, date] |

**Not reviewed:** [screens or frames that exist but were not covered, or "None"]
**Not Verified:** [checks that could not be made and what is missing, e.g. "Real loading times: needs a running build", or "None"]

## 2. Summary

| Severity | Count |
|----------|-------|
| Critical | X |
| Major | X |
| Minor | X |

| Aspect | Status | Issues |
|--------|--------|--------|
| Heuristics | Pass / Fail | [Count] |
| Laws of UX and patterns | Pass / Fail | [Count] |
| Consistency | Pass / Fail | [Count] |

## 3. Nielsen's heuristics

Status is text: **Pass**, **Minor issues**, **Fail** or **Not Verified** (say what is missing).

| Heuristic | Status | Finding |
|-----------|--------|---------|
| 1. Visibility of system status | | |
| 2. Match to real world | | |
| 3. User control and freedom | | |
| 4. Consistency and standards | | |
| 5. Error prevention | | |
| 6. Recognition over recall | | |
| 7. Flexibility and efficiency | | |
| 8. Aesthetic and minimal design | | |
| 9. Error recovery | | |
| 10. Help and documentation | | |

## 4. Findings

Every finding cites screen, element and file line. Severity is text: **Critical** (must fix), **Major** (should fix), **Minor** (nice to fix).

| ID | Severity | Issue | Location (screen → element, file line; required) | Heuristic / law | Recommendation | Fixed in |
|----|----------|-------|---------------------------------------------------|-----------------|----------------|----------|
| UX-001 | Critical | | [SCR-### → element, `prototype.html` line n] | | | [STORY-XXX.ACn or "Design file only"] |
| UX-002 | Major | | | | | |
| UX-003 | Minor | | | | | |

## 5. What works (keep these)

- [What works well, with screen and element]

## 6. PRD alignment

| REQ ID | Addressed | Notes |
|--------|-----------|-------|
| | Yes / No / Partial | |
