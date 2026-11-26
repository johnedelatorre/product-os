# UX Writing Skill

> **TL;DR:** Every project with a user interface gets a UX writing pass on the real designs, paired with the design critique. The pass starts from how the product already writes (prior designs, screenshots, documents) when the PM has them, and from the designs alone when they do not. Together the critique and the pass produce two outputs: the final designs, and the UX writing guide (`ux-writing.md`) with the voice, the words the product uses, the patterns and the final copy for every screen. The epic links to the guide, and every ticket with a screen says: use the copy in the design as is.

## When to Use

- In Phase 6 (Review), together with the design critique
- Before the final design is handed to the team
- When copy changes after the handoff: update the guide first, then the design

## Paired With the Design Critique

The design critique and the UX writing pass run as a pair. A design critique is never run without the pass.

| Step | Who | What |
|------|-----|------|
| 1 | Design Critic | Critiques the real design: layout, hierarchy, consistency, fit with the PRD. Findings about wording are passed to the UX Writer. |
| 2 | PM | Decides each Critical and Major finding: fix now, or accept with a reason |
| 3 | UX Writer | Runs the UX writing pass on the design with those fixes in it |
| 4 | Both | The fixes and the final copy are put into the design |

**The pair has two outputs: the final designs and the UX writing guide.** When the PM did not ask for a design critique, the pass still runs on its own.

## Intake: How the Product Already Writes

Before the pass, ask the PM for what shows the product's existing writing. Take it in one step, as in start question 6 of `.claude/skills/engineering-handoff.md`:

| Source | What the pass takes from it |
|--------|-----------------------------|
| Prior designs or screenshots of the product | The words it already uses, its button and error wording, its tone |
| A voice, brand or content style guide | The rules to follow |
| Existing PRDs, help articles or release notes | Names of features and things, and how users are addressed |
| A previous UX writing guide for this product | The terms table and patterns, reused as they are |

1. **With prior material:** read it first, list the words and patterns it shows, and write the new copy to match. Where the new design breaks an existing pattern, say so and ask which wins.
2. **With no prior material:** run the pass on the designs as they are. Take the voice and the terms from the designs themselves, propose them to the PM, and confirm before writing.
3. **Save what was given** as sources of kind `design` or `product` under `context.sources` in `progress.yaml`, so no later pass asks again.

## What the Pass Produces

| Output | Where it goes |
|--------|---------------|
| **UX writing guide** (`ux-writing.md`) | Linked from the epic's Handoff table and the links page |
| **The final copy, in the design** | The final design (Figma or the Claude design) and both prototypes carry the copy from the guide |
| **One line in every ticket with a screen** | "Copy: use the copy in the design as is. It has been through the UX writing pass." With a link to the guide |

## Ground Rules

1. **The real design only.** The pass reads the actual screens: `wireframes.md`, `prototype.html`, a Figma file or screenshots. No design, no pass: stop and ask the PM for one.
2. **Every line of copy cites its screen.** Screen ID (`SCR-###`) and element.
3. **Never invent a product fact.** A number, a limit, a price or a rule comes from the PRD or a source. A gap is a named TBD: what is missing and who provides it.
4. **The guide holds the final copy only.** One approved wording per element.
5. **The ticket line is true or it is not written.** A ticket says the copy has been through the pass only when its screens are marked applied in the guide.

## The Questions to Ask First

Follow `.claude/skills/guided-questions.md`. Ask what the sources do not answer:

1. **Do you have anything that shows how the product writes today?** Prior designs, screenshots, a voice or style guide, earlier documents. "I don't have that" is a valid answer: the pass then works from the designs alone.
2. **Which words does the product already use for its main things?** For example "workspace" or "account", "member" or "user". Skip this when the prior material answers it.
3. **Who reads this copy?** Their role, how often they use the product, and their reading level.
4. **Which languages?** Whether the copy will be translated, and which language is the source.
5. **How formal?** Offer two or three sample lines in different tones and let the PM pick.

## Writing Rules

| Rule | What it means |
|------|---------------|
| **Clear** | Plain words the user already uses. No internal names, no jargon, no idioms. |
| **Short** | The fewest words that still say it. One idea per sentence. |
| **Useful** | Each line helps the user do the next thing. Remove lines that only decorate. |
| **Consistent** | One word per thing, everywhere. An action keeps its name through the whole flow. |
| **Sentence case** | Headings, buttons and labels. Capitals only for the first word and proper names. |

## Patterns

| Element | Rule | Example |
|---------|------|---------|
| **Button** | Verb plus object. Says what happens. | "Save changes", not "Submit" |
| **Confirmation** | Uses the button's own verb, past tense | "Changes saved" |
| **Error** | What happened, then how to fix it. No blame, no apology. | "That email is already in use. Sign in, or use another email." |
| **Empty state** | What this place is for, then the first action | "No reports yet. Create your first report." |
| **Loading** | Say what is loading when it takes more than a moment | "Loading 30 days of data" |
| **Label and help text** | Label names the field. Help text says the rule before the user breaks it. | "Password" · "At least 12 characters" |
| **Destructive action** | Name the thing and the consequence. The button repeats the action. | "Delete 3 reports? This cannot be undone." · "Delete reports" |
| **Link** | Says where it goes. Never "click here". | "View billing history" |

Accessibility: every image that carries meaning has alt text, every icon-only button has a name, and no instruction depends on colour or position alone ("the red button", "on the right").

## The Pass, Step by Step

1. **Read** the prior material the PM gave, the PRD, the design brief, the design critique's findings on wording, and every screen.
2. **Ask** the questions above.
3. **List the words**: one row per main thing in the product, with the word to use and the words to avoid.
4. **Go screen by screen.** For each element with text: title, labels, help text, buttons, messages and states. Write the final copy.
5. **Check each line** against the rules and patterns above.
6. **Show the PM** the copy for each screen and get it approved.
7. **Put the copy into the design.** Update `wireframes.md`, `prototype.html` and `prototype-handoff.html`. For Figma, the Figma Agent applies the copy, or the designer does from the guide. Mark each screen applied, with the date.
8. **Write the guide** from the template `templates/design/ux-writing-guide.md`.

## The Guide's Sections

1. **What was reviewed**: the designs, the screens covered and the version, and the prior material the voice was taken from.
2. **Voice and tone**: three to five rules, each with one example.
3. **Words we use**: the terms table.
4. **Patterns**: the rules this product follows for buttons, errors, empty states and the rest.
5. **Copy by screen**: one table per screen with the final copy for every element, and whether it is applied in the design.
6. **Open items**: copy that is undecided, as named TBDs.

## Where It Shows Up in the Handoff

1. **The epic's Handoff table** has a row: "UX writing guide: the copy for every screen. The designs already use it."
2. **Every ticket with a screen** carries the Copy line under Design.
3. **Backend-only tickets** have no Copy line.
4. **A screen that is not applied yet** is a named TBD in its ticket, not the Copy line.

## Quality Checklist

- [ ] The pass ran together with the design critique when there was one, on the design with the accepted fixes in it
- [ ] The PM was asked for prior designs, screenshots or guides; the guide says what the voice was taken from
- [ ] The pass ran on the real design, and the guide says which screens and which version
- [ ] The questions were asked, and no voice, term or fact was invented
- [ ] Every screen in the handoff prototype has its copy in the guide
- [ ] One word per thing; an action keeps its name through the flow
- [ ] Buttons say what happens; errors say what happened and how to fix it
- [ ] The PM approved the copy
- [ ] The final design and both prototypes carry the copy, and each screen is marked applied
- [ ] The epic links to the guide, and every ticket with a screen has the Copy line
