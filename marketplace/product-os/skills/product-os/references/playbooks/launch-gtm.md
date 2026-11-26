# Skill: Launch and Go-to-Market

Create release notes, enablement materials, and changelog entries.

## When to Use

- Preparing for feature launch
- Creating customer communications
- Enabling sales and support
- Updating changelog

## Quick Start

```
/product-os:launch --project initiatives/onboarding/signup --version 2.4.0
```

## Launch Materials

### Release Notes (Customer-facing)

```markdown
# What's New: Simplified Signup

## Overview
Brief, benefit-focused summary.

## What's New
- Feature 1: Benefit explanation
- Feature 2: Benefit explanation

## How to Use
1. Step-by-step instructions
2. With screenshots
```

### Enablement (Internal)

```markdown
# Sales & Support Enablement

## Quick Summary
- Key changes in bullets

## Talking Points
### For Sales
- "We've made it 3x faster..."

### For Support
- Common questions and answers

## Demo Script
1. Show before/after
2. Highlight key benefits
```

### Changelog Entry

```markdown
## [2.4.0] - 2026-11-06

### Added
- New features

### Changed
- Modified behaviors

### Fixed
- Bug fixes

### Removed
- Deprecated features
```

## Audience Variants

| Audience | Content Style |
|----------|---------------|
| Customers | Benefits, how-to |
| Sales | Talking points, objections |
| Support | Technical, FAQ |
| Internal | Full context |

## Launch Checklist

**Pre-Launch**
- [ ] Feature complete
- [ ] Tracking implemented
- [ ] Release notes written
- [ ] Enablement complete

**Launch Day**
- [ ] Feature enabled
- [ ] Monitoring active
- [ ] Support ready
- [ ] Communications sent

**Post-Launch**
- [ ] Metrics flowing
- [ ] Error rates normal
- [ ] Review scheduled

## Writing Tips

1. **Customer-first** — Benefits over features
2. **No jargon** — Plain language
3. **Show, don't tell** — Include visuals
4. **Call to action** — What should they do?

## Related

- `/product-os:launch` — Create materials
- `/product-os:review-launch` — Post-launch review
- `.claude/agents/launch-manager.md` — Full spec
