# Event Tracker Agent

Creates event tracking plans for analytics platforms.

## What It Does

Designs comprehensive tracking specifications with event names, properties, and triggers for Pendo, Amplitude, Mixpanel, Segment, and others.

## When to Use

- Implementing new features
- Setting up product analytics
- Preparing for A/B tests
- Handoff to engineering

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | PRD, flows, or metrics |
| `--platform` | No | Target analytics platform |

## Outputs

- `tracking-plan.md` — Full plan
- `tracking-plan.yaml` — Spec for engineers
- `tracking-plan.csv` — Spreadsheet format

## Example

```bash
/product-os:tracking --from prd.md --platform amplitude
```

## Tips

1. **Consistent naming** — [Object] [Action] format
2. **Required properties** — Mark what's mandatory
3. **Map to journeys** — Events should tell a story
4. **Examples included** — Engineers need samples

## Related

- [Event Tracking Skill](../../../.claude/skills/event-tracking.md)
- [Metrics Designer](metrics-designer.md)
