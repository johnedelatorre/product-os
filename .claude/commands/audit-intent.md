---
description: "Audit code against documented intent: find gaps between what docs promise and what code enforces."
argument-hint: "--scope <path> --docs <path>"
---
# /product-os:audit-intent

> Audit code against documented intent: find gaps between what docs promise and what code enforces.

**Output Style:** Follow `.claude/skills/clear-output.md`

## Usage

```
/product-os:audit-intent --scope <path> --docs <path>
/product-os:audit-intent --scope src/ --docs docs/
```

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--scope` | Yes | Path to code being audited |
| `--docs` | No | Path to intent docs (default: docs/) |
| `--output` | No | Output path (default: reports/intent-audit.md) |

## What It Checks

- **Permissions docs** vs actual authorization code
- **Architecture docs** vs actual boundaries
- **Privacy policy** vs actual data handling
- **API contracts** vs actual implementation

## Findings Format

Each finding includes:
- Documented intent (quoted, with source)
- Implemented reality (file:line citation)
- Gap classification (Critical/High/Medium)
- Attacker and victim
- Concrete fix

## Conditional Application

| Context | Requires Audit? |
|---------|-----------------|
| PM/design artifacts only | No |
| Any code being shipped | **Yes** |
| Configuration changes | Yes if affects access/data |

## Output

- Findings report with severity
- Handoff format for coding agent
- Unable-to-verify items marked clearly

## Integration

- Required for release gate when shipping code
- Feeds into DoD verification
- Part of shipping artifacts workflow

## Skill Reference

See `.claude/skills/intended-vs-implemented.md` for full methodology.
