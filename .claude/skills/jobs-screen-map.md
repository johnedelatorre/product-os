# Jobs-Screen Map Skill

> Map user jobs to screens: job → screen → question → primary action. For design briefs, flows, and design critique.

**Attribution:** Adapted from [phuryn/product-engineering](https://github.com/phuryn/product-engineering) ui-design skill (MIT License, Copyright 2026 Pawel Huryn). See NOTICE.md.

## Core Principle

Before drawing any screen, work out what people come to do: one row per job, in the user's words, mapped to the screen that does it.

**A screen with no job is cut. A job with no screen is a gap.**

## The Jobs Map

| # | Job (user's words) | Screen | Question It Answers | Primary Action |
|---|-------------------|--------|---------------------|----------------|
| 1 | [what user wants to accomplish] | [screen name] | [what user learns] | [main button/action] |

## Process

### 1. List User Jobs

Use the user's language, not system terminology:
- "See how my campaign performed" not "View analytics dashboard"
- "Find a contractor in my area" not "Search provider database"
- "Get paid for my work" not "Process invoice submission"

### 2. Map to Screens

Each job gets a screen. Ask:
- Where does this happen?
- Is this the right place for this job?
- Could jobs be combined without confusion?

**Do NOT rigidly enforce one screen per job if product warrants multiple steps.** Purposeful mapping matters, not arbitrary rules.

### 3. Define the Question

Each screen answers one primary question:
- Dashboard: "How is my business doing right now?"
- Settings: "How do I change my preferences?"
- Detail view: "What are the specifics of this item?"

### 4. Identify Primary Action

What's the one thing the user most needs to do here?
- Dashboard: "Create new [item]"
- Detail: "Edit" or "Complete"
- List: "Select" or "Filter"

## Example Data in Screens

**Use realistic, clearly marked example data.**

| Type | Use | Mark As |
|------|-----|---------|
| Example data | Fill every screen, every tab | "Sample data" label |
| Empty states | Show alongside filled states | Intentionally shown |
| Edge cases | Error states, loading, zero results | Shown for each |

**The example data fills every screen, every tab, so a click-through never meets an empty one unexpectedly.**

## Fresh-Eyes Walkthrough

Before owner sees screens:

1. Give a fresh session (or person new to domain) only the screenshots
2. They get only: ordered images and the user's job
3. Never give: brief, code, prior context
4. Ask for each screen:
   - What is this for?
   - What would you press next?
   - What is unclear?
5. Fix any screen they cannot explain

**Don't claim fresh-eyes review if you provided context beyond screenshots.**

## Output Template

```markdown
# Jobs-Screen Map: [Project Name]

## Jobs Map

| # | Job (user's words) | Screen | Question | Primary Action |
|---|-------------------|--------|----------|----------------|
| 1 | | | | |
| 2 | | | | |

## Screen Inventory

### Screen: [Name]

**Job(s):** #[number(s)]

**Question answered:** [what user learns]

**Primary action:** [main thing to do]

**States:**
- [ ] Filled (with example data)
- [ ] Empty
- [ ] Loading
- [ ] Error
- [ ] Zero results

**Example data notes:** [what sample data represents, labeled as sample]

---

## Gaps Analysis

### Jobs Without Screens
| Job | Gap Reason | Resolution |
|-----|------------|------------|
| [job] | [why no screen] | [add screen / combine / cut job] |

### Screens Without Jobs
| Screen | Assessment |
|--------|------------|
| [screen] | [cut / found job / navigation only] |

## Fresh-Eyes Review

**Reviewer:** [who - fresh session or person]
**Context given:** [screenshots only / more - explain]

| Screen | Could Explain? | Next Action Clear? | Issues Found |
|--------|----------------|-------------------|--------------|
| [screen] | ✅ / ❌ | ✅ / ❌ | [issues] |

**Note:** [If fresh-eyes couldn't run, state why and mark Not Verified]
```

## Integration with Design Workflow

| Phase | Jobs-Screen Map Role |
|-------|---------------------|
| Proposal | Initial jobs map with key screens |
| Design Brief | Complete jobs map |
| User Flows | Flows reference jobs map |
| Wireframes | Each wireframe shows job number |
| Design Critique | Verify each screen serves its job |

## Quality Checklist

- [ ] Jobs in user's words (not system terminology)
- [ ] Every job has a screen (or documented reason)
- [ ] Every screen has a job (or cut)
- [ ] Example data fills all screens (labeled as sample)
- [ ] Empty/loading/error states shown
- [ ] Fresh-eyes walkthrough done (or marked Not Verified)
- [ ] No fake user research claimed

## What This Is NOT

- **Not rigid one-screen-per-job** — complex jobs may span screens
- **Not a replacement for user research** — don't claim research you didn't do
- **Not a feature list** — jobs are user outcomes, not features
- **Not the only design input** — combine with flows, wireframes, critique
