# Skill: Event Tracking Plan

Create event tracking specifications for analytics platforms.

## When to Use

- Implementing new features
- Setting up product analytics
- Preparing for A/B tests
- Documenting tracking requirements

## Quick Start

```
/product-os:tracking --from prd.md --platform amplitude
```

## Naming Convention

```
[Object] [Action]
```

| Good | Bad |
|------|-----|
| Form Submitted | submit |
| Button Clicked | click_button |
| Page Viewed | user viewed page |

## Event Specification

```yaml
- name: "Signup Started"
  description: "User initiates signup flow"
  trigger: "Signup page loads"
  category: conversion
  
  properties:
    - name: "source"
      type: string
      required: true
      examples: ["homepage", "pricing"]
```

## Property Types

| Type | Example |
|------|---------|
| `string` | "email", "google" |
| `integer` | 1, 42, 1000 |
| `number` | 3.14, 99.99 |
| `boolean` | true, false |
| `array` | ["tag1", "tag2"] |

## Event Categories

| Category | Purpose |
|----------|---------|
| `pageview` | Page/screen loads |
| `engagement` | User interactions |
| `conversion` | Funnel milestones |
| `feature` | Feature usage |
| `error` | Error states |

## User Journey Mapping

```yaml
user_journeys:
  signup:
    steps:
      - event: "Signup Started"
        step: 1
      - event: "Form Completed"
        step: 2
      - event: "Signup Completed"
        step: 3
        conversion_event: true
```

## Platform-Specific Notes

**Amplitude**
- Use `identify` for user properties
- Group events in taxonomy

**Mixpanel**
- Use super properties for persistent data
- Group by distinct_id

**Segment**
- Track calls for events
- Identify calls for users

## Quality Checklist

- [ ] All actions have events
- [ ] Naming consistent
- [ ] Required properties marked
- [ ] Types specified
- [ ] Examples provided
- [ ] Maps to metrics

## Related

- `/product-os:tracking` — Create plan
- `/product-os:metrics` — Metrics framework
- `.claude/agents/event-tracker.md` — Full spec
