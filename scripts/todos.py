#!/usr/bin/env python3
"""Owner To-Do list, pinned in a Telegram topic.

Usage:
  todos.py setup                       create the pinned list message
  todos.py add "Title" [--why W] [--steps "A|B|C"] [--minutes N]
  todos.py list | render | done ID | drop ID

Settings (environment first, then ~/.hermes/.env):
  TELEGRAM_BOT_TOKEN   bot token (never printed)
  TODOS_CHAT_ID        chat id (default: TELEGRAM_HOME_CHANNEL)
  TODOS_THREAD_ID      topic id for the To-Dos topic (optional)
  TODOS_OFFLINE=1      do not call Telegram (local only, for tests)
Data: $HERMES_HOME/notes/todos.json (default ~/.hermes/notes/todos.json)
"""
import argparse, datetime as dt, json, os, sys, urllib.request

HOME = os.environ.get("HERMES_HOME", os.path.expanduser("~/.hermes"))
DATA = os.path.join(HOME, "notes", "todos.json")


def env(key, default=""):
    if os.environ.get(key):
        return os.environ[key]
    path = os.path.join(HOME, ".env")
    if os.path.exists(path):
        for line in open(path, encoding="utf-8"):
            line = line.strip()
            if line.startswith(key + "="):
                return line.split("=", 1)[1].strip().strip('"').strip("'")
    return default


def load():
    if os.path.exists(DATA):
        with open(DATA, encoding="utf-8") as f:
            return json.load(f)
    return {"next_id": 1, "items": [], "pinned_message_id": None}


def save(db):
    os.makedirs(os.path.dirname(DATA), exist_ok=True)
    tmp = DATA + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(db, f, ensure_ascii=False, indent=2)
    os.replace(tmp, DATA)


def tg(method, **payload):
    if env("TODOS_OFFLINE") == "1":
        return {"ok": True, "result": {"message_id": 0}, "offline": True}
    token = env("TELEGRAM_BOT_TOKEN")
    if not token:
        sys.exit("TELEGRAM_BOT_TOKEN not set (configure the Telegram gateway first).")
    req = urllib.request.Request(
        f"https://api.telegram.org/bot{token}/{method}",
        data=json.dumps(payload).encode(),
        headers={"Content-Type": "application/json"},
    )
    try:
        with urllib.request.urlopen(req, timeout=20) as r:
            return json.load(r)
    except urllib.error.HTTPError as e:  # report Telegram's reason, never the token
        try:
            return json.load(e)
        except Exception:
            return {"ok": False, "description": f"HTTP {e.code}"}


def target():
    chat = env("TODOS_CHAT_ID") or env("TELEGRAM_HOME_CHANNEL")
    if not chat and env("TODOS_OFFLINE") != "1":
        sys.exit("Set TODOS_CHAT_ID or TELEGRAM_HOME_CHANNEL.")
    t = {"chat_id": chat}
    if env("TODOS_THREAD_ID"):
        t["message_thread_id"] = int(env("TODOS_THREAD_ID"))
    return t


def render_text(db):
    open_items = [i for i in db["items"] if i["status"] == "open"]
    lines = [f"✅ To-Do list — {len(open_items)} open", ""]
    if not open_items:
        lines.append("Nothing waiting on you. 🎉")
    for i in open_items:
        mins = f" (~{i['minutes']} min)" if i.get("minutes") else ""
        lines.append(f"#{i['id']} {i['title']}{mins}")
        if i.get("why"):
            lines.append(f"   Why: {i['why']}")
        for n, s in enumerate(i.get("steps", []), 1):
            lines.append(f"   {n}. {s}")
        lines.append("")
    lines.append(f"Updated {dt.datetime.now().strftime('%a %d %b %H:%M')}")
    return "\n".join(lines)[:4000]


def refresh(db):
    text = render_text(db)
    t = target()
    mid = db.get("pinned_message_id")
    if mid:
        r = tg("editMessageText", chat_id=t["chat_id"], message_id=mid, text=text)
        if r.get("ok") or "not modified" in r.get("description", ""):
            return
    r = tg("sendMessage", text=text, **t)
    if not r.get("ok"):
        sys.exit(f"Telegram error: {r.get('description')}")
    db["pinned_message_id"] = r["result"]["message_id"]
    tg("pinChatMessage", chat_id=t["chat_id"], message_id=db["pinned_message_id"], disable_notification=True)
    save(db)


def main():
    p = argparse.ArgumentParser(description="Owner To-Do list")
    sub = p.add_subparsers(dest="cmd", required=True)
    sub.add_parser("setup"); sub.add_parser("list"); sub.add_parser("render")
    a = sub.add_parser("add"); a.add_argument("title"); a.add_argument("--why", default="")
    a.add_argument("--steps", default=""); a.add_argument("--minutes", type=int)
    for c in ("done", "drop"):
        s = sub.add_parser(c); s.add_argument("id", type=int)
    args = p.parse_args()
    db = load()
    if args.cmd == "add":
        item = {"id": db["next_id"], "title": args.title, "why": args.why,
                "steps": [s.strip() for s in args.steps.split("|") if s.strip()],
                "minutes": args.minutes, "status": "open", "added": dt.date.today().isoformat()}
        db["items"].append(item); db["next_id"] += 1; save(db); refresh(db)
        print(f"added #{item['id']}")
    elif args.cmd in ("done", "drop"):
        for i in db["items"]:
            if i["id"] == args.id:
                i["status"] = "done" if args.cmd == "done" else "dropped"
                i["closed"] = dt.date.today().isoformat()
                break
        else:
            sys.exit(f"no item #{args.id}")
        save(db); refresh(db); print(f"{args.cmd} #{args.id}")
    elif args.cmd == "list":
        print(render_text(db))
    else:  # setup / render
        db["pinned_message_id"] = None if args.cmd == "setup" else db.get("pinned_message_id")
        save(db); refresh(db); print("pinned list ready")


if __name__ == "__main__":
    main()
