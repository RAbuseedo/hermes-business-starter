#!/usr/bin/env bash
# Hermes Business Starter: one-line bootstrap for a company owner's Mac.
#
#   curl -fsSL https://raw.githubusercontent.com/RAbuseedo/hermes-business-starter/v1/setup.sh | bash
#
# Safe to run again at any time (idempotent). It:
#   1. installs Hermes Agent with the official installer if `hermes` is missing
#   2. clones or updates this kit into ~/.hermes/starter, pinned to a reviewed release tag
#   3. installs the kit's skills into ~/.hermes/skills/business-starter/
#   4. installs SOUL.md from SOUL.template.md only if you have no custom SOUL.md yet
#   5. creates starter notes in ~/.hermes/notes/ (never overwrites existing ones)
#   6. launches Hermes with the onboarding prompt
#
# Environment knobs:
#   STARTER_DRY_RUN=1       skip the Hermes install and the final launch (for testing)
#   STARTER_NO_LAUNCH=1     do everything but do not launch Hermes at the end
#   STARTER_SOURCE_DIR=DIR  install from a local checkout instead of git (private-repo route)
#   STARTER_REPO_URL=URL    clone from a different URL (fork, or an authenticated URL)
#   STARTER_REF=NAME        release tag (or branch) to install. Default: v1, a reviewed tag.
#                           The machine never follows unreviewed changes: re-running only
#                           moves to a newer release when you change STARTER_REF on purpose.
#   HERMES_HOME=DIR         Hermes home (default: ~/.hermes)
#
# Everything lives inside main() so that `curl | bash` reads the whole file
# before running anything (stdin is the script itself).

set -euo pipefail

