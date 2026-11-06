# /product-os:guide

Start or resume guided mode, or jump to a specific phase.

## Usage

```
/product-os:guide --initiative <slug> --project <slug>
/product-os:guide <phase>
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--initiative` | For new | Initiative slug |
| `--project` | For new | Project slug |
| `<phase>` | For jump | Phase to jump to |

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

1. Loads or creates `progress.yaml`
2. Shows current phase and document status
3. Explains what's needed and why
4. Asks key questions to gather inputs
5. Calls specialist agents to create documents
6. Reviews outputs against exit criteria
7. Suggests next step

## Agent

Uses `.claude/agents/guide.md`
