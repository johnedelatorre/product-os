# Guided Questions Skill (Always On)

> **TL;DR:** Every agent asks before it writes, and keeps asking until its document is finished. One question at a time, with short options and a recommended answer. An agent never fills a decision with its own assumption, and the PM never has to say "ask me guided questions". This applies to every document in every phase: intake, PRD, briefs, flows, wireframes, the design critique, the UX writing guide, the reviews, the epic and its tickets, and launch.

## When to Use

- Every agent, for every document it writes
- At the start of a document, in the middle of it, and before it is called finished
- Together with the start questions and the outputs question in `.claude/skills/engineering-handoff.md`, which cover the start of a project and the handoff

## The Rule

1. **Before writing.** Read the sources. List the decisions this document needs that the sources do not answer. Ask them, most important first.
2. **While writing.** On reaching a decision only the PM can make, stop and ask. Do not write past it.
3. **Before finishing.** Show what was decided and what is open, and ask the PM to confirm or change it.
4. **Until it is finished.** A document is finished when no decision in it was made by the agent alone.

## How to Ask

1. **One question at a time.** Open each with its place: "Question 2 of 4".
2. **Say how many first.** "I have 3 questions before I write the PRD."
3. **Short numbered options, the recommended one marked**, with one line on why. The PM can answer with a number, "recommended", or their own words.
4. **Ask only what changes the document.** If both answers lead to the same text, do not ask.
5. **Never ask twice.** An answer in `progress.yaml`, in a source the PM gave, or in an approved document is used, not asked again.
6. **Ask, do not demand.** Word each question as an invitation: "What do you already have?", not "Give me everything you have."

## The Agent Asks, the PM Answers

Product OS is a conversation with an agent. On every interface the question comes from the agent, in the conversation.

1. **A question is never a page title or a document heading.** The title says where the PM is: the project, the phase, the task.
2. **Every question comes with quick replies.** In Claude they are choices to tap. In Claude Code and ChatGPT they are numbered options. The PM can always type their own answer.
3. **Offer real options for this project**, taken from the sources and earlier answers. Add "I don't know yet" to every question.
4. **After each answer, say one line on what was understood**, then ask the next question.
5. **Open each turn with where the PM is** and the task counts, from the status board (`.claude/skills/guided-workflow.md` → "The Status Board").
6. **The board and the setup are one reply away**, on a phone too: `board`, `task <n>`, `docs`, `connectors`, `settings` (same file → "On a Phone", "Connectors and Settings").

## What to Ask

| Ask | Do not ask |
|-----|------------|
| A trade-off: speed or scope, breadth or depth | A fact a source already states |
| What is in and what is out | A choice with a clear default: state the default and continue |
| A target number, a date, an owner | Formatting, wording and layout the templates already set |
| Which of two or three real options | Permission to do the next obvious step |
| Which findings to fix and which to accept | The same question a second time |

## How Many

1. **At most 5 questions before a document is written.** Ask the 5 that change the most.
2. **A second round after the first draft** covers what the draft exposed. At most 5 again.
3. **What is still undecided is a named TBD**: what is missing and who provides it. It is tracked as an open item and never blocks.
4. **"I don't know yet" is always a valid answer.** Record it as a named TBD and continue.

## Questions by Document

Examples of the decisions each document needs. Ask the ones the sources do not answer.

| Document | Ask |
|----------|-----|
| **Intake** | Which problem matters most to the requester? · What evidence is strongest? · Who else has a say? |
| **PRD** | What is out of scope? · Which metric decides success, and what is the target? · When do we stop? |
| **Project brief** | Who reads it, and what do they decide after reading? · Which risk do they need to know first? |
| **Design brief** | Where will the designs be made: Claude Design, Figma, or both? · Web, mobile or both? · Which principle wins when two conflict? (The design system and existing designs are already saved from start question 4.) |
| **User flows and wireframes** | Which user journey comes first? · Which edge cases and error states must be shown? |
| **Design critique** | Which design is being critiqued: Figma, the prototype or screenshots? · What matters most here: brand, clarity, density or speed of use? · For each Critical and Major finding: fix it now, or accept it with a reason? |
| **UX writing guide** | Is there a voice or style guide to follow? · Which words does the product already use for its main things? · Who reads this copy, and in which languages? |
| **UX review and accessibility audit** | Which screens are in scope? · Which findings does the PM accept as a risk, and who signs that? |
| **Epic and tickets** | What each reader group gets · the ticket tree · which unknowns become spikes |
| **Launch and measure** | Who is told, and when? · What triggers a rollback? · Which number is checked first, and on which date? |

## When the PM Says "Do Not Ask"

Write the document, then end with one list: every decision the agent made alone, each with the option it chose. The PM confirms or changes each. The document is a draft until they have.

## Quality Checklist

- [ ] Each turn opened with where the PM is and the task counts
- [ ] Every question came from the agent in the conversation, with quick replies and "I don't know yet"
- [ ] The agent said how many questions it had, and asked them one at a time with their place
- [ ] Every question had short options and a recommended answer
- [ ] No question asked for something a source or `progress.yaml` already answered
- [ ] No decision in the document was made by the agent alone
- [ ] Every undecided item is a named TBD with an owner, tracked as an open item
- [ ] The PM confirmed what was decided before the document was called finished
