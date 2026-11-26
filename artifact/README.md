# Product OS as a Claude Artifact: the Visual Start

> **TL;DR:** `product-os-start.html` is a guided page for the seven start questions. You answer on the left, and the brief fills in on the right. At the end it copies a brief that you paste into your Product OS project in Claude or ChatGPT, where the documents are written. Use it when you want a page, not a chat, for the first questions.

## What It Looks Like

![The review screen on a desktop screen and on a phone: four numbers, what it noticed, a table of the documents it will make, and what it understood](../docs/images/hero.jpg)

1. **Seven questions, one per screen**, each with its place ("Question 2 of 7"): what and who, readers, your role, the design system, where it came from, what you already have, and "Does this look right?"
2. **The brief on the right fills in as you answer.** It is the playback, built live.
3. **"What do you already have?" sorts what you list** into Found and Missing.
4. **The last screen is a review of the project**: four numbers (questions answered, kinds of material found, documents to be made, reader groups), what it noticed, a table of every document with who it is for and its phase, and what it understood.
5. **One button copies the brief**, and two links open Claude and ChatGPT.

The page opens with example answers so you can see a finished run. "Clear all answers" starts yours.

## Setup (about 2 minutes)

1. Download [`product-os-start.html`](product-os-start.html) from this folder.
2. In Claude (claude.ai or the desktop app), attach the file and say: *"Publish this page as an artifact."*
3. Open the artifact and answer the seven questions.
4. Press **Yes, copy the brief**.
5. Paste the brief into your Product OS project: [Claude chat](../claude-ai/README.md) or [ChatGPT](../chatgpt/README.md). Attach the files you listed.

**For a team:** one person publishes the artifact and shares it from its page. Every PM then starts from the same link.

**Without Claude:** the file is one self-contained HTML page. Opening it in a browser works too.

**On a phone:** the page fits a phone screen. The table becomes a list, and the brief folds into one line you can open. Artifacts open in the Claude apps for iOS and Android.

## What It Does and Does Not Do

| It does | It does not |
|---------|-------------|
| Ask the seven start questions | Ask the questions before each document. Those depend on your sources, and they happen in the chat. |
| Sort what you list into Found and Missing, by name | Read your files. You attach them in the chat. |
| Show what will be made for each reader group and for you | Write the documents. The chat does. |
| Keep your answers in your own browser | Share answers between people or devices |
| Copy a brief in the `progress.yaml` format | Write to Confluence or Jira |

## How It Fits the Other Paths

The brief it copies uses the same `audience`, `design_system` and `context` blocks as `progress.yaml` (`.claude/skills/guided-workflow.md`). Claude Code, Claude chat and ChatGPT all read it, skip the start questions, show the playback and wait for your yes.
