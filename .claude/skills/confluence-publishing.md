# Skill: Confluence Publishing

Publish project artifacts to Confluence with proper hierarchy.

## When to Use

- After artifacts are approved
- Before Jira sync (to get Confluence links)
- Sharing documentation with stakeholders
- Archiving project documentation

## Ground Rules

1. **Approval first** — Show the publish plan (each page: create or update, location, change summary). Write nothing until the human explicitly approves.
2. **Atlassian MCP preferred** — Use the connected MCP tools (no credentials needed). The REST fallback script (with `.env`) is only for when no MCP server is connected.
3. **Search before create** — Find pages by `publish-manifest.json` IDs, then by title/CQL search; update in place.
4. **Check the instance** — Confirm space, parent page, and available macros before publishing.
5. **Record IDs** in `publish-manifest.json`.

## Quick Start

```
/product-os:publish --project initiatives/onboarding/signup/
```

## Confluence Hierarchy

```
Product Space (PROD)
└── Initiatives
    └── [Initiative Name]
        └── [Project Name]
            ├── Project Brief
            ├── PRD
            ├── Project Plan
            ├── RACI
            ├── Gantt Chart
            ├── Design Brief
            ├── User Flows
            ├── Wireframes
            ├── Design Critique
            ├── UX Review
            ├── Accessibility Audit
            ├── Backlog  ← Special page with tables
            └── Decision Log
```

## Backlog Page Structure

The Backlog page summarizes all epics and stories:

```markdown
## Summary
| Metric | Value |
|--------|-------|
| Total Epics | 3 |
| Total Stories | 18 |
| Total Story Points | 73 |

## Story Points by Discipline
| Discipline | Points | % |
|------------|--------|---|
| Frontend | 31 | 42% |
| Backend | 26 | 36% |
| Fullstack | 16 | 22% |

## Epics
| Epic | Stories | Points | FE | BE | FS | Jira |
|------|---------|--------|-----|-----|-----|------|
| Auth | 5 | 21 | 8 | 8 | 5 | [PROJ-101] |

## Stories
| Story | Epic | Points | Discipline | Jira |
|-------|------|--------|------------|------|
| Login form | Auth | 3 | frontend | [PROJ-111] |
```

## Configuration

In `product-os.config.yaml`:

```yaml
confluence:
  base_url: "https://company.atlassian.net/wiki"
  space_key: "PROD"
  initiatives_parent_page_id: "123456789"
```

In `.env` (REST fallback only; not needed with the Atlassian MCP server):

```
ATLASSIAN_EMAIL=your@email.com
ATLASSIAN_API_TOKEN=your-token
```

## Finding Parent Page ID

1. Navigate to the Initiatives page in Confluence
2. Click ⋯ menu → Page Information
3. Copy the Page ID from URL or page

## Idempotent Publishing

Re-running publish updates existing pages:

1. Checks for existing page by manifest page ID, then by title
2. If exists: Updates content, preserves ID
3. If new: Creates page
4. Records in `publish-manifest.json`

## Manifest Output

```json
{
  "project": "initiatives/onboarding/signup",
  "published_at": "2026-11-06T15:30:00Z",
  "pages": {
    "project-brief": {
      "page_id": "123456",
      "title": "Signup - Project Brief",
      "url": "https://company.atlassian.net/wiki/spaces/PROD/pages/123456"
    },
    "prd": {
      "page_id": "123457",
      "title": "Signup - PRD",
      "url": "..."
    }
  }
}
```

## Markdown to Confluence

| Markdown | Confluence |
|----------|------------|
| `# Heading` | `<h1>` |
| `**bold**` | `<strong>` |
| `[link](url)` | `<a href="url">` |
| Mermaid code blocks | Mermaid macro (or image) |
| Tables | HTML tables |

## Fallback Script

If MCP not available:

```bash
python scripts/atlassian-fallback.py publish \
  --config product-os.config.yaml \
  --project initiatives/onboarding/signup/
```

## Quality Checklist

- [ ] All artifacts in project folder
- [ ] Config has correct space key
- [ ] Atlassian MCP connected (or credentials in .env for the REST fallback)
- [ ] Human approved the publish plan
- [ ] Hierarchy will be correct
- [ ] Backlog page has discipline columns

## Tips

1. **Publish before Jira sync** — Confluence links go in Jira
2. **Review hierarchy first** — harder to move pages later
3. **Use labels** — product-os, initiative-slug, project-slug
4. **Check Mermaid** — ensure macro is available or falls back to image

## Related

- `/product-os:publish` — Publish to Confluence
- `/product-os:jira-sync` — Create Jira issues after publishing
- `.claude/agents/confluence-publisher.md` — Full agent specification
