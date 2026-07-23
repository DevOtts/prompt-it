# Dry-run — Mode 1 (new-session compiler)

**Method:** the coordinator applied `plugins/prompt-it/skills/prompt-it/SKILL.md` Mode 1, step by step, to a real rough input. Honest label: authored-by-coordinator simulation of the skill's instructions, not an end-user session.

## Input (rough core, stripped from prompt-examples.txt "LANGFUSE OBSERVABILITY")

> Engine has a lot of modules, LLM is invoked in multiple places and we have ZERO visibility of costs, models, token leaks. We're blind. I want to track every place we use LLM, brain-apps included. Langfuse should be a global service on our contabo VPS, each tenant a langfuse project. Beacon has a langfuse implementation you can look at. I care about good trace naming so we know where a trace came from.

## Pipeline trace

1. **Clarity gate:** not trivial — multi-repo, infra + instrumentation + naming conventions, no DoD. Full pipeline.
2. **Route:** fuzzy/large, needs discovery + specs across repos → **plan-it**.
3. **Author-context extraction (head-only content recovered):** the Beacon reference impl; the VPS + credentials pointer; the trace-naming taxonomy examples; "brain-apps included" scope signal. Zero questions needed — all resolvable from the ask + lookups.
4. **Pointer validation (real, this session):** `ls -d /Users/macbook/Workspace/ANM/Beacon` → exists ✔. Engine-Core repo listing → exists ✔ (brain-admin-ui, brain-agent, brain-api-core…). Quick grep for a specific langfuse file inside Beacon did NOT resolve one → the prompt points at the repo and names the pattern, without inventing a file path (dead-pointer rule).
5. **Draft:** plan-it profile → include R, G, /goal, CP, SF, light DS; **omit** tiering note, uncertainty clause, output contract, size/shape pre-decision.

## Emitted output

```
plan-it

Engine invokes LLMs across many modules and brain-apps with zero cost/model/token
visibility — we can't find leaks or right-size models.

/goal plan full LLM observability for Engine: every LLM call traced in Langfuse,
self-hosted as a global service, one Langfuse project per tenant.

Context package:
- @/Users/macbook/Workspace/ANM/Beacon — has a working Langfuse integration; mirror
  its instrumentation pattern (locate the langfuse wiring during pre-ground; not
  pinned to a file here).
- Deploy target: contabo_brain_apps_master_vps — credentials in @.secrets/.full.credentials
  (requires [CONTABO_VPS_CREDS]; do not inline them into docs).
- Trace naming must encode origin, e.g. "chat", "app:pulse", "automation:<name>" —
  extend this taxonomy to every call site you find.

DoD sketch (for the planning run to lock):
1. Inventory of every LLM call site (Engine modules + brain-apps), each mapped to a
   proposed trace name — verifiable against the call-site list itself.
2. Deployment plan for global Langfuse on the VPS with per-tenant projects.
3. Instrumentation plan per call-site pattern, mirroring Beacon's approach.

Out of scope / do not touch:
- No instrumentation code changes in this session — planning only.
- Multi-step/agent trace decomposition (per-step spans) is a later enhancement
  unless the inventory shows it's cheap to spec now.

/goal (restated): a plan-it package that makes every LLM call in Engine traceable
to its origin and cost, per tenant, via self-hosted Langfuse.
```

🎯 Target: plan-it — multi-repo discovery + spec work; sizing/shape belongs to its G1 gate.
💡 Validated the Beacon pointer at repo level only — a quick grep didn't pin the langfuse file, so the prompt names the pattern and leaves file discovery to pre-ground instead of shipping a guessed path.

## Conformance check (vs SKILL.md rules)

- [x] Slots for plan-it route: R ✔ G ✔ /goal ✔ CP ✔ DS(light) ✔ SF ✔
- [x] Omissions honored: NO tiering/teams note (original prompt had one — deliberately not reproduced), no uncertainty clause, no output contract, no size/shape pre-decision
- [x] 🎯 and 💡 lines present; prompt in one copyable block
- [x] Directive count: 8 discrete directives (≤10)
- [x] Goal restated at end (long prompt rule)
- [x] Credential safety: [CONTABO_VPS_CREDS]-style reference, no secrets
- [x] Dead-pointer rule exercised: unresolved file path NOT invented; disclosed in 💡
- [x] Intent preserved: no scope added beyond the rough ask (multi-step spans explicitly deferred, mirroring the original's spirit)
