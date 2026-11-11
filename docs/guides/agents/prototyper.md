# Prototyper Agent

Creates the clickable low-fidelity prototype from wireframes and flows.

## What It Does

Generates a single-file HTML prototype of every wireframed screen, with click navigation, states (loading, error, empty, success) and toggleable annotations, plus a React version for claude.ai. It tests flows before visual design; it is not final UI.

## When to Use

- Wireframes approved, need interaction testing
- User research with clickable prototype
- Stakeholder demo

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | `wireframes.md` |
| `--flows` | Yes | `flows.yaml` (navigation structure) |

## Outputs and How to Open Them

All files land in `initiatives/<initiative>/<project>/`.

| File | What it is | How to open | Confluence |
|------|-----------|-------------|------------|
| `prototype.html` | Self-contained clickable prototype | Double-click to open in any browser; no install or server. Share the file or host it as static HTML | **Prototype** page under **2. Design** links to or attaches it (TBD: attach vs hosted link is not yet defined by the publisher; the PM decides per project) |
| `prototype-react.tsx` | Claude Artifact-compatible React | Paste into claude.ai and ask for an Artifact; it renders as a clickable prototype there | Link the artifact from the Prototype page |
| `prompt-pack.md` | Prompts for generating the prototype in claude.ai | Copy each prompt into claude.ai | Not published |

In `prototype.html`: `→`/`←` move through the flow, `a` toggles annotations.

## Example

```bash
/product-os:prototype --from initiatives/onboarding/signup/wireframes.md --flows initiatives/onboarding/signup/flows.yaml
```

## Features

- Click navigation between screens
- Basic interactions (buttons, forms)
- State changes (loading, error, success)
- Mobile-responsive layout
- No external dependencies

## Tips

1. **Single file** — Claude artifacts require self-contained code
2. **Inline styles** — no CSS imports
3. **Mock data** — realistic placeholder content
4. **Touch-friendly** — test on mobile devices

## Related

- [Design Workflow](../design-workflow.md) — from PRD to reviewed designs
- [Prototype Skill](../../../.claude/skills/prototype-generation.md)
- [UX Reviewer](ux-reviewer.md) — review the prototype
- [Accessibility Auditor](accessibility-auditor.md) — audit the prototype in a browser
