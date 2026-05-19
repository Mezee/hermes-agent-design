---
name: hermes-skill-discovery
description: Find Hermes-related skills, templates, and reusable workflows for harness design, specialist agents, control rooms, and agent-native reviews. Use when Codex needs to discover external Hermes skills, search Context7 for Hermes skill guidance, or decide whether to adapt an existing Hermes skill versus writing a new one.
---

# Hermes Skill Discovery

Find relevant Hermes skills before inventing new ones.

## Workflow

### 1. Start With The Need

Translate the user request into the smallest useful search query:
- workflow type
- domain
- agent role
- Hermes surface such as harness, control room, reviewer, or orchestrator

Prefer queries like:
- `Hermes harness builder`
- `Hermes control room`
- `Hermes review workflow`
- `Hermes specialist agent`

### 2. Prefer Current Discovery Sources

When available:
- use the installed Context7 plugin for current `ctx7` skill-search guidance
- use the bundled script at [`../../scripts/search_hermes_skills.sh`](../../scripts/search_hermes_skills.sh) when CLI access is preferred

If neither is available, still help by:
- proposing search queries
- describing the type of skill to look for
- explaining whether the user likely needs an existing skill, a new skill, or a plugin-local adaptation

### 3. Evaluate Results

For each candidate, summarize:
- what it is for
- what part should be reused
- whether it fits Level 1, 2, 3, or 4 maturity
- whether it should stay external, be adapted locally, or be replaced by a new skill

### 4. Recommend The Smallest Move

Default to:
- reuse an existing skill when it already matches the workflow
- adapt an existing skill when the pattern is right but the domain is different
- write a new skill only when the workflow is clearly novel

## Output Format

Return:
1. `Search Summary`
2. `Candidate Skills`
3. `Recommended Reuse Strategy`
4. `Next Skill To Invoke`

## Example Invocations

- `Use $hermes-skill-discovery to find Hermes skills for a control-room workflow.`
- `Use $hermes-skill-discovery to search for Hermes agent-review patterns.`
- `Use $hermes-skill-discovery to decide whether this harness should reuse an existing skill.`
