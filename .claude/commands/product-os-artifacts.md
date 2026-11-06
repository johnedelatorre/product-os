# /product-os:artifacts

Manage the design artifact registry for a project.

## Usage

```
/product-os:artifacts --project <path> [--action <action>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--project` | Yes | Project path |
| `--action` | No | `add`, `update`, `validate`, `sync` (default: `validate`) |
| `--url` | For add | Artifact URL |
| `--type` | For add | Artifact type (figma-design, figjam, loom, etc.) |
| `--name` | For add | Artifact name |

## Examples

```bash
# Validate all artifacts for broken/stale links
/product-os:artifacts --project initiatives/onboarding/signup

# Add a new Figma file
/product-os:artifacts --project initiatives/onboarding/signup --action add \
  --url "https://figma.com/file/xxx" --type figma-design --name "Signup Flow"

# Sync to Confluence Design Links section
/product-os:artifacts --project initiatives/onboarding/signup --action sync
```

## Agent

Uses `.claude/agents/artifact-registry.md`
