---
name: owner-onboarding
description: "Use when onboarding a new company owner. Runs ONBOARDING.md."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [onboarding, owner, setup]
    related_skills: [secrets-intake, owner-todos, company-profile, mac-keep-alive, daily-briefs]
---

# Owner onboarding

Runs `~/.hermes/starter/onboarding/ONBOARDING.md` with a company owner, step by step, on their new Mac. The script is the source of truth; this skill is how to run it well.

## When to Use
- The owner says "start onboarding" or setup.sh launched Hermes with the onboarding prompt.
- `~/.hermes/notes/onboarding/PROGRESS.md` shows unfinished steps (resume there).

## Rules
1. **One action per message.** Why (1 to 2 lines), the one thing to do, what they will see when it worked. Wait for "done", then verify yourself.
2. **Owner's language.** Arabic if they write Arabic, English otherwise. Short sentences, no jargon, no file paths unless they must paste them.
3. **Paste lines in code blocks**, one per block, nothing to edit inside them. If something must be typed (a password), say where to type it and that nothing shows while typing.
4. **Never ask for secrets in chat.** Hidden prompts (`hermes gateway setup`, `hermes secrets bitwarden setup`) or the Bitwarden web app only. If one is pasted anyway: do not repeat it, ask the owner to rotate it, continue.
5. **Money and accounts:** show the cost and what it buys, then wait for an explicit yes. The owner enters card details on the vendor page themselves.
6. **Verify, then record.** After each step append to `~/.hermes/notes/onboarding/PROGRESS.md`: `- [x] Step N title — YYYY-MM-DD — evidence` (or `[-] skipped: reason`, `[!] blocked: what is needed`).
7. **Browser sign-ins on this Mac:** `python3 ~/.hermes/starter/scripts/chrome_gate.py human-start 30 "signing in to X"` before asking; `human-end` after.
8. **Helpers:** a delegate the owner names may click and type; approvals (money, accounts, sending, publishing) still come from the owner.
9. **Stop cleanly.** If the owner is tired, write the next step to PROGRESS.md and the To-Do list; the next session resumes there.

## Placeholders
During step 8, replace in `~/.hermes/SOUL.md`: `{{OWNER_NAME}}`, `{{OWNER_FIRST_NAME}}`, `{{COMPANY}}`, `{{COMPANY_ONE_LINER}}`, `{{CITY}}`, `{{DELEGATES}}`, `{{BRIEF_LANGUAGE}}`, `{{BRIEF_MORNING}}` (default 07:30), `{{BRIEF_EVENING}}` (default 18:00), `{{WORK_WEEK}}` (for the UAE usually Monday to Friday), `{{WEEKLY_REVIEW_DAY}}` (default Friday afternoon). Show the owner the changed lines. Check none remain: `grep -n '{{' ~/.hermes/SOUL.md`.

## Done when
Steps 0 to 5, 8, 10, 11 are done or knowingly skipped; the first morning brief has been delivered; the owner has a clear To-Do list of what is still theirs.
