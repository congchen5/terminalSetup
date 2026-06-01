---
description: Create a new git worktree for a new feature branch and print the command to open Claude there
author: Cong Chen
---

Create a new git worktree for a new feature branch.

## Step 1 — Get the feature description

If the user provided a description after the command (e.g. `/new-worktree add selfie detection support`), use that as the feature description.

If no description was provided, ask: "What are you working on?" and wait for their answer.

## Step 2 — Generate the branch name

Using the feature description, generate a branch name following Persona's convention:

**Format**: `congchen/YYYY-MM-DD/short-description`

- `congchen` — the username prefix (always this for this user)
- `YYYY-MM-DD` — today's date
- `short-description` — 3-6 words from the feature description, lowercase, hyphenated, no filler words

Run `date +%Y-%m-%d` to get today's date.

Example: "add selfie custom detection support" → `congchen/2026-03-25/selfie-custom-detection`

Show the user the generated branch name and ask: "Does this look right, or would you like a different name?"

## Step 3 — Pick a worktree directory

Worktrees live at `~/persona/persona-web-N` where N is the next available slot number.

Check which slots exist:
```
ls -d ~/persona/persona-web-* 2>/dev/null
```

Pick the lowest N (starting at 2) that doesn't already exist. If `persona-web-2` is taken, use `persona-web-3`, etc.

## Step 4 — Create the worktree and branch

```
git worktree add ~/persona/persona-web-<N> -b <branch-name>
```

## Step 5 — Print the launch command

Tell the user:

```
✅ Worktree created at ~/persona/persona-web-<N> on branch <branch-name>

Open a new terminal and run:
  claude ~/persona/persona-web-<N>

Or if you use the Claude desktop app, open a new window pointed at that directory.
```

Also remind them: when done with this feature, clean up with:
```
git worktree remove ~/persona/persona-web-<N>
git branch -d <branch-name>   # only after the PR is merged
```
