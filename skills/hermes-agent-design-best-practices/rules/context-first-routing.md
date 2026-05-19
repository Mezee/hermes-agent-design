---
title: Context-First Routing
impact: HIGH
tags: [architecture, context, routing, agents-md]
---

# Context-First Routing

Design Hermes harnesses so durable context loads before task-specific reasoning. Keep `AGENTS.md` focused on routing, invariants, repository structure, and local discovery rules.

## Why

- **Lower prompt noise**: Durable rules stay in one place instead of being repeated in every task
- **Better local reasoning**: Nested `AGENTS.md` files let the agent discover only the rules relevant to the current subtree
- **Safer execution**: Hard constraints are visible before the agent reaches tool use

## Pattern

```text
# Bad
repo/
└── AGENTS.md
    - frontend rules
    - backend rules
    - deployment notes
    - current sprint TODOs
    - temporary debugging notes

# Good
repo/
├── AGENTS.md
│   - system architecture
│   - cross-cutting constraints
│   - routing rules
├── apps/web/AGENTS.md
│   - component and styling rules
└── apps/api/AGENTS.md
    - API, job, and data rules
```

## Rules

1. Put global architecture and non-negotiables in the root `AGENTS.md`.
2. Put subsystem-specific rules in nested `AGENTS.md` files near the code they govern.
3. Keep task notes, temporary plans, and session state out of `AGENTS.md`.
4. Write routing rules so the agent can map intents to the right local context quickly.
