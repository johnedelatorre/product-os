---
description: "Generate comprehensive user flows from PRD."
argument-hint: "--from <prd.md> [--targets <list>]"
---
# /product-os:flows

Generate comprehensive user flows from PRD.

## Usage

```
/product-os:flows --from <prd.md> [--targets <list>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | Path to PRD |
| `--targets` | No | Render targets: mermaid, claude-artifact, figjam, excalidraw, drawio, lucidchart, miro, whimsical |
| `--output` | No | Output directory |

## Output

Generates:
- `flows.yaml` — Canonical flow specification (source of truth)
- `flows.md` — Mermaid diagrams (always generated)
- `journey-map.md` — Emotional journey across touchpoints
- `sitemap.md` — Information architecture
- `flow-traceability.md` — PRD-to-flow mapping
- Additional outputs per target (HTML, .excalidraw, .drawio, etc.)

## Where It Goes and How to View It

| File (in `initiatives/<initiative>/<project>/`) | How to view | Confluence |
|-------------------------------------------------|-------------|------------|
| `flows.md` (Mermaid diagrams, always) | Renders as diagrams on GitHub, in claude.ai and in editors with a Mermaid preview | **User Flows** page under **2. Design**, via `/product-os:publish` (Mermaid macro, or PNG when the macro is missing) |
| `flows.yaml` (source of truth) | Any text editor | Not published; it feeds the other outputs |
| `journey-map.md`, `sitemap.md`, `flow-traceability.md` | Any Markdown viewer | Published with the design pages |
| `claude-artifact` target: interactive HTML | Open in a browser; renders as an artifact in claude.ai | Linked from the User Flows page |
| `figjam` target: FigJam board (Figma MCP) | Open the board link in Figma | Linked from the User Flows page |

## Flow Types

- **Task flows** — Linear happy-path flows
- **User flows** — Multi-path with decisions, errors, edge cases
- **System flows** — Swimlane diagrams (user, frontend, backend, external)
- **Journey maps** — Emotional arc across experience
- **Sitemap/IA** — Navigation structure

## Example

```
/product-os:flows --from prd.md --targets mermaid,claude-artifact,figjam
```

## Agent

Uses: `flow-designer.md`

## Quality Checklist

- [ ] All flow types present
- [ ] Happy paths marked
- [ ] Error paths documented
- [ ] No dead ends
- [ ] PRD traceability complete
