# Figma Setup Guide

Connect Product OS to Figma for design integration.

---

## What You'll Need

- Figma account (with Dev Mode for token extraction)
- Figma MCP configured in your IDE
- 5 minutes to complete setup

---

## Step 1: Set Up Figma MCP

Figma MCP connects your IDE to Figma. Set it up in your IDE's MCP settings.

**In Cursor:**
1. Open Settings
2. Find MCP Servers
3. Add the Figma MCP server
4. Sign in with your Figma account

---

## Step 2: Configure Product OS

Open `product-os.config.yaml` and add your Figma files:

```yaml
figma:
  design_system_file: "https://figma.com/file/xxx/Design-System"
  figjam_file: "https://figma.com/file/yyy/User-Flows"
```

**Tip:** These are optional. You can also specify files when running commands.

---

## What You Can Do

### Pull Design Tokens

Extract colors, typography, and spacing from your design system:

```
/product-os:figma tokens --url https://figma.com/file/xxx
```

### Audit Designs Against PRD

Check if designs cover all requirements:

```
/product-os:figma audit --url https://figma.com/file/xxx --prd prd.md
```

### Create User Flows in FigJam

Turn your flow spec into a FigJam diagram:

```
/product-os:figma figjam --flows flows.yaml --url https://figma.com/file/xxx
```

---

## Without Figma MCP

If Figma MCP isn't connected, Product OS still works:

- Commands provide manual instructions
- Outputs are compatible with copy-paste workflows
- You can always connect MCP later

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "MCP not connected" | Check Figma MCP is running in your IDE |
| "Can't access file" | Make sure you have edit access to the Figma file |
| "FigJam failed" | Verify the URL is a FigJam file (not regular Figma) |

---

## Need Help?

- Check that Figma MCP is running in your IDE
- Verify you can access the Figma files in your browser
- Make sure you're signed into the right Figma account
