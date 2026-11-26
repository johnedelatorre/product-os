# Story: [STORY-XXX] [Verb] [thing] [for whom]

<!-- Jira Summary: "[Verb] [thing] [for whom]", e.g. "Show password rules while the user types".
     Jira Description: everything below this comment, exactly as laid out in docs/reference/document-format.md §4.
     Keep it short: an engineer should read the whole ticket in under a minute (.claude/skills/engineering-handoff.md).
     Jira fields, not repeated in the Description: key, assignee, status, story points field (mirrors Estimate), labels. -->

**As a** [user type], **I want** [capability], **so that** [outcome].

**Problem:** [One or two sentences: what is broken or missing for this user today.]

## Requirements
- [What to build, in 3–5 short lines.]
- [Name the labels, components, rules and data an engineer needs.]

## UX and design requirements
- [Design-system components, copy, the states to show, accessibility. Or "None: no UI" for backend-only work.]

## Design
[Figma: link to this ticket's own page or frame in the main design file] · Prototype: [link to its step, `#scr-###`] · Flow: [FLOW-### step]
**Copy:** use the copy in the design as is. It has been through the UX writing pass. [UX writing guide](link)
<!-- Copy line: only on tickets with a screen, and only when the screen is marked applied in ux-writing.md. Leave it out of backend-only tickets. -->

## Done when
- [ ] [A plain sentence a tester can check]
- [ ] [3–5 lines in total, covering the main path and the one or two cases that matter]

## Estimate
[n] points · frontend / backend / fullstack · PRD: REQ-XXX · Depends on: [STORY-XXX or None]
<!-- Backend tickets: write "[n] points (proposed; engineering confirms)". -->

## Sub-tasks
<!-- Optional. Use when the work divides by discipline or by step. One line each, no points. Leave the section out when there are none. -->
- [frontend] [step]
- [backend] [step]

## Engineering to complete
<!-- Backend tickets only. Product OS writes the user story, the problem, the high-level requirements and Done when, and leaves this section empty. The engineers fill it in. Leave the section out of frontend tickets. -->
- **Approach:**
- **API and data changes:**
- **Risks and unknowns:**
