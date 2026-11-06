# Atlassian Setup Guide

Configure Confluence and Jira integration for Product OS.

---

## Prerequisites

- Atlassian Cloud account (Confluence and Jira)
- Admin or project admin access
- API token for authentication

---

## 1. Generate API Token

1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click **Create API token**
3. Give it a label like "Product OS"
4. Copy the token (you won't see it again)

---

## 2. Configure Environment

Create `.env` from template:

```bash
cp .env.example .env
```

Edit `.env`:

```bash
ATLASSIAN_EMAIL=your@email.com
ATLASSIAN_API_TOKEN=your-api-token-here
```

---

## 3. Configure Confluence

Edit `product-os.config.yaml`:

```yaml
confluence:
  # Your Atlassian instance
  base_url: "https://yourcompany.atlassian.net/wiki"
  
  # Space key (visible in space URL: /spaces/PROD/...)
  space_key: "PROD"
  
  # Parent page ID for Initiatives
  # Find via: Page > ⋯ > Page Information > Page ID
  initiatives_parent_page_id: "123456789"
```

### Finding the Parent Page ID

1. Navigate to the page that will contain all initiatives
2. Click the **⋯** menu
3. Click **Page Information**
4. The Page ID is in the URL or visible on the page

---

## 4. Configure Jira

Edit `product-os.config.yaml`:

```yaml
jira:
  base_url: "https://yourcompany.atlassian.net"
  project_key: "PROJ"  # Your Jira project key
  
  issue_types:
    epic: "Epic"
    story: "Story"  # or "Task" if your project uses Tasks
  
  custom_fields:
    story_points: "customfield_10016"
    epic_link: "customfield_10014"
    epic_name: "customfield_10011"
    start_date: "customfield_10015"
```

### Finding Custom Field IDs

**Method 1: Jira Admin**
1. Go to Jira Settings > Issues > Custom Fields
2. Click on a field
3. The ID is in the URL: `/secure/admin/ConfigureCustomField!default.jspa?customFieldId=10016`

**Method 2: REST API**
```bash
curl -u your@email.com:api-token \
  "https://yourcompany.atlassian.net/rest/api/3/field" \
  | jq '.[] | select(.name | contains("Story Points"))'
```

### Common Custom Field IDs

| Field | Common ID | Notes |
|-------|-----------|-------|
| Story Points | customfield_10016 | Varies by instance |
| Epic Link | customfield_10014 | Links story to epic |
| Epic Name | customfield_10011 | Epic summary field |
| Start Date | customfield_10015 | Or use built-in |

---

## 5. Discipline Labels

Configure how discipline labels are applied:

```yaml
jira:
  # "labels" (default) or "components"
  discipline_mapping: "labels"
  
  # If using components:
  components:
    frontend: "Frontend"
    backend: "Backend"
```

**Labels mode:** Adds `frontend`, `backend` as Jira labels
**Components mode:** Adds as Jira components (must exist in project)

---

## 6. Using Atlassian MCP (Recommended)

If you have the Atlassian MCP server configured in your IDE:

1. Product OS will automatically detect it
2. No additional setup needed
3. Falls back to REST API if MCP unavailable

---

## 7. Using REST API Fallback

If MCP is not available, use the fallback script:

```bash
# Publish to Confluence
python scripts/atlassian-fallback.py publish \
  --config product-os.config.yaml \
  --project initiatives/my-initiative/my-project/

# Sync to Jira
python scripts/atlassian-fallback.py jira-sync \
  --config product-os.config.yaml \
  --project initiatives/my-initiative/my-project/
```

### Requirements

```bash
pip install requests pyyaml python-dotenv
```

---

## 8. Verify Setup

Test your configuration:

```bash
# Test Confluence access
curl -u your@email.com:api-token \
  "https://yourcompany.atlassian.net/wiki/rest/api/space/PROD"

# Test Jira access
curl -u your@email.com:api-token \
  "https://yourcompany.atlassian.net/rest/api/3/project/PROJ"
```

---

## Troubleshooting

### 401 Unauthorized
- Check email and API token in `.env`
- Regenerate API token if needed

### 403 Forbidden
- Check space/project permissions
- Ensure you have edit access

### Custom field not found
- Verify field ID via REST API
- Field may have different ID per project

### Epic link not working
- Some Jira versions use different epic link mechanisms
- Check if your project uses next-gen or classic
