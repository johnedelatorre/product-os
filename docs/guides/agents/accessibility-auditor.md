# Accessibility Auditor Agent

Audits the actual designs for WCAG 2.2 AA compliance.

## What It Does

Audits real designs against WCAG 2.2 Level AA criteria and provides remediation guidance. Each issue cites the exact screen, frame and element.

## When to Use

- Before handoff to engineering
- Quality gate for design completion
- Compliance verification

## What It Needs: the Real Design

| Source | What can be checked |
|--------|---------------------|
| `prototype.html` in a browser, or a live URL | Full audit: automated scans (axe-core, pa11y, Lighthouse), keyboard, focus, screen reader |
| Figma link (via Figma MCP) | Real colours for contrast, target sizes |
| Screenshots | Visible content, labels, apparent contrast |
| `wireframes.md` | Structure, labels, heading order, annotated focus order |

No design available: the agent stops and asks you for one. Checks that need a running build or real colours are marked **Not Verified** when those are missing, never guessed.

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--target` | Yes | `prototype.html` or a URL (full audit), or a Figma link, screenshots or `wireframes.md` (static checks) |
| `--wcag` | No | WCAG level (default: AA) |

## Outputs

- `accessibility-audit.md` — standard header, then a **What was reviewed** table (sources, screens, version, review date, methods that ran) and the audit. Template: `templates/design/accessibility-audit.md`.
- `a11y-issues.csv` — issue log for tracking
- `axe-results.json` — raw scan data (only when a scan ran)

## Example

```bash
/product-os:a11y --target initiatives/onboarding/signup/prototype.html
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

1. **Test with tools** — use axe-core on a running build for verification
2. **Consider all users** — visual, motor, cognitive
3. **Document exceptions** — with justification

## Related

- [Design Workflow](../design-workflow.md) — from PRD to reviewed designs
- [Accessibility Skill](../../../.claude/skills/accessibility-audit.md)
- [UX Reviewer](ux-reviewer.md) — broader UX evaluation
