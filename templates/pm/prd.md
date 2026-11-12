# [Feature/Project Name] — PRD

**[Subtitle: one line on the problem, the solution and the expected outcome, for product, design and engineering]**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [author] | Draft / In review / Approved / Implementing / Shipped | [YYYY-MM-DD] |

## Description
[2–4 sentences: what this PRD covers, what it is based on (intake / proposal), and how to read it: summary here, detail in the numbered sections below.]

## Problem Statement
[Who has the problem, what it is, the evidence, and what it costs if we do nothing. Full evidence: §1 Problem Statement.]

## Solution
[What we will build. Key scope in and out (full list: §4 Goals & Non-Goals, §8 Functional Requirements).]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| [Primary metric] | [value or TBD: who provides it] | [value] | [source / event] |
| [Guardrail metric] | [value or TBD: who provides it] | [Do not exceed X] | [source / event] |

Full metric definitions (formulas, guardrails, instrumentation): §10 Success Metrics and the project's metrics framework.

### Validation: how we know we are right

| Hypothesis | How we validate it | Status | Metric it moves |
|------------|--------------------|--------|-----------------|
| [H-1: We believe X because Y] | [Experiment / usability test / analytics / interview] | Unvalidated / Partial / Validated | [metric above] |

Full hypotheses and assumptions: §2 Hypotheses & Validation. Stop criteria: §16 Rollout Plan.

## Next Action
[One action, one owner.]

---

## Document Details

| Field | Value |
|-------|-------|
| **Stage** | Early (hypotheses) / Defined (requirements) / Delivery-ready (evidence-backed) |
| **Created** | [Date] |
| **Intake Reference** | [Link to intake.md] |

### Stakeholders

| Role | Name | Responsibility |
|------|------|----------------|
| Product Owner | | Final approver |
| Engineering Lead | | Feasibility review |
| Design Lead | | UX review |
| QA Lead | | Test strategy |

---

## 1. Problem Statement

### What's Broken

[Describe the problem in user/business terms. No solution language.]

### Evidence

| Source | Finding | Confidence |
|--------|---------|------------|
| [Analytics/Research/Support/etc.] | [What the data shows] | High/Medium/Low |

### Impact

- **Who:** [Affected users/segments]
- **How many:** [Quantify reach]
- **Severity:** [How bad is the problem for them]
- **Business cost:** [Revenue, retention, efficiency impact]

---

## 2. Hypotheses & Validation

> **Note:** Hypotheses are beliefs requiring validation. Early-stage PRDs may have mostly hypotheses; delivery-ready PRDs need evidence.

