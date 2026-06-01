---
name: skill-authoring
description: Use when creating a new skill, editing an existing skill, or reviewing a skill's frontmatter and description for correctness
author: Cong Chen
---

# Skill Authoring

## Overview

Skills are reusable reference guides for techniques, patterns, or tools. They live in `~/.claude/skills/<skill-name>/SKILL.md`.

## Frontmatter

Required fields: `name` and `description` (max 1024 chars total). Optional: `author`.

```yaml
---
name: kebab-case-name
description: Use when [triggering conditions only]
author: Cong Chen
---
```

- `name`: letters, numbers, hyphens only. Active voice, descriptive (`skill-authoring` not `skill-creation`)
- `description`: starts with "Use when...", third-person, under 500 characters
- `author`: always include to track ownership. Use for commands (`~/.claude/commands/`) too

## CSO (Claude Search Optimization)

**The most important rule:** Description = triggering conditions ONLY. Never summarize the workflow.

When a description summarizes what the skill does, Claude uses the description as a shortcut and skips reading the full skill body. This causes Claude to follow a simplified version instead of the actual instructions.

```yaml
# BAD — summarizes workflow, Claude will shortcut
description: Use when executing plans - dispatches subagent per task with code review between tasks

# GOOD — triggering conditions only, Claude reads the full skill
description: Use when executing implementation plans with independent tasks in the current session
```

**Keywords:** Use words Claude would search for — error messages, symptoms, synonyms, tool names.

## Structure

```markdown
# Skill Name

## Overview
Core principle in 1-2 sentences.

## When to Use
Symptoms, use cases, when NOT to use.

## Core Pattern / Quick Reference
Tables or bullets for scanning.

## Implementation
Inline code for simple patterns. Separate file for heavy reference (100+ lines).

## Common Mistakes
What goes wrong + fixes.
```

Omit empty sections. Keep skills concise (<500 words for most skills).

## Token Efficiency

Skills load into every conversation where they're triggered. Every token counts.

- Move detailed flag/option docs to `--help` references
- Cross-reference other skills instead of repeating their content
- One excellent example beats many mediocre ones
- Choose the most relevant language for examples, don't implement in multiple languages

## File Organization

```
skills/
  skill-name/
    SKILL.md              # Main reference (required)
    supporting-file.*     # Only if needed (heavy reference, reusable scripts)
```

Keep content inline unless reference material exceeds ~100 lines or you have reusable tools/scripts.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Description summarizes workflow | Only list triggering conditions |
| Description uses first person | Write in third person |
| Description is vague ("For async testing") | Be specific ("Use when tests have race conditions or pass/fail inconsistently") |
| Multiple mediocre examples | One excellent, runnable example |
| Narrative storytelling ("In session X, we found...") | Extract reusable pattern, drop the story |
| Flowcharts for linear steps | Use numbered lists. Flowcharts only for non-obvious decisions |
