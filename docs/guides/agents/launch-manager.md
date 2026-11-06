# Launch Manager Agent

Coordinates go-to-market activities for launches.

## What It Does

Creates release notes, sales/support enablement, changelog entries, and launch checklists for feature releases.

## When to Use

- Preparing for launch
- Creating customer communications
- Enabling internal teams
- Updating changelog

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project path |
| `--version` | No | Version number |
| `--audience` | No | `customers`, `internal`, `all` |

## Outputs

- `release-notes.md` — Customer-facing notes
- `enablement.md` — Sales/support guide
- `changelog-entry.md` — For CHANGELOG.md
- `launch-checklist.md` — Readiness tracker

## Example

```bash
/product-os:launch --project initiatives/onboarding/signup --version 2.4.0
```

## Tips

1. **Customer-first** — Benefits over features
2. **No jargon** — Plain language
3. **Include visuals** — Screenshots help
4. **Checklist everything** — Don't miss steps

## Related

- [Launch GTM Skill](../../.claude/skills/launch-gtm.md)
- [Post-Launch Reviewer](post-launch-reviewer.md)
