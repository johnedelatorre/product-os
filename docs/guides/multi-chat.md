# Running a Project in More Than One Chat

> **TL;DR:** A long chat costs more with every step, because it re-reads its own history each time. Product OS tells you the size of a heavy phase before it starts and, when the work calls for it, proposes a second chat. You paste one prompt. The board carries the handover, shows every workstream, and any chat can tell you how another one is doing. You never manage files, context or connectors.

## When Product OS Proposes a Second Chat

Before design production, bulk publishing, or any phase with many repeated steps, the agent says the size first: how many items, how many rounds, and that the cost follows the number of steps. Then it asks one question, with choices to tap, when one of these is true:

1. The phase needs more than about 50 tool steps.
2. The chat has been summarized once already.
3. The work is a different kind from the rest of the chat, such as design production inside a product management chat.

A small feature never gets that question. If you say no, the agent carries on in the same chat and does not ask again for that phase.

## What You Do

1. Say yes, and name the workstreams in your own words, for example "Product management" and "Design office".
2. Open the board. The Workstreams card shows a row for each one.
3. Open the new workstream's row and select **Copy the prompt**.
4. Start a new Claude chat that has the Product OS plugin, and paste the prompt as the first message.
5. For each later round, paste the same prompt again. It never changes.

There is no file to download or attach. The new chat reads the handover from the board.

## What the Board Shows

| On the Workstreams card | What it tells you |
|-------------------------|-------------------|
| The name and the owner | Which chat, or which person, runs the workstream |
| Step n of m | The round it is in |
| The status badge | Not started, In progress, Ready for your review, Paused, Blocked or Done |
| "No update for 2 hours" | The row is stale: no update for longer than the round was estimated to take |
| The handover | The goal, your scope in your words, the steps with DONE marks, the counts and the decisions |

Each chat writes only its own workstream and its handover, at the end of each round. The chat that started the project writes everything else.

If the new chat cannot read the board, open "If the new chat cannot read this board" in the row. It gives the handover as one Markdown file. Give the new chat that file with the prompt.

## Asking for Status

Write "status of the design office" in any chat. The agent reads that workstream on the board and, where it has the tool, checks the real output: the screens in the design file, the pages in Confluence, the tickets in Jira. The answer is short:

```
The design office finished round 2 of 8: 96 of 402 screens exist in both themes.

Screens: 96 of 402 · Dark 48 · Light 48
Board line: changed 12 minutes ago

What I checked
1. The board document for the design office
2. The design file: frames per page, counted by theme

Stage: round 3 of 8, tablet sizes. Next check: at the end of that round, about 40 minutes.
```

Where your Claude has a scheduling tool, the agent offers one check-in at the expected end of the round. Each check-in costs usage, so it keeps them few.

## Cost

1. The cost of a long chat follows the number of steps, not the number of screens. In one measured chat of 120 requests, 58% of the usage went to re-reading the instructions and the chat's history, and 10% to the design tool.
2. A second chat starts small, so each step costs less.
3. For a production chat, set tool access to "On demand": in the chat's "+" menu, under Connectors, then Tool access. You do not need to switch connectors off one by one.
4. With no deadline, let your plan's limit set the pace before you buy extra credits.
5. Ask "where did the usage go?" for a breakdown.

## When a Designer Does the Design

The workstream is "Design: <the designer's name>". Its handover is the design brief with links, written for a person. The board shows the same row. You update its status by telling the agent, or the agent updates it after checking the design file, when it has access. No second chat is proposed for design.

## In Claude Code

Roles run as subagents with their own context, and state lives in files, so no second chat is proposed. The same workstream and handover documents are used, so a board looks the same whether the project ran in a chat or in Claude Code.

## What the Agent Cannot Do

1. It cannot watch another chat live. It reads the board and the real output when you ask.
2. It cannot rename a chat.
3. It cannot update a board that is shared publicly. It tells you, and asks you to share the board by name instead.

## Related

- [Guided Workflow](guided-workflow.md): the nine phases and the status board
- [The Product OS board](../../artifact/README.md)
- The rules the agents follow: `.claude/skills/multi-chat.md`
