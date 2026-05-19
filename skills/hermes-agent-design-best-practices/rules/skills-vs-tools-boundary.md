---
title: Skills vs Tools Boundary
impact: HIGH
tags: [skills, tools, mcp, architecture]
---

# Skills vs Tools Boundary

Use skills for repeatable reasoning patterns and tools for deterministic actions. Avoid putting both responsibilities into the same layer.

## Why

- **Replaceability**: A tool can change without rewriting the reasoning pattern
- **Testability**: Tool contracts can be validated independently
- **Clarity**: The agent can decide first, then execute second

## Pattern

```text
# Bad
skill: "deploy-service"
- inspect config
- decide environment
- call cloud API
- patch files
- infer success from vague logs

# Good
skill: "deployment-review"
- inspect config
- select environment
- define expected output contract
- choose deployment tool

tool: "deploy_service"
- input: service, environment, version
- output: deployment_id, status, logs_url
```

## Rules

1. Put decision logic, sequencing, and output shape in the skill.
2. Put side effects, API calls, or binary/file processing in tools.
3. Give tools explicit input and output schemas.
4. Do not create a single skill that hides unstructured tool behavior.
