# Hermes Agent-Native Review Checklist

Use this checklist and template when reviewing a Hermes system.

## Checks

- [ ] Every major user action has an agent path
- [ ] Agent and user operate in the same workspace or store
- [ ] The workflow is at the smallest maturity level that still fits
- [ ] Specialists exist only when they have a clear scope
- [ ] Orchestration exists only when there are real specialists to route between
- [ ] Automation starts only after the workflow performs well in real runs
- [ ] The control room is used for governance, not as the hidden work surface
- [ ] Runtime context includes available entities, actions, and vocabulary
- [ ] Root context-file strategy matches Hermes priority rules
- [ ] `SOUL.md` is treated as `HERMES_HOME` identity, not repo-local project context
- [ ] Plugin use is justified over skills or ordinary prompt/context files
- [ ] Repo-local plugins use `.hermes/plugins/` and note `HERMES_ENABLE_PROJECT_PLUGINS=true`
- [ ] Plugin handlers follow Hermes contracts: `args: dict, **kwargs`, JSON-string returns, error JSON on failure
- [ ] Tools are primitives or intentionally narrow domain shortcuts
- [ ] Important entities have full CRUD or documented constraints
- [ ] Completion is explicit, not inferred heuristically
- [ ] Evals cover routing, parity, approval boundaries, and failure cases

## Review Template

```md
## Hermes Agent-Native Review

### Summary
[Short assessment]

### Capability Parity Map

| User Action | Location | Agent Path | Status |
|---|---|---|---|
| Publish report | Report screen | `publish_report` | covered |

### Findings

#### Critical
1. **Missing parity for archive action**
   - Location: `app/reports/*`
   - Impact: user can archive, agent cannot
   - Fix: add `archive_report` or primitive equivalent

2. **Workflow was automated before it was stable**
   - Location: orchestration layer
   - Impact: weak output is being scaled through cron or events
   - Fix: collapse back to a simpler level and harden the Level 1 workflow first

#### Warnings
1. **Static context prompt**
   - Recommendation: inject available reports and status terms at runtime

2. **Control room is acting like the work surface**
   - Recommendation: move governance back into the control room and route execution through the actual agents

#### Observations
1. **Completion signal could be richer**
   - Recommendation: return changed artifacts with `complete_task`

### Recommendations
1. Add missing parity tools or primitive paths
2. Move agent writes into shared workspace
3. Add runtime context injection
4. Collapse unnecessary orchestration or specialist layers
5. Delay automation until the workflow survives repeated real runs

### What Works
- Shared file space already exists
- Tool outputs are structured

### Verdict
- `PASS` or `NEEDS WORK`
```
