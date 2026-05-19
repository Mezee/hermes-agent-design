---
title: Stable Prompt Layers
impact: HIGH
tags: [architecture, prompt-design, soul, memory]
---

# Stable Prompt Layers

Separate identity, project rules, memory, and task state into distinct layers. Do not mutate durable prompt layers to carry short-lived execution state.

## Why

- **Cache stability**: Stable prompt prefixes improve reuse and reduce churn
- **Cleaner reasoning**: The agent can tell what is permanent versus what is only true for this run
- **Lower drift**: Identity files stop turning into scratchpads

## Pattern

```text
# Bad
SOUL.md
- voice and identity
- today we are debugging auth
- remember to inspect /tmp/build.log

# Good
SOUL.md
- identity, stance, decision style

AGENTS.md
- project architecture and constraints

MEMORY.md
- durable environment facts

runbook.md or current thread
- live task state and temporary notes
```

## Rules

1. Keep `SOUL.md` for identity and decision posture only.
2. Keep `AGENTS.md` for project operating rules and routing.
3. Keep memory files for durable facts that survive sessions.
4. Keep temporary plans and execution state in task artifacts, not prompt-layer files.
