---
description: "Save a context snapshot of the current session to memory so a future Claude instance can continue where we left off. Use /snapshot or /snapshot <topic>. Use when switching contexts, before restarting, running low on context, or anytime you want to checkpoint progress."
author: Cong Chen
---

# Session Snapshot

Save the current session's context to a persistent memory file so a new Claude instance can pick up exactly where this one left off.

## Step 1 — Determine the topic

If the user provided a topic argument (e.g. `/snapshot x-age-pipeline`), use that as the filename slug.

If no topic was provided, infer the primary topic from the conversation. Pick a short, descriptive slug (2-4 words, lowercase, hyphenated). Examples: `x-age-pipeline-run`, `jira-model-upgrade`, `pr-review-rate-limits`.

## Step 2 — Gather context from the conversation

Review the full conversation and extract:

1. **What we're doing** — the high-level goal or project
2. **Key decisions made** — important choices, trade-offs, or constraints established
3. **Current state** — what's been completed, what's in progress
4. **Important details** — file paths, directory structures, URLs, IDs, names, configurations, formats, commands used
5. **Gotchas & learnings** — anything non-obvious that came up (bugs, workarounds, format quirks, validation rules)
6. **Next steps** — what was about to happen or what the user said they'd do next

## Step 3 — Check for existing memory file

Look in the memory directory for an existing file matching the topic:

```
/Users/congchen/.claude/projects/-Users-congchen-persona/memory/<slug>.md
```

- If it exists, **read it first** and update it with the new context — merge, don't duplicate.
- If it doesn't exist, create a new file.

## Step 4 — Write the snapshot

Write the memory file with this structure:

```markdown
# <Topic Title>

## Overview
<1-3 sentences: what this is about and the high-level goal>

## Current Status
<What's done, what's in progress, what's blocked>

## Key Context
<Important details a new Claude instance needs: file paths, structures, IDs, URLs, formats, commands, configurations>

## Decisions & Constraints
<Key decisions made, trade-offs, rules established>

## Gotchas & Learnings
<Non-obvious things that came up — validation quirks, workarounds, format issues>

## Next Steps
<What to do next, in priority order>
```

Keep it **concise but complete** — a new Claude instance should be able to read this file and immediately understand the full context without asking the user to re-explain anything.

Omit any section that has nothing relevant (e.g. if there are no gotchas, skip that section).

## Step 5 — Update MEMORY.md

Read `/Users/congchen/.claude/projects/-Users-congchen-persona/memory/MEMORY.md`.

- If the topic is already referenced there, update the entry if the status changed.
- If not, add a short entry (2-3 lines max) with a link to the snapshot file.

Do NOT bloat MEMORY.md — it has a 200-line soft limit. Keep entries brief.

## Step 6 — Confirm

Tell the user:
- The file path that was written/updated
- A 2-3 line summary of what was captured
- Remind them the snapshot will be auto-loaded in future sessions
