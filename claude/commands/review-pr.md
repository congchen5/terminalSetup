---
description: Use when a PR is ready for review, before requesting human reviewers, or when asked to review the current PR
author: Cong Chen
---

Run the company's review agents against the current PR, fix issues, and iterate until clean.

## Step 1 — Gather PR context

Run these in parallel:
```
gh pr view --json number,title,url,body
gh pr diff
git log origin/master..HEAD --oneline
```

Capture the PR number, title, URL, diff, and commit list.

## Step 2 — Run `/review-squad`

Launch the `/review-squad` skill to run the full team of Persona reviewer agents (backend, Rails, frontend, security, reliability, product — plus domain-specific reviewers when file patterns match).

Wait for all reviewer verdicts.

## Step 3 — Address review findings

For each finding across all reviewers:
- **BLOCKS MERGE**: Must fix before proceeding
- **SHOULD FIX**: Fix unless there's a clear reason not to (note why if skipping)
- **SUGGESTIONS**: Apply if they're quick wins, otherwise note for later

After addressing findings, run any relevant local validation (tests, linting) on changed files.

## Step 4 — Re-run non-approving reviewers until all approve

Track which reviewers gave an APPROVE verdict. If any fixes were made in Step 3, re-run `/review-squad` with only the reviewers that did NOT approve (pass their keywords to scope the run). Reviewers who already approved do not need to review again.

Repeat Steps 3-4 until every reviewer has returned an **APPROVE** verdict. Do not proceed until all reviewers approve.

## Step 5 — Push changes

If any changes were made during the review loop:
```
git add -A
git commit --amend --no-edit
git push --force-with-lease
```

## Step 6 — Report

Print a summary:
- PR URL
- Number of review iterations completed
- Summary of changes made (if any)
- Final verdicts from each reviewer
- "PR is ready for human review"
