# Artifact Registry Agent

Maintains a centralized manifest of all design and product artifacts.

## What It Does

Manages `artifacts.yaml` with links to Figma files, FigJam boards, prototypes, Loom recordings, and research documents. Validates links, syncs to Confluence, and enables Jira ticket linking.

## When to Use

- Starting a new project
- Adding design deliverables
- Weekly link validation
- Syncing Design Links to Confluence

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project path |
| `--action` | No | `add`, `update`, `validate`, `sync` |

## Outputs

- `artifacts.yaml` — Master manifest
- `artifacts-report.md` — Validation report
- Confluence "Design Links" section

## Example

```bash
/product-os:artifacts --project initiatives/onboarding/signup --action validate
```

## Tips

1. **Run weekly** — Catch stale/broken links early
2. **Include frames** — Link specific Figma frames, not just files
3. **Assign owners** — Every artifact needs an owner
4. **Auto-register** — Other agents add artifacts automatically

## Related

- [Artifact Registry Skill](../../../.claude/skills/artifact-registry.md)
- [Confluence Publisher](confluence-publisher.md)
