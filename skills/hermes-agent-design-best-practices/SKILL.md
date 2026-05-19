---
name: hermes-agent-design-best-practices
description: Best practices for designing Hermes agent systems that are autonomous, simple for users, and safely human-in-the-loop. Use when creating or refactoring Hermes harnesses, writing AGENTS.md files, defining what the agent should infer vs ask, shaping skill and tool boundaries, designing delegation, memory, or evaluation loops, or turning repo architecture into an agent operating model.
---

# Hermes Agent Design Best Practices

Patterns for designing Hermes agents as explicit operating systems instead of ad hoc prompts. These rules are primarily for the agent and harness designer, not for burdening the end user with internal architecture jargon. Contains 11 rules across architecture, execution, and quality.

## When to Apply

Reference these guidelines when:

- Creating a new Hermes harness or agent architecture
- Writing or restructuring `AGENTS.md` files
- Defining context, skill, tool, and memory boundaries
- Deciding whether work should stay single-agent or use delegation
- Adding evals, observability, or approval boundaries
- Converting a repository's structure into a reusable Hermes design
- Deciding what Hermes should infer automatically and what it should ask in plain language

## Current Hermes Conventions

Apply these platform-specific conventions when turning the rules below into real files:

- `SOUL.md` is global identity loaded from `HERMES_HOME`; do not treat a repo-local `SOUL.md` as project context
- project context uses a priority system: `.hermes.md` or `HERMES.md` first, then `AGENTS.md`, then `CLAUDE.md`, then `.cursorrules`
- only one project-context type wins at startup, so the harness should not depend on multiple root context files being merged
- Hermes progressively discovers nested `AGENTS.md` and related context files as it moves into subdirectories, so route local rules downward instead of bloating the root file
- Hermes plugins are Python plugins with `plugin.yaml` plus `register(ctx)` in `__init__.py`; add `schemas.py` and `tools.py` when the plugin surface is non-trivial
- repo-local plugins live under `.hermes/plugins/` and require `HERMES_ENABLE_PROJECT_PLUGINS=true`
- plugin handlers should accept `args: dict, **kwargs`, return JSON strings, and convert failures into error JSON rather than raising
- `pre_llm_call` is the hook for live context injection; use it for per-turn context, not durable identity or stable policy
- Hermes skills live in `~/.hermes/skills/`; external skill directories are read-only discovery sources, not the primary write target

## Rules Summary

### Architecture (HIGH)

#### context-first-routing - @rules/context-first-routing.md

Load durable context before task logic and keep `AGENTS.md` focused on routing, invariants, and local discovery.

```markdown
# Bad
- Put architecture, current task notes, and temporary TODOs in one giant AGENTS.md

# Good
repo/
├── AGENTS.md          # global rules, architecture, boundaries
├── apps/api/AGENTS.md # API-specific conventions
└── apps/web/AGENTS.md # frontend-specific conventions
```

#### stable-prompt-layers - @rules/stable-prompt-layers.md

Keep `SOUL.md`, `AGENTS.md`, memory, and task state in separate layers so the prompt stays stable and cacheable.

```markdown
# Bad
Append volatile sprint status to SOUL.md every run

# Good
SOUL.md    -> identity and stance
AGENTS.md  -> project operating rules
MEMORY.md  -> durable facts only
Task state -> current conversation or output artifact
```

#### skills-vs-tools-boundary - @rules/skills-vs-tools-boundary.md

Use skills for procedural reasoning and tools for deterministic execution with tight schemas.

```markdown
# Bad
One "god skill" that reasons, calls APIs, mutates files, and decides output format implicitly

# Good
Skill: choose workflow and output contract
Tool: execute search, scrape, build, or deploy step
```

#### action-parity - @rules/action-parity.md

Map every meaningful user-facing action to an equivalent agent capability.

```markdown
# Bad
UI action: "Publish note"
Agent: no tool or primitive path exists

# Good
| User Action | Agent Path |
| --- | --- |
| Publish note | `publish_note` or `write_file` + `update_index` |
```

