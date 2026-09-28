---
name: backup-to-drive
description: "Use when setting up or testing the encrypted nightly backup."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [backup, restic, google-drive, disaster-recovery]
    related_skills: [secrets-intake, mac-keep-alive]
---

# Backup to Google Drive (restic)

Nightly encrypted backup of `~/.hermes` (notes, skills, config, sessions; excluding caches) to the owner's Google Drive. Restorable onto a new Mac in under an hour.

## Setup (with the owner's OK; all free)
1. Install tools (user-level, no admin): restic and rclone via Homebrew if present (`brew install restic rclone`), otherwise download the official release binaries into `~/.local/bin`.
2. Google Drive remote: `rclone config` → new remote `gdrive` → Google Drive → scope `drive.file` → browser sign-in by the owner (open a human window first).
3. Repository password: generate a long random password in a script, store it in Bitwarden as `RESTIC_PASSWORD` (never printed), and ask the owner to write it on paper and keep it in the office safe. Without it the backup cannot be opened by anyone, including us.
4. `export RESTIC_REPOSITORY=rclone:gdrive:hermes-backup` and `restic init`.
5. Nightly job (cron, silent on success): `restic backup ~/.hermes --exclude ~/.hermes/cache --exclude '*.log' --exclude ~/.hermes/hermes-agent` then `restic forget --keep-daily 14 --keep-weekly 8 --keep-monthly 12 --prune` weekly.
6. Test restore now: `restic restore latest --target ~/.hermes/cache/scratch/restore-test --include ~/.hermes/notes` and compare file counts; delete the scratch copy.

## Monthly
`restic check` and a small restore test; report size and last successful backup time in the brief. Alert immediately if a nightly run fails twice.

## Restore on a new Mac
Install Hermes (the kit line), install restic+rclone, sign in rclone to the same Drive, set `RESTIC_PASSWORD` from Bitwarden or the paper copy, `restic restore latest --target /`, then `hermes gateway install`.
