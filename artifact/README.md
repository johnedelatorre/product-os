# Product OS as a Claude Artifact: the Visual Start

> **TL;DR:** `product-os-start.html` is the start of a project as a visual workspace. A guide asks the seven start questions in a conversation, with chips to answer. A board beside it shows every task: Start and the nine phases, each done, in progress or not started, with its numbers. Opened in Claude, the guide is Claude. At the end it copies a brief you paste into your Product OS project in Claude, ChatGPT or Claude Code, where the documents are written.

## What It Looks Like

![Product OS on a desktop screen and on a phone. The desktop shows a conversation with the guide beside a board of ten tasks. The phone shows the board slid out over the conversation.](../docs/images/hero.jpg)

1. **Where you are**, at the top: the project, the question you are on, and a bar of the seven steps.
2. **The conversation.** The guide asks one question at a time ("Question 4 of 7"). You tap a chip or type. It asks as an invitation: "What do you already have?", "Does this look right?".
3. **The board.** Four numbers (questions answered, kinds of material found, documents planned, phases done), then ten tasks. Start lists its seven steps with your answers. Each phase opens to its documents and who each is for.
4. **Connectors and settings.** Confluence, Jira, Figma and Claude Design, each set to connected, not connected or not used; then your readers, role, design system, Confluence space and Jira project. They travel in the brief, and your chat checks each connector itself.
5. **What I noticed.** Short notes on gaps, readers and the design system.
6. **The end.** You say yes, it copies the brief, and two chips open Claude and ChatGPT.

The page opens with example answers, part way through, so you can see a project in progress. "Start over" clears it.

## The Agent

| Where you open it | Who asks | What it adds |
|-------------------|----------|--------------|
| **As a Claude artifact** | Claude. The badge reads "Agent: Claude". The first answer asks for your consent. | It reads typed answers into the right fields, reflects each answer in one line, and writes "What I noticed". |
| **As a plain file in a browser** | Fixed questions. The badge reads "Guided questions". | Nothing is sent anywhere. The notes come from fixed rules. |

The seven questions and their order are fixed in both. Claude never invents an answer: it only restates what you typed.

## The Board After the Start

Paste a project's `progress.yaml` under "Update the board from progress.yaml". The board then shows which phases and documents are done, in progress or skipped, and where you are. Claude Code saves that file in the project folder; Claude chat and ChatGPT give it to you when you ask.

## Setup (about 2 minutes)

1. **With the Product OS plugin** in your Claude account ([how to add it](../README.md#path-a--claude-chat)): say *"Open the Product OS workspace."* Claude publishes the page as your own artifact. Go to step 3.
   **Without it:** download [`product-os-start.html`](product-os-start.html) from this folder.
2. In Claude (claude.ai or the desktop app), attach the file and say: *"Publish this page as an artifact. It asks Claude through the `sample` capability, so declare that capability."* The artifact is yours and private to you. Without the capability the page still works, with fixed questions.
3. Open the artifact and answer the guide's seven questions.
4. Tap **Yes, copy the brief**.
5. Paste the brief into your Product OS project: [Claude chat](../claude-ai/README.md) or [ChatGPT](../chatgpt/README.md). Attach the files you listed.

**For a team:** each PM adds the plugin and opens their own workspace. A team that wants one shared page can have one person publish it and share it from its page.

**Without Claude:** the file is one self-contained HTML page. Opening it in a browser works too.

**On a phone:** the conversation fills the screen, and the bar at the top stays in view with where you are. "Tasks and documents" slides the board out over the conversation: the numbers, every task with its status, each document, and Connectors and settings. "Close" returns you to the question. Artifacts open in the Claude apps for iOS and Android.

## What It Does and Does Not Do

| It does | It does not |
|---------|-------------|
| Run the start conversation, with Claude as the guide when opened in Claude | Ask the questions before each document. Those depend on your sources, and they happen in the chat. |
| Sort what you list into Found and Missing, by name | Read your files. You attach them in the chat. |
| Show every task, its status and its numbers | Write the documents. The chat does. |
| Record your connectors and settings, and put them in the brief | See your connections. Your chat checks them. |
| Update the board from a `progress.yaml` you paste | Follow a project live. You paste the file again to refresh it. |
| Copy a brief in the `progress.yaml` format | Write to Confluence or Jira |

Your answers stay in your own browser.

## How It Fits the Other Paths

The brief it copies uses the same `audience`, `design_system` and `context` blocks as `progress.yaml` (`.claude/skills/guided-workflow.md`). Claude Code, Claude chat and ChatGPT all read it, skip the start questions, show the playback and wait for your yes.
