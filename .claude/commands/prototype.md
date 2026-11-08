---
description: "Generate clickable HTML/React prototypes from wireframes."
argument-hint: "--from <wireframes.md> --flows <flows.yaml>"
---
# /product-os:prototype

Generate clickable HTML/React prototypes from wireframes.

## Usage
```
/product-os:prototype --from <wireframes.md> --flows <flows.yaml>
```

## Output
- `prototype.html` — Self-contained clickable prototype
- `prototype-react.tsx` — Claude Artifact-compatible React
- `prompt-pack.md` — Prompts for Claude.ai

## Features
- All screens from flows
- Navigation between screens
- State variations (loading, error, empty, success)
- Annotations toggle
- Keyboard navigation

## Agent
Uses: `prototyper.md`
