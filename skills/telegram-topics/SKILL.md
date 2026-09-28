---
name: telegram-topics
description: "Use when creating Telegram topics for briefs and to-dos."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [telegram, topics, gateway]
    related_skills: [owner-todos, daily-briefs]
---

# Telegram topics

Topics keep the owner's chat with Hermes tidy: 📰 Briefs, ✅ To-Dos, 👥 Clients, 📦 Projects, 💬 General.

## Two ways
1. **Topics in the bot's private chat** (cleanest). Newer Telegram bots can have topics in the direct chat. In @BotFather → the bot → Bot Settings, enable topics/threaded mode if the option is shown. Then Hermes calls the Bot API `createForumTopic` with the owner's chat id.
2. **Private group with Topics** (works everywhere). Owner creates a group (just them and the bot, plus named delegates), Group settings → Topics ON, adds the bot as admin with "Manage topics". Put the group id in `TELEGRAM_HOME_CHANNEL` and allow it in the gateway.

## Create topics (script, token from env, never printed)
```
python3 - <<'PY'
import json, os, urllib.request
tok = os.environ["TELEGRAM_BOT_TOKEN"]; chat = os.environ["TELEGRAM_HOME_CHANNEL"]
for name in ["📰 Briefs", "✅ To-Dos", "👥 Clients", "📦 Projects", "💬 General"]:
    req = urllib.request.Request(f"https://api.telegram.org/bot{tok}/createForumTopic",
        data=json.dumps({"chat_id": chat, "name": name}).encode(), headers={"Content-Type": "application/json"})
    r = json.load(urllib.request.urlopen(req)); print(name, r.get("result", {}).get("message_thread_id"), r.get("description", ""))
PY
```
Record the thread ids in `~/.hermes/notes/telegram.md` (ids only) and set `TODOS_THREAD_ID` in `~/.hermes/.env` for the To-Do list.

## Rules
- Only the owner and named delegates are allowed users of the bot. Everyone else is ignored.
- If `createForumTopic` fails with "not a forum", use way 2.
