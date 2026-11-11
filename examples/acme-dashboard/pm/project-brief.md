# Dashboard Performance — Project Brief

**One-page summary of the Dashboard Performance project for executives and stakeholders.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | Approved | 2026-11-06 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
The one-page version of the [PRD](prd.md): problem, why now, goals, scope, people, timeline and risks. Read this for the decision; read the PRD for the detail.

## Problem Statement
Enterprise customers wait 15+ seconds for the dashboard to load, causing poor satisfaction (CSAT 2.1/5), 47 support tickets in the past month and churn risk from our largest account ($2M ARR).

## Solution
Improve both perceived performance (skeleton loading, progressive rendering) and actual performance (lazy loading, API changes), and monitor load time. No new dashboard features.

## Success Metrics
| Goal | Metric | Baseline | Target (by when) | How we measure |
|------|--------|----------|------------------|----------------|
| Reduce load time | p95 Time to Interactive | 16.4 s | < 3 s at launch | RUM |
| Improve perception | Dashboard CSAT | 2.1 / 5 | > 4.0 within 30 days of launch | Zendesk |
| Reduce support load | Dashboard-related tickets | 47 / 30 days | −50% within 30 days of launch | Zendesk |

Full framework: [metrics-framework.md](metrics-framework.md).

## Next Action
Ruth Adeyemi (CS Lead) shares this brief with the Acme account team by 2026-11-14 for QBR prep.

---

## Why Now

Acme Corp's next QBR is in 6 weeks, and they're actively evaluating competitors. Support ticket volume for "slow dashboard" is increasing weekly. Delaying action risks losing our largest customer.

---

## Scope

### In Scope
- Perceived performance improvements (skeleton loading, progressive rendering)
- Actual performance improvements (lazy loading, API optimization)
- Dashboard load time monitoring and alerting

### Out of Scope
- New dashboard features
- Mobile dashboard redesign
- Real-time data refresh (future phase)

---

## Users

| User Type | Description | Size | Priority |
|-----------|-------------|------|----------|
| Enterprise admin | Daily dashboard users | 500 | Primary |
| Enterprise viewer | Weekly dashboard users | 2,000 | Secondary |

---

## Stakeholders

| Role | Name | Responsibility | Sign-off |
|------|------|----------------|----------|
| Sponsor | Elena Marsh (VP Product) | Executive oversight | Yes |
| Product | Priya Shah | Requirements | Yes |
| Engineering | Tomás Ortega | Delivery | Yes |
| Design | Kenji Mori | UX | Yes |
| Customer Success | Ruth Adeyemi | Acme relationship | No |

---

## Timeline

| Milestone | Target Date | Dependencies |
|-----------|-------------|--------------|
| PRD Approved | Nov 8 | — |
| Design Complete | Nov 15 | PRD |
| Development Complete | Dec 6 | Design |
| QA Complete | Dec 13 | Dev |
| Launch | Dec 16 | QA |

---

## Risks

| Risk | P | I | Mitigation |
|------|---|---|------------|
| Backend changes need more time | M | H | Early eng spike, parallel workstreams |
| Acme QBR before launch | M | H | Interim communication, early beta |

---

## Links

| Document | Link |
|----------|------|
| Full PRD | [prd.md](prd.md) |
| Intake | [intake.md](../intake/intake.md) |

---

*This is a one-page summary. See the full PRD for complete details.*
