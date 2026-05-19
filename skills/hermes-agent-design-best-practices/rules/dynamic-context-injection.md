---
title: Dynamic Context Injection
impact: HIGH
tags: [context, runtime, prompt, resources]
---

# Dynamic Context Injection

Give the agent live knowledge of what exists and what it can do right now: entities, files, resources, recent state, and domain vocabulary.

## Why

- **Less confusion**: The agent does not ask what already exists
- **Better autonomy**: Open-ended requests become tractable
- **Stronger parity**: The agent sees the same relevant state the user sees

## Pattern

```markdown
# Bad
System prompt:
"Help the user with their work."

# Good
Available projects:
- alpha
- beta

Available entity types:
- note
- report
- task

Relevant vocabulary:
- "publish" means moving a draft into the feed
- "archive" means hide from active lists without deletion
```

## Rules

1. Inject available resources and current entities into the system context.
2. Include app-specific vocabulary and action meanings.
3. Refresh or re-query context for long-running sessions when state may have changed.
4. Do not rely on the user to restate obvious app state the system already knows.
