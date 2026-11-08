# /product-os:release-gate

> Run the release gate: owner preview, go/no-go, independent review, verify build serves.

**Output Style:** Follow `.claude/skills/clear-output.md`

## Usage

```
/product-os:release-gate --initiative <slug> --project <slug>
/product-os:release-gate --stage <stage-name> --initiative <slug> --project <slug>
```

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--initiative` | Yes | Initiative slug |
| `--project` | Yes | Project slug |
| `--stage` | No | Specific stage to gate (default: current) |
| `--skip-preview` | No | Skip owner preview (code-only changes) |

## Process

### 1. Pre-Release Checks

- Tests passing
- Intent vs. implementation audit
- Independent review (mandatory for code)
- Owner click-through (if UI changes)
- Docs current

### 2. Go/No-Go

- Post explicit checklist with evidence
- Request owner's explicit GO or NO-GO
- Silence is never go
- Waivers recorded as waivers (not Pass)

### 3. Promote

- Apply migrations (if any)
- Update production branch
- Deploy all runtimes

### 4. Verify

- Confirm new build serves (probe additions/removals)
- Code/schema agreement
- All runtimes at correct version
- Smoke tests

## Owner Click-Through

When change affects what user sees:

```markdown
## Ready for Review

**URL:** [link]

### Flows to Try
| Flow | Action | Expected Result |
|------|--------|-----------------|
| [flow] | [action] | [result] |
```

## Independent Review

**Required for code releases.**

- Fresh session, never saw build
- No checklist (unsteered)
- Subject computed from git
- Bounded iterations (escalate after 3-5 rounds)

If unavailable: **Mark Not Verified, block release**

## Output

- Release checklist with evidence
- Go/no-go post for owner
- Verification results
- Tag and release record

## Skill Reference

See `.claude/skills/release-gate.md` for full methodology.
