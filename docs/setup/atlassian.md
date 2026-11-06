# Atlassian Setup Guide

Connect Product OS to your Confluence and Jira.

---

## What You'll Need

- Atlassian Cloud account with Confluence and Jira
- Permission to create pages and issues
- 10 minutes to complete setup

---

## Step 1: Create API Token

1. Go to [Atlassian API Tokens](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click **Create API token**
3. Name it "Product OS"
4. Copy the token (save it somewhere safe - you won't see it again)

---

## Step 2: Save Your Credentials

1. Copy `.env.example` to `.env`
2. Open `.env` in any text editor
3. Fill in your details:

```
ATLASSIAN_EMAIL=your@email.com
ATLASSIAN_API_TOKEN=paste-your-token-here
```

**Important:** Never share your `.env` file or commit it to git.

---

## Step 3: Configure Confluence

Open `product-os.config.yaml` and update the Confluence section:

```yaml
confluence:
  base_url: "https://yourcompany.atlassian.net/wiki"
  space_key: "PROD"
  initiatives_parent_page_id: "123456789"
```

### How to find each value:

| Setting | Where to Find It |
|---------|------------------|
| `base_url` | Your Atlassian URL + `/wiki` |
| `space_key` | In any space URL: `/spaces/PROD/...` |
| `initiatives_parent_page_id` | See below |

### Finding the Parent Page ID

1. Go to the Confluence page where you want initiatives to live
2. Click the **⋯** menu (top right)
3. Click **Page Information**
4. The Page ID is shown on that page or in the URL

---

## Step 4: Configure Jira

Update the Jira section in `product-os.config.yaml`:

```yaml
jira:
  base_url: "https://yourcompany.atlassian.net"
  project_key: "PROJ"
```

### How to find your project key:

Look at any issue in your project. The key is the prefix before the number (e.g., **PROJ**-123).

---

## Step 5: Set Up Custom Fields (Optional)

Jira uses custom fields for story points, epic links, etc. The defaults usually work, but if you need to find your specific field IDs:

1. Go to **Jira Settings** > **Issues** > **Custom Fields**
2. Click on a field name
3. The ID is in the URL (the number after `customFieldId=`)

Update `product-os.config.yaml` with your field IDs:

```yaml
jira:
  custom_fields:
    story_points: "customfield_10016"
    epic_link: "customfield_10014"
```

**Tip:** Start with the defaults. Only change these if stories aren't getting points or epic links.

---

## Step 6: Choose Discipline Labels

Decide how to track frontend/backend work:

**Option A: Labels (Default)**
```yaml
jira:
  discipline_mapping: "labels"
```
Adds `frontend` or `backend` as issue labels.

**Option B: Components**
```yaml
jira:
  discipline_mapping: "components"
  components:
    frontend: "Frontend"
    backend: "Backend"
```
Uses Jira components (must exist in your project first).

---

## You're Done!

Test your setup by running:

```
/product-os:new-project --initiative test --project test-setup
```

If everything works, you'll see the orchestrator start the pipeline.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "401 Unauthorized" | Check your email and API token in `.env` |
| "403 Forbidden" | Check you have edit access to the space/project |
| Stories don't get points | Update `story_points` field ID |
| Stories don't link to epics | Update `epic_link` field ID |

---

## Need Help?

If you're stuck, check:
- Your `.env` file has the right email and token
- Your `product-os.config.yaml` has the right URLs
- You have edit permissions in Confluence and Jira
