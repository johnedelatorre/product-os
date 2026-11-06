# Figma Agent

Integrates with Figma via MCP for design sync.

## What It Does

Reads from and writes to Figma using the Figma MCP server for design tokens, audit, and sync.

## When to Use

- Extracting design tokens from Figma
- Auditing Figma designs for consistency
- Syncing product artifacts with Figma

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--file` | Yes | Figma file URL |
| `--action` | Yes | `tokens`, `audit`, `sync` |

## Outputs

- `figma-tokens.json` — Extracted design tokens
- `figma-audit.md` — Design audit report

## Example

```bash
/product-os:figma \
  --file "https://figma.com/file/..." \
  --action tokens
```

## Prerequisites

Figma MCP must be configured:
```yaml
# product-os.config.yaml
figma:
  enabled: true
  mcp_server: figma
```

## Graceful Degradation

If Figma MCP unavailable:
1. Log warning
2. Continue with manual design workflow
3. Document in output that Figma sync skipped

## Tips

1. **Check MCP status first** — `figma.enabled` in config
2. **Use file URLs** — not embed or prototype URLs
3. **Have fallback ready** — MCP may be unavailable

## Related

- [Figma MCP Setup](../../setup/figma-mcp.md)
- [Design Critic](design-critic.md) — reviews Figma designs
