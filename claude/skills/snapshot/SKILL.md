---
name: snapshot
description: Use when the session is long, a milestone was reached, complex state would be painful to reconstruct, context pressure is building, the user is switching topics, or the user asks to save context or checkpoint.
author: Cong Chen
---

# Proactive Session Snapshots

Save session context to persistent memory so a future Claude instance can continue where this one left off. Tell the user briefly:

> "Let me save a snapshot of where we are so we don't lose context."

Then:

1. **Determine topic slug** — infer from the conversation (2-4 words, lowercase, hyphenated)
2. **Extract context** — goals, decisions, current state, file paths, gotchas, next steps
3. **Check for existing file** — read and merge if it exists at:
   ```
   ~/.claude/projects/<project-slug>/memory/<slug>.md
   ```
4. **Write the snapshot** with these sections (omit empty ones):
   - Overview
   - Current Status
   - Key Context
   - Decisions & Constraints
   - Gotchas & Learnings
   - Next Steps
5. **Update MEMORY.md** — add/update a brief entry with link to the snapshot file
6. **Confirm** — tell the user what was saved (1-2 lines)

## Rules

- **Don't over-snapshot** — once per major milestone or topic, not after every small action
- **Don't interrupt flow** — wait for a natural pause
- **Merge, don't duplicate** — update existing snapshot files rather than creating new ones
- **Keep MEMORY.md lean** — entries are 2-3 lines max with a link to the full snapshot
