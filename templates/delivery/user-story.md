# Story: [STORY-XXX] [Verb] [thing] [for whom]

<!-- Jira Summary: "[Verb] [thing] [for whom]", e.g. "Show password rules while the user types".
     Jira Description: everything below this comment, exactly as laid out in docs/reference/document-format.md §4.
     Jira fields, not repeated in the Description: key, assignee, status, story points field (mirrors Details), labels. -->

**As a** [user type], **I want** [capability], **so that** [outcome].

## Description
[What this story changes, in 2–3 sentences.]

## Problem Statement
[The user problem this story solves.]

## Solution
[What we build, with any technical notes engineering needs. Exclusions go under Details → Out of scope.]

## Acceptance Criteria

```gherkin
Feature: [Feature name]

  Scenario: STORY-XXX.AC1 [Happy path]
    Given [precondition]
    When [action]
    Then [outcome]

  Scenario: STORY-XXX.AC2 [Error case]
    Given [precondition]
    When [error condition]
    Then [error handling]

  Scenario: STORY-XXX.AC3 [Edge case]
    Given [edge case precondition]
    When [action]
    Then [edge case outcome]
```

## Design
**Use cases:** [UC-X / JTBD-X this story serves (PRD §Use Cases / §JTBD)]
**Flow and screens:** [FLOW-### steps and SCR-### screens this story implements, linked to flows.md, wireframes.md and prototype.html (`#scr-###`); or "No UI design" for backend-only stories]
**States:** [empty, loading, error, success and edge states this story must show; name the AC that covers each]
**UX requirements:** [design-system, copy, accessibility (WCAG 2.2 AA) and interaction rules; or "None" with the reason]

## Validation
| Check | What proves it |
|-------|----------------|
| Tests | [Unit: …; Integration: …; E2E: … (N/A if not applicable)] |
| Observability | [Logs, events and alerts that prove it works in production] |
| Rollout / rollback | [Feature flag, rollback trigger, rollback step] |
| Success metric | [MET-### or event this story moves] |

## Details
| Discipline | Points | Confidence | Dependencies |
|------------|--------|------------|--------------|
| frontend / backend / fullstack | [1-13 or TBD: team calibration] | High / Medium / Low | [STORY-XXX (blocks / blocked by, status) or None] |

**Estimate rationale:** [Complexity, uncertainty, similar past work, and why this discipline]
**Out of scope:** [Explicit exclusion, or "None"]

## Links
Epic: EPIC-XXX · PRD requirement: REQ-XXX · Confluence: [Epics & Stories page link]
