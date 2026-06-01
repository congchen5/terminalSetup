---
description: Use when the current branch needs to be pushed, synced with master, or a PR needs to be created
author: Cong Chen
---

Check if there is an existing PR for the current branch by running `gh pr view --json number,title,state 2>/dev/null`.

Then do the following based on the result:

**If a PR already exists:**
1. Stage all changes: `git add -A`
2. Amend the last commit: `git commit --amend --no-edit`
3. Force push to the remote branch: `git push --force-with-lease`

**If no PR exists:**
1. Stage all changes: `git add -A`
2. Create a commit — infer a clear, concise commit message from the staged changes
3. Push the branch: `git push -u origin HEAD`
4. Create a PR using `gh pr create --fill` — infer title and body from the branch name and commit

**After either case, sync with master:**
1. Fetch from origin: `git fetch origin`
2. Rebase onto master: `git rebase origin/master`
3. If there are rebase conflicts, stop and report them clearly rather than attempting to resolve automatically

Finally, print a short summary of what was done (PR link if created/updated, rebase result).
