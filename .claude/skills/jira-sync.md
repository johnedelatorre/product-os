# Skill: Jira Sync

Create and sync epics/stories to Jira with dates and dependencies.

## When to Use

- After Confluence publishing (to link docs)
- Before sprint planning
- Keeping Jira in sync with Product OS artifacts

## Quick Start

```
/product-os:jira-sync --project initiatives/onboarding/signup/
```

## Ground Rules

1. **Approval first** — Show the proposed creates, updates, and links; write nothing until the human explicitly approves.
2. **Atlassian MCP preferred** — Use the connected MCP tools (no credentials needed). The REST fallback script (with `.env`) is only for when no MCP server is connected.
3. **Search before create** — Match existing issues (manifest keys, then labels/summary) and update in place.
4. **Read field IDs from the instance** — Don't assume default custom field IDs.
5. **Team-managed (next-gen) projects** link stories to epics via the `parent` field (no Epic Link field), and story points are often "Story point estimate". Company-managed projects may use an Epic Link custom field and "Story Points".
6. **Record IDs** in `jira-sync-manifest.json`.

## What Gets Created

### Epics
- Summary: `[Project] Epic: [Title]`
- Description: Goal + Confluence links
- Labels: `product-os`, initiative, project
- Start/Due dates from Gantt

### Stories
- Summary: Story title
- Description: User story + acceptance criteria
- Parent epic (`parent` field in team-managed projects; Epic Link where the instance uses it)
- Story points ("Story point estimate" or "Story Points", per project type)
- Discipline labels (`frontend`, `backend`, or both)
- Start/Due dates from Gantt
- Dependencies as issue links

## Discipline Labels

| Source | Jira |
|--------|------|
| `frontend` | `frontend` label |
| `backend` | `backend` label |
| `fullstack` | Both `frontend` and `backend` labels |

**Optional: Map to components instead:**

```yaml
# product-os.config.yaml
jira:
  discipline_mapping: "components"
  components:
    frontend: "Frontend"
    backend: "Backend"
```

## Gantt Integration

Dates from `gantt.md` populate Jira fields:

| Gantt | Jira |
|-------|------|
| Task start | Start Date |
| Task end | Due Date |
| Dependency | Issue Link (blocks) |

This enables **Jira Plans/Timeline** to show:
- Timeline bars for each issue
- Dependency arrows
- Critical path highlighting

## Configuration

```yaml
# product-os.config.yaml
jira:
  base_url: "https://company.atlassian.net"
  project_key: "PROJ"
  
  # EXAMPLE IDs only: read the real ones from your instance
  custom_fields:
    story_points: "customfield_10016"
    epic_link: "customfield_10014"   # not used in team-managed projects (use parent)
    start_date: "customfield_10015"
```

**Finding custom field IDs:** with MCP, use the issue-type field-metadata tool for your project. With the REST fallback:

```bash
curl -u email:token \
  "https://company.atlassian.net/rest/api/3/field" \
  | jq '.[] | select(.name | test("Story point"; "i"))'
```

## Idempotent Sync

Re-running updates existing issues:

1. Matches by label + summary (or custom `product-os-id` field)
2. Updates changed fields
3. Never creates duplicates
4. Records in `jira-sync-manifest.json`

## Manifest Output

```json
{
  "project": "initiatives/onboarding/signup",
  "synced_at": "2026-11-06T16:00:00Z",
  "epics": {
    "EPIC-001": {
      "jira_key": "PROJ-101",
      "url": "https://company.atlassian.net/browse/PROJ-101"
    }
  },
  "stories": {
    "STORY-001": {
      "jira_key": "PROJ-111",
      "epic_key": "PROJ-101",
      "story_points": 3,
      "discipline": "frontend"
    }
  }
}
```

## Dependency Links

Dependencies create issue links:

```
STORY-002 is blocked by STORY-001
STORY-001 blocks STORY-002
```

In Jira Plans, these show as connecting arrows.

## Post-Sync

After successful sync:

1. Update Confluence backlog with Jira links (after separate approval)
2. Verify Jira Plans timeline
3. Issues ready for sprint planning

## Fallback Script

If MCP not available:

```bash
python scripts/atlassian-fallback.py jira-sync \
  --config product-os.config.yaml \
  --project initiatives/onboarding/signup/
```

## Quality Checklist

- [ ] All epics and stories defined
- [ ] Story points assigned
- [ ] Discipline labels assigned
- [ ] Gantt dates available
- [ ] Dependencies mapped
- [ ] Confluence manifest available
- [ ] Field IDs confirmed against the instance
- [ ] Human approved the proposed change set

## Troubleshooting

| Issue | Cause | Fix |
|-------|-------|-----|
| Epic link fails | Team-managed project or wrong field ID | Use `parent`; otherwise read the Epic Link field ID from the instance |
| Points empty | Wrong field ("Story Points" vs "Story point estimate") | Read the field ID from field metadata |
| Dates not in Timeline | Field not enabled | Enable in project settings |

## Related

- `/product-os:jira-sync` — Run sync
- `/product-os:publish` — Publish to Confluence first
- `.claude/agents/jira-sync.md` — Full agent specification
