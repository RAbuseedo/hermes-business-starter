---
name: open-loops
description: "Use when reporting status or tracking commitments. Maintains OPEN-LOOPS.md."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [status, commitments, tracking]
    related_skills: [daily-briefs, owner-todos, agency-ops]
---

# Open loops

Every request the owner makes is a loop until it is closed with evidence. `~/.hermes/notes/OPEN-LOOPS.md` is the single list.

## Format
```
## Active
- [ ] <what> — asked <date> — owner: Hermes | <staff name> | owner — next: <next action> — due <date>
## Waiting on others
- [ ] <what> — waiting on <who> since <date> — chase on <date>
## Done (last 14 days)
- [x] <what> — closed <date> — evidence: <how we know>
```

## Rules
- Add a loop the moment a request arrives (chat, voice note, email from the owner).
- Close only with evidence (the email sent, the file delivered, the client's reply).
- Every brief reports each active loop in one line until closed. Stale (no movement in 3 working days): say why and propose the next move.
- Move done items older than 14 days to `~/.hermes/notes/archive/loops-<yyyy-mm>.md`.
