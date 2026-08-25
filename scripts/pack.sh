#!/usr/bin/env bash
# Rebuild the .skill bundles from the skills/ folders.
# The folders are the source of truth. The .skill zips are what npx installs.
# Run this after editing anything under skills/.
set -euo pipefail

cd "$(dirname "$0")/.."

for name in vault-groom vault-capture vault-save-chat; do
  rm -f "skills/$name.skill"
  (cd skills && zip -qrD "$name.skill" "$name" -x '.*' -x '*/.*')
  echo "packed skills/$name.skill"
  unzip -Z1 "skills/$name.skill" | sed 's/^/  /'
done
