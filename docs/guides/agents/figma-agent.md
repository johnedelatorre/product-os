# Figma Agent

Integrates with Figma via MCP for design sync, and reads real Figma designs for reviews.

## What It Does

Reads from and writes to Figma using the Figma MCP server: design tokens, PRD alignment audits, FigJam flow boards and wireframe frames. Figma is optional in the design sequence; flows, wireframes and the prototype exist as files without it.

## When to Use

- Extracting design tokens from Figma
- Auditing Figma designs against the PRD
- Putting flows (FigJam) or wireframes (frames) into Figma
- Giving reviewers access to real Figma frames

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `<action>` | Yes | `tokens`, `audit`, `figjam`, `push` |
| `--url` | Yes | Figma file or frame URL |
| `--prd` | For `audit` | PRD to check against |
| `--flows` | For `figjam` | `flows.yaml` |

## Outputs and How to View Them

| Action | Output | How to view | Confluence |
|--------|--------|-------------|------------|
| `tokens` | `design-tokens.yaml` | Any text editor | Not published |
| `audit` | `initiatives/<initiative>/<project>/figma-audit.md` | Any Markdown viewer | Published with design pages |
| `figjam` | FigJam board from `flows.yaml` | Open the board link in Figma | Linked from the **User Flows** page |
| `push` | New page of wireframe frames in the Figma file (starting points) | Open the file link in Figma | Linked from the **Wireframes** page |

## Example

```bash
/product-os:figma tokens --url https://figma.com/file/xxx
/product-os:figma audit --url https://figma.com/file/xxx --prd prd.md
/product-os:figma figjam --flows flows.yaml --url https://figma.com/file/xxx
```

## Prerequisites

Figma MCP must be connected in your IDE, see [Figma MCP Setup](../../setup/figma-mcp.md). Figma file links can be set in `product-os.config.yaml`:

```yaml
figma:
  design_system_file: "https://figma.com/file/xxx/Design-System"
  figjam_file: "https://figma.com/file/yyy/User-Flows"
```

## Graceful Degradation

If Figma MCP unavailable:
1. Log warning
2. Continue with manual design workflow (manual token export, manual audit, paste Mermaid from `flows.md` into FigJam)
3. Document in output that Figma sync skipped

## Tips

1. **Check MCP status first** — the agent reports connected or fallback
2. **Use file URLs** — not embed or prototype URLs
3. **Have fallback ready** — MCP may be unavailable

## Related

- [Design Workflow](../design-workflow.md) — from PRD to reviewed designs
- [Figma MCP Setup](../../setup/figma-mcp.md)
- [Design Critic](design-critic.md) — reviews Figma designs
