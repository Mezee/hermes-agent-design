---
title: Shared Workspace
impact: HIGH
tags: [workspace, parity, ui-integration, files]
---

# Shared Workspace

Make the agent work in the same workspace, store, or file system the user works in. Avoid separate agent-only output zones unless there is a strong containment reason.

## Why

- **Inspectability**: Users can see and edit what the agent creates
- **Immediate usefulness**: Agent actions appear where the product already expects them
- **Lower complexity**: No fragile sync layer between user space and agent space

## Pattern

```text
# Bad
Documents/
├── user/
└── agent-output/

# Good
Documents/
├── notes/
├── reports/
└── tasks/

Both user and agent read and write the same entities.
```

## Rules

1. Put agent outputs in the same data plane the UI reads from.
2. Ensure UI surfaces observe agent-created changes immediately.
3. Avoid hidden agent sandboxes for normal product work.
4. Use isolation only for explicit safety, staging, or review workflows.
