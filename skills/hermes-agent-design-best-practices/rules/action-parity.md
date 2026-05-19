---
title: Action Parity
impact: HIGH
tags: [parity, ui, tools, capabilities]
---

# Action Parity

Ensure the agent can achieve the same outcomes the user can achieve through the UI or direct workspace manipulation.

## Why

- **No orphan features**: New UI actions do not strand the agent
- **Better product coherence**: Agent help is useful across the full product surface
- **Clear audits**: Capability gaps can be found early with a simple map

## Pattern

```markdown
# Bad
UI:
- Create report
- Publish report
- Archive report

Agent tools:
- create_report

# Good
| User Action | Agent Capability |
| --- | --- |
| Create report | `create_report` |
| Publish report | `publish_report` or primitive publish path |
| Archive report | `archive_report` |
```

## Rules

1. Build a capability map for every major user-facing action.
2. Require an agent path for each action, even if it is composed from primitives.
3. Review parity whenever adding or changing UI workflows.
4. Treat missing parity as an architectural defect, not a documentation issue.
