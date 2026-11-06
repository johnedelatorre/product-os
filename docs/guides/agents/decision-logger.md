# Decision Logger Agent

Records decisions in ADR format.

## What It Does

Documents architectural and product decisions with context, options considered, and rationale.

## When to Use

- Significant decisions made
- Trade-offs evaluated
- Historical record needed

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--title` | Yes | Decision title |
| `--options` | No | Options considered |

## Outputs

- `decisions/ADR-XXX.md` — Decision record

## Example

```bash
/product-os:decision --title "Use React for frontend"
```

## ADR Format

- **Title**: Short decision name
- **Status**: Proposed/Accepted/Deprecated
- **Context**: Why this decision needed
- **Decision**: What we chose
- **Options Considered**: Alternatives evaluated
- **Consequences**: What happens as a result

## Tips

1. **Document when fresh** — capture context
2. **Link to related ADRs** — decisions connect
3. **Update status** — mark deprecated decisions

## Related

- [PRD Author](prd-author.md) — references decisions
- [Risk Manager](risk-manager.md) — decision consequences
