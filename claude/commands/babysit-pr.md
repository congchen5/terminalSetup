---
description: Use when a PR has failing CI checks, flaky tests, or needs to be kept green after pushing
author: Cong Chen
---

You are running an automated PR fix loop. Your goal: keep the branch in sync with master and get all CI checks on the current PR to pass.

Track the current iteration number (start at 1) and print a short status line at the start of each loop:
```
--- Iteration <N> | commit: <short SHA> | <timestamp> ---
```

---

## Step 0 — Sync with master first

Before looking at test failures, make sure the branch is up to date. Run:

```
git fetch origin
git rev-list --count HEAD..origin/master
```

If the count is greater than 0, the branch is behind master and needs a rebase.

**If behind master:**
1. `git rebase origin/master`
2. **If there are conflicts:**
   - Run `git rebase --abort` immediately to restore the branch to a clean state
   - Report the conflicting files clearly
   - Stop — do NOT attempt to auto-resolve conflicts
3. If rebase succeeds: `git push --force-with-lease`
4. Report how many commits were pulled in from master.

**If up to date:** continue to Step 1.

---

## Step 1 — Get current check status

Run:
```
gh pr checks --json name,state,bucket,link
```

Parse the results into these buckets:
- **failed**: `bucket` is `fail`
- **pending**: `bucket` is `pending`
- **passed**: `bucket` is `pass` or `skipping`

**If ALL checks are pass/skipping → proceed to Step 1b to check bot comments before declaring done.**

**If there are NO failures (only pending):**
- Report what's still running and their links.
- Wait for them to finish:
  ```
  timeout 1800 gh pr checks --watch --interval 30 2>&1 | tail -20
  ```
  - If the watch exits with "no checks reported" or exits unexpectedly before all checks settled, wait 30 seconds and re-run `gh pr checks --json` to re-evaluate — don't assume done.
  - If the 1800s timeout is hit, report which checks are still pending and stop.
- Once it returns normally, go back to the top of Step 1 and re-evaluate.

**If there are failures → proceed to Step 2.**

---

## Step 1b — Check github-actions bot comments for red/yellow flags

Some bots (like `change-safety-check`) post results as **PR comments**, not as formal check statuses — so `gh pr checks` never sees them. Always check for these after checks settle.

Run:
```
CURRENT_SHA=$(git rev-parse HEAD)
PUSH_TIME=$(git log -1 --format="%aI")
gh pr view --json comments --jq '[.comments[] | select(.author.login == "github-actions")] | last | {body: .body, createdAt: .createdAt}'
```

**Staleness check**: Compare the comment's `createdAt` to `PUSH_TIME`. If the comment predates the current push by more than a few minutes, it's stale — wait 60 seconds and re-check before acting on it.

Scan the most recent `github-actions` comment for:
- 🔴 **RED** — a real issue that must be fixed (treat like a check failure, go to Step 2)
- 🟡 **YELLOW** — a warning worth reviewing; fix if there's clear actionable output
- 🟢 **GREEN** — all clean

**If the latest comment is all green → you're done. Print a final summary and stop.**

**If there are RED or YELLOW flags → treat them as failures and proceed to Step 2.**

---

## Step 2 — Diagnose each failed check

For each failed check, get the failure details based on its type:

### Buildkite failures (name contains "buildkite")

Extract the build number from the link URL (format: `https://buildkite.com/<org>/<pipeline>/builds/<number>`).

1. **Get annotations first** (most concise summary) — use the `mcp__claude_ai_Buildkite__list_annotations` tool with:
   - `organization_slug`: extracted from URL (e.g. `persona-identities-inc`)
   - `pipeline_slug`: extracted from URL (e.g. `web-pull-request`)
   - `build_number`: extracted from URL

2. **Check for flaky test retries** — if the annotation mentions "retry", "flaky", or the job was soft-failed, skip fixing and go back to watching. Flaky failures will resolve on the next push or re-run.

3. **Check for startup/dependency failures** — if logs show `Could not find <gem> in locally installed gems` or `Cannot find module`, this is a missing dependency after a rebase, not a code bug:
   - For missing gems: `docker compose run --rm --no-deps web bundle install`, then restart with `docker compose up -d web worker`
   - For missing JS packages: `docker compose exec vite yarn`
   - After resolving, go back to Step 1 (no code fix needed, no push needed)

4. **Get failed job details** — use `mcp__claude_ai_Buildkite__get_build` to list jobs, then for each failed job use `mcp__claude_ai_Buildkite__read_logs` to get the raw output.

5. **Search for specific error patterns** if needed — use `mcp__claude_ai_Buildkite__search_logs`.

