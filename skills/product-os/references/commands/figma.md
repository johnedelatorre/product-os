---
description: "Interact with Figma via MCP."
argument-hint: "<action> --url <figma-url> [options]"
---
# /product-os:figma

Interact with Figma via MCP.

## Usage
```
/product-os:figma <action> --url <figma-url> [options]
```

## Actions
- `tokens` — Extract design tokens
- `audit` — Check design against PRD
- `figjam` — Generate FigJam flows
- `push` — Push wireframes to Figma

## Examples
```
/product-os:figma tokens --url https://figma.com/file/xxx
/product-os:figma audit --url https://figma.com/file/xxx --prd prd.md
/product-os:figma figjam --flows flows.yaml --url https://figma.com/file/xxx
```

## Where It Goes and How to View It

| Action | Output | How to view | Confluence |
|--------|--------|-------------|------------|
| `tokens` | `design-tokens.yaml` | Any text editor | Not published |
| `audit` | `initiatives/<initiative>/<project>/figma-audit.md` | Any Markdown viewer | Published with the design pages |
| `figjam` | FigJam board built from `flows.yaml` | Open the board link in Figma | Linked from the **User Flows** page |
| `push` | New page of wireframe frames in the Figma file (starting points, not final designs) | Open the file link in Figma | Linked from the **Wireframes** page |

Figma is optional: flows, wireframes and the prototype exist as files without it. Reviews (`/product-os:critique --figma-url`) read real Figma frames through this agent and cite their node IDs.

## Fallback
When Figma MCP not connected, provides manual instructions.

## Agent
Uses: `figma-agent.md`
