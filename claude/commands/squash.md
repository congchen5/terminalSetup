---
description: Squash all commits on this branch into a single commit, then force-push
author: Cong Chen
---

Squash all commits on the current branch down to a single commit.

## Steps

1. **Find the merge base** — the point where this branch diverged from master:
   ```
   git merge-base HEAD origin/master
   ```

2. **Count how many commits will be squashed:**
   ```
   git rev-list --count $(git merge-base HEAD origin/master)..HEAD
   ```
   Report this number to the user before proceeding. If there is only 1 commit, say so and stop — nothing to do.

3. **Read all commits and diffs** to understand the full scope of changes:
   ```
   git log --reverse $(git merge-base HEAD origin/master)..HEAD --format="%H %s%n%b"
   git diff $(git merge-base HEAD origin/master)..HEAD --stat
   ```

4. **Soft-reset to the merge base**, staging all changes without losing them:
   ```
   git reset --soft $(git merge-base HEAD origin/master)
   ```

5. **Craft the commit message** by loading the `/using-git` skill and following its commit message format exactly. Use the *oldest* commit's `type(scope):` prefix for the subject line. Synthesize all sections from everything across all commits.

   The `/using-git` skill is the source of truth for commit message structure, required sections, valid types, severity levels, and how to use `-F - <<'EOF'`. Always defer to it — do not hardcode the format here.

6. **Force-push:**
   ```
   git push --force-with-lease
   ```

7. Report: how many commits were squashed, the final commit message, and the push result.

## Constraints
- Never squash into master/main.
- Never use `--no-verify`.
- Follow the `/using-git` skill for commit message format, including how to invoke `git commit`.
