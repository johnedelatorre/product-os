# Flow Designer Agent

Creates user flows, journey maps, and sitemaps.

## What It Does

Documents how users move through the product with canonical YAML specs that render to multiple targets.

## When to Use

- After PRD, before wireframes
- Need to visualize user journeys
- Creating information architecture

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | Path to `prd.md` |
| `--format` | No | Output format (see below) |

## Outputs

- `flows.yaml` — Canonical YAML spec (always)
- `flows.md` — Mermaid diagrams (always)
- `journey-map.md` — User journey map
- `sitemap.md` — Information architecture

## Output Formats

| Format | Flag | Output |
|--------|------|--------|
| Mermaid | `--format mermaid` | Mermaid flowchart |
| ASCII | `--format ascii` | ASCII diagram |
| Lucidchart | `--format lucidchart` | CSV import |
| PlantUML | `--format plantuml` | PlantUML source |

## Example

```bash
/product-os:flows --from prd.md --format mermaid
```

## Tips

1. **Start with happy path** — main flow first
2. **Add error branches** — what happens when things fail?
3. **Use canonical YAML** — enables multi-target rendering

## Related

- [User Flows Skill](../../.claude/skills/user-flows.md)
- [Wireframer](wireframer.md) — wireframes from flows
