---
description: "Start or resume guided mode, or jump to a specific phase."
argument-hint: "--initiative <slug> --project <slug>"
---
# /product-os:guide

Start or resume guided mode, or jump to a specific phase.

## Usage

```
/product-os:guide --initiative <slug> --project <slug>
/product-os:guide <phase>
/product-os:guide --skip [<document|phase>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--initiative` | For new | Initiative slug |
| `--project` | For new | Project slug |
| `<phase>` | For jump | Phase to jump to (earlier phases with no artifacts are marked skipped) |
| `--skip [<document\|phase>]` | No | Skip the current (or named) document or optional phase; records `skip_reason` and `skip_risks` in `progress.yaml` |

## Phases

| Phase | Description |
|-------|-------------|
| `intake` | Transform requirements into problem statement |
| `discovery` | Explore problem space (optional) |
| `prioritize` | Decide if and when to build |
| `define` | PRD, brief, metrics, plan |
| `design` | Flows, wireframes, prototype |
| `review` | Critique, UX review, accessibility on the real designs, then the review exit check |
| `deliver` | Epics, stories, Definition of Ready gate, Confluence, Jira |
| `launch` | Release notes, enablement |
| `measure` | Post-launch review, follow-ups |

## Examples

```bash
# Start new guided initiative
/product-os:guide --initiative customer-onboarding --project signup

# Resume existing initiative (reads from progress.yaml)
/product-os:guide

# Jump to a specific phase
/product-os:guide design

# Skip current phase
/product-os:guide --skip
```

## Missing Information? Keep Going

Any document or exit criterion in any phase can be deferred. Tell the guide you don't have it yet ("no baseline yet, come back later"). It asks one short question (what's missing, who can provide it, revisit by which phase), records an open item and moves on. Owner can be TBD.

- Documents still get written, with each gap marked as a named TBD
- A phase with deferred items advances as `complete_with_open_items`
- Open items resurface at their revisit phase, and you can resolve one any time ("I have the baseline now")
- Before Launch you decide per item: resolve now, or carry forward as an accepted risk

Still hard stops: publishing to Confluence/Jira needs explicit approval, and code-shipping release gates (Not Verified blocks release, owner explicit GO) are unchanged.

## What It Does

1. Loads or creates `initiatives/<initiative>/<project>/progress.yaml` (migrating older files to schema `1.2`)
2. Scans the project directory for existing artifacts and marks them `complete` or `in_progress` instead of recreating them
3. Shows current phase and document status
4. Explains what's needed and why
5. Asks key questions to gather inputs
6. Calls specialist agents to create documents
7. Reviews outputs against exit criteria
8. Records deferrals as open items when the PM doesn't have something yet
9. Suggests next step

## Agent

Uses `.claude/agents/guide.md`
