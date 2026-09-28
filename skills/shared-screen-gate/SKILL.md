---
name: shared-screen-gate
description: "Use before driving Chrome or the desktop on a shared Mac."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [chrome, desktop, shared-screen]
    related_skills: [owner-onboarding]
---

# Shared-screen gate

People use this Mac too. Before Hermes drives the real Chrome or the desktop, it checks whether a human has the screen.

`python3 ~/.hermes/starter/scripts/chrome_gate.py <command>`
- `status` prints FREE or BUSY (who, why, until when). Exit code 0 = free, 1 = busy.
- `human-start <minutes> "<why>"` mark the screen as taken by a person (use before asking someone to sign in).
- `human-end` release it.
- `agent-start <minutes> "<why>"` / `agent-end` mark agent use, so people know not to click while Hermes works.

## Rules
- BUSY means hands off: do other work, check again later.
- Prefer background methods (APIs, headless browser) over the owner's real Chrome.
- Never type into a window a human is using. Never read or store what is on screen beyond the task.
