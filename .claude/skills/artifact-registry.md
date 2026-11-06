# Skill: Artifact Registry

Maintain a centralized manifest of all design and product artifacts.

## When to Use

- Starting a new project
- Adding design deliverables
- Checking for broken links
- Syncing to Confluence

## Quick Start

```
/product-os:artifacts --project initiatives/onboarding/signup --action validate
```

## Artifact Types

| Type | Examples |
|------|----------|
| `figma-design` | Figma design files |
| `figma-prototype` | Figma prototypes |
| `figjam` | FigJam boards |
| `loom` | Video recordings |
| `claude-artifact` | Claude-generated HTML/React |
| `miro` | Miro boards |
| `prototype` | HTML/React prototypes |
| `research` | Research documents |
| `external` | External resources |

## Manifest Structure

```yaml
artifacts:
  - id: figma-main
    name: "Signup Flow Designs"
    type: figma-design
    url: "https://figma.com/file/xxx"
    owner: "@designer"
    status: in-progress
    last_verified: 2026-11-06
    jira_tickets:
      - PROJ-101
```

## Status Values

| Status | When to Use |
|--------|-------------|
| `draft` | Work in progress |
| `in-progress` | Actively being worked on |
| `review` | Ready for feedback |
| `approved` | Ready for use |
| `current` | Active version |
| `superseded` | Replaced by newer version |
| `archived` | No longer in use |

## Auto-Registration

Agents automatically register artifacts they create:
- Flow Designer → FigJam boards
- Prototyper → HTML prototypes
- Figma Agent → Figma files

## Link Validation

Run weekly to catch broken/stale links:

```
/product-os:artifacts --project <path> --action validate
```

Links not verified in 30+ days are flagged as stale.

## Confluence Sync

Creates "Design Links" section on project page:

| Name | Type | Status | Owner | Link |
|------|------|--------|-------|------|
| Signup Flow | Figma | In Progress | @designer | [Open](...) |

## Related

- `/product-os:artifacts` — Run validation
- `.claude/agents/artifact-registry.md` — Full agent spec
