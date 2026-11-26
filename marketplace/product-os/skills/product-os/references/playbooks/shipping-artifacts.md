# Shipping Artifacts Skill

> The documentation set that makes AI-built code reviewable: architecture, flows, permissions, variables, test coverage.

**Attribution:** Adapted from [phuryn/product-engineering](https://github.com/phuryn/product-engineering) shipping-artifacts skill (MIT License, Copyright 2026 Pawel Huryn). See NOTICE.md.

## Purpose

AI agents write code fast but leave no durable record of intent — what the system is supposed to do, who may do what, where secrets live, which rules are verified. Without that record, no human (and no auditing agent) can tell whether code is safe to ship.

These docs are written for two readers: a human reviewer and the next AI coding agent. They are the **intended-state** half of every later audit.

## Conditional Application

| Workflow | Requires These Artifacts? |
|----------|--------------------------|
| PM/research/design only | No |
| Code being shipped | **Yes — required** |
| Configuration changes | Yes, update relevant docs |
| New integrations | Yes, document in architecture |

## Locations and Names

**The repo's own setup wins.** Before writing anything:

1. Check agent instructions (`AGENTS.md`, `CLAUDE.md`)
2. Find existing docs location (`docs/`, `documentation/`)
3. Find existing equivalents (match on content, not filename)
4. Find existing test-coverage map
5. Find existing reports location

**Follow what you find.** Use plugin defaults only where repo has none.

**Never create a file differing only in letter case** from an existing one — collisions on case-insensitive filesystems.

## Core Documents (Always Required)

### 1. `architecture.md`

What the system is and how it hangs together.

**Must capture:**
- Product overview and key assumptions
- Tech stack
- Auth/sessions/claims flow end-to-end
- Trust boundaries (service-role vs. client)
- Known risks/assumptions (backed by code locations)
- Related documents index

**Reviewer use:** Root document; everything cross-references from here.

### 2. `flows.md`

Journeys where permissions and side effects are exercised.

**Must capture:**
- Each flow as actor + precondition + success outcome
- Step-by-step: UI → server → data → jobs → providers
- **Authz check at each protected step** (which claim/role, on which resource, expected deny case)
- **Trust-boundary crossings** (browser→server, server→provider, webhook→app)
- State changes and side effects

**Reviewer use:** Runtime view that static permissions matrix can't show.

**Anti-PRD rule:** Flows not touching permissions, data integrity, external effects, money, privacy, or safety don't belong here.

### 3. `permissions.md`

Who may do what.

**Must capture:**
- Roles/claims and where scope is derived
- Resource × operation × role matrix
- Which tables have RLS vs. code-enforced checks

**Reviewer use:** Baseline for access-control audits.

### 4. `variables.md`

Configuration and secrets, mapped to risk.

**Must capture:**

| Name | Used By | Scope | Source | Rotation | Risk |
|------|---------|-------|--------|----------|------|
| [name] | [component] | Server/Client | [env/secret] | [policy] | [risk level] |

- Explicit confirmation: no secret bundled client-side
- Pre-go-live checklist
- **Names and purpose only — NEVER secret values**

**Reviewer use:** Secrets/PII-leak surface and rotation plan.

### 5. `tests.md`

Verification map: which rules are checked, proposed, or uncovered.

**Three clearly separated sections:**

| Section | Contains |
|---------|----------|
| **Existing coverage** | Tests in repo today, tied to rule each pins |
| **Proposed tests** | Recommended cases not yet written, by type |
| **Gaps** | Documented rules with no verification, ranked |

**Each row carries:**
- Use-case → rule → expected behavior (including deny case)
- Evidence source (doc + code)
- Status (existing / proposed / none)

**Reviewer use:** Shows whether each rule is actually pinned by test, only proposed, or unverified.

## Conditional Documents (Only If Applicable)

### 6. `emails.md` (if app sends email)

Every notification the system sends.

- Queue → processor → provider path
- Templates and variables accepted
- Retry/backoff behavior
- Where to look when send fails

### 7. `cron.md` (if scheduled jobs exist)

All scheduled work and safe operation.

| Job | Schedule | Function | Secrets | Limits | Retry |
|-----|----------|----------|---------|--------|-------|
| [name] | [cron] | [func] | [which] | [limits] | [policy] |

- How each job stays idempotent
- How internal calls authenticate
- Where to see last runs

### 8. `seo.md` (if public/indexable routes)

How app handles SEO and social previews.

- Preview approach (static meta / prerender / edge HTML)
- Route → needs-SEO → public-data-only table
- How dynamic metadata is sanitized
- Bot vs. human routing

### 9. `automation.md` (if embedded AI/automation)

Embedded agents and automation paths.

Per automation/agent:
- Trigger + owner + approval required?
- Inputs it may read
- **Exact tools/APIs it may call** (tool surface as guardrail)
- Where steering (prompt) lives vs. non-prompt guardrails
- Output contract (schema, validation, failure handling)
- App-owned side effects vs. agent suggestions
- Controls: approval gates, logging, rate limits, kill switch

**Reviewer use:** Makes hidden automation visible; draws line between what agent proposes and what app enforces.

## Output Template

```markdown
# Shipping Artifacts: [Project Name]

## Documentation Inventory

| Doc | Path | Status | Notes |
|-----|------|--------|-------|
| architecture.md | [path] | Present / Stale / Missing | |
| flows.md | [path] | Present / Stale / Missing | |
| permissions.md | [path] | Present / Stale / Missing | |
| variables.md | [path] | Present / Stale / Missing | |
| tests.md | [path] | Present / Stale / Missing | |
| emails.md | [path] | Present / N/A | [reason if N/A] |
| cron.md | [path] | Present / N/A | |
| seo.md | [path] | Present / N/A | |
| automation.md | [path] | Present / N/A | |

## Cross-References

All docs reference back to architecture.md under "Related Documents."

## Stack-Specific Notes

[Identify actual project stack]

**Supported validations:** [what can be verified]

**Unsupported stack validations:** [what remains unverified — state clearly]

**Stack-specific checklists needed:** [if any]
```

## Integration

- **Intended-vs-Implemented:** Uses these docs as intent baseline
- **Release Gate:** Verifies docs exist and match code
- **DoD Gate:** Checks documentation completeness

## Quality Checklist

- [ ] Core docs (1-5) present for any code being shipped
- [ ] Conditional docs included only when capability exists
- [ ] N/A capabilities noted in architecture.md
- [ ] No secret values in variables.md (names/purpose only)
- [ ] Cross-references in place
- [ ] Actual stack identified
- [ ] Unsupported validations stated clearly
- [ ] Docs match code (or findings raised)

## Critical Rules

1. **Skip inapplicable conditional docs** — write one line in architecture.md ("No scheduled work — no cron.md") rather than inventing empty documents.
2. **Be honest about current state** — accurate map, not clean bill of health.
3. **Reuse existing doc names/links** — don't create competing docs.
4. **Docs are intent, not proof** — code audit verifies alignment.
5. **Don't promise executed behavior for instructional docs** — these describe what should be true, not what is verified.
