---
description: "Log a product decision (ADR style)."
argument-hint: "--title \"<title>\" --options \"<options>\" --decision \"<outcome>\""
---
# /product-os:decision

Log a product decision (ADR style).

## Usage
```
/product-os:decision --title "<title>" --options "<options>" --decision "<outcome>"
```

## Output
- `decisions/DEC-XXX.md` — Individual decision record
- Updates `decision-log.md`

## Agent
Uses: `decision-logger.md`
