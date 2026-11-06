# /product-os:opportunity-tree

Create an opportunity solution tree for discovery.

## Usage

```
/product-os:opportunity-tree --outcome <outcome> [--context <path>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--outcome` | Yes | Desired measurable outcome |
| `--context` | No | Research, data, or intake docs |
| `--existing` | No | Path to existing tree to expand |

## Examples

```bash
# Create new opportunity tree
/product-os:opportunity-tree --outcome "Increase signup conversion from 66% to 80%"

# Expand existing tree
/product-os:opportunity-tree --existing opportunity-tree.yaml \
  --outcome "Reduce time to first value"
```

## Agent

Uses `.claude/agents/opportunity-tree.md`
