# UX Writer

> Runs the UX writing pass on the real designs and writes the UX writing guide: the voice, the words, and the final copy for every screen.

## What It Does

The UX Writer reads the actual screens, writes the final copy for every element, puts that copy into the design, and records it in `ux-writing.md`. The team then builds the copy exactly as it appears in the design.

## When to Use

- In Phase 6 (Review), together with the design critique
- Before the final design goes to the team
- When copy changes after the handoff: update the guide first, then the design

## Paired With the Design Critique

The design critique and the UX writing pass run as a pair.

1. The Design Critic critiques the design and passes its findings on wording to the UX Writer.
2. You decide each Critical and Major finding.
3. The UX Writer runs the pass on the design with your accepted fixes in it.
4. The fixes and the final copy go into the design.

The pair gives you two outputs: the final designs and the UX writing guide.

## What It Needs: the Real Design

`wireframes.md`, `prototype.html` or a prototype URL, a Figma link, or screenshots. Without one, the agent stops and asks you for it.

## It Asks First

1. Do you have anything that shows how the product writes today? Prior designs, screenshots, a voice or style guide.
2. Which words does the product already use for its main things?
3. Who reads this copy?
4. Which languages?
5. How formal?

With prior material, the pass matches it. With none, the pass works from the designs alone and confirms the voice with you before writing.

## Inputs

| Input | Required |
|-------|----------|
| The real design | Yes |
| `prd.md` | Yes |
| `flows.md` | Yes |
| Prior designs, screenshots or a style guide | No |
| `design-critique.md` | If it exists |

## Outputs

| Output | What it is |
|--------|------------|
| `ux-writing.md` | The UX writing guide: voice and tone, words we use, patterns, the final copy by screen, open items |
| The design, with the copy in it | `wireframes.md` and both prototypes updated; for Figma, a list of changes by screen and element |

## Example

```
/product-os:ux-writing --designs prototype.html --prd prd.md --prior screenshots/ --critique design-critique.md
```

See the worked example: [`examples/acme-dashboard/design/ux-writing.md`](../../../examples/acme-dashboard/design/ux-writing.md).

## What the Team Gets

1. The epic's Handoff table links to the UX writing guide.
2. Every ticket with a screen says: "Copy: use the copy in the design as is. It has been through the UX writing pass."
3. Backend-only tickets have no Copy line.

## Tips

1. Give it screenshots of the product as it is today. Three or four are enough to match the voice.
2. Decide the critique's findings before the pass, so copy is written once.
3. A screen is marked applied only after its copy is in the design.

## Related

- [Design Critic](design-critic.md)
- [UX Reviewer](ux-reviewer.md)
- [Delivery Agent](delivery-agent.md)
- Skill: [`.claude/skills/ux-writing.md`](../../../.claude/skills/ux-writing.md)
