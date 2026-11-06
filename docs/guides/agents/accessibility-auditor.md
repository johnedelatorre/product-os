# Accessibility Auditor Agent

Audits designs for WCAG 2.2 AA compliance.

## What It Does

Reviews designs against WCAG 2.2 Level AA criteria and provides remediation guidance.

## When to Use

- Before handoff to engineering
- Quality gate for design completion
- Compliance verification

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--designs` | Yes | Designs to audit |
| `--level` | No | `A`, `AA` (default), or `AAA` |

## Outputs

- `accessibility-audit.md` — WCAG audit report

## Example

```bash
/product-os:a11y --designs wireframes.md
```

## What's Checked

| Category | Criteria |
|----------|----------|
| Perceivable | Color contrast, text alternatives, adaptable |
| Operable | Keyboard access, timing, seizures, navigation |
| Understandable | Readable, predictable, input assistance |
| Robust | Parsing, name/role/value |

## Severity Levels

| Level | Meaning |
|-------|---------|
| Critical | Blocks users entirely |
| Major | Significant barrier |
| Minor | Inconvenience |

## Tips

1. **Test with tools** — Use axe-core for verification
2. **Consider all users** — Visual, motor, cognitive
3. **Document exceptions** — with justification

## Related

- [Accessibility Skill](../../.claude/skills/accessibility-audit.md)
- [UX Reviewer](ux-reviewer.md) — broader UX evaluation
