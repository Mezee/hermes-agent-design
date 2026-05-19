---
title: CRUD and Capability Discovery
impact: MEDIUM
tags: [tools, crud, dynamic-apis, mcp]
---

# CRUD and Capability Discovery

Design tools so important entities have full create, read, update, and delete coverage. For broad or dynamic APIs, expose discovery primitives instead of hardcoding every variant.

## Why

- **Fewer dead ends**: The agent can correct, remove, or revise work
- **Higher flexibility**: New resource types do not require a new tool every time
- **Better composition**: The agent can explore and adapt rather than wait for code changes

## Pattern

```text
# Bad
create_note
read_note

# Good
create_note
read_note
update_note
delete_note
list_available_types
read_entity(type: string, id: string)
```

## Rules

1. Provide full CRUD for user-visible entities unless deletion is intentionally forbidden.
2. Prefer discovery plus generic access for dynamic external systems.
3. Avoid over-constraining inputs when the backing system can validate them.
4. Treat missing delete or update paths as parity gaps.
