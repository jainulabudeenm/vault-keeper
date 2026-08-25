#!/usr/bin/env bash
# One runnable check for the release gate. No framework on purpose.
set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="$HERE/../scripts/check-leaks.sh"
pass=0
fail=0

assert_exit() { # desc want_code root
  local desc="$1" want="$2" root="$3" got
  bash "$SCRIPT" "$root" >/dev/null 2>&1
  got=$?
  if [ "$got" -eq "$want" ]; then
    pass=$((pass + 1)); echo "ok   $desc"
  else
    fail=$((fail + 1)); echo "FAIL $desc (want exit $want, got $got)"
  fi
}

mkfixture() {
  local d
  d="$(mktemp -d)"
  mkdir -p "$d/skills/demo" "$d/commands"
  echo "# Demo skill" > "$d/skills/demo/SKILL.md"
  echo "run the demo" > "$d/commands/demo-init.md"
  echo "# Example profile" > "$d/profile.example.md"
  echo "# Readme" > "$d/README.md"
  echo "$d"
}

R="$(mkfixture)"
assert_exit "clean tree passes" 0 "$R"

R="$(mkfixture)"
echo "buy a K380 keyboard" >> "$R/skills/demo/SKILL.md"
assert_exit "gear leak in skill body fails" 1 "$R"

R="$(mkfixture)"
echo "read 02-areas/finance/ledger.md" >> "$R/skills/demo/SKILL.md"
assert_exit "vault path in skill body fails" 1 "$R"

R="$(mkfixture)"
echo "authorized by ledger D23" >> "$R/skills/demo/SKILL.md"
assert_exit "ledger ref in skill body fails" 1 "$R"

R="$(mkfixture)"
echo "route this to porter-work instead" >> "$R/commands/demo-init.md"
assert_exit "employer ref in command fails" 1 "$R"

R="$(mkfixture)"
echo "monthly discretionary: 40000" >> "$R/profile.example.md"
echo "his name is Zain" >> "$R/profile.example.md"
assert_exit "name in example profile fails" 1 "$R"

R="$(mkfixture)"
echo "Built and maintained by Zain." >> "$R/README.md"
assert_exit "author name in README allowed" 0 "$R"

R="$(mkfixture)"
echo "/plugin marketplace add jainulabudeenm/vault-keeper" >> "$R/skills/demo/SKILL.md"
assert_exit "github handle allowed in skill body" 0 "$R"

R="$(mkfixture)"
printf 'A sentence %s with an em dash.\n' "$(printf '\xe2\x80\x94')" >> "$R/README.md"
assert_exit "em dash in README fails" 1 "$R"

R="$(mkfixture)"
printf 'A skill line %s like this.\n' "$(printf '\xe2\x80\x94')" >> "$R/skills/demo/SKILL.md"
assert_exit "em dash in skill body fails" 1 "$R"

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