main() {
  local REPO_URL="${STARTER_REPO_URL:-https://github.com/RAbuseedo/hermes-business-starter.git}"
  local REF="${STARTER_REF:-v1}"
  local DRY="${STARTER_DRY_RUN:-0}"
  local NO_LAUNCH="${STARTER_NO_LAUNCH:-$DRY}"
  local HH="${HERMES_HOME:-$HOME/.hermes}"
  local KIT="$HH/starter"
  local SKILLS_DST="$HH/skills/business-starter"
  local NOTES="$HH/notes"
  local SRC="${STARTER_SOURCE_DIR:-}"
  local PROMPT="Start onboarding: read ~/.hermes/starter/onboarding/ONBOARDING.md and follow it with me step by step. Load the owner-onboarding skill first."

  say()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
  ok()   { printf '\033[1;32m ok\033[0m %s\n' "$*"; }
  warn() { printf '\033[1;33m !!\033[0m %s\n' "$*" >&2; }
  die()  { printf '\033[1;31mERR\033[0m %s\n' "$*" >&2; exit 1; }
  has_tty() { (: </dev/tty) 2>/dev/null; }

  # If this script is being run from inside a checkout (bash setup.sh), use that checkout.
  if [ -z "$SRC" ] && [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    local here
    here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [ -f "$here/SOUL.template.md" ] && [ "$here" != "$KIT" ]; then SRC="$here"; fi
  fi

  say "Hermes Business Starter"
  [ "$(uname -s)" = "Darwin" ] || warn "This kit is written for macOS. Continuing anyway."

  # 0. Command line tools (git). On a brand-new Mac, git is a stub that triggers this install.
  if ! xcode-select -p >/dev/null 2>&1 && [ "$DRY" != "1" ]; then
    say "Installing Apple's Command Line Tools (needed for git). A window will pop up: click Install."
    xcode-select --install >/dev/null 2>&1 || true
    die "When the Command Line Tools finish installing, paste the same line again."
  fi
  command -v git >/dev/null 2>&1 || die "git is missing. Install Apple's Command Line Tools: xcode-select --install"

  # 1. Hermes itself
  export PATH="$HOME/.local/bin:$PATH"
  if command -v hermes >/dev/null 2>&1; then
    ok "Hermes already installed ($(hermes --version 2>/dev/null | head -1 || echo unknown version))"
  elif [ "$DRY" = "1" ]; then
    warn "DRY RUN: skipping the Hermes install"
  else
    say "Installing Hermes Agent with the official installer (this takes a few minutes)."
    say "When it asks, pick your AI provider (Nous Portal or OpenRouter). You pay the provider directly."
    local tmp
    tmp="$(mktemp -t hermes-install)"
    curl -fsSL https://hermes-agent.nousresearch.com/install.sh -o "$tmp" || die "Could not download the Hermes installer. Check the internet connection."
    if has_tty; then bash "$tmp" </dev/tty; else bash "$tmp"; fi
    rm -f "$tmp"
    command -v hermes >/dev/null 2>&1 || die "Hermes install did not finish. Open a new Terminal window and paste the line again."
    ok "Hermes installed"
  fi

  # 2. The kit
  mkdir -p "$HH"
  if [ -n "$SRC" ]; then
    say "Installing the kit from local folder $SRC"
    mkdir -p "$KIT"
    rsync -a --delete --exclude '.git/' "$SRC/" "$KIT/"
  elif [ -d "$KIT/.git" ]; then
    say "Updating the kit in $KIT to release $REF"
    if git -C "$KIT" fetch --quiet --force --tags origin \
         && git -C "$KIT" fetch --quiet origin "$REF" 2>/dev/null; then
      if git -C "$KIT" rev-parse -q --verify "refs/tags/$REF" >/dev/null; then
        git -C "$KIT" checkout --quiet --force --detach "refs/tags/$REF"
      else
        git -C "$KIT" checkout --quiet --force --detach FETCH_HEAD
      fi
    else
      warn "Could not update the kit (offline, or '$REF' does not exist). Using the copy already on disk."
    fi
  else
    say "Downloading the kit (release $REF) to $KIT"
    [ -e "$KIT" ] && mv "$KIT" "$KIT.old.$(date +%Y%m%d%H%M%S)"
    git clone --quiet --depth 1 --branch "$REF" "$REPO_URL" "$KIT" \
      || die "Could not download the kit from $REPO_URL at $REF (private repo? see README: 'Private repo install')."
  fi
  if [ -d "$KIT/.git" ]; then
    ok "Kit at $(git -C "$KIT" describe --tags --always 2>/dev/null || echo "$REF")"
  fi
  ok "Kit ready in $KIT"

  # 3. Skills (kit-managed: re-running replaces them with the kit's version)
  mkdir -p "$SKILLS_DST"
  local d name n=0
  for d in "$KIT"/skills/*/; do
    [ -f "$d/SKILL.md" ] || continue
    name="$(basename "$d")"
    mkdir -p "$SKILLS_DST/$name"
    rsync -a --delete "$d" "$SKILLS_DST/$name/"
    n=$((n + 1))
  done
  ok "$n skills installed in $SKILLS_DST"

  # 4. SOUL.md: only when there is none, or when it is still the stock auto-seeded text.
  local soul="$HH/SOUL.md"
  if [ ! -s "$soul" ]; then
    cp "$KIT/SOUL.template.md" "$soul"
    ok "SOUL.md installed from the template (placeholders get filled during onboarding)"
  elif grep -q 'hermes-business-starter' "$soul"; then
    ok "SOUL.md already from this kit, left as is"
  elif [ "$(wc -c <"$soul" | tr -d ' ')" -lt 1500 ] && head -c 200 "$soul" | grep -qE '^(You are Hermes Agent|# Hermes Agent Persona)'; then
    cp "$soul" "$soul.stock.$(date +%Y%m%d%H%M%S)"
    cp "$KIT/SOUL.template.md" "$soul"
    ok "Stock SOUL.md replaced with the kit template (stock copy kept next to it)"
  else
    warn "You already have a custom SOUL.md. Left untouched. The kit template is at $KIT/SOUL.template.md"
  fi

  # 5. Notes (never overwrite)
  mkdir -p "$NOTES"
  local f
  for f in "$KIT"/templates/notes/*.md; do
    [ -f "$f" ] || continue
    if [ ! -e "$NOTES/$(basename "$f")" ]; then cp "$f" "$NOTES/"; fi
  done
  mkdir -p "$NOTES/onboarding"
  cp "$KIT"/onboarding/*.md "$NOTES/onboarding/"
  chmod +x "$KIT"/scripts/*.sh "$KIT"/scripts/*.py 2>/dev/null || true
  # Scheduled jobs may only run scripts under ~/.hermes/scripts: copy helpers there (never overwrite).
  mkdir -p "$HH/scripts"
  for f in "$KIT"/scripts/*; do
    [ -f "$f" ] || continue
    if [ ! -e "$HH/scripts/$(basename "$f")" ]; then cp "$f" "$HH/scripts/"; fi
  done
  ok "Notes ready in $NOTES"

  echo
  say "Setup done. Next: Hermes will walk you through onboarding, one step at a time."
  echo "    To start it yourself later, paste:  hermes chat -q \"$PROMPT\""
  echo

  # 6. Launch
  if [ "$NO_LAUNCH" = "1" ]; then
    warn "Not launching Hermes (STARTER_NO_LAUNCH/STARTER_DRY_RUN)."
    return 0
  fi
  if has_tty; then
    exec hermes chat -q "$PROMPT" </dev/tty
  else
    warn "No terminal attached. Open Terminal and paste the line above."
  fi
}

main "$@"
