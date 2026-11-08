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

## Fallback
When Figma MCP not connected, provides manual instructions.

## Agent
Uses: `figma-agent.md`
