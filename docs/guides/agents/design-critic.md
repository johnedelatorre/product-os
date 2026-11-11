# Design Critic Agent

Provides structured visual design critique of the actual designs.

## What It Does

Reviews real design artifacts against established principles, the PRD and brand guidelines, and produces severity-rated findings with actionable recommendations. Each finding cites the exact screen, frame and element it is about.

## When to Use

- Design ready for review
- Before handoff to engineering
- Quality gate before prototype

## What It Needs: the Real Design

The critic reviews only designs that exist. Give it at least one of:

| Source | How it is read |
|--------|----------------|
| Figma file or frame link | Through the Figma MCP (`figma-agent`) |
| Screenshots or images | Directly |
| `prototype.html` or a prototype URL | Opened in a browser |
| `wireframes.md` | Directly |

No design available: the agent stops and asks you for one. It never critiques a described or imagined screen.

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--designs` | Yes* | `wireframes.md`, `prototype.html`, a prototype URL, or screenshot files |
| `--figma-url` | Yes* | Figma file or frame URL |
| `--prd` | Yes | PRD for alignment check |
| `--brand` | No | Brand guidelines |

\* At least one of `--designs` or `--figma-url`.

## Outputs

- `design-critique.md` — standard header (`docs/reference/document-format.md`), then a **What was reviewed** table (sources, frame/screen IDs, version, review date), scorecard and findings. Template: `templates/design/design-critique.md`.

## Example

```bash
/product-os:critique --designs initiatives/onboarding/signup/wireframes.md --prd initiatives/onboarding/signup/prd.md
```

## Rules for Findings

1. **Cite the location:** source → screen/frame ID → element, with a screenshot or frame link where possible. No citation, no finding.
2. **Not Verified, not guessed:** anything the agent could not inspect says so and names what is missing. On grayscale wireframes, Color, Typography and Brand are Not Verified.

## Critique Framework

| Category | What's Reviewed |
|----------|-----------------|
| Hierarchy | Visual weight, focal points |
| Alignment | Grid consistency, spacing |
| Consistency | Patterns, components |
| Contrast | Readability, accessibility |
| Gestalt | Grouping, proximity |
| Typography | Type scale, hierarchy |

The agent scores nine dimensions: Visual Hierarchy, Layout & Composition, Typography, Color, Spacing & Alignment, Component Consistency, Content & Microcopy, PRD Alignment, Brand Alignment.

## Severity Levels

| Level | Meaning |
|-------|---------|
| Critical | Blocks launch, must fix |
| Major | Should fix before launch |
| Minor | Nice to fix |
| Enhancement | Future improvement |

## Tips

1. **Be specific** — "Button too small" → "Primary CTA at 10px is below the 24×24px touch-target minimum (44px recommended)"
2. **Reference standards** — cite guidelines
3. **Include rationale** — why it matters

## Related

- [Design Workflow](../design-workflow.md) — from PRD to reviewed designs
- [Design Critique Skill](../../../.claude/skills/design-critique.md)
- [UX Reviewer](ux-reviewer.md) — evaluates usability