Common Buildkite failure types and how to identify them from logs:
- **TypeScript (tsgo)**: look for `TS2xxx` error codes
- **oxfmt formatting**: look for "formatting" or "oxfmt" in the annotation
- **oxlint/eslint**: look for lint rule violations
- **RSpec**: look for `rspec` in job name; check annotation for failing spec paths
- **Vitest**: look for `vitest` in job name; check for failing test names
- **Rubocop**: look for cop names like `Style/`, `Layout/`, etc.
- **change-safety-check**: look for missing test coverage warnings

### GitHub Actions failures (link contains `github.com/actions/runs`)

This covers both **red** (failed) and **yellow** (neutral/warning) check states. Both need attention.

For each failed or warning GitHub Actions check:

1. **Extract the run ID** from the link URL (format: `.../runs/<run_id>/...`).

2. **Get a summary of what failed:**
   ```
   gh run view <run_id>
   ```

3. **Get the full failed log output:**
   ```
   gh run view <run_id> --log-failed
   ```

4. **If the check name gives a hint, look for it specifically:**
   - `commitlint` — commit message doesn't follow the required format (type, scope, subject). Fix the commit message via `git commit --amend`.
   - `check-rebase` — branch is behind master; handle in Step 0.
   - `impure-job-signature-commenter` / `routes-rb-changes-commenter` / `external-api-changes-commenter` / `flipper-changes-commenter` — these are auto-commenters, not blocking failures. If they're red, check the log but they usually don't require code changes.
   - `check` (lint/type check jobs) — look at the log for eslint, rubocop, or tsc errors.
   - `fail-merge-freeze` — the repo is in a merge freeze; nothing to fix in code, inform the user.
   - `fail-do-not-merge-label` — the PR has a do-not-merge label; inform the user.

5. **For yellow/neutral checks** (state `NEUTRAL` or bucket `fail` with a warning tone):
   - Treat these the same as failures — read the log and fix if there's actionable output.
   - Common sources: linting warnings promoted to errors, annotation bots flagging issues.

### Chromatic / UI visual diff failures

These require human review of visual diffs. Note the URL, tell the user they need to manually approve or fix the snapshots, and do not block on them. Only attempt to fix if you can identify a clear code cause from the check name or annotation.

---

## Step 3 — Fix the failures

Based on what you found, fix the code. Common fixes:

**TypeScript errors (tsgo)**
- Fix type errors in the relevant files.
- Remember: tsgo uses an excess property check — intermediate typed variables required for object literals with extra fields (don't use inline `as` casts on object literals).

**Formatting (oxfmt)**
```
yarn format
```

**Linting (oxlint/eslint)**
```
yarn lint:ox:fix front-end/path/to/file.tsx
```

**Commit message (commitlint)**
Use the `/using-git` skill for the correct format, then:
```
git commit --amend
```

**RSpec test failures**
- Read the failing spec and source files.
- Fix either the spec (if test is wrong) or the source (if behavior is wrong).
- Validate: `docker compose exec web bundle exec rspec --fail-fast spec/path/to/file_spec.rb`

**Vitest test failures**
- Read the failing spec and source files.
- Fix accordingly.
- Validate: `yarn vitest run --bail 1 --silent=true front-end/path/to/file.spec.tsx`

**Rubocop**
- Fix the flagged code style issues.
- Validate: `docker compose exec web bundle exec rubocop path/to/file.rb`

**change-safety-check (missing specs)**
- Add the missing test coverage the bot flagged.

---

## Step 4 — Validate locally before pushing

Run the fastest relevant local check for what you fixed:
- TypeScript changes: `yarn tsgo:check`
- Formatting: `yarn format` (idempotent, safe to run)
- Linting: `yarn lint:ox:fix <file>`
- RSpec: run the specific failing spec
- Vitest: run the specific failing test file

If a local check fails, fix it before pushing.

---

## Step 5 — Amend and push

Print what was fixed before pushing:
```
Fixed: <one-line summary of what was changed>
```

Then:
```
git add -A
git commit --amend --no-edit
git push --force-with-lease
```

---

## Step 6 — Wait and repeat

After pushing, the old check results are stale. New checks will be triggered.

1. Wait 30 seconds for GitHub to register the new checks.
2. Run: `timeout 1800 gh pr checks --watch --interval 30 2>&1 | tail -20`
3. If the watch exits with "no checks reported", wait 30s and poll with `gh pr checks --json` instead.
4. Once checks settle, increment the iteration counter and go back to Step 0.

---

## Important constraints

- **Never skip hooks** (`--no-verify`) or bypass signing.
- **Never force push to master**.
- **Don't fix what isn't broken** — only touch files related to the failures.
- **Chromatic visual diffs** require human approval — flag them and don't block on them.
- **Merge freeze / do-not-merge label** — inform the user, don't attempt to work around them.
- **Rebase conflicts** — always run `git rebase --abort` first, then stop and report.
- If you hit the same failure 3+ times without progress, stop and explain the situation to the user rather than looping forever.
