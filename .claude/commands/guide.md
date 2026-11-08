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
| `review` | Critique, UX review, accessibility, gates |
| `deliver` | Epics, stories, Confluence, Jira |
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

## What It Does

1. Loads or creates `initiatives/<initiative>/<project>/progress.yaml` (migrating v1.0 files to schema v1.1)
2. Scans the project directory for existing artifacts and marks them `complete` or `in_progress` instead of recreating them
3. Shows current phase and document status
4. Explains what's needed and why
5. Asks key questions to gather inputs
6. Calls specialist agents to create documents
7. Reviews outputs against exit criteria
8. Suggests next step

## Agent

Uses `.claude/agents/guide.md`
