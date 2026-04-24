#!/usr/bin/env bash
# Push the ICP-Builder folder to a new public GitHub repo called `icp-builder`.
# Requires: git and gh (GitHub CLI) installed, and `gh auth login` already done.

set -e

cd "$(dirname "$0")"

# Clean any python bytecode / mac metadata before first commit
find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
find . -name ".DS_Store" -delete 2>/dev/null || true

# Confirm gh auth
if ! gh auth status >/dev/null 2>&1; then
  echo "gh is not authenticated. Run: gh auth login"
  exit 1
fi

# Init git if needed
if [ ! -d .git ]; then
  git init -b main
fi

git add .
git commit -m "Initial commit: ICP Builder skill" || echo "Nothing to commit."

# Create repo + push. If repo already exists, just push.
if gh repo view icp-builder >/dev/null 2>&1; then
  OWNER=$(gh api user --jq .login)
  git remote remove origin 2>/dev/null || true
  git remote add origin "https://github.com/${OWNER}/icp-builder.git"
  git branch -M main
  git push -u origin main
else
  gh repo create icp-builder --public --source=. --remote=origin --push \
    --description "ICP Builder — a Claude skill for turning a raw account list into a graded, sized, territory-ready book of business."
fi

OWNER=$(gh api user --jq .login)
echo ""
echo "Done. Repo: https://github.com/${OWNER}/icp-builder"
