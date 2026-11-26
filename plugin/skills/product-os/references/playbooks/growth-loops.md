# Growth Loops Skill

> Design growth loops (flywheels) that compound user acquisition through the product itself.

**Attribution:** Adapted from [phuryn/product-engineering](https://github.com/phuryn/product-engineering) growth-loops skill (MIT License, Copyright 2026 Pawel Huryn). See NOTICE.md.

## When to Use

- Designing growth mechanisms for a product
- Building sustainable viral or referral traction
- Reducing reliance on paid acquisition
- Analyzing competitor growth strategies
- Optimizing for product-led growth

## The 5 Growth Loop Types

### 1. Viral Loop

**Shared user-created content brings new users back to product.**

| Aspect | Details |
|--------|---------|
| Mechanism | Users create → share on external platforms → new users discover and signup |
| Example | Figma designs shared as links, Loom videos in emails |
| Strength | Exponential acquisition if content inherently shareable |
| Challenge | Requires highly shareable output and strong incentive |

### 2. Usage Loop

**Sharing value created in-product invites new users or drives re-engagement.**

| Aspect | Details |
|--------|---------|
| Mechanism | User creates → shares creation → others consume → become engaged users |
| Example | Twitter threads, Medium articles, Notion templates shared publicly |
| Strength | Growth tied directly to usage and network effects |
| Challenge | Content creation friction must be very low |

### 3. Collaboration Loop

**Inviting colleagues to co-create expands user base within organizations.**

| Aspect | Details |
|--------|---------|
| Mechanism | User creates → invites colleagues → colleagues discover product value |
| Example | Google Docs invitations, Figma team projects, Slack channels |
| Strength | Deep organizational penetration and high retention |
| Challenge | Works best for collaborative/team-based products |

### 4. User-Generated Loop

**Users discover others' creations, then create and share their own.**

| Aspect | Details |
|--------|---------|
| Mechanism | Discover content → create similar → share → others discover |
| Example | TikTok, Pinterest, YouTube trends driving creator participation |
| Strength | Creates content flywheel and network effects |
| Challenge | Requires critical mass of quality content |

### 5. Referral Loop

**Users invite for rewards, incentives, or social recognition.**

| Aspect | Details |
|--------|---------|
| Mechanism | User refers → referred joins → referrer rewarded → shares more |
| Example | Dropbox bonus, Uber referrals, PayPal signup bonuses |
| Strength | Directly incentivizes acquisition; easy to measure ROI |
| Challenge | Requires valuable incentive without eroding unit economics |

## Process

### Step 1: Define Product Value

Clarify the core value users experience:
- Primary action users take
- Value created per user action
- Network effects present (if any)
- Friction points in experience

### Step 2: Evaluate Loop Fit

Assess which loops align with your product:
- Product type (collaborative, content-based, utility)
- Target user behavior and sharing habits
- Network effects already present
- Existing user base and engagement

### Step 3: Design Loop Mechanics

For each potential loop:

| Element | Description |
|---------|-------------|
| **Actor** | Who initiates the loop action |
| **Action** | What they do in-product |
| **Value** | What value is created |
| **Output** | What gets shared/sent |
| **Next step** | How it drives acquisition or repeat use |

### Step 4: Identify Assumptions and Risks

**Mark all assumptions.** Don't invent loop performance.

| Assumption | Evidence | Risk if Wrong |
|------------|----------|---------------|
| [assumption] | [source or "untested"] | [impact] |

### Step 5: Define Metrics

| Metric | Formula | Target |
|--------|---------|--------|
| Loop coefficient | (invites × conversion) per cycle | > 1 for viral |
| Cycle time | Time for one loop iteration | |
| Activation rate | % of invited who activate | |

## Loop Design Template

```markdown
# Growth Loop: [Name]

## Loop Type
[Viral / Usage / Collaboration / UGC / Referral]

## Loop Mechanics

### Actor → Action → Value → Output → Next

1. **Actor:** [who]
2. **Action:** [what they do in-product]
3. **Value created:** [what value]
4. **Output:** [what gets shared]
5. **Next acquisition/repeat step:** [how it brings next user]

## Visual

```
[Actor] → [Action in Product] → [Value Created]
                                      ↓
                              [Shared Output]
                                      ↓
                              [New User Discovers]
                                      ↓
                              [Signs Up / Engages]
                                      ↓
                              [Becomes Actor] → ...
```

## Assumptions

| Assumption | Evidence Type | Confidence |
|------------|---------------|------------|
| [assumption] | Validated / Estimated / Untested | High/Med/Low |

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [risk] | H/M/L | H/M/L | [action] |

## Metrics

| Metric | Current | Target | Measurement |
|--------|---------|--------|-------------|
| Loop coefficient | [n/a or value] | [target] | [how measured] |
| Cycle time | | | |
| Activation rate | | | |

## Step Most Likely to Break

**[Step name]:** [Why this is the weakest link and how to test it]

## Anti-Patterns to Avoid

- [ ] Not spam or dark patterns
- [ ] Incentives don't erode unit economics
- [ ] Doesn't require unrealistic user behavior
- [ ] Doesn't depend on invented performance data
```

## Integration

- **GTM/Launch:** Loop design informs launch strategy
- **Roadmap:** Loop optimization as roadmap item
- **Metrics:** Loop metrics in success framework
- **Experiment:** Test loop assumptions before building

## Quality Checklist

- [ ] Loop type appropriate for product
- [ ] Each step names actor, action, value, output, next
- [ ] Assumptions marked, not presented as facts
- [ ] No invented loop performance numbers
- [ ] Weakest step identified for testing
- [ ] No spam or dark patterns
- [ ] Risks and mitigations documented

## Anti-Patterns

**Avoid:**
- Assuming all products need growth loops
- Copying competitor loops without fit analysis
- Inventing conversion rates or coefficients
- Dark patterns (forced sharing, hidden invites)
- Spam mechanics (over-notification)
- Multiple loops before one works

**Instead:**
- Evaluate fit honestly
- Start with one loop, master it
- Test assumptions before building
- Respect user consent and attention
- Build on genuine value creation
