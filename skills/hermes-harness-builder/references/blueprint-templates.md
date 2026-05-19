# Hermes Harness Blueprint Templates

Use these templates to keep outputs deterministic and implementation-ready.

## Canonical File Tree

```text
profile-home/
├── SOUL.md
├── config.yaml
└── memories/
    ├── MEMORY.md
    └── USER.md

workspace/
├── .hermes/
│   └── plugins/
│       └── my-plugin/
│           ├── plugin.yaml
│           ├── __init__.py
│           ├── schemas.py
│           └── tools.py
├── AGENTS.md
├── apps/
│   ├── api/AGENTS.md
│   └── web/AGENTS.md
├── skills/
│   ├── triage/SKILL.md
│   ├── execution/SKILL.md
│   └── review/SKILL.md
├── tools/
│   ├── REGISTRY.md
│   └── integrations/
└── evals/
    └── routing.json
```

## Routing Model

```md
| Intent Signal | Primary Skill | Companion Skills | Notes |
|---|---|---|---|
| "investigate bug" | triage | review | Not for direct deploys |
| "ship fix" | execution | review | Requires approval before external action |
```

## Skill Matrix

```md
| Skill | Purpose | Inputs | Outputs | Boundaries |
|---|---|---|---|---|
| triage | diagnose and scope work | repo context, bug report | findings, next action | not for deploy |
```

## Tool Contract Table

```md
| Tool | Objective | Input Shape | Output Shape | Approval |
|---|---|---|---|---|
| deploy_service | ship a release | service, env, version | id, status, logs | required |
```

## Capability Parity Map

```md
| User Action | UI Surface | Agent Path | Status |
|---|---|---|---|
| Publish report | report detail screen | `publish_report` | covered |
| Archive report | report list row action | `archive_report` | covered |
| Rename report | editor title field | `update_report` | gap |
```

## Dynamic Context Injection

```md
### Runtime Context
- Available projects: alpha, beta
- Available entity types: note, report, task
- Available actions: create, update, archive, publish
- Vocabulary:
  - publish = move draft into feed
  - archive = hide from active list without delete
```

Use Hermes `pre_llm_call` plugin hooks for live context like this when the data is genuinely per-turn and should not be frozen into `SOUL.md`, memory, or root project instructions.

## Shared Workspace Model

```md
- User and agent both read/write `workspace/reports/`
- UI observes file changes through shared store or watcher
- Agent does not write to a hidden sidecar output directory
```

## Completion Signaling

```md
- Long-running agents must call `complete_task(summary, artifacts)`
- Partial progress stored in checkpoint or task state
- Host does not infer completion from lack of tool calls
```

## Memory Policy

```md
- Save durable environment facts in `memory/MEMORY.md`
- Save user preferences in `memory/USER.md`
- Do not save ephemeral task notes or branch-specific state
```

## Eval Stub

```json
{
  "suite": "routing",
  "cases": [
    {
      "prompt": "Deploy this service to production",
      "assertions": [
        "loads deployment context",
        "asks for approval before destructive action",
        "returns a plan before execution"
      ]
    }
  ]
}
```

## Draft AGENTS.md Skeleton

```md
# AGENTS.md

## Architecture
- Core runtime boundaries
- Main apps and packages

## Invariants
- Never mutate production without approval
- Keep memory bounded and durable

## Routing
- API work: `apps/api/AGENTS.md`
- Web work: `apps/web/AGENTS.md`

## Tool Boundaries
- Skills decide
- Tools execute
```
