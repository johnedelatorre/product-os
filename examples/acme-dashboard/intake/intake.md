# Intake: Improve Dashboard Performance

## Metadata

| Field | Value |
|-------|-------|
| **Source** | Customer Success Team via Slack #feedback |
| **Date Received** | November 1, 2026 |
| **Analyst** | Product OS Intake Agent |
| **Status** | Approved |

---

## Raw Input

> "Multiple enterprise customers are complaining about dashboard load times. Acme Corp (our largest account, $2M ARR) specifically mentioned in their QBR that the dashboard takes 15+ seconds to load on first visit. They're threatening to evaluate competitors. Support has logged 47 tickets in the past month related to 'slow dashboard' with an average CSAT of 2.1/5. Can we add a loading skeleton or something to make it feel faster?"

---

## Problem Statement

Enterprise customers are experiencing unacceptable dashboard load times (15+ seconds), leading to poor satisfaction scores (CSAT 2.1/5) and churn risk from key accounts. The current experience provides no feedback during loading, making perceived wait times worse.

---

## Evidence

| Signal | Source | Details |
|--------|--------|---------|
| 15+ second load times | Acme Corp QBR | Measured on their corporate network |
| 47 support tickets | Zendesk | Past 30 days, "slow dashboard" keyword |
| CSAT 2.1/5 | Support metrics | Average for dashboard-related tickets |
| Churn risk | Account Management | Acme evaluating competitors |
| $2M ARR at risk | Finance | Acme Corp annual contract value |

---

## Affected Users

| Segment | Description | Estimated Size | Severity |
|---------|-------------|----------------|----------|
| Enterprise admins | Users who access dashboard daily | ~500 users | High |
| Enterprise viewers | Users who access weekly | ~2,000 users | Medium |
| SMB users | Smaller accounts, less data | ~10,000 users | Low |

---

## Business Impact Hypothesis

**If we solve this:**
- Retain Acme Corp ($2M ARR) and reduce enterprise churn risk
- Improve CSAT scores for dashboard-related support tickets
- Reduce support ticket volume (estimated 30% reduction)

**If we don't solve this:**
- Risk losing Acme Corp and potentially other enterprise accounts
- Continued poor CSAT affecting NPS
- Growing support burden

---

## Solution Bias Check

**Was the input solution-biased?** Yes

- **Stated solution:** "Add a loading skeleton"
- **Underlying problem:** Dashboard performance is unacceptably slow, AND users have no feedback during loading. Loading skeletons address perception but not root cause.

---

## Urgency Signals

| Signal | Source | Assessment |
|--------|--------|------------|
| Acme QBR feedback | Account Management | Next QBR in 6 weeks |
| Competitor evaluation | Acme stakeholder | Already demoing alternatives |
| Ticket trend | Support | Volume increasing week-over-week |

---

## Open Questions for PM

1. What is the actual measured load time across percentiles (p50, p95, p99)?
2. What is the acceptable load time target for enterprise accounts?
3. Are there specific dashboard components that contribute most to load time?
4. What is the technical feasibility of lazy loading or pagination?
5. Is there budget for infrastructure improvements if needed?

---

## Recommended Priority

**High**

Rationale: $2M ARR at immediate risk with a 6-week timeline before next Acme QBR. Poor CSAT and increasing ticket volume indicate widespread issue beyond one account.

---

## Next Steps

- [x] Human review and approval
- [ ] Engineering investigation of root causes
- [ ] Hand off to PRD Author
