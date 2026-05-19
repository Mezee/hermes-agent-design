#!/usr/bin/env bash
set -euo pipefail

query="${*:-Hermes Agent}"

if command -v ctx7 >/dev/null 2>&1; then
  exec ctx7 skills search "$query"
fi

if command -v npx >/dev/null 2>&1; then
  exec npx ctx7 skills search "$query"
fi

echo "ctx7 CLI is not available."
echo "Install Context7 CLI or use the Context7 plugin to search for Hermes skills."
echo "Suggested query: $query"
