---
title: Single Agent First
impact: HIGH
tags: [orchestration, delegation, multi-agent]
---

# Single Agent First

Start with one strong Hermes agent. Add subagents only when the main agent is failing because context, tools, or responsibilities are colliding.

## Why

- **Less overhead**: Fewer handoffs and summaries to manage
- **Better coherence**: One agent retains the full causal chain
- **Clearer justification**: Delegation becomes a deliberate architecture choice

## Pattern

```text
# Bad
planner -> researcher -> coder -> reviewer
for every normal feature request

# Good
primary Hermes agent handles:
- context loading
- planning
- execution
- validation

delegate only for:
- parallel research
- isolated audits
- bounded implementation slices
```

## Rules

1. Keep work in one agent until prompt complexity or tool overlap becomes a real problem.
2. Delegate independent subtasks, not the critical path by default.
3. Require a concrete reason for each extra agent: isolation, parallelism, or specialization.
4. Remove multi-agent layers that do not improve reliability or speed.
