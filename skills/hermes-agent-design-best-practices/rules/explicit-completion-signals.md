---
title: Explicit Completion Signals
impact: HIGH
tags: [execution, completion, loop, orchestration]
---

# Explicit Completion Signals

Require the agent to explicitly signal when a task is complete. Avoid fragile heuristics like "it stopped calling tools, so it must be done."

## Why

- **Reliable orchestration**: The host can distinguish in-progress from done
- **Better resume behavior**: Partial completion can be checkpointed and resumed
- **Cleaner UX**: Users get a clear summary of what finished and what remains

## Pattern

```text
# Bad
Loop exits after no tool call
Host guesses the work is complete

# Good
Agent calls:
complete_task(
  summary="Published 3 reports",
  artifacts=["reports/q2-summary.md"]
)
```

## Rules

1. Add an explicit completion signal or completion tool to long-running agents.
2. Return a summary and relevant artifacts or state changes with completion.
3. Track partial progress separately from final completion.
4. Do not treat silence as success.
