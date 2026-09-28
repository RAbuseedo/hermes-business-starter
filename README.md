# Hermes Business Starter

A starter kit that turns a fresh Mac (for example a Mac mini on the office desk) into a company owner's AI chief of staff, running [Hermes Agent](https://hermes-agent.nousresearch.com/docs) by Nous Research.

After one terminal line, Hermes walks the owner through setup step by step: keeping the Mac awake, the AI provider, Telegram, Bitwarden for secrets, Google Workspace, WhatsApp and phone options, a company profile interview, daily briefs, and backups. Then it runs the company's routine: clients, projects and deliverables, team follow-ups, invoices and collections, and morning and evening briefs.

## The one line
Open **Terminal** on the Mac and paste:

```
curl -fsSL https://raw.githubusercontent.com/RAbuseedo/hermes-business-starter/v1/setup.sh | bash
```

It installs Hermes with the official installer if needed (you pick your AI provider during that step), installs this kit, then opens Hermes, which starts onboarding.

**Pinned releases.** The line above installs release tag `v1`, and re-running it never pulls newer, unreviewed changes. To move to a newer release on purpose: `curl -fsSL https://raw.githubusercontent.com/RAbuseedo/hermes-business-starter/v2/setup.sh | STARTER_REF=v2 bash`.

## Private repo install (if this repo is private)
Raw URLs do not work for private repos. Clone with a GitHub account that has access, then run the script from the checkout:
```
git clone --branch v1 https://github.com/RAbuseedo/hermes-business-starter.git ~/hermes-business-starter && bash ~/hermes-business-starter/setup.sh
```
(or download the ZIP from GitHub, unzip, and run `bash setup.sh` inside the folder).

## What gets installed
- `~/.hermes/starter/` this kit (pinned to a release tag)
- `~/.hermes/skills/business-starter/` the kit's skills
- `~/.hermes/SOUL.md` from `SOUL.template.md`, only if there is no custom SOUL yet (placeholders are filled during onboarding)
- `~/.hermes/notes/` starter notes (existing files are never overwritten)
- `~/.hermes/scripts/` helper scripts (existing files are never overwritten)

Options: `STARTER_REF=<tag>`, `STARTER_NO_LAUNCH=1`, `STARTER_DRY_RUN=1` (skip Hermes install and launch, for testing), `STARTER_SOURCE_DIR=<folder>`, `STARTER_REPO_URL=<url>`.

## Layout
- `setup.sh` bootstrap (idempotent)
- `SOUL.template.md` the chief-of-staff persona and hard lines
- `onboarding/` the owner onboarding script, accounts checklist, WhatsApp and phone-line options
- `skills/` owner-onboarding, agency-ops, company-profile, client-crm, daily-briefs, open-loops, owner-todos, secrets-intake, telegram-topics, comms-channels, agency-marketing, arabic-documents, mac-keep-alive, backup-to-drive, shared-screen-gate
- `scripts/` todos.py (pinned owner To-Do list in Telegram), chrome_gate.py (shared-screen gate), keep-alive-check.sh
- `templates/notes/` starter notes
- `profiles/` optional seed profiles with public information only

Hermes' bundled skills are used too, for example `google-workspace`, `email-inbox-triage`, `weekly-review-planning`, `meeting-action-items`, `document-to-action-items`, `pdf`, `docx`, `xlsx`, `powerpoint`, `humanizer`. Optional official skills suggested during onboarding: `official/productivity/telephony`, `official/creative/social-media-content-calendar`.

## Safety model
- Hermes never spends money, signs up for paid services, publishes, messages anyone other than the owner, shares credentials, deletes things, or signs anything without the owner's explicit OK.
- Only the owner (and delegates the owner names) can instruct Hermes. Staff and client messages are input, not commands.
- All secrets live in the owner's Bitwarden Secrets Manager. Hermes keeps only one access token locally. Never paste passwords in chat.

## Privacy
This repository contains no personal data, credentials, or company-internal information. Each owner's company profile, notes, and secrets are created on their own machine during onboarding and never leave it (except in the owner's own encrypted backup). The `profiles/` seeds contain public information only.

## License
MIT
