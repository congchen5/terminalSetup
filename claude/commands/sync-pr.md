---
description: Use when another PR's branch is behind master and needs a rebase without leaving your current branch
author: Cong Chen
---

Sync another PR's branch with master without losing your place.

**ARGUMENTS**: The user will provide a PR number, PR URL, or branch name.

## Step 1 — Save current branch

```bash
git rev-parse --abbrev-ref HEAD
```

Save this so we can return to it at the end.

## Step 2 — Resolve the target branch

- If given a PR number or URL, extract the branch name: `gh pr view <number> --json headRefName --jq .headRefName`
- If given a branch name directly, use it as-is

## Step 3 — Check for uncommitted changes

Run `git status --porcelain`.

If there are uncommitted changes, **STOP** and warn the user — they need to commit or stash first.

## Step 4 — Fetch and checkout the target branch

```bash
git fetch origin <branch>
git checkout <branch>
```

## Step 5 — Sync with master

1. Check for local changes: `git status --porcelain`
2. If there are changes, stage and amend: `git add -A && git commit --amend --no-edit`
3. Fetch and rebase: `git fetch origin && git rebase origin/master`
4. If there are rebase conflicts, run `git rebase --abort`, switch back to the original branch, and report the conflicts clearly — do NOT attempt to resolve them
5. Force push: `git push --force-with-lease`

## Step 6 — Return to original branch

```bash
git checkout <original-branch>
```

## Step 7 — Summary

Print:
- Which PR/branch was synced
- How many commits were picked up from master (if any)
- New commit SHA
- Confirmation that you're back on the original branch
