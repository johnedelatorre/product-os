---
description: "Create low-fidelity wireframes from flows."
argument-hint: "--from <flows.yaml> --brief <design-brief.md>"
---
# /product-os:wireframes

Create low-fidelity wireframes from flows.

## Usage
```
/product-os:wireframes --from <flows.yaml> --brief <design-brief.md>
```

## Output
- `wireframes.md` — ASCII or HTML wireframes with annotations

## Where It Goes and How to View It

| File (in `initiatives/<initiative>/<project>/`) | How to view | Confluence |
|-------------------------------------------------|-------------|------------|
| `wireframes.md`: screen inventory + one ASCII wireframe per screen (`SCR-###`) with annotations | Any Markdown viewer (GitHub, VS Code, claude.ai) | **Wireframes** page under **2. Design**, via `/product-os:publish` |
| Optional HTML wireframes, e.g. `wireframes/registration.html` | Open in a browser | Linked from the Wireframes page |

Wireframes are static. For a **clickable** low-fi version, run `/product-os:prototype --from wireframes.md --flows flows.yaml`.

## Includes
- All screens from flows
- Realistic content (no lorem ipsum)
- Interaction annotations
- Responsive notes
- Accessibility notes
- State variations

## Agent
Uses: `wireframer.md`
