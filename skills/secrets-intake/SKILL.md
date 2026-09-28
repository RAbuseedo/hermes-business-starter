---
name: secrets-intake
description: "Use when any password, key or token is involved. Bitwarden only."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [secrets, bitwarden, security]
    related_skills: [owner-onboarding, owner-todos]
---

# Secrets intake (Bitwarden Secrets Manager)

All company secrets live in the owner's **Bitwarden Secrets Manager** project (for example `hermes`). Hermes holds only one credential: the machine-account access token, `BWS_ACCESS_TOKEN` in `~/.hermes/.env`, set by `hermes secrets bitwarden setup`. With `secrets.bitwarden.enabled: true`, Hermes injects every project secret as an environment variable at startup.

## Adding a secret (preferred: owner does it)
1. Tell the owner the exact **Name** to use (UPPER_SNAKE_CASE, becomes the env var; use the exact name the tool or skill documents) and where to get the value at the vendor.
2. Owner: Bitwarden web app → Secrets Manager → project → New secret → Name + Value → Save.
3. Hermes: `hermes secrets bitwarden sync` (or restart the gateway) and verify the key NAME resolves: `hermes secrets bitwarden status`.
4. Verify against the vendor with a harmless read-only call. Report "works" or the exact error, never the value.

## Generated secrets (backup passwords etc.)
If the machine account has write access: generate in a script, `bws secret create NAME "$value" <project_id> --note "what/where to rotate"`, never print the value. Tell the owner to also keep a paper copy for anything needed in disaster recovery.

## Never
- Never ask for a secret in chat. If one is pasted: do not repeat it, ask the owner to rotate it at the vendor and store the new value in Bitwarden.
- Never print `bws secret list` raw output: its JSON includes values. Filter to names only:
  `bws secret list | python3 -c "import json,sys; print([s['key'] for s in json.load(sys.stdin)])"`
- Never put secrets in notes, git, logs, cron prompts, subagent context, or messages.
- Card numbers never go in Bitwarden Secrets Manager or chat; the owner types them on the vendor's billing page.

## Inventory
`~/.hermes/notes/accounts.md` lists each account, purpose, and the secret NAME that holds its credential. Names only.
