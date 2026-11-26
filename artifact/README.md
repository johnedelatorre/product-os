# The Product OS Board

> **TL;DR:** The board is a page that shows a Product OS project at a glance. Claude runs the project in your chat and keeps the board up to date. You only open it. It comes with the Product OS plugin: there is nothing to set up.

## What It Shows

![The Product OS board on a desktop screen and on a phone: where the project is, the next step, four numbers, three insights, and the nine phases with their status](../docs/images/hero.jpg)

1. **Where the project is**: the phase, the document in hand, and a bar of the nine phases.
2. **The next step**: what Claude is waiting for from you, with a button that copies the short reply.
3. **Four numbers**: documents done, in progress, named TBDs, phases done.
4. **How the project is doing**: up to six notes written by Claude. What is going well, a gap in the material, a risk.
5. **Three views, one at a time**: Tasks (the nine phases and their documents), Documents (a table of every document, what it was made as, its status, its link, and where it is published), and Published and connected (the Jira epic and tickets, the Confluence pages, and your connectors).

The board is read-only. You answer Claude in the chat, and the board changes by itself. It follows your device's light or dark setting and fits a phone.

## How You Get It

1. Add the Product OS plugin to Claude ([steps](../README.md#path-a--claude-chat)).
2. Say *"Start Product OS"*.
3. When the project has a name, Claude makes the board as your own artifact and gives you the link.

The board is yours and private to you, until you share it from its page. **For a team:** share the board with the people who should follow the project. They see it update, and they cannot change it.

## How It Works

| Part | What it does |
|------|--------------|
| `product-os-board.html` | The page. It reads the project from its own database and redraws when the data changes. |
| Claude, in your chat | Writes the project's state to that database after every step: where it is, the next step, each document, each ticket, the insights, the connectors it checked. |
| The plugin skill | Tells Claude when to make the board and what to write (`skills/product-os/SKILL.md`, "The board"). |

The page's `capabilities` block lists what it needs from Claude: a database, and who is viewing. It asks Claude nothing and it calls no connector.

## What It Does and Does Not Do

| It does | It does not |
|---------|-------------|
| Show every task, document, ticket and connector, with links | Run the project. Claude does that in your chat. |
| Update by itself while Claude works | Let you answer questions. You answer in the chat. |
| Work on a phone and when shared | Show anything before Claude has written to it |

Opened as a plain file, outside Claude, the page says that it needs to be opened in Claude.
