---
description: "Execute the next recommended step in guided mode."
---
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
3. Says how many open items exist; if any are due (`revisit_by` is the current phase), offers to resolve them first. The PM can decline and continue.
4. Executes that action via specialist agent
5. Updates progress and reports result

## Examples

```bash
# Do next step for current initiative
/product-os:next

# Do next step for specific initiative
/product-os:next --initiative customer-onboarding --project signup
```

## Decision Logic

```
If open items have revisit_by == current_phase:
  → Offer to resolve them first (PM may decline)

If PM says they don't have the info for this step:
  → Defer it (missing, owner, revisit_by), add open item, move on

If current_document.status == "in_progress":
  → Continue document
  
If current_phase has unstarted documents:
  → Start next document in order
  
If all phase documents complete, N/A, skipped or deferred:
  → Check exit criteria (fail → fix or defer)

If every exit criterion is pass, N/A or deferred:
  → Advance to next phase (complete_with_open_items if any deferred)

If entering Launch with open items:
  → For each: resolve now, or carry forward as accepted risk (record who accepted)
  
If at final phase and complete:
  → Congratulate PM, suggest retrospective
```

## Agent

Uses `.claude/agents/guide.md`
