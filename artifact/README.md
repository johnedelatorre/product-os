# Product OS as a Claude Artifact

> **TL;DR:** `product-os.html` is all of Product OS as one page. A guide asks, you answer with chips, each agent writes its document, and a board shows every task. It runs inside your own Claude, with all 41 agents, 48 commands and 44 playbooks in the page. You read, change, accept and download every document there.

## What It Looks Like

![Product OS on a desktop screen and on a phone. The desktop shows a conversation with the guide beside a board of ten tasks. The phone shows the board slid out over the conversation.](../docs/images/hero.jpg)

1. **Where you are**, at the top: the project, the phase and document you are on, and a bar of the nine phases.
2. **The conversation.** The guide asks one question at a time, and you tap a chip or type. After the start, the agent for each document asks its own questions, writes the document, and waits for your review.
3. **The board.** Four numbers (documents done, in progress, named TBDs, phases done), then Start and the nine phases. Each phase lists its documents with a status and one action: Write, Continue, Review or Open.
4. **The document.** It opens over the page, and you can read it as it is written. Copy it, download it, or close it and tell the guide what to change.
5. **All agents and commands.** Every agent and command with a search box. Run any of them; its output is kept under Other documents.

The board also holds **Connectors and settings** (Confluence, Jira, Figma, Claude Design, your readers, role, design system, Confluence space and Jira project) and **What I noticed**, short notes on gaps.

The page opens with example answers, part way through the start, so you can see a project in progress. "Start over" clears it.

## How a Document Is Written

![A PRD open in the workspace: a summary, numbered sections and a metrics table with named TBDs, and buttons to copy, download and close](../docs/images/document.png)

1. Tap **Start: PRD** in the conversation, or **Write** next to the document on the board.
2. The PRD Author reads the project and the earlier documents, then asks up to five questions with chips. "I don't know yet" is always an answer, and it becomes a named TBD.
3. It writes `prd.md` from its agent file, the template and the playbooks. You can read it as it is written, and stop it.
4. You accept it, type a change, or ask for more questions. A document is done only when you accept it.
5. The guide offers the next document. You can skip it, or pick another from the board.

Reviews (design critique, UX writing guide, UX review, accessibility audit) ask for the screens first. Attach screenshots, or continue without them and the gap is written as a named TBD.

## Setup (about 2 minutes)

1. **With the Product OS plugin** in your Claude account ([how to add it](../README.md#path-a--claude-chat)): say *"Open the Product OS workspace."* Claude publishes the page as your own artifact.
   **Without it:** download [`product-os.html`](product-os.html), attach it in Claude (claude.ai or the desktop app) and say: *"Publish this page as an artifact. Declare these capabilities for it: `sample` with images, and `downloads`."*
2. Open the artifact. The first time the guide needs Claude, Claude asks you to allow it. The page uses your own Claude usage.
3. Answer the seven start questions, then tap **Start: Intake**.

The artifact is yours and private to you. **For a team:** each PM adds the plugin and opens their own workspace.

**On a phone:** the conversation fills the screen, and the bar at the top stays in view with where you are. "Tasks and documents" slides the board out over the conversation. A document opens full screen. Artifacts open in the Claude apps for iOS and Android.

**Without Claude:** opened as a plain file in a browser, the page asks the start questions and tracks the documents. It cannot write them there. "Copy the brief" takes your answers to a chat.

## Where Your Work Is Kept

| What | Where |
|------|-------|
| Your answers and documents | In this browser. "Start over" erases them, after a second tap. |
| Another device | "Save the project file" on one device, "Open a project file" on the other |
| Claude Code or a chat | "Copy progress.yaml" and download each document |
| A project run in Claude Code or a chat | Paste its `progress.yaml` and the board shows what is done there |

## What It Does and Does Not Do

| It does | It does not |
|---------|-------------|
| Run all nine phases, each document with its own agent, template and playbooks | Publish to Confluence or Jira. Take the documents to your chat with the Atlassian connector. |
| Ask before each document, and wait for you to accept it | Read your files. It knows your material by the names you listed, and sees the screenshots you attach for a review. |
| Keep every document, with copy and download | Sync between devices. You move the project file. |
| Run any of the 41 agents and 48 commands | Run tools. A command that needs a repo, Figma or Jira writes its document only. |
| Record your connectors and settings | See your connections |

## How It Is Built

`product-os.html` is generated. `artifact/src/workspace.html` is the page, and `scripts/build-workspace.py` puts every agent, playbook, command and template into it. Edit the source or the Product OS files, then run the script. `scripts/validate.sh` fails when the page is out of date.

## How It Fits the Other Paths

"Copy the brief" and "Copy progress.yaml" use the same `audience`, `design_system`, `context` and `phases` blocks as `progress.yaml` (`.claude/skills/guided-workflow.md`). Claude Code, Claude chat and ChatGPT read them and continue from there.
