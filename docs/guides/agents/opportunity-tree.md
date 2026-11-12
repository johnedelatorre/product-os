# Opportunity Solution Tree Agent

Creates opportunity solution trees for structured discovery.

## What It Does

Builds visual trees connecting outcomes to opportunities to solutions, preventing solution-first thinking and enabling systematic discovery.

## When to Use

- Before writing a PRD
- Exploring a new problem space
- Connecting multiple solutions to outcomes
- Team alignment on what to pursue

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--outcome` | Yes | Measurable outcome to achieve |
| `--context` | No | Research, data, or intake docs |

## Outputs

- `opportunity-tree.md` — Tree with Mermaid diagram
- `opportunity-tree.yaml` — Machine-readable spec

## Example

```bash
/product-os:opportunity-tree --outcome "Increase signup conversion from 66% to 80%"
```

## Tips

1. **Outcome first** — Always start with what you want to achieve
2. **Opportunities are problems** — Not solutions
3. **Evidence-backed** — Each opportunity needs data
4. **Link to hypotheses** — Track assumptions

## Related

- [Opportunity Tree Skill](../../../.claude/skills/opportunity-tree.md)
- [Hypothesis Logger](hypothesis-logger.md)
