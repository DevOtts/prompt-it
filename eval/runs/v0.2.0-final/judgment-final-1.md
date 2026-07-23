# v0.2.0-final — Judgment final-1 (FINAL CERTIFICATION)

Judge: independent QA pass, review-it honesty rules (evidence-quoted rows, closed vocabulary PASS/FAIL, no vibes). Property conformance against `eval/expected-prompts.md` GLOBALS G1–G6 + per-sample MUST/MUST-NOT — never byte-similarity against the exemplar text. Inputs read in full: oracle, sample-prompts, S01–S05 outputs in `eval/runs/v0.2.0-final/`, SKILL.md + references/targets.md (diagnosis reference only).

Global checks (G1 output shape; G2 ≤10 directives; G3 no credentials; G4 intent preserved; G5 no tiering; G6 no task execution) are checked once per sample and folded into each table rather than repeated as a separate block, since none of the five differ in how they satisfy the globals.

---

## S01 — route: plan-it → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape: fence → 🎯 → 💡 → ≤2 setup → optional Qs | ✓ | Response opens at ` ``` `; closes, then `🎯 Target: plan-it —…`, `💡 This session is sandboxed…`, 1 setup line, then 3 optional refinement questions |
| G2 | ≤10 directives | ✓ | goal(1) + 4 success-sketch items + 2 scope-fence clauses ≈ 7 |
| G3 | no credentials | ✓ | "Credentials are stored via the existing secret mechanism — never in plain config" (policy line, no secret values) |
| G4 | intent preserved | ✓ (noted) | Goal adds "configure, and remove" beyond the sample's "install" verb, but this rides the user's own analogy ("MCP section… like we have for backfill and webhooks" — those sections are full CRUD) and lives only in a non-binding Success Sketch explicitly marked "lock the real DoD during planning" — not committed scope |
| G5 | no tiering | ✓ | none present |
| G6 | did not do the task | ✓ | output is a prompt only, no MCP work performed |
| MUST | route plan-it | ✓ | `/plan-it` first line |
| MUST | GROUNDING | ✓ | "Third parties (HubSpot, Airtable, etc.) now ship official MCP servers, but tenants have no plug-and-play way to install them…" |
| MUST | /goal one sentence | ✓ | single sentence goal line |
| MUST | CP names both consumer surfaces | ✓ | both "brain-agent" and "brain-apps" are separate CP bullets with distinct roles |
| MUST | SCOPE FENCES present | ✓ | "Out of scope / do not touch: existing backfill and webhook sections' behavior…" |
| MUST-NOT | sizing/shape pre-decision | ✓ (absent) | no "4 squads"/"size L" language anywhere |
| MUST-NOT | uncertainty clause | ✓ (absent) | only inline `(assumed: … — flag if wrong)` pointer markers, which the binding nuances explicitly permit — no dedicated UC/ask-don't-guess slot |
| MUST-NOT | output contract | ✓ (absent) | no deliverable-location/format contract |
| MUST-NOT | discovery performed by prompt-it itself | ✓ (absent) | CP bullets assign lookups to the future session ("find its existing tool/integration registry as the attachment point"), not claim prompt-it already found it |

No FAIL rows.

---

## S02 — route: fable-it → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape | ✓ | fence → 🎯 → 💡 → 1 setup line, no trailing Qs (optional, not required) |
| G2 | ≤10 directives | ✓ | goal(1) + 5 DoD items + 1 scope-fence clause ≈ 7 |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | "Build and ship it" → DoD item 5 "Shipped: merged and deployed…verified working in the deployed environment" |
| G5 | no tiering | ✓ | none present (S02's own sample input carries no tiering note — that's S19) |
| G6 | did not do the task | ✓ | prompt only |
| MUST | route fable-it | ✓ | `/fable-it` first line |
| MUST | pattern-to-imitate named | ✓ | "trigger-draft.service.ts — the pattern to mirror: per-Space… → OPENROUTER_API_KEY → OPENAI_API_KEY" |
| MUST | DoD sketch numbered, each item names a verification TARGET | ✓ (minor note) | items 2/3/5 name explicit targets ("outbound request auth / logs prove it", "existing behavior unchanged", "verified working in the deployed environment"); item 1 restates the resolution-order invariant without its own proof pointer — acceptable since items 2–4 collectively supply the target for it |
| MUST | SCOPE FENCES | ✓ | "Out of scope / do not touch: other backbone connection types…" |
| MUST-NOT | tiering note | ✓ (absent) | none |
| MUST-NOT | persistence/autonomy clauses | ✓ (absent) | "Shipped: merged and deployed" is a DoD outcome, not a run-state/stop-condition contract |
| MUST-NOT | verification protocol prescriptions (how to run QA) | ✓ (absent) | "(outbound request auth / logs prove it)" names evidence type, not a setup procedure (no "configure test Space X, hit endpoint Y" steps) |

No FAIL rows.

---

