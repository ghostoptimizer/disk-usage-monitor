#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/../config/config.env"
mkdir -p "$(dirname "$LOG_FILE")"

# ── Portable disk-usage check ───────────────────────────────────────────────
if df --help 2>&1 | grep -q -- '--output'; then
  # GNU df (Linux)
  USAGE=$(df --output=pcent / | tail -1 | tr -dc '0-9')
else
  # BSD df (macOS) or other POSIX df
  USAGE=$(df -P / | tail -1 | awk '{print $5}' | tr -dc '0-9')
fi

if (( USAGE >= THRESHOLD )); then
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  MESSAGE="⚠️ Disk usage at ${USAGE}% (threshold: ${THRESHOLD}%) on $(hostname) at ${TIMESTAMP}"
  echo "$MESSAGE" >> "$LOG_FILE"
  printf "%s\n" "$MESSAGE" | mail -s "Disk Usage Alert: ${USAGE}% used" "$EMAIL"
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') - All usage within limits ($USAGE% < ${THRESHOLD}%)" \
    >> "$LOG_FILE"
fi
