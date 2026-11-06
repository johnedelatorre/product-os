# /product-os:critique

Perform structured visual design critique.

## Usage
```
/product-os:critique --designs <path> --prd <prd.md> [--figma-url <url>]
```

## Arguments
| Argument | Required | Description |
|----------|----------|-------------|
| `--designs` | Yes | Design artifacts or screenshots |
| `--prd` | Yes | PRD for alignment check |
| `--figma-url` | No | Figma URL for MCP analysis |
| `--brand` | No | Brand guidelines |

## Evaluation Dimensions
1. Visual hierarchy
2. Layout and composition
3. Typography
4. Color
5. Spacing and alignment
6. Component consistency
7. Content and microcopy
8. PRD alignment
9. Brand alignment

## Severity Levels
- **Critical (P0)**: Blocks launch
- **Major (P1)**: Should fix before launch
- **Minor (P2)**: Polish item

## Output
- `design-critique.md` — Findings with scorecard

## Agent
Uses: `design-critic.md`
