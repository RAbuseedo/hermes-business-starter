#!/usr/bin/env bash
# Read-only health check for an always-on Hermes Mac. Changes nothing.
set -u
line() { printf '%-28s %s\n' "$1" "$2"; }
pm="$(pmset -g 2>/dev/null || true)"
s="$(printf '%s\n' "$pm" | awk '$1=="sleep"{print $2}')"
[ "${s:-x}" = "0" ] && line "System sleep" "OK (never)" || line "System sleep" "FIX: sleeps after ${s:-?} min -> sudo pmset -c sleep 0"
a="$(printf '%s\n' "$pm" | awk '$1=="autorestart"{print $2}')"
[ "${a:-0}" = "1" ] && line "Restart after power cut" "OK" || line "Restart after power cut" "FIX: sudo pmset -c autorestart 1"
fv="$(fdesetup status 2>/dev/null || echo unknown)"
line "FileVault" "$fv"
al="$(defaults read /Library/Preferences/com.apple.loginwindow autoLoginUser 2>/dev/null || echo off)"
line "Automatic login" "$al"
if command -v hermes >/dev/null 2>&1; then
  if hermes gateway status 2>/dev/null | grep -qiE 'running|supervised|PID [0-9]+'; then line "Hermes gateway" "OK (running)"; else line "Hermes gateway" "CHECK: hermes gateway status"; fi
else
  line "Hermes" "not installed"
fi
free="$(df -g "$HOME" 2>/dev/null | awk 'NR==2{print $4}')"
[ "${free:-0}" -ge 20 ] && line "Free disk" "OK (${free} GB)" || line "Free disk" "LOW (${free:-?} GB)"
