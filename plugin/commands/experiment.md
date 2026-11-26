---
description: "Design A/B test with sample size calculation."
argument-hint: "--hypothesis \"<hypothesis>\" --metric <metric> --baseline <value>"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:experiment

Design A/B test with sample size calculation.

## Usage
```
/jdlt-product-os:experiment --hypothesis "<hypothesis>" --metric <metric> --baseline <value>
```

## Output
- `experiment.md` — Full experiment design with sample size

## Agent
Uses: `experiment-designer.md`
