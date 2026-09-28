#!/usr/bin/env python3
"""Shared-screen gate: who is using this Mac's screen/Chrome right now?

  chrome_gate.py status                     FREE (exit 0) or BUSY (exit 1)
  chrome_gate.py human-start MIN "why"      a person has the screen
  chrome_gate.py agent-start MIN "why"      Hermes is driving the screen
  chrome_gate.py human-end | agent-end      release
Lock file: $HERMES_HOME/state/screen-gate.json (expires automatically).
"""
import json, os, sys, time

HOME = os.environ.get("HERMES_HOME", os.path.expanduser("~/.hermes"))
LOCK = os.path.join(HOME, "state", "screen-gate.json")


def read():
    try:
        with open(LOCK) as f:
            d = json.load(f)
        return d if d.get("until", 0) > time.time() else None
    except (OSError, ValueError):
        return None


def write(who, minutes, why):
    os.makedirs(os.path.dirname(LOCK), exist_ok=True)
    with open(LOCK, "w") as f:
        json.dump({"who": who, "why": why, "since": time.time(), "until": time.time() + minutes * 60}, f)


def main(argv):
    cmd = argv[1] if len(argv) > 1 else "status"
    cur = read()
    if cmd == "status":
        if not cur:
            print("FREE"); return 0
        left = int((cur["until"] - time.time()) / 60)
        print(f"BUSY: {cur['who']} — {cur['why']} — about {left} min left"); return 1
    if cmd in ("human-start", "agent-start"):
        who = cmd.split("-")[0]
        minutes = int(argv[2]) if len(argv) > 2 else 30
        why = argv[3] if len(argv) > 3 else ""
        if who == "agent" and cur and cur["who"] == "human":
            print(f"BUSY: human — {cur['why']}"); return 1
        write(who, minutes, why); print(f"{who} has the screen for {minutes} min"); return 0
    if cmd in ("human-end", "agent-end"):
        if cur and cur["who"] == cmd.split("-")[0]:
            os.remove(LOCK)
        print("FREE"); return 0
    print(__doc__); return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
