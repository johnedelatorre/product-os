# Delivery Agent Agent

Creates epics, stories, and story point estimates.

## What It Does

Transforms design and planning artifacts into a backlog with properly pointed stories and discipline labels.

## When to Use

- Design approved, ready for delivery planning
- Creating sprint backlog
- Estimating work

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | PRD, flows, and design artifacts |
| `--velocity` | No | Team velocity for sprint planning |

## Outputs

- `epics.md` — Epic definitions
- `stories.md` — User stories with points and disciplines

## Example

```bash
/product-os:deliver --from prd.md
```

## Story Structure

Epics and stories use the standard format in [`docs/reference/document-format.md`](../../reference/document-format.md): §3 for epics (summary `[Project] — [Outcome in plain words]`; Subtitle, Description, Problem Statement, Solution, Success Metrics, Stories, Dependencies, Links) and §4 for stories. `epics.md` and `stories.md` open with the standard header. Templates: `templates/delivery/epic.md`, `templates/delivery/user-story.md`.

Each story description has these sections, in order (document-format §4):
- **User story line:** "**As a** [user], **I want** [capability], **so that** [outcome]."
- **Description:** what the story changes, in 2–3 sentences
- **Problem Statement:** the user problem it solves
- **Solution:** what we build, with technical notes
- **Acceptance Criteria:** Gherkin scenarios (Given/When/Then), one ID per scenario
- **Design:** use cases, flow and screens, states, UX requirements
- **Validation:** tests, observability, rollout / rollback, success metric
- **Details:** discipline (frontend/backend/fullstack), story points (Fibonacci), confidence, dependencies, estimate rationale, out of scope
- **Links:** epic, PRD requirement, Confluence page

## Discipline Labels

| Label | Meaning |
|-------|---------|
| `frontend` | UI/UX implementation |
| `backend` | API, data, business logic |
| `fullstack` | Both frontend and backend |

## Tips

1. **Keep stories small** — Under 8 points ideally
2. **Include rationale** — Why this point estimate?
3. **Track dependencies** — Note blockers

## Related

- [Story Pointing Skill](../../../.claude/skills/story-pointing.md)
- [Discipline Labeling Skill](../../../.claude/skills/discipline-labeling.md)
- [Confluence Publisher](confluence-publisher.md) — next step
