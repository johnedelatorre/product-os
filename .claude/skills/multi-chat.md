# More Than One Chat Skill

> **TL;DR:** A project can run in more than one chat without losing its place. The agent states the size of a heavy phase before it starts, proposes a second chat when the work calls for one, hands over through the board, keeps one board current from every chat, and answers "status of <workstream>" from any chat. The PM never manages context, files or connectors.

## When to Use

1. Before design production, bulk publishing, or any phase with many repeated steps
2. When a chat has run long, or its work changes kind
3. When a message opens with "Continue the Product OS workstream"
4. When the PM asks for the status of a workstream, or about cost
5. When a person, such as a designer, does a phase instead of an agent

## Why

A long chat re-reads its instructions and its own history on every step. In one measured chat of 120 requests, 58% of the usage went to that re-reading, and 10% to the design tool. The cost follows the number of steps, not the number of screens. A second chat with a short handover starts small, so each step costs less.

In Claude Code this shows less: roles run as subagents with their own context, and state lives in files. It shows in a long chat, and in any chat kept open for weeks.

## The Size Check

Before a production-heavy phase, say the size in plain words. Do it before any item is made.

1. **How many items**: screens, frames, pages or tickets. Count them from the plan. Multiply by every size, theme and state the PM asked for, and show the sum ("402 screens × 3 sizes × 2 themes, with states: about 10,000 frames").
2. **How many rounds**, and what one round holds.
3. **What drives the cost**: the number of steps, not the number of items.
4. **The rounds you propose**, in order, most useful first.
5. **One question, with choices to tap**, when the scope can be staged: all of it, a first stage, or a smaller set the PM names.

A small feature gets one line ("12 screens, one round") and no question.

## The Split Rule

Propose a second chat, with one question to tap, when any of these is true:

1. The phase needs more than about 50 tool steps.
2. Your context opens with a summary of earlier turns: the chat has been summarized once already.
3. The work is a different kind from the rest of the chat, such as design production inside a product management chat.

The question names what the split saves and what the PM does: "This phase is about 400 steps. In a second chat each step costs less. You paste one prompt there. Do you want that?" with the choices "Yes, a second chat", "No, stay here".

After a yes, write the workstream and its handover to the board. Then reply with only these steps and the prompt:

1. Open a new Claude chat.
2. Paste this prompt as the first message, and send it.
3. For each later round, paste the same prompt again. The board has it too: open the row in the Workstreams card and select "Copy the prompt".
4. To see how it is going, open the board, or ask here for "status of <the name the PM gave it>".

The PM starts the new chat. Say so. Never leave them to work out when, who or how.

Rules:

1. **Never propose a split for a small feature.** Small means the phase fits in one round of about 50 tool steps or fewer. This rule comes before the three conditions above.
2. **If the PM says no**, carry on in the same chat and do not ask again for that phase.
3. **A person doing the phase is not a split.** See "When a Person Does a Phase".

## Workstreams

A workstream is one line of work in a project, owned by one chat or one person.

1. **The PM names each one**, in plain words: "Product management", "Design office". Ask once, with two or three suggestions to tap.
2. **Use those names in every reply.** Never "the other chat" or "chat 2". A workstream's name is the one on the board. It is not the chat's title, which you cannot see or change.
3. **Its id** is the name in lower case with hyphens: `design-office`.
4. **One workstream leads.** It is the chat that started the project. `project/state.lead` holds its id.
5. **A project with one chat has no workstream rows.** Add them when the second one starts.

## The Handover Lives on the Board

The handover is a board document, `handover/<workstream id>`. It is not a file.

| Field | What it holds |
|-------|---------------|
| `goal` | What this workstream is for, in one or two sentences |
| `scope` | The scope the PM set, in their words |
| `links`, `ids` | Every link and id the work needs: the design file, its key, the pages, the epic |
| `content_rules`, `working_rules` | What the output must follow, and how the work is done |
| `steps` | The rounds left, in order, each with `done` true or false |
| `counts`, `decisions`, `report` | The counts now, the decisions already made, and how to report |

Rules:

1. **Write it before the second chat starts**, in full. The second chat has nothing else.
2. **Keep it current.** At the end of each round, mark the round's steps done and update the counts.
3. **Starting a workstream takes one prompt**, pasted as the first message of a new chat. The board shows it with a Copy button. It holds the board's link, and it is the same for every round:

```
Continue the Product OS workstream "<name>" (<id>) from this board: <board link>
Read the board first. Do the next round in the handover, and only that round. Then write your workstream and its handover back to the board, and report.
```

4. **Show that prompt once in a reply**, in one code block, never reworded.
5. **A file is the fallback only.** When the new chat cannot read the board, the board offers "Download the handover" as one Markdown file. If the PM gets a second copy of a file, say in one line that it takes the place of the first.

### Starting From the Prompt

When a message opens with "Continue the Product OS workstream":

1. Open the board from its link with your artifact tool, and read `project/state`, `workstreams/<id>` and `handover/<id>`.
2. Say in two lines what you read: the workstream, the round you will do, and the counts.
3. Ask no start questions. The project exists.
4. Do the next round in the handover, and only that round.
5. Write `workstreams/<id>` and `handover/<id>`, then report.

