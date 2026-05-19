# Hermes Agent Maturity Model

Use this model when deciding how much Hermes architecture a workflow actually needs.

## Level 1: Main Agent

Use one main Hermes agent as both:
- the front door for the user
- the prototype bench for new workflows

Choose Level 1 when:
- the workflow is new
- quality is still uneven
- one person can still judge the work directly
- the agent needs frequent correction

Design guidance:
- prefer one strong agent over several shallow ones
- keep credentials, memory, and approvals centralized
- treat the main agent as the place where new skills are discovered and refined

## Level 2: Specialized Agents

Break a workflow into a specialist only after it is stable enough to deserve its own scope.

Choose Level 2 when:
- the workflow repeats reliably
- the scope is clear enough to separate
- different credentials or memory are beneficial
- the specialist can own a narrow output without constant coaching

Each specialist should define:
- scope
- inputs and outputs
- credentials
- memory boundaries
- approval boundaries

## Level 3: Orchestrated Team

Add an orchestrator only when there are real specialists to route between.

Choose Level 3 when:
- users need one front door across multiple specialists
- routing decisions are frequent enough to justify a coordinator
- specialist boundaries are already stable

The orchestrator should:
- route work
- maintain cross-agent visibility
- avoid doing most specialist work itself

## Level 4: Automated Team

Promote the team to cron or event-driven execution only after the workflow already performs well with human oversight.

Choose Level 4 when:
- the workflow succeeds repeatedly in real runs
- failures are understood
- approvals are explicit
- the team can checkpoint and signal completion safely

Do not automate weak output. Scaling mediocre work just creates faster drift.

## Promotion Rule

Move up only when the current level is already working:
1. prototype in one agent
2. split into specialists only after repeated success
3. add an orchestrator only when specialists exist
4. automate only after quality survives real runs
