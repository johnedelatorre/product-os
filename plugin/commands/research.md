---
description: "Create research plan or synthesize findings."
argument-hint: "plan --questions \"<research questions>\""
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:research

Create research plan or synthesize findings.

## Usage
```
/jdlt-product-os:research plan --questions "<research questions>"
/jdlt-product-os:research synthesize --transcripts <files>
```

## Output
- `research-plan.md` or `interview-guide.md`
- `research-synthesis.md` (for synthesize)

## Agent
Uses: `ux-researcher.md`
