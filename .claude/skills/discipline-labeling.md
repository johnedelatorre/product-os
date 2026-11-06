# Skill: Discipline Labeling

Assign frontend/backend/fullstack labels to stories with rationale.

## When to Use

- Creating stories from PRD and designs
- Planning team allocation
- Tracking work distribution
- Sprint capacity planning by skill

## Quick Start

```
/product-os:deliver --from prd.md --designs wireframes.md
```

## Discipline Definitions

| Label | Criteria | Examples |
|-------|----------|----------|
| `frontend` | UI implementation, client-side logic, no API changes | Form validation, styling, animations, routing |
| `backend` | API, database, server logic, no UI changes | New endpoint, data migration, business logic |
| `fullstack` | Requires BOTH frontend AND backend work | New feature end-to-end, API + UI integration |

## Assignment Rules

### Frontend (`frontend`)
Assign when the story:
- Only touches UI code
- Uses existing APIs as-is
- Involves styling, layout, or client-side behavior
- Requires no database changes

**Example:**
```markdown
**Story:** Add loading skeleton to dashboard
**Label:** `frontend`
**Rationale:** Pure UI enhancement. Existing API already returns data; 
this adds visual feedback during loading. No backend changes needed.
```

### Backend (`backend`)
Assign when the story:
- Only touches server-side code
- Creates or modifies APIs
- Involves database changes
- Has no UI component

**Example:**
```markdown
**Story:** Add pagination to /api/projects endpoint
**Label:** `backend`
**Rationale:** API-only change. Adds offset/limit parameters and 
total count to response. Frontend pagination is a separate story.
```

### Fullstack (`fullstack`)
Assign when the story:
- Requires new API AND new UI
- Cannot be meaningfully split
- Has tightly coupled frontend/backend logic

**Example:**
```markdown
**Story:** User can upload profile photo
**Label:** `fullstack`
**Rationale:** Requires new upload API endpoint with S3 integration 
AND new frontend upload component with progress indicator. 
Tightly coupled; should be done together.
```

## When to Split vs Fullstack

**Split into separate stories when:**
- Backend can be built and tested independently
- Frontend can work with mocked data
- Different team members will work on each
- Clear API contract exists

**Keep as fullstack when:**
- Iterating on both sides together
- One developer doing both
- API contract will evolve during development
- Small enough for one sprint

## Point Totals by Discipline

Track in your backlog summary:

```markdown
## Story Points by Discipline

| Discipline | Stories | Points | % of Total |
|------------|---------|--------|------------|
| Frontend | 8 | 21 | 35% |
| Backend | 6 | 24 | 40% |
| Fullstack | 4 | 15 | 25% |
| **Total** | **18** | **60** | **100%** |
```

This helps with:
- Sprint planning (match to team skills)
- Hiring decisions (see bottlenecks)
- Resource allocation

## Jira/Confluence Integration

**Jira Labels:** Applied automatically by `/product-os:jira-sync`
- `frontend` label
- `backend` label
- Fullstack gets BOTH labels

**Confluence Backlog Table:** Shows discipline column with subtotals

**Component Mapping (optional):**
```yaml
# In product-os.config.yaml
jira:
  discipline_mapping: "components"
  components:
    frontend: "Frontend"
    backend: "Backend"
```

## Quality Checklist

- [ ] Every story has a discipline label
- [ ] Rationale documented for each
- [ ] Fullstack used sparingly
- [ ] Point totals calculated
- [ ] Team capacity matches distribution

## Tips

1. **Default to splitting** — separate FE/BE stories enable parallel work
2. **Use fullstack for spikes** — when exploring, keep together
3. **Review distribution** — 80% one discipline = bottleneck risk
4. **Match to team** — if you have 2 FE and 1 BE, plan accordingly
5. **Update when scope changes** — label may change as story evolves

## Related

- `/product-os:deliver` — Generate stories with labels
- `story-pointing.md` — Estimate story points
- `.claude/agents/delivery-agent.md` — Full agent specification
