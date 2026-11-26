# Value Curve Skill

> Compare offerings on the factors one customer segment values. Identify strategic differentiation vs. deliberate parity.

**Attribution:** Adapted from [phuryn/product-engineering](https://github.com/phuryn/product-engineering) value-curve skill (MIT License, Copyright 2026 Pawel Huryn). See NOTICE.md.

## When to Use

- Comparing your product with competitors
- Choosing what to be best at
- Identifying strategic differentiation
- Planning deliberate non-competition areas

## Core Principle

**A good strategy competes to be unique, not the best at everything.** The curve shows where to lead, where parity is enough, and what to deliberately ignore.

## Before You Start

- **One segment per curve.** Needs differ between segments; mixing them shows no focus.
- **Factors are the segment's needs, not your features.** Phrase as solution-agnostic outcomes: "find live sports events," not "sports streaming feature."
- **Evidence from customers.** Interviews for importance and satisfaction with current solutions.
- **With no interviews, label every score an assumption.** First output is then what to test.

## Steps

### 1. Score Every Need for the Segment

For each need: **opportunity = importance × (1 − satisfaction)**

Both on a 0-1 scale. High importance + low satisfaction = high opportunity.

### 2. Pick 5-7 Factors

Include:
- **Highest opportunity scores** — where you can add most value
- **Must-haves** — highly important even if satisfied today (dropping one loses the customer)
- **Relative price** — scored so lower price scores higher

**Leave out needs the segment doesn't care about**, even if competitors fight over them.

**Name factors with customer direction** — higher always means better for customer. "Low price for one user" not "Price."

### 3. List the Offerings

- Your product (as planned or as it is)
- 2-4 competitors the segment actually uses
- At least one substitute (spreadsheet, agency, manual workaround, doing nothing)

### 4. Score Each Offering 0-100 on Each Factor

Use what customers said and reviews show, not feature lists. A feature that exists but doesn't serve the need scores low.

**Every score needs a source or is labeled assumption.**

### 5. Draw the Curve

- Factors on horizontal axis, ordered by importance to segment
- Scores on vertical axis
- One line per offering, with legend
- Keep score table beside chart with sources

### 6. Read the Curve

Write the meaning in a few sentences:

- **Where we must be far ahead:** segment's top-opportunity needs. If not clearly above competitors, no reason to switch.
- **Where parity is enough:** the must-haves.
- **What we deliberately don't compete on:** factors where we sit at or below competitors because segment doesn't care.
- **Lines that look the same:** same shape as competitor = competing on degree, not difference.

**Blue Ocean's four actions help reshape:** eliminate, reduce, raise, create.

## Output

```markdown
# Value Curve: [Segment Name]

## Segment
[One-line description of the segment this curve is for]

## Score Table

| Factor | Our Product | Competitor A | Competitor B | Substitute | Source |
|--------|-------------|--------------|--------------|------------|--------|
| [need] | [0-100] | [0-100] | [0-100] | [0-100] | [source or "assumption"] |

## Chart
[Description or embedded chart visualization]

## Strategic Reading

### Where We Must Lead
- **[Factor]:** [Why we need to be best here]

### Where Parity Is Enough
- **[Factor]:** Customers already satisfied; maintain, don't invest

### Deliberate Non-Competition
- **[Factor]:** This segment doesn't value this; we consciously under-invest

### Strategic Actions
| Action | Factor | Current | Target | Rationale |
|--------|--------|---------|--------|-----------|
| Raise | [factor] | [score] | [score] | [why] |
| Maintain | [factor] | [score] | [score] | [why] |
| Reduce | [factor] | [score] | [score] | [why] |

## Assumptions to Test
| Assumption | How to Test | Priority |
|------------|-------------|----------|
| [assumption] | [method] | High/Medium/Low |
```

## Example

Streaming service for live sports segment (illustrative scores, 0-100 scale):

| Factor | Our Product | Competitor A | Competitor B | Source |
|--------|-------------|--------------|--------------|--------|
| Sports events | 95 | 40 | 30 | User survey |
| Concerts | 90 | 35 | 45 | Team estimate (assumption) |
| Content for kids (must-have) | 70 | 75 | 70 | Reviews |
| Movies | 30 | 90 | 85 | Feature comparison |
| Low price | 60 | 50 | 65 | Published pricing |

**Reading:**
- We aim to be best at sports events and concerts (top needs for this segment)
- Content for kids stays at parity (must-have, but satisfied)
- Movies deliberately low (this segment doesn't prioritize it)

## Mistakes to Avoid

- **Scoring features instead of needs** — turns curve into feature comparison
- **More than 7 factors** — shape stops saying anything
- **Including factors segment doesn't care about** — don't compete where it doesn't matter
- **Trying to beat everyone on everything** — opposite of strategy
- **One curve for several segments** — needs differ
- **Treating assumptions as findings** — unlabeled guesses look like evidence

## Quality Checklist

- [ ] One segment only
- [ ] Every score has source or labeled assumption
- [ ] 5-7 factors maximum
- [ ] Includes at least one substitute
- [ ] Reading states where to lead and what to ignore
- [ ] Assumptions listed for testing
