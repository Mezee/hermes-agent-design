---
title: Bounded Memory
impact: HIGH
tags: [memory, persistence, context]
---

# Bounded Memory

Persist only information that is durable, high-value, and expensive to rediscover. Keep user preferences separate from project or environment facts.

## Why

- **Smaller context**: The agent does not re-read noise every run
- **Higher signal**: Saved facts are more trustworthy and reusable
- **Cleaner ownership**: Preferences and environment facts do not get mixed

## Pattern

```markdown
# Bad
MEMORY.md
- Investigated payment bug on Tuesday
- Current branch is test-branch
- Need to review the navbar tomorrow

# Good
MEMORY.md
- Staging deploy requires VPN access
- Integration tests need seeded Stripe fixtures

USER.md
- Prefer concise status updates
- Avoid destructive git commands without confirmation
```

## Rules

1. Save only facts likely to matter in future sessions.
2. Keep ephemeral branch names, temporary tasks, and logs out of memory files.
3. Separate user preferences from project/environment facts.
4. Prune stale memory instead of letting it grow unbounded.
