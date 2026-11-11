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

## Where It Goes and How to Open It

| File (in `initiatives/<initiative>/<project>/`) | How to view | Confluence |
|-------------------------------------------------|-------------|------------|
| `prototype.html`: clickable low-fi prototype, one self-contained file | Double-click to open in any browser; no install or server. Share the file or host it as static HTML | **Prototype** page under **2. Design** links to or attaches it. TBD: the publisher does not yet define attach vs hosted link; the PM decides per project |
| `prototype-react.tsx` | Paste into claude.ai and ask for an Artifact; it renders there as a clickable prototype | Link the artifact from the Prototype page |
| `prompt-pack.md` | Copy prompts into claude.ai to generate Artifacts | Not published |

In the prototype: `→`/`←` move through the flow, `a` toggles annotations.

## Features
- All screens from flows, one section per screen: `id="scr-###"` matching `SCR-###` in `wireframes.md`, opened by `#scr-###`
- Navigation between screens
- State variations (loading, error, empty, success)
- Annotations toggle
- Keyboard navigation

## Agent
Uses: `prototyper.md`
