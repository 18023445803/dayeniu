#!/usr/bin/env bash
# One-click push helper for the YSYX E/F knowledge base.
#
# Usage (from Git Bash):
#   ./push-to-github.sh <your-github-username> [repo-name] [public|private]
#
# Examples:
#   ./push-to-github.sh octocat
#   ./push-to-github.sh octocat ysyx-ef-knowledge-base private
#
# Prerequisites (pick ONE):
#   A) GitHub CLI:  gh auth login          (then this script auto-creates the repo)
#   B) HTTPS + PAT: create a Personal Access Token with "repo" scope at
#                   https://github.com/settings/tokens
#                   and create an EMPTY repo on github.com first.
#                   When git prompts for password, paste the token (not your password).
#
# This script never hardcodes or stores any token.

set -euo pipefail
cd "$(dirname "$0")"

USER_NAME="${1:-18023445803}"
REPO_NAME="${2:-dayeniu}"
VISIBILITY="${3:-private}"

echo "[target] https://github.com/${USER_NAME}/${REPO_NAME}  (${VISIBILITY})"
echo "[tips] If github.com is slow/blocked, start Clash Verge and enable system proxy first."

if [[ "$VISIBILITY" != "public" && "$VISIBILITY" != "private" ]]; then
  echo "ERROR: visibility must be 'public' or 'private'" >&2
  exit 1
fi

git branch -M main
git remote remove origin 2>/dev/null || true

if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  echo "[mode] GitHub CLI detected - creating ${VISIBILITY} repo ${USER_NAME}/${REPO_NAME} ..."
  gh repo create "${USER_NAME}/${REPO_NAME}" "--${VISIBILITY}" \
    --source=. --remote=origin --push
  echo "[done] Pushed to https://github.com/${USER_NAME}/${REPO_NAME}"
else
  echo "[mode] No GitHub CLI session - using HTTPS + Personal Access Token."
  echo ">>> FIRST: create an EMPTY repo named '${REPO_NAME}' at https://github.com/new"
  echo ">>> Then paste your Personal Access Token when git asks for a password."
  read -r -p "Press Enter to continue once the empty repo exists on GitHub... "
  git remote add origin "https://github.com/${USER_NAME}/${REPO_NAME}.git"
  git push -u origin main
  echo "[done] Pushed to https://github.com/${USER_NAME}/${REPO_NAME}"
fi
