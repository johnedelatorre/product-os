# Figma MCP Setup Guide

Configure Figma MCP integration for Product OS.

---

## Overview

Figma MCP enables Product OS to:
- Pull design tokens and frame data
- Audit Figma designs against PRD requirements
- Generate FigJam user flow diagrams
- Push wireframes and design system starters

---

## Prerequisites

- Figma account with Dev Mode access
- Figma MCP server installed and configured in your IDE
- Files you want to access (own or have edit access)

---

## 1. Install Figma MCP

Follow the official Figma MCP documentation for your IDE:

**For Cursor:**
1. Open Settings > MCP Servers
2. Add Figma MCP server
3. Authenticate with your Figma account

**Configuration location:**
```json
// .cursor/mcp.json or similar
{
  "mcpServers": {
    "Figma": {
      "command": "figma-mcp",
      "args": []
    }
  }
}
```

---

## 2. Configure Product OS

Edit `product-os.config.yaml`:

```yaml
figma:
  # Default design system file (for token extraction)
  design_system_file: "https://figma.com/file/xxx/Design-System"
  
  # Default FigJam file for user flows
  figjam_file: "https://figma.com/file/yyy/User-Flows"

integrations:
  figma_mcp: "Figma"  # MCP server name
```

---

## 3. Available Operations

### Pull Design Tokens

```bash
/product-os:figma tokens --url https://figma.com/file/xxx
```

Extracts:
- Color variables (with modes)
- Typography styles
- Spacing values
- Effect styles

Output: `design-tokens.yaml`

### Audit Against PRD

```bash
/product-os:figma audit --url https://figma.com/file/xxx --prd prd.md
```

Checks:
- Requirement coverage (which PRD items have designs)
- Design system compliance
- Accessibility basics (contrast, labels)

Output: `figma-audit.md`

### Generate FigJam Flows

```bash
/product-os:figma figjam --flows flows.yaml --url https://figma.com/file/xxx
```

Creates:
- Connector-based flow diagrams
- Sticky notes for annotations
- Color-coded states
- Sections for each flow

### Push Wireframes

```bash
/product-os:figma push --wireframes wireframes.md --url https://figma.com/file/xxx
```

Creates:
- Basic Figma frames with auto-layout
- Placeholder components
- Annotation layer

---

## 4. Graceful Fallback

When Figma MCP is not connected, Product OS:

1. Detects MCP is unavailable
2. Provides manual instructions
3. Generates offline-compatible formats

Example fallback output:

```markdown
## Manual Token Extraction

Figma MCP is not connected. To extract tokens manually:

1. Open Figma file: [URL]
2. Go to Local Variables
3. Export variables as JSON
4. Place in `design-tokens.json`
```

---

## 5. Skills Integration

The following skills are available for Figma operations:

| Skill | Path | Purpose |
|-------|------|---------|
| figma-design-to-code | `figma-design-to-code/SKILL.md` | Implement Figma designs |
| figma-use | `figma-use/SKILL.md` | General Figma MCP usage |
| figma-generate-diagram | `figma-generate-diagram/SKILL.md` | Generate diagrams |
| figma-code-connect | `figma-code-connect/SKILL.md` | Code Connect templates |

---

## 6. Troubleshooting

### MCP not detected
- Verify Figma MCP is running
- Check MCP server configuration
- Restart IDE

### Authentication failed
- Re-authenticate in Figma MCP settings
- Check Figma account permissions

### Can't access file
- Verify you have edit access to the file
- Check if file is in a team you have access to

### FigJam write failed
- Verify the URL is a FigJam file (not regular Figma)
- Check FigJam-specific permissions
