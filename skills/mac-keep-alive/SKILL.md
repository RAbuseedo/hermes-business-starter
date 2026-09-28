---
name: mac-keep-alive
description: "Use when making the Mac survive sleep, reboot and power cuts."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [macos, uptime, launchd, permissions]
    related_skills: [owner-onboarding]
---

# Mac keep-alive

Goal: Hermes is reachable 24/7 on a desk Mac (Mac mini or similar).

## Checks (read-only, run anytime)
`bash ~/.hermes/starter/scripts/keep-alive-check.sh` prints sleep settings, auto-restart, FileVault, auto-login, gateway status, and disk space, with a plain verdict for each.

## Settings (owner types the Mac password when asked)
- No sleep on power: `sudo pmset -c sleep 0 disksleep 0 womp 1 autorestart 1` (display sleep is fine).
- Restart after power failure: System Settings → Energy → "Start up automatically after a power failure".
- Automatic login (so the gateway starts after reboot): System Settings → Users & Groups. Not possible with FileVault on; the owner chooses between encryption and unattended restart. Recommend FileVault on plus a UPS for short cuts.
- Gateway as a service: `hermes gateway install`, then `hermes gateway status`.
- Headless Mac mini: with no display attached some screen features misbehave; a cheap HDMI dummy plug helps if screen control is ever needed.

## macOS permissions
Grant only what a task needs, when it needs it, and say why:
- Files and Folders / Full Disk Access: only for backup or mail-file tasks.
- Contacts, Calendars, Reminders: only if the owner wants Apple apps used (Google is usually the source of truth).
- Accessibility / Screen Recording: only for desktop control.
Path: System Settings → Privacy & Security → the category → enable Terminal (or the Hermes app). Changes may need the app restarted.

## After a power cut
Brief line in the next brief: "Mac restarted at <time>, all services back" or what is still down.
