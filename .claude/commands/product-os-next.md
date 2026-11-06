# /product-os:next

Execute the next recommended step in guided mode.

## Usage

```
/product-os:next
/product-os:next --initiative <slug> --project <slug>
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--initiative` | No | Initiative slug (defaults to current) |
| `--project` | No | Project slug (defaults to current) |

## What It Does

1. Reads `progress.yaml` to find current phase and document
2. Determines next logical action:
   - Complete in-progress document
   - Start next document in phase
   - Run exit criteria check
   - Advance to next phase
3. Executes that action via specialist agent
4. Updates progress and reports result

## Examples

```bash
# Do next step for current initiative
/product-os:next

# Do next step for specific initiative
/product-os:next --initiative customer-onboarding --project signup
```

## Decision Logic

```
If current_document.status == "in_progress":
  → Continue document
  
If current_phase has unstarted documents:
  → Start next document in order
  
If all phase documents complete:
  → Check exit criteria
  
If exit criteria passed:
  → Advance to next phase
  
If at final phase and complete:
  → Congratulate PM, suggest retrospective
```

## Agent

Uses `.claude/agents/guide.md`
