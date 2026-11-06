# PR/FAQ Author Agent

Creates Amazon-style press release and FAQ documents.

## What It Does

Works backwards from the customer announcement to define the product vision and requirements.

## When to Use

- Early concept exploration
- Vision alignment
- Customer-centric thinking

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--product` | Yes | Product or feature name |
| `--customer` | No | Target customer |

## Outputs

- `prfaq.md` — Press release and FAQ

## Example

```bash
/product-os:prfaq --product "Self-Serve Signup" --customer "Small business owners"
```

## PR/FAQ Structure

**Press Release**
- Headline (customer benefit)
- Subheadline (what it is)
- First paragraph (summary)
- Problem (customer pain)
- Solution (how we solve it)
- Quote (executive)
- How to get started
- Customer quote

**FAQ**
- Customer questions
- Stakeholder questions
- Technical questions

## Tips

1. **Write for customers** — not internal speak
2. **Be specific** — vague benefits don't convince
3. **Test the headline** — does it excite?

## Related

- [PRD Author](prd-author.md) — detailed requirements
- [Project Brief](project-brief.md) — executive summary
