---
description: "Generate the engineering handoff: an epic that links to everything, lean tickets with estimates, and a ticket tree you approve."
argument-hint: "--from <prd.md> --designs <design-brief.md,wireframes.md>"
---
# /jdlt-product-os:deliver

Generate the engineering handoff: an epic that links to everything, lean tickets with estimates, and a ticket tree you approve.

## Usage

```
/jdlt-product-os:deliver --from <prd.md> --designs <design-brief.md,wireframes.md>
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | Path to PRD |
| `--designs` | Yes | Design artifacts (comma-separated) |
| `--velocity` | No | Team velocity for sprint estimate |
| `--output` | No | Output directory |

## Before It Writes Anything: The Outputs Question

Asked once per project, when `progress.yaml` has no `handoff` block (`.claude/skills/engineering-handoff.md`):

1. **Is this what goes to the team?** One list to confirm: what each reader group gets (engineers get the standard handoff: PRD, project brief, user flows, final design, end-to-end prototype, the epic and its tickets), what else is attached (for example a schema or low-fidelity wireframes), the one final design, and the ticket shape saved for your team. Say yes, or change any line.
2. **Is this ticket tree right?** After the tickets are drafted.

On your team's first project it also asks, once, how tickets are organized: parent tickets with sub-tasks (recommended), or a flat list.

## Output

Generates:
- `epics.md` — The epic: the team's hub, with a link to every handoff output
- `stories.md` — Lean tickets, then PM notes (never sent to Jira)
- `backlog.csv` — Export for Jira import

## Epic Format

`epics.md` opens with the standard header (`docs/reference/document-format.md` §1). Each epic follows §3: summary `[Project] — [Outcome in plain words]`, then one short body: Subtitle, What and why, Who it is for, the Handoff table (PRD, project brief, user flows, final design, end-to-end prototype, extras, links page), the ticket list with one estimate line, and Dependencies when there are any. Priority, owner and status are Jira fields. Template: `templates/delivery/epic.md`.

The epic is where the team gets everything. It does not repeat the PRD.

## Story Format

`stories.md` opens with the standard header. Each story follows §4 (summary `[Verb] [thing] [for whom]`): one short body, each part once. Template: `templates/delivery/user-story.md`.

Each story includes, in this order:
- User story line (As a... I want... so that...)
- Problem: one or two sentences
- Requirements: 3–5 short lines, naming labels, components and rules
- UX and design requirements
- Copy: on every ticket with a screen, "use the copy in the design as is", with a link to the UX writing guide
- Design: a link to this ticket's own page or frame in the main Figma file, and its step in the prototype
- Done when: a checklist of 3–5 testable lines
- Estimate: points, **discipline label** (`frontend`, `backend`, or `fullstack`), PRD requirement, dependencies
- Sub-tasks (optional): one line each

**Backend tickets** stay high level and end with an empty **Engineering to complete** section (approach, API and data changes, risks). The engineers fill it in and confirm the estimate.

## The Ticket Tree

After drafting, the agent proposes how the tickets are organized: which piece of work sits under which ticket, and what it merged or split and why. You accept the tree or move items. Nothing goes to Jira before you accept it.

```
EPIC-001 Self-Serve Signup — Users finish signup without sales help
├── STORY-001 Create an account with email            3 pts · fullstack
│   ├── [frontend] Signup form and inline validation
│   └── [backend]  Create-account endpoint
└── STORY-002 See password rules while typing         2 pts · frontend
```

## Discipline Labels

| Label | When to Use |
|-------|-------------|
| `frontend` | UI only, no API changes |
| `backend` | API/database only, no UI |
| `fullstack` | Both frontend and backend |

## Story Point Rubric

| Points | Complexity | Uncertainty |
|--------|------------|-------------|
| 1 | Trivial | None |
| 2 | Simple | Low |
| 3 | Moderate | Low |
| 5 | Complex | Medium |
| 8 | Very Complex | High (needs a reason; split it if you can) |
| 13 | Extremely Complex | Very High (split it, or run a spike first) |

## Example

```
/jdlt-product-os:deliver \
  --from prd.md \
  --designs design-brief.md,wireframes.md \
  --velocity 40
```

## Agent

Uses: `delivery-agent.md`

## Quality Checklist

- [ ] Outputs question answered
- [ ] Every PRD requirement has stories
- [ ] The epic links to every handoff output, with one final design
- [ ] Every story is short: user story, problem, requirements, design link, Done when, estimate
- [ ] Done when lines are testable
- [ ] Tickets are 1–5 points; steps inside a ticket are sub-tasks
- [ ] Backend tickets are high level, with Engineering to complete left empty
- [ ] You accepted the ticket tree
- [ ] Discipline labels assigned
- [ ] Dependencies identified
