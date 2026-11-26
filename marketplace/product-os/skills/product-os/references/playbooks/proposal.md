# Proposal Skill

> Research an idea, propose what to build, interface first. For new ideas and "is this worth building" — not for agreed changes or bugs.

**Attribution:** Adapted from [phuryn/product-engineering](https://github.com/phuryn/product-engineering) propose skill (MIT License, Copyright 2026 Pawel Huryn). See NOTICE.md.

## When to Use

Use this skill for:
- **New ideas** — "I have an idea for..."
- **Worth building?** — "Should we build X?"
- **Product in use needs its next step** — evidence-based iteration

Do NOT use for:
- **Agreed changes** — Go straight to PRD or plan
- **Bugs** — Go straight to fix
- **Small UI changes** — No proposal overhead needed
- **Existing WIP** — Continue with current artifacts

## Core Principle

**Every claim is a hypothesis with a source until people use and pay.** What comes out is informed hypotheses, never findings.

**This is not an interview.** Questions come last, and only the ones evidence cannot decide. The skill brings in what the owner doesn't know yet.

**The owner decides; the agent owns the evidence.** The owner owns the thesis, the segment, what gets built and when. The agent owns the evidence and the proposal artifact, and says plainly where evidence and the owner's idea disagree.

## Claim Types

Mark every claim by kind:

| Kind | Example | Treatment |
|------|---------|-----------|
| **Observed fact** | A published price; a review saying "I export to spreadsheet every Friday" | Evidence with source and date |
| **Owner constraint** | "I want to start with educators"; "no mobile app" | A decision: recorded, not argued with |
| **Agent inference** | "Educators will pay because they pay for similar tools" | Marked as agent's, with underlying evidence |
| **Unsupported assumption** | "Teams will switch within a month" | Named, and tested before anything rests on it |

**A competitor's marketing is evidence of positioning, not capabilities or outcomes.**

**The owner's preference is a decision; the owner's assertion is a hypothesis.** "I want this segment" records a choice. "This segment will pay" remains a hypothesis sourced only to the owner.

## Steps

### 1. Read What Exists

Read the owner's material and any existing product context first:
- Supplied notes, research, data, links, screenshots
- Existing brief, decision log, earlier proposals
- Current product state and prior decisions

**Use the repository's existing proposal location.** Duplicated proposals lose decisions between them. Update existing proposals rather than creating new ones.

### 2. Research What's Missing

Research up to five alternatives people actually use:
- Include substitutes (spreadsheets, agencies, manual workarounds, doing nothing)
- Keep substitutes distinct from direct competitors
- Each quote is verbatim with link and date read
- Exclude vendor posts, staff posts, affiliate/promoted content
- Every source gets address and date read

**Apply adjacent skills when segments are open:**
- `beachhead-segment.md` for segment selection
- `value-proposition.md` for proposition
- `value-curve.md` for comparison

### 3. Check Feasibility First

Before drawing screens, check what may not exist or be allowed:
- API availability
- Platform rules
- Data access
- Cost per user vs. price

Name what you checked. Screens of something that can't be built waste review time.

### 4. Propose

**One direction when evidence clearly favors it; two or three when choice is real.** Inventing alternatives hides the recommendation.

For each direction include:
- Audience and value proposition
- Scope: what first version does and deliberately leaves out
- Advantage over alternatives
- Impact vs. effort weighting

**Name the weakest consequential assumption** — the one that, if wrong, changes the recommendation. A shaky detail that changes nothing can wait.

**Recommend one direction with reason.**

### 5. Jobs Map Before Screens

Before drawing any screen:

| Job (user's words) | Screen | Question it answers | Primary action |
|--------------------|--------|---------------------|----------------|

A screen with no job is cut. A job with no screen is a gap.

### 6. Key Screens

For each key job, show:
- Realistic example data (labeled as sample)
- Empty states alongside filled states
- The job number it serves

**Fresh-eyes check:** A session given only the screens should be able to say what it's for and what to press next.

### 7. Ask Only What Evidence Can't Decide

Questions belong in the artifact. Ask only about:
- Owner's values and preferences
- Segment choice
- Scope decisions

Each question has options, a recommendation, and reason.

### 8. Define the Experiment

Include:
- Hypothesis ID
- Participants
- Task
- Observed behavior
- Decisive result

Building the first version and putting it before paying users is often the experiment.

## Output: `proposal.md`

Save to `initiatives/<initiative>/<project>/proposal.md`:

```markdown
# Proposal: [Title]

## TL;DR
[One paragraph: what to build, for whom, why now]

## Metadata
- **Author:** [Agent]
- **Date:** [Date]
- **Status:** Draft | Under Review | Accepted | Rejected
- **Stage:** Idea exploration (not PRD-ready)

## Research

### What We Learned
[Key findings with sources and dates]

### Claim Classification
| Claim | Type | Source |
|-------|------|--------|
| [claim] | Observed / Owner decision / Inference / Assumption | [source] |

### Alternatives People Use
| Alternative | Type | Strengths | Weaknesses |
|-------------|------|-----------|------------|
| [name] | Competitor / Substitute / Do nothing | | |

## Segment
[Target segment with evidence for selection]

## Value Proposition
1. **Who:** [segment]
2. **Why:** [problem/JTBD]
3. **What before:** [current state]
4. **How:** [solution]
5. **What after:** [outcome]
6. **Alternatives:** [why us]

## Feasibility Check
| Check | Result | Notes |
|-------|--------|-------|
| [check] | ✅ / ❌ / ⚠️ | [details] |

## Recommendation

### Direction
[Recommended direction with rationale]

### First Version Scope
**In:** [what's included]
**Out:** [what's deliberately excluded]

### Weakest Consequential Assumption
[The assumption that, if wrong, changes the recommendation]

## Jobs Map
| # | Job (user's words) | Screen | Question | Primary Action |
|---|-------------------|--------|----------|----------------|
| 1 | | | | |

## Key Screens
[Descriptions or links to mockups, each labeled with job number]

## Open Decisions
| Decision | Options | Recommendation | Reason | Owner |
|----------|---------|----------------|--------|-------|
| | | | | |

## Hypotheses to Test
| ID | Hypothesis | Test | Decisive Result |
|----|------------|------|-----------------|
| H1 | | | |

## Next Steps
- [ ] Owner reviews proposal
- [ ] Resolve open decisions
- [ ] If accepted, proceed to PRD
```

## After Acceptance

When the owner accepts:
1. Update the brief and link proposal as evidence
2. Update decision log where needed
3. Proceed to PRD for complex changes
4. For simple changes, proceed directly to plan

## Running It Again

After people have used the product:
1. Collect what they used, returned to, abandoned
2. Update the same proposal file
3. Place each observation under the hypothesis it bears on
4. Update hypothesis status: supported, weakened, refuted, untested
5. Replace recommendation (keeping old and new creates confusion)

**What people say they did counts; what they say they would do is a hypothesis again.**

## Quality Checklist

- [ ] Every claim shows its type and source
- [ ] Alternatives include substitutes and "do nothing"
- [ ] Feasibility checked before screens
- [ ] Jobs mapped before screens drawn
- [ ] One clear recommendation with reason
- [ ] Weakest consequential assumption named
- [ ] Open decisions have recommendations
- [ ] Experiment defined with decisive result
