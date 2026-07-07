#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

COMMIT_MSG="${1:-chore: publish latest site updates}"

git add -A

if git diff --cached --quiet; then
  echo "No file changes to commit."
else
  git commit -m "$COMMIT_MSG"
fi

env -u http_proxy -u https_proxy -u all_proxy \
  git -c http.proxy= -c https.proxy= \
  push https://github.com/ZhiweiWang/zhiweiwang.github.io.git main

echo
echo "Push complete: $(git rev-parse --short HEAD)"
echo "Check deployment status: https://github.com/ZhiweiWang/zhiweiwang.github.io/actions"