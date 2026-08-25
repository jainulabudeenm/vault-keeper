#!/usr/bin/env bash
# Release gate. Two checks:
#   1. No personal data in text that ships as skill behavior.
#   2. No em dashes in any markdown, per the project's published-prose rule.
# Usage: check-leaks.sh [root]   (default: the repo containing this script)
set -uo pipefail

ROOT="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
status=0

# Scoped on purpose. README, LICENSE and .claude-plugin/ are excluded because
# author attribution legitimately carries the maintainer's name and handle.
# ponytail: find-based globbing, fine at this repo size.
scoped_files() {
  find "$ROOT/skills" "$ROOT/commands" -name '*.md' -type f 2>/dev/null
  find "$ROOT" -maxdepth 1 -name '*.md' -not -name 'README.md' -type f 2>/dev/null
  return 0
}

all_markdown() {
  find "$ROOT" -name '*.md' -type f -not -path '*/.git/*' 2>/dev/null
  return 0
}

# 'jainulabudeenm' is deliberately NOT here. It contains 'jainulabudeen', so
# denying that string would match the handle and fail every install instruction.
# The email is matched instead, which is unambiguous.
# ponytail: D[0-9]+ is unanchored, so a token like HD1080 would false-positive.
# Acceptable at this scale; anchor it if a real hit ever shows up.
DENY='Porter|porter-work|theporter\.in|m\.jainulabudeen|₹|K380|Pixel|Bengaluru|Careem|02-areas/|01-projects/|D[0-9]+|Zain'

while IFS= read -r f; do
  [ -n "$f" ] || continue
  if hits="$(grep -nE "$DENY" "$f")"; then
    echo "LEAK  $f"
    printf '%s\n' "$hits" | sed 's/^/        /'
    status=1
  fi
done < <(scoped_files)

while IFS= read -r f; do
  [ -n "$f" ] || continue
  if hits="$(grep -n "$(printf '\xe2\x80\x94')" "$f")"; then
    echo "EMDASH  $f"
    printf '%s\n' "$hits" | sed 's/^/        /'
    status=1
  fi
done < <(all_markdown)

[ "$status" -eq 0 ] && echo "check-leaks: clean"
exit "$status"
