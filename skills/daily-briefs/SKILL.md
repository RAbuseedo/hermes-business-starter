---
name: daily-briefs
description: "Use when writing morning/evening briefs or the weekly review."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [briefs, reporting, cron]
    related_skills: [open-loops, owner-todos, agency-ops, email-inbox-triage, weekly-review-planning]
---

# Daily briefs and weekly review

Plain-language status for a busy owner, delivered to the Telegram **📰 Briefs** topic.

## Schedule (create with the owner's OK)
- Morning brief at the owner's morning time (default 07:30), evening brief (default 18:00), working days only.
- Weekly review once a week (default Friday 15:00).
Example:
```
hermes cron create --name "Morning brief" --skill daily-briefs --deliver telegram "30 7 * * 1-5" "Write and deliver the morning brief. Load daily-briefs and agency-ops; read ~/.hermes/notes/OPEN-LOOPS.md, todos.json, projects/, money.md; check the inbox and today's calendar."
```
`--deliver telegram` goes to the home channel; use `telegram:<chat_id>` (see `hermes cron create --help` for topic/thread targets on this version) to land in the Briefs topic. Use a cheaper `--model` for routine jobs if the owner agrees. Check with `hermes cron list` and test once with `hermes cron run <id>`. Cron prompts must be self-contained: tell the job to load this skill and read the notes listed below.

## Inputs
`OPEN-LOOPS.md`, `todos.json` (open owner items), project files, `money.md`, client files, the inbox (last 24h: new client mail, mail waiting a reply), today's and tomorrow's calendar.

## Morning brief shape (under 20 lines)
```
Good morning. <one line: the day in a sentence>
🔴 Needs you (N)
- <decision/action> — <one action to take>
📅 Today: <meetings with time and who>
👥 Clients: <new requests / waiting our reply / waiting their approval>
📦 Due in 48h: <deliverable — client — who>
👩‍💼 Team: <overdue or at-risk tasks by person>
💰 Money: <invoices due/overdue, quotes waiting>
▶ Hermes today: <what I will do>
```
Evening brief: ✅ done today (with evidence), what slipped and why, 🔴 still needs you, tomorrow's first things.

## Weekly review
Delivered, slipped, collected vs invoiced, client health (green/amber/red + reason), team load, top five for next week, one suggestion to improve how the company runs. Uses the bundled `weekly-review-planning` method where helpful.

## Style
Owner's language (Arabic or English). No IDs, paths, or jargon. Red items always first, each with the one action. If nothing needs the owner, say so in one line.
