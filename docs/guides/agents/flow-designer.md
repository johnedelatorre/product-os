# Flow Designer Agent

Creates user flow diagrams, journey maps and sitemaps.

## What It Does

Documents how users move through the product. It writes a canonical YAML spec (`flows.yaml`) and renders it to Mermaid diagrams (`flows.md`, always) and to other tools on request.

## When to Use

- After PRD, before wireframes
- Need to visualize user journeys
- Creating information architecture

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | Path to `prd.md` |
| `--targets` | No | Extra render targets: `mermaid`, `claude-artifact`, `figjam`, `excalidraw`, `drawio`, `lucidchart`, `miro`, `whimsical` |
| `--output` | No | Output directory (default: the project folder) |

## Outputs and How to View Them

All files land in `initiatives/<initiative>/<project>/`.

| File | What it is | How to view | Confluence |
|------|-----------|-------------|------------|
| `flows.md` | Mermaid flowcharts, one per flow, plus a notation legend (always generated) | Renders as diagrams on GitHub, in claude.ai and in editors with a Mermaid preview | **User Flows** page under **2. Design** via `/product-os:publish` (Mermaid macro, or PNG when the macro is missing) |
| `flows.yaml` | Canonical spec, the source of truth | Any text editor | Not published |
| `journey-map.md` | Emotional journey across touchpoints | Any Markdown viewer | Published with design pages |
| `sitemap.md` | Information architecture | Any Markdown viewer | Published with design pages |
| `flow-traceability.md` | PRD-to-flow mapping | Any Markdown viewer | Published with design pages |
| Target outputs | Interactive HTML (`claude-artifact`), FigJam board (`figjam`, needs Figma MCP), `.excalidraw`, `.drawio`, Lucidchart CSV, Miro JSON, Whimsical Markdown | HTML: open in a browser or as a claude.ai artifact; FigJam: open the board link | Linked from the User Flows page |

Markdown outputs open with the standard header (`docs/reference/document-format.md`).

## Example

```bash
/product-os:flows --from initiatives/onboarding/signup/prd.md --targets mermaid,claude-artifact
```

## Tips

1. **Start with happy path** — main flow first
2. **Add error branches** — what happens when things fail?
3. **Use canonical YAML** — enables multi-target rendering

## Related

- [Design Workflow](../design-workflow.md) — from PRD to reviewed designs
- [User Flows Skill](../../../.claude/skills/user-flows.md)
- [Wireframer](wireframer.md) — wireframes from flows