| ID | Hypothesis | Evidence Status | Validation Method |
|----|------------|-----------------|-------------------|
| H-1 | [We believe X because Y] | Unvalidated / Partial / Validated | [How we'll test it] |
| H-2 | | | |

### Assumptions & Provenance

| ID | Assumption | Source | Confidence | Validation Plan |
|----|------------|--------|------------|-----------------|
| A-1 | [What we're assuming] | [Who said it / where it came from] | High/Med/Low | [How to validate] |

---

## 3. Background & Evidence

### Market Context

[Competitive landscape, market trends, TAM/SAM/SOM if relevant]

### Research Findings

| Study | Method | Key Finding | Limitations |
|-------|--------|-------------|-------------|
| | | | |

### Strategic Alignment

- **Company goal:** [Which company goal this supports]
- **Product strategy:** [How this fits the roadmap]
- **Why now:** [Timing rationale]

---

## 4. Goals & Non-Goals

### Goals

| ID | Goal | Success Metric | Target | Timeline | Evidence Required |
|----|------|----------------|--------|----------|-------------------|
| G-1 | | | | | [What proves success] |
| G-2 | | | | | |

### Non-Goals

| Exclusion | Rationale |
|-----------|-----------|
| [What we're explicitly NOT doing] | [Why it's out of scope] |

---

## 5. User Types & Personas

| Persona | Description | Primary JTBD | Evidence Source |
|---------|-------------|--------------|-----------------|
| | | | [Research/data backing this persona] |

---

## 6. Jobs-to-be-Done

| ID | When I... | I want to... | So that I... | Priority | Evidence |
|----|-----------|--------------|--------------|----------|----------|
| JTBD-1 | | | | Must | [Source] |
| JTBD-2 | | | | Should | |

---

## 7. Use Cases

### UC-1: [Use Case Name]

**Actor:** [Persona]
**Preconditions:** [State before]
**Trigger:** [What initiates]

**Main Flow:**
1. [Step]
2. [Step]

**Postconditions:** [State after]

**Alternative Flows:**
- [Variation and how it's handled]

**Exception Flows:**
- [Error condition and recovery]

---

## 8. Functional Requirements

| ID | Requirement | Priority | JTBD | Stage | Notes |
|----|-------------|----------|------|-------|-------|
| REQ-001 | | Must | JTBD-1 | Defined | |
| REQ-002 | | Should | JTBD-1 | TBD | [What's needed to define] |

> **Stage key:** Defined = ready for implementation; TBD = needs spike or research; Deferred = pushed to later phase

---

## 9. Non-Functional Requirements

| Category | Requirement | Target | Current | Priority |
|----------|-------------|--------|---------|----------|
| Performance | Page load time | <2s p95 | [Baseline] | Must |
| Scalability | Concurrent users | [Target] | [Current] | Should |
| Security | [Requirement] | | | Must |
| Accessibility | WCAG level | 2.2 AA | | Must |
| Reliability | Uptime | 99.9% | | Must |

---

## 10. Success Metrics

### Primary Metrics

| Metric | Formula | Baseline | Target | Measurement Window |
|--------|---------|----------|--------|--------------------|
| | | | | |

### Guardrail Metrics

| Metric | Threshold | Stop Criteria | Action if Breached |
|--------|-----------|---------------|-------------------|
| | Do not exceed X | If Y happens | [Specific action] |

### Instrumentation vs Outcomes

| Metric Type | Example | What It Proves |
|-------------|---------|----------------|
| Instrumentation | Event fires on button click | Code works |
| Adoption | 50% of users click button | Feature is used |
| Outcome | 20% lift in conversion | Business value delivered |

> **Note:** Instrumentation proves tracking works. Adoption proves usage. Outcomes prove value. Don't conflate them.

---

## 11. Analytics & Instrumentation

### Events

| Event Name | Trigger | Properties | Purpose |
|------------|---------|------------|---------|
| | | | |

### Dashboards

| Dashboard | Metrics | Audience | Update Frequency |
|-----------|---------|----------|------------------|
| | | | |

---

## 12. Technical Needs

### Data Models

[Data structures this feature adds or changes]

### APIs

| Endpoint | Method | Purpose | Owner |
|----------|--------|---------|-------|
| | | | |

### Integrations

| System | Integration Type | Status |
|--------|------------------|--------|
| | | |

---

## 13. Dependencies

| ID | Dependency | Team/System | Status | Risk Level | Mitigation |
|----|------------|-------------|--------|------------|------------|
| DEP-1 | | | | | |

---

## 14. Risks & Mitigations

| ID | Risk | Probability | Impact | Score | Mitigation | Owner |
|----|------|-------------|--------|-------|------------|-------|
| R-1 | | H/M/L | H/M/L | [P×I] | | |

---

## 15. Alternatives Considered

| Option | Description | Pros | Cons | Why Not Selected |
|--------|-------------|------|------|------------------|
| [Current choice] | | | | **Selected** |
| [Alternative 1] | | | | |
| [Alternative 2] | | | | |

---

## 16. Rollout Plan

### Phases

| Phase | Scope | Success Criteria | Rollback Trigger |
|-------|-------|------------------|------------------|
| 1 | [% of users / segment] | [Metrics to hit] | [When to pull back] |
| 2 | | | |
| GA | 100% | | |

### Feature Flags

| Flag | Description | Default | Rollback Owner |
|------|-------------|---------|----------------|
| | | Off | |

### Rollback Criteria

| Condition | Action | Owner | SLA |
|-----------|--------|-------|-----|
| [Metric breaches threshold] | [Specific action] | [Name] | [Time to act] |

### Stop Criteria

| Condition | Decision | Owner |
|-----------|----------|-------|
| [When we'd kill the feature entirely] | [Who decides] | |

---

## 17. Open Questions

| ID | Question | Owner | Due Date | Resolution | Status |
|----|----------|-------|----------|------------|--------|
| Q-1 | | | | | Open / Resolved |

---

## 18. AI Feature Specification (If Applicable)

> **Include only if the feature involves AI/ML components.**

### Model Behavior

| Aspect | Specification |
|--------|---------------|
| Input | [What the model receives] |
| Output | [What the model produces] |
| Confidence threshold | [Minimum confidence to surface] |
| Fallback behavior | [What happens when uncertain] |

### Evaluation Criteria

| Metric | Target | Measurement Method |
|--------|--------|-------------------|
| Accuracy | | |
| Latency | | |
| Fairness | | [How bias is measured] |

### Failure Modes

| Failure | User Impact | Mitigation |
|---------|-------------|------------|
| Model unavailable | | |
| Low confidence | | |
| Incorrect output | | |

### Human Override

[How users can correct or override AI decisions]

---

## 19. Appendix

### Research Data

[Links to full research reports]

### Technical Diagrams

[Architecture, sequence diagrams]

---

## Stage Completeness Guide

| Stage | Required Sections | Evidence Bar |
|-------|-------------------|--------------|
| **Early** | Problem, Hypotheses, Goals, JTBD | Hypotheses can be unvalidated |
| **Defined** | All sections | At least partial evidence for key hypotheses |
| **Delivery-Ready** | All sections complete | Evidence for all critical hypotheses; metrics baselined |

For early-stage PRDs, mark incomplete sections with `[TBD: what's needed]` rather than fabricating content.
