---
title: Isolated Delegation
impact: HIGH
tags: [delegation, subagents, isolation, safety]
---

# Isolated Delegation

Treat each Hermes subagent as an isolated worker with an explicit goal, explicit context, explicit tools, and a defined return format.

## Why

- **Predictable outcomes**: The worker knows what success looks like
- **Safer access**: Tool permissions can be narrowed to the task
- **Easier integration**: The parent agent receives a clean summary instead of hidden state

## Pattern

```yaml
# Bad
delegate:
  task: "look into the auth issue"

# Good
delegate:
  goal: "Audit retry behavior in auth webhook processing"
  context:
    - src/jobs/auth_webhook.ts
    - docs/retry-policy.md
  tools:
    - read_repo
    - search_repo
  return:
    - findings
    - file references
    - unresolved questions
```

## Rules

1. Pass the minimum context needed for the subtask.
2. Restrict the toolset to what the worker actually needs.
3. Ask for a structured summary rather than assuming shared hidden state.
4. Avoid delegation when constant back-and-forth would erase the benefit.
