---
name: hermes-agent-native-reviewer
description: Review Hermes harnesses, agent-enabled apps, and agent-facing architecture for action parity, shared workspace discipline, dynamic context injection, tool design, completion signaling, eval coverage, and maturity-level fit. Use after adding UI features, agent tools, system prompts, AGENTS.md files, new workflow capabilities, or automation layers to verify the system remains agent-native and is not scaling weak workflows.
---

# Hermes Agent Native Reviewer

Review Hermes systems for whether the agent is truly first-class, not bolted on.

Before reviewing, read:
- `../hermes-agent-design-best-practices/SKILL.md`
- `../../docs/maturity-model.md`
- `../../docs/promotion-checklist.md`
- `../../docs/control-room-patterns.md`
- [references/review-checklist.md](references/review-checklist.md)

Use the first as the standard and the second as the output scaffold.

## Review Workflow

### 1. Understand The Surface Area

Inspect:
- user-facing actions or workflows
- agent tools and primitives
- maturity level and promotion path
- `AGENTS.md`, `SOUL.md`, and prompt construction
- runtime context injection
- workspace or storage layout
- completion signaling and eval coverage

### 2. Build A Capability Map

For each meaningful user action, verify:
- an equivalent agent path exists
- the path is available through tools or primitives
- the agent sees the same underlying data

Always create a capability parity table.

### 3. Review The Core Disciplines

Check for:
- action parity
- shared workspace
- dynamic context injection
- correct maturity level for the workflow
- unnecessary specialist or orchestrator complexity
- automation before quality is proven
- correct control-room usage as governance, not work surface
- specialist scope, credentials, memory, and approval boundaries
- correct use of Hermes context layers and root context-file priority
- correct use of plugins versus skills versus prompt files
- primitive tool design
- full CRUD or intentional exceptions
- explicit completion signaling
- eval and observability coverage

### 4. Classify Findings

Use severity based on impact:
- `Critical`: agent cannot achieve a user-visible outcome, or state changes are unsafe/invisible
- `Warning`: architecture works but is likely to confuse, constrain, or degrade the agent
- `Observation`: improvement opportunity, not a blocking defect

### 5. Recommend Fixes

For each non-trivial finding, propose a concrete remediation:
- collapse the design back to a simpler maturity level
- add or reshape a tool
- inject missing runtime context
- move agent output into shared workspace
- add completion tool or checkpoint
- add parity/eval coverage

## Output Format

Return sections in this order:
1. `Hermes Agent-Native Review`
2. `Summary`
3. `Capability Parity Map`
4. `Findings`
5. `Recommendations`
6. `What Works`
7. `Verdict`

Use the template in [references/review-checklist.md](references/review-checklist.md).

## Review Rules

- Do not stop at "tools exist"; verify the agent can achieve the user outcome.
- Do not treat separate agent-only storage as acceptable by default.
- Do not accept heuristic completion detection when explicit signaling is possible.
- Flag "scaled slop" when the system is automating or multiplying a weak Level 1 workflow.
- Flag workflow-shaped tools that hide judgment inside code.
- Flag missing dynamic context when the agent would not know what entities or actions exist.
- Flag repo-local `SOUL.md` usage, since Hermes loads identity from `HERMES_HOME`.
- Flag harnesses that assume `.hermes.md`, `AGENTS.md`, and `CLAUDE.md` all load together at startup.
- Flag plugin designs that skip `plugin.yaml`, `register(ctx)`, JSON-string handlers, or the `HERMES_ENABLE_PROJECT_PLUGINS=true` requirement for repo-local plugins.

## Example Invocations

- `Use $hermes-agent-native-reviewer to audit this Hermes app after adding a new report workflow.`
- `Use $hermes-agent-native-reviewer to review this codebase for parity gaps between UI and agent capabilities.`
- `Use $hermes-agent-native-reviewer to check whether our prompts, tools, and storage model are truly agent-native.`
- `Use $hermes-agent-native-reviewer to review whether this Hermes team was promoted to orchestration or automation too early.`
