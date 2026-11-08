---
description: "Structure a raw requirement into a problem/opportunity statement."
argument-hint: "--input \"<requirement>\" [--source \"<source>\"]"
---
# /product-os:intake

Structure a raw requirement into a problem/opportunity statement.

## Usage

```
/product-os:intake --input "<requirement>" [--source "<source>"]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--input` | Yes | Raw requirement text or file path |
| `--source` | No | Source attribution (who, when, context) |
| `--output` | No | Output path (default: `intake.md`) |

## Output

Generates `intake.md` with:
- Problem statement (neutral, not solution-biased)
- Evidence and supporting data
- Affected users and segments
- Business impact hypothesis
- Open questions for PM

## Example

```
/product-os:intake \
  --input "CEO wants us to add Apple Pay to checkout" \
  --source "Leadership meeting, Nov 2026"
```

## Agent

Uses: `intake-analyst.md`

## Quality Checklist

- [ ] Problem is stated neutrally
- [ ] Source is documented
- [ ] Evidence is captured
- [ ] Users are identified
- [ ] Questions are listed