If you cannot read the board, say so in one line and ask for the handover file from the board.

## Board Data and Who Writes It

`workstreams/<id>` holds one row of the board's Workstreams card.

| Field | What it holds |
|-------|---------------|
| `name`, `owner`, `by` | The PM's name for it; who runs it ("Claude, in its own chat", or a person's name); `claude` or `person` |
| `phase`, `step`, `steps` | The phase, and step n of m, counted in rounds |
| `status`, `next` | `planned`, `working`, `review`, `paused`, `blocked` or `done`; and one sentence on what is next |
| `counts`, `url` | Up to six of `{"label", "value"}`; and the link to the output |
| `round_minutes`, `updated` | How long you estimate the current round takes; and the time now, ISO 8601 |

Ownership:

1. **Each chat writes only its own `workstreams/<id>` and `handover/<id>`.**
2. **The lead chat owns everything else**: `project/state`, `documents`, `tickets`, `todos`.
3. **Two chats never write the same document.** To change something you do not own, say what should change and let the owner write it.
4. **Read the board first, write your part last**, in every chat that touches the project.
5. **A production chat writes at the end of each round**, never more often.

Writing:

1. **Read the document's version, then write with that version.**
2. **Refused because people outside the organization were invited**: send the same call once more.
3. **Refused because the board is shared publicly**: stop. Tell the PM the board cannot be updated while it is public, and ask them to share it by name instead.
4. **Never say the board is updated when the write did not succeed.**

The board flags a row as stale when it has had no update for longer than `round_minutes`. Set that number honestly at the start of each round.

## Status Across Chats

When the PM writes "status of <workstream>" in any chat:

1. Read that workstream's board document.
2. Where you have the tool, check the real output yourself: count the screens per theme in the design file, the pages in Confluence, the tickets in Jira.
3. Answer in this shape, and no longer:

```
The design office finished round 2 of 8: 96 of 402 screens exist in both themes.

Screens: 96 of 402 · Dark 48 · Light 48
Board line: changed 12 minutes ago

What I checked
1. The board document for the design office
2. The design file: frames per page, counted by theme

Stage: round 3 of 8, tablet sizes. Next check: at the end of that round, about 40 minutes.
```

Check-ins:

1. **Where a scheduling tool exists**, offer one check-in, timed to the expected end of the current round. When it fires, answer in the status shape and set the next one.
2. **Keep them few, and say why**: each check-in costs usage.
3. **Where no scheduling tool exists**, say so, and tell the PM to ask for status.

Say plainly what you cannot do: you cannot watch another chat live, and you cannot rename a chat.

## Producing at Volume

For the Figma agent, product designer, wireframer and prototyper, when a round makes many items:

1. **Many screens per step**: 10 to 60. Never one screen per step.
2. **One visual check per batch**, at low resolution. No check for a theme copy unless the original showed a problem.
3. **No running commentary.** One report per round, with links and real counts.
4. **Decide, and list each real decision on the page.** Do not ask during production.
5. **Count and compare at the end of each round**: both themes and all sizes. The report states the counts.

## Cost, in Plain Words

1. **Before a production phase**, say what drives the cost and what the split saves.
2. **When the PM asks about cost**, offer the usage breakdown.
3. **For a production chat, recommend the "On demand" tool access setting.** In Claude it is in the chat's "+" menu, under Connectors, then Tool access. Never tell the PM to switch connectors off one by one.
4. **With no deadline**, recommend letting the plan's limit set the pace before recommending extra credits.

## Less to Read, Fewer Things to Hold

1. **One file or none. One prompt**, shown once per reply.
2. **Never put a document for later reading in the same reply as steps the PM must do now.**
3. **Steps are numbered, and no more than five.**
4. **When the PM says they are overwhelmed**, reply with only: what to use, the steps, the prompt, and what to ignore.

## When a Person Does a Phase

When a designer does the design phase:

1. **The workstream is "Design: <designer's name>"**, with `by` set to `person`.
2. **Its handover document is the design brief with links**, written for a person: the goal, the scope, the links, the rules, the steps, and how to report back.
3. **The board shows the same row.** The PM updates its status by telling you, or you update it after checking the design file, when you have access.
4. **No second chat is proposed for design.** The split rule still applies to the other phases.

## In Claude Code

Subagents keep their own context there, and state lives in files. Keep that.

1. **Delegate as before.** A role that runs as a subagent is not a split, and needs no question.
2. **Use the same workstream and handover documents on the board**, when the session can write to it, so a board looks the same whether the project ran in a chat or in Claude Code.
3. **Without a board**, keep the same fields under `workstreams` in `progress.yaml`, and the handover in `HANDOVER.md` (`.claude/skills/session-handover.md`).

## Quality Checklist

- [ ] The size was stated before any item was made
- [ ] A split was proposed only when the split rule applied, and once
- [ ] Each workstream has the PM's name for it, and one owner
- [ ] The handover is on the board, and its steps and counts match the last round
- [ ] Each chat wrote only its own documents
- [ ] Every board write was read back or confirmed before it was reported
- [ ] The prompt was shown once, unchanged
