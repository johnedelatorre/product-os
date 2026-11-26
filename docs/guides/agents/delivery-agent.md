# Delivery Agent Agent

Creates the engineering handoff: one epic that links to everything the team needs, short tickets with estimates, and a ticket tree you approve.

## What It Does

Turns the approved PRD and designs into a backlog the team can read quickly and build from without rewriting it. The rules are in [`.claude/skills/engineering-handoff.md`](../../../.claude/skills/engineering-handoff.md).

1. **Asks the outputs question**: what goes to the team, any extras to attach to the epic, which design is final, how tickets are organized.
2. **Writes the epic as the hub**: a short summary, who it is for, and a table of links to the PRD, project brief, user flows, final design and end-to-end prototype.
3. **Writes lean tickets**: each one is a single thing a user can see or do, at 1–5 points.
4. **Proposes the ticket tree**: which work sits under which ticket, as sub-tasks, and what it merged or split and why. You accept it or move items.

## When to Use

- Design approved, ready to hand over to engineering
- Creating sprint backlog
- Estimating work

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | PRD, flows, and design artifacts |
| `--velocity` | No | Team velocity for sprint planning |

## Outputs

- `epics.md` — The epic: what and why, who it is for, the Handoff links, the ticket list
- `stories.md` — Lean tickets, then PM notes (your estimate reasoning, tests and rollout; never sent to Jira)

## Example

```bash
/product-os:deliver --from prd.md
```

## Story Structure

Epics and stories use the standard format in [`docs/reference/document-format.md`](../../reference/document-format.md): §3 for epics and §4 for stories. `epics.md` and `stories.md` open with the standard header. Templates: `templates/delivery/epic.md`, `templates/delivery/user-story.md`.

Each story description has these parts, in order (document-format §4):
- **User story line:** "**As a** [user], **I want** [capability], **so that** [outcome]."
- **Problem:** one or two sentences
- **Requirements:** 3–5 short lines, naming labels, components and rules
- **UX and design requirements:** components, copy, states to show, accessibility
- **Design:** a link to that ticket's own page or frame in the main Figma file, and its step in the prototype
- **Done when:** a checklist of 3–5 testable lines
- **Estimate:** points (Fibonacci), discipline (frontend/backend/fullstack), PRD requirement, dependencies
- **Sub-tasks:** optional, one line each
- **Engineering to complete:** backend tickets only, left empty for the engineers (approach, API and data changes, risks)

## Discipline Labels

| Label | Meaning |
|-------|---------|
| `frontend` | UI/UX implementation |
| `backend` | API, data, business logic |
| `fullstack` | Both frontend and backend |

## Tips

1. **Keep stories small** — 1–5 points; split a 13
2. **Use sub-tasks for the steps inside a story** — Do not cut one slice into a frontend ticket and a backend ticket
3. **Do not design the backend** — Say what it must do and let the engineers complete the ticket
4. **Keep the reasoning in PM notes** — The ticket carries the estimate on one line
5. **Track dependencies** — Note blockers

## Related

- [Engineering Handoff Skill](../../../.claude/skills/engineering-handoff.md)
- [Story Pointing Skill](../../../.claude/skills/story-pointing.md)
- [Discipline Labeling Skill](../../../.claude/skills/discipline-labeling.md)
- [Confluence Publisher](confluence-publisher.md) — next step