## S03 — route: review-it → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape | ✓ | fence → 🎯 → 💡 → 1 setup line → 3 optional Qs |
| G2 | ≤10 directives | ✓ | goal/claim statement + verify-clause + 3 scope-fence clauses ≈ 5 |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | "check it's actually done… the claim is in the last session's report" carried verbatim into "Claim under test: the completion claims in the last session's report" |
| G5 | no tiering | ✓ | none present |
| G6 | did not do the task | ✓ | no verdict rendered, only the review prompt |
| MUST | route review-it | ✓ | `/review-it` first line |
| MUST | CP identifies claim-under-test + where it lives | ✓ | "Claim under test: the completion claims in the last session's report (assumed: … `.fable-it-reports/` or `.agents/history/`…)" |
| MUST | SCOPE FENCES | ✓ | "Out of scope / do not touch: no fixes, no code changes, no redeploys — verdict + evidence per claimed item only" |
| MUST-NOT | fresh DoD authored | ✓ (absent) | no numbered DoD list; "Verify every item that report marks done" points at the existing report instead of authoring new criteria |
| MUST-NOT | how-to-verify instructions (tools/env) | ✓ (absent, checked closely) | "as observed live on the deployed test environment… not just in the codebase" names WHAT is under test (the exemplar itself requires CP to name "the test env" as part of the claim's subject) — no tool/procedure is prescribed (no CDP/curl/specific steps); this is CP scope-identification, not a verification protocol |
| MUST-NOT | credentials content | ✓ (absent) | none |

No FAIL rows.

---

## S04 — route: iterate → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape | ✓ | fence → 🎯 → 💡 → 1 setup line, no trailing Qs |
| G2 | ≤10 directives | ✓ | goal(1) + 2 DoD items + 1 scope-fence ≈ 4 |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | "Make the build green" → "/goal Make `pnpm build` pass" |
| G5 | no tiering | ✓ | none present |
| G6 | did not do the task | ✓ | the error is diagnosed in prose only, no fix applied |
| MUST | route iterate | ✓ | `/iterate` first line |
| MUST | error text carried verbatim | ✓ | "`src/eval/runner.ts(42,18): error TS2345: Argument of type 'string \| undefined' is not assignable to parameter of type 'string'.`" reproduced exactly |
| MUST | "root cause, not suppression" framing | ✓ | "Fix the type error at its source… not by suppressing it (`!`, `as string`, `@ts-ignore` are out unless the invariant is provably guaranteed and documented in one line)" |
| MUST | DS names the verifying command | ✓ | "1. `pnpm build` exits 0 — paste the clean exit as evidence." |
| MUST-NOT | multi-step epic structure | ✓ (absent) | single goal + 2-item DoD, no epic/phase scaffolding |
| MUST-NOT | cycle-structure instructions | ✓ (absent) | no diagnose→fix→test→verify loop prescribed — iterate's own loop is left untouched |

No FAIL rows.

---

## S05 — route: bare (non-agentic script task) → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape | ✓ | fence → 🎯 → 💡 → 1 setup line → 3 optional Qs |
| G2 | ≤10 directives | ✓ | create-script clause(1) + 4 numbered rules + UC(1) + OC/run-show(1) + scope-fence(1) ≈ 9 |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | every judgment call beyond the sample's vague ask ("first occurrence wins", "new output file", column-name assumption) is inline-flagged `(assumed: … — flag if wrong)` or offered as an optional refinement — nothing imposed silently |
| G5 | no tiering | ✓ | none present |
| G6 | did not do the task | ✓ | script is specified, not written/run by prompt-it |
| MUST | no harness skill header | ✓ | response opens directly with the task prose, no `/route` line |
| MUST | UNCERTAINTY CLAUSE present, inside block | ✓ | "If the file is missing, empty, or has no email-like column: stop and print the actual header row instead of guessing a column." |
| MUST | OUTPUT CONTRACT incl. run-and-show verification, inside block | ✓ | "When done, run the script and show its report: total rows read, rows kept, rows removed, output path. Spot-check by grepping one duplicated email in the output — it must appear exactly once." |
| MUST | case-insensitive email rule stated | ✓ | "Treats two rows as duplicates when their emails match after lowercasing + trimming whitespace" |
| MUST-NOT | @-refs to harness state files | ✓ (absent) | none |
| MUST-NOT | /read-chat refs | ✓ (absent) | none |

No FAIL rows.

---

## Summary final-1

- **S01 (plan-it): PASS** — all MUSTs satisfied (route, grounding, one-sentence goal, both consumer surfaces named, fences); no MUST-NOT violated (no sizing pre-decision, no UC/OC slot, no self-performed discovery); the goal's "configure, and remove" addition is grounded in the user's own backfill/webhooks analogy and lives only in a non-binding sketch, so it does not read as silent scope creep.
- **S02 (fable-it): PASS** — pattern-to-imitate (trigger-draft.service.ts) named, DoD sketch gives verification targets (not methods), fences present; no tiering, no persistence/autonomy clause, no verification-protocol prescription. DoD item 1 is a thin restatement of the invariant rather than its own proof pointer, but items 2–5 collectively supply real targets, so the MUST holds in substance.
- **S03 (review-it): PASS** — CP correctly names the claim-under-test and where it lives, no fresh DoD authored (points at the existing report instead), fences are review-only. The "observed live… not just in the codebase" phrasing was checked closely against the how-to-verify MUST-NOT; it identifies WHAT is under test (per the exemplar's own instruction to name "the test env" in CP) rather than prescribing a tool or procedure, so it does not cross the line.
- **S04 (iterate): PASS** — the TS2345 error is carried verbatim, root-cause-not-suppression framing is explicit, DoD names the exact verifying command (`pnpm build` exits 0); no epic structure or cycle-structure instructions leak in.
- **S05 (bare): PASS** — no harness header, uncertainty clause and output contract (with run-and-show verification) both present inside the block, case-insensitive email rule stated explicitly; no @-refs or /read-chat leakage.

All five samples PASS on every MUST with no MUST-NOT violated. No FAIL diagnoses required this pass.
