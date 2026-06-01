---
description: Use when starting a new PR or task from a clean slate on latest master
author: Cong Chen
---

Create a fresh branch based on the latest origin/master for starting new PR work.

## Step 1 — Check for uncommitted changes

Run `git status --porcelain` in the current worktree.

If there are ANY uncommitted changes (staged, unstaged, or untracked files that look intentional):
- **STOP** and warn the user: "You have uncommitted changes. Please commit or stash them before creating a fresh branch."
- List the changed files so they can see what's pending.
- **Do NOT proceed** until the working tree is clean.

## Step 2 — Ask what the PR is about

Ask the user: **"What's the gist of this PR?"**

Wait for their response.

- If they provide a description, use it to generate the branch name in Step 3.
- If they provide nothing (empty input / just hit enter), use a generic name: `congchen/YYYY-MM-DD/wip`

## Step 3 — Generate the branch name

**Format**: `congchen/YYYY-MM-DD/short-description`

- `congchen` — always this prefix
- `YYYY-MM-DD` — today's date (run `date +%Y-%m-%d`)
- `short-description` — 3-6 words from their description, lowercase, hyphenated, no filler words

Show the user the generated branch name and ask: **"Does this branch name look good?"**

If they want changes, adjust accordingly. If they confirm (or just hit enter), proceed.

## Step 4 — Fetch latest master and create the branch

Run these commands in sequence:

```bash
git fetch origin master
```

Then create the new branch from the fetched master tip:

```bash
git checkout -b <branch-name> origin/master
```

This ensures the branch starts from the latest remote master with zero local changes carried over.

## Step 5 — Confirm

Show the user:

```
Branch <branch-name> created off latest origin/master.
Ready to work.
```
