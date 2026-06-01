---
description: Use when you need to test the current worktree branch in the local OrbStack dev environment
author: Cong Chen
---

Test the current branch's changes in the OrbStack dev environment running in the root repo.

## Step 1 — Determine the root repo path

Get the current working directory and extract the repo name. If it follows the pattern `<repo-name>-N` (e.g., `persona-web-2`, `persona-web-3`), strip the `-N` suffix to get the root repo name (e.g., `persona-web`). The root repo lives as a sibling directory at the same parent path.

```bash
CURRENT_DIR="$(pwd)"
PARENT_DIR="$(dirname "$CURRENT_DIR")"
DIR_NAME="$(basename "$CURRENT_DIR")"

# Strip trailing -N (where N is one or more digits) to get root repo name
ROOT_NAME="$(echo "$DIR_NAME" | sed 's/-[0-9]*$//')"
ROOT_REPO="$PARENT_DIR/$ROOT_NAME"
```

If `ROOT_NAME` equals `DIR_NAME` (no `-N` suffix), tell the user they're already in the root repo and there's nothing to fetch — just restart the Rails server directly (skip to Step 3).

Verify the root repo exists:
```bash
ls "$ROOT_REPO/.git" > /dev/null 2>&1
```

If it doesn't exist, report the error and stop.

## Step 2 — Fetch the current branch into the root repo

Get the current branch name, then fetch and checkout in the root repo.

**Important**: The current directory may be a git worktree of the root repo. Git does not allow the same branch to be checked out in two worktrees simultaneously. To handle this, always use detached HEAD mode:

```bash
BRANCH="$(git rev-parse --abbrev-ref HEAD)"

cd "$ROOT_REPO"
git fetch origin "$BRANCH"
git checkout --detach "origin/$BRANCH"
```

This avoids the "already used by worktree" error and puts the root repo at exactly the right commit.

Print which branch/commit was checked out and in which directory.

## Step 3 — Restart the Rails server in OrbStack

```bash
cd "$ROOT_REPO"
docker compose restart web
```

Rails typically takes 20-30 seconds to boot. Wait, then verify:
```bash
sleep 25
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/dashboard/login
```

- `200` or `302` — server is up, ready for testing
- `000` — not ready yet, wait another 15 seconds and retry once
- Other — show `docker compose logs --tail=20 web` and report

## Step 4 — Summary

Print:
- Root repo path
- Branch/commit checked out (note it's detached HEAD)
- Rails server status
- Reminder: dashboard is at `http://localhost:3000/dashboard/login`