#### shared-workspace - @rules/shared-workspace.md

Keep the agent and the user in the same data plane so agent work is inspectable and immediately useful.

```markdown
# Bad
user data -> /workspace/docs
agent output -> /tmp/agent-output

# Good
user data -> /workspace/docs
agent writes -> /workspace/docs
UI observes the same files or store
```

### Execution (HIGH)

#### bounded-memory - @rules/bounded-memory.md

Store only durable facts that are expensive to rediscover, and keep preferences separate from project facts.

```markdown
# Bad
MEMORY.md
- Current ticket: fix navbar spacing
- Today's shell history

# Good
MEMORY.md
- Local dev server runs on port 4010
- Deployment requires vpn + manual approval
```

#### single-agent-first - @rules/single-agent-first.md

Default to one capable agent and add delegation only when context or tool overlap makes the main prompt unstable.

```markdown
# Bad
research-agent -> planner-agent -> writer-agent for every task

# Good
Primary Hermes agent handles most work
Delegate only for isolated research, audits, or parallel subtasks
```

#### isolated-delegation - @rules/isolated-delegation.md

When delegating, pass explicit context, restrict tools, and expect a summary rather than hidden shared state.

```markdown
# Bad
"Go figure it out" with full repo access and no success criteria

# Good
goal: "Audit webhook retry logic"
context: files, constraints, expected output
tools: read-only repo tools
return: findings + file references
```

#### dynamic-context-injection - @rules/dynamic-context-injection.md

Inject live app state, available resources, and domain vocabulary so the agent knows what exists right now.

```markdown
# Bad
System prompt: "Help the user manage their workspace."

# Good
Available projects: alpha, beta
Available entities: notes, tasks, reports
Available actions: create, update, archive, publish
```

#### explicit-completion-signals - @rules/explicit-completion-signals.md

Require the agent to signal completion explicitly instead of guessing from silence or heuristic loop exits.

```markdown
# Bad
Assume the task is done after two iterations without tool calls

# Good
Agent must call `complete_task(summary, artifacts)`
```

### Quality (MEDIUM)

#### evals-and-observability - @rules/evals-and-observability.md

Design every Hermes harness with explicit eval cases, approval boundaries, and observable execution.

```json
{
  "prompt": "Design a harness for customer support triage",
  "assertions": [
    "loads shared context first",
    "returns explicit tool contracts",
    "keeps destructive actions behind approval"
  ]
}
```

#### crud-and-capability-discovery - @rules/crud-and-capability-discovery.md

Design tools so entities have full CRUD coverage and broad APIs can be explored dynamically instead of hardcoding every branch.

```markdown
# Bad
create_note
read_note

# Good
create_note
read_note
update_note
delete_note
list_note_types
read_entity(type: string, id: string)
```

## Philosophy

Good Hermes designs are:

1. **Explicit** - Context, routing, and boundaries are written down
2. **Layered** - Identity, project rules, memory, and task state stay separate
3. **Composable** - Skills and tools can change without rewriting the whole harness
4. **Constrained** - Delegation, memory, and tool access stay bounded
5. **Measurable** - Behavior is observable and tested with evals

## Plugin Design Rule

Use a plugin only when the harness needs deterministic execution, hook-based observation, or turn-time context injection that should not live inside free-form prompt instructions.

Prefer:
- `AGENTS.md` or `.hermes.md` for project rules and routing
- `SOUL.md` for identity
- skills for reusable procedures
- plugins for tools, hooks, and bounded runtime integration

If a capability can stay a skill plus ordinary Hermes tool use, keep it there. Reach for a plugin when you need stable callable primitives or lifecycle hooks.

## User Simplicity Rule

Keep these concepts mostly internal to Hermes:
- tool contracts
- parity maps
- context injection
- completion signaling
- mutation boundaries

Expose them to the user only when:
- they explicitly ask for architecture detail
- implementation work requires concrete files
- Hermes cannot safely infer a missing business decision

When Hermes must ask, ask in plain language about outcomes, judgment, and approvals rather than architecture vocabulary.
