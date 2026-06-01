---
description: Use when assigned a Jira bug ticket that needs investigation, a fix, and a PR
author: Cong Chen
---

Fix a Jira bug from ticket to merged PR.

## Step 1 — Read the full Jira ticket

Use the Atlassian MCP tools to fetch the issue by key (e.g. `VULN-2153`).

- Read the description, all comments, and all linked issues
- Open and read every URL referenced in the ticket (docs, logs, dashboards, other tickets)
- If there are attachments or screenshots, review those too
- Extract: what is the reported problem, who reported it, what is the severity/priority, and any reproduction steps

## Step 2 — Investigate the relevant code

Trace the issue to its root cause in the codebase:

- Follow the thread from the bug report into the code — find the affected files, methods, and code paths
- Understand the surrounding architecture and how the affected code fits into the broader system
- Identify the full scope of what needs to change (including tests, related files, and downstream effects)
- Load any relevant skills for the area of code you're working in (see CLAUDE.md for the skill loading rules)

## Step 3 — Explain the problem

Present the issue clearly with specific codebase references:

- What is broken or missing, in plain terms
- Which files, methods, and lines are involved
- Why it's happening (root cause)
- What the fix looks like at a high level

This is for shared understanding — make sure we both agree on what the problem is before moving to a solution.

## Step 4 — Discuss until aligned

Open the floor for follow-up questions. Iterate on the plan:

- Answer questions, explore alternatives, address concerns
- Refine the approach based on feedback
- **Do NOT start implementing until the user explicitly approves the plan**

## Step 4b — Record the plan in Jira

Once the plan is agreed upon, **add a comment to the Jira ticket** documenting:

- The root cause analysis
- The agreed-upon plan (numbered steps if multi-PR)
- Any relevant context or trade-offs discussed

This creates a paper trail so that:
- If the fix spans multiple PRs, each step is tracked
- Future engineers can understand what was done and why
- The ticket stays current as a single source of truth

As each step in the plan is completed (PR merged, monitor created, etc.), **add a follow-up comment** to the Jira ticket with:
- What was done
- Links to the relevant PR(s)
- What remains (if anything)

## Step 5 — Implement the fix

Once approved:

- Make the code changes
- Write or update tests as needed
- Run targeted validation (tests, linting, type checks) on changed files

## Step 6 — Review

Run `/review-pr` to self-review before sending to human reviewers. This triggers `/review-squad` (6+ reviewer agents), addresses findings, and iterates until all reviewers approve.

## Step 7 — Summary and Jira update

Provide a final summary:

- What the issue was
- What changed (files, methods) and why
- Any risks or things to watch for after deploy
- PR URL

**Update the Jira ticket** with a comment linking the PR and summarizing what was addressed. If there are remaining steps in the plan, note what's left.
