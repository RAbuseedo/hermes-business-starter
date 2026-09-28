---
name: owner-todos
description: "Use when a step needs the owner. Queue it on their pinned To-Do list."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [todos, human-gates, telegram]
    related_skills: [telegram-topics, daily-briefs, open-loops]
---

# Owner To-Do list (human gates)

Some steps only the owner can do: approve a payment, sign in, scan a QR, enter a card, answer a question. Queue them on one pinned list in the Telegram **✅ To-Dos** topic instead of blocking, then keep working.

## Script
`python3 ~/.hermes/starter/scripts/todos.py <command>`
- `setup` create the topic's pinned list message (once; needs the Telegram gateway configured).
- `add "Title" --why "one line" --steps "Step 1|Step 2" [--minutes 5]` add an item and refresh the pinned list.
- `list` show open items. `done <id>` / `drop <id>` close one. `render` re-send the pinned list.
Settings are read from environment or `~/.hermes/.env`: `TELEGRAM_BOT_TOKEN`, `TODOS_CHAT_ID` (defaults to `TELEGRAM_HOME_CHANNEL`), `TODOS_THREAD_ID` (the To-Dos topic id). `TODOS_OFFLINE=1` keeps everything local (for testing). Data: `~/.hermes/notes/todos.json`.

## Writing a good item
- Title: verb + object ("Approve Twilio upgrade").
- Why: what it unblocks, in one line.
- Steps: numbered, one action each, exact button names or one paste line, and what they will see when done.
- Minutes: honest estimate.
- Never include secrets, card numbers, or codes.

## Rules
- One item per decision. Do not bundle.
- When the owner says done, verify it yourself before `done <id>`.
- Mention the count of open items in each brief; red items first.
