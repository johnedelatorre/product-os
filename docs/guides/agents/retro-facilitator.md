# Retro Facilitator Agent

Facilitates retrospectives and improvement tracking.

## What It Does

Structures retrospectives with Start/Stop/Continue format and tracks action items.

## When to Use

- End of sprint/project
- Team reflection
- Process improvement

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project to reflect on |
| `--participants` | No | Team members |

## Outputs

- `retrospective.md` — Retro document with actions

## Example

```bash
/product-os:retro --project initiatives/onboarding/signup/
```

## Retro Format

**Start** — What should we begin doing?
**Stop** — What should we stop doing?
**Continue** — What's working well?
**Actions** — Specific improvements to implement

## Tips

1. **Create safe space** — honest feedback requires trust
2. **Focus on process** — not blame
3. **Track actions** — improvement requires follow-through

## Related

- [Risk Manager](risk-manager.md) — retrospective risks
- [Stakeholder Comms](stakeholder-comms.md) — share learnings
