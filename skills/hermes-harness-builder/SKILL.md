---
name: hermes-harness-builder
description: Turn a repo, product idea, or agent brief into a usable Hermes harness with minimal user effort. Use when creating or refactoring a Hermes harness, choosing between one agent, specialists, an orchestrator, or automation, drafting AGENTS.md and skill structure, or translating a rough concept into an autonomy-first, human-in-the-loop system. Pair with `hermes-agent-design-best-practices` for the governing design rules.
---

# Hermes Harness Builder

Build a usable Hermes harness from an incomplete brief. Infer what can be inferred, choose the smallest maturity level that works, ask only for missing business decisions, and keep the user-facing output simple.

Before building, read:
- `../hermes-agent-design-best-practices/SKILL.md`
- `../../docs/maturity-model.md`
- `../../docs/promotion-checklist.md`
- `../../docs/control-room-patterns.md`

Treat the best-practices skill as the governing standard and this skill as the implementation workflow.

## Workflow

### 1. Read The Brief And Infer Aggressively

Start from the user's outcome, not from architecture vocabulary.

Infer as much as possible from:
- the repo
- the product brief
- the existing workflow description
- obvious domain patterns

Do not ask the user to define internal architecture unless the architecture choice changes product behavior.

### 2. Ask Only For Missing Business Decisions

Only ask questions when the missing answer materially changes what the agent should do.

Ask in plain language, for example:
- who should the agent target?
- what counts as a good lead?
- when should it stop and ask you before acting?
- what should happen when the agent is unsure?
- what outcome matters most: replies, meetings, or qualified meetings?

Avoid questions like:
- define tool contracts
- define parity model
- define memory boundaries

Those are internal harness responsibilities.

### 3. Build The Harness Internally

Internally determine:
- which maturity level the workflow should start at
- what the agent needs to know
- what the agent needs to be able to do
- what state it needs to track
- when it can act autonomously
- when it must ask the human
- what parts may improve over time
- what parts must remain fixed

Respect current Hermes conventions while doing this:
- keep `SOUL.md` in `HERMES_HOME`, not in the repo workspace
- treat project context as a priority stack: `.hermes.md` or `HERMES.md` first, then `AGENTS.md`, then `CLAUDE.md`, then `.cursorrules`
- remember Hermes loads only one project-context type at startup; do not design a harness that depends on all of them loading at once
- when the harness needs plugin code, use a Hermes plugin layout with `plugin.yaml`, `__init__.py`, and optional `schemas.py` and `tools.py`
- if the plugin is repo-local, place it under `.hermes/plugins/` and note that `HERMES_ENABLE_PROJECT_PLUGINS=true` must be set for Hermes to load it
- use `pre_llm_call` only for live turn context injection, not for identity, stable policy, or durable memory

Use the templates in [references/blueprint-templates.md](references/blueprint-templates.md) when you need structure, but do not force all internal sections into the user-facing response.

### 4. Choose The Smallest Viable Maturity Level

Default to Level 1 first.

Use the maturity model in `../../docs/maturity-model.md`:
- Level 1: one main agent and prototype bench
- Level 2: specialist agents with distinct scope
- Level 3: orchestrator over real specialists
- Level 4: cron or event-driven automated team

Promotion rules:
- do not split into specialists until the workflow is already good
- do not add an orchestrator before specialists exist
- do not automate weak output
- do not move up a level just because the architecture sounds impressive

When proposing Level 2 or above, explicitly define:
- why the current level is no longer enough
- what scope each new agent owns
- what credentials and memory boundaries differ
- what still requires approval

### 5. Present A Simple User Journey

Default to explaining the harness in user terms:
- what the agent will do on its own
- what it will ask the human
- where the human can review or approve
- what gets better over time
- what stays fixed for safety or consistency

Only expose deeper architecture sections if:
- the user asks for them
- implementation work requires them
- the harness has real ambiguity that must be resolved explicitly

### 6. Draft Concrete Artifacts When Needed

When the user wants implementation-ready output, draft:
- root `AGENTS.md`
- optional nested `AGENTS.md`
- `SOUL.md` outline for `HERMES_HOME`
- starter `SKILL.md` definitions
- memory structure
- eval stubs
- tool registry outline
- plugin scaffold when the design needs deterministic tools or hooks

Keep internal architecture concrete, but keep the conversation with the user plain.

## Default Output Shape

Unless the user asks for deeper architecture, return:
1. `What the agent does`
2. `Recommended maturity level`
3. `What it still needs from you`
4. `When it pauses for approval`
5. `How it improves over time`
6. `Promotion path`
7. `Next build step`

If needed, append:
- `Control room design`
- `Internal harness plan`
- `Draft files`

## Execution Rules

- Infer first, ask second.
- Ask only business-facing questions.
- Keep architecture terms internal by default.
- Preserve human-in-the-loop points for ambiguity, risk, and approval.
- Prefer fewer agents with better output over more agents with weaker output.
- Do not dump every internal design section on the user unless asked.
- If you ask a question, explain why it matters in plain language.

## When To Read References

- Read [references/blueprint-templates.md](references/blueprint-templates.md) when drafting files or internal scaffolding.
- Read `../hermes-agent-design-best-practices/SKILL.md` at the start of every use to validate autonomy and human-in-the-loop behavior.
- Read `../../docs/maturity-model.md` before deciding to introduce specialists, an orchestrator, or automation.
- Read `../../docs/control-room-patterns.md` before designing control-room artifacts.

## Example Invocations

- `Use $hermes-harness-builder to design a Hermes harness for this monorepo.`
- `Use $hermes-harness-builder to turn this agent brief into AGENTS.md, skills, and eval scaffolding.`
- `Use $hermes-harness-builder to refactor our current prompt into a layered Hermes architecture.`
- `Use $hermes-harness-builder to fill in the missing parts of this agent idea and only ask me what truly matters.`
- `Use $hermes-harness-builder to decide whether this workflow should stay single-agent or split into specialists.`
