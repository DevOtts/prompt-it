# v0.2.1-final certification — Judge A (S01–S05)

Oracle: `eval/expected-prompts.md` (globals G1–G6 + per-sample MUST/MUST-NOT). Inputs: `eval/sample-prompts.md`. Precedent applied: `eval/runs/v0.2.0-final/judgment-final-1.md` (S01–S05 sections) — properties, not byte-equality; standing rulings honored: fence-opens-response is the G1 shape check; ≤2 setup lines and ≤3 appended refinement questions after the output contract do not violate G1; questions must carry concrete candidate options; inline `(assumed: … — flag if wrong)` markers are the sanctioned handling of unresolved points; "(unvalidated — target session must confirm)" markers are sanctioned cross-tree behavior for the headless prompt-it-repo run. All five `.err` files are 0 bytes — no harness noise.

---

## S01 — route: plan-it → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape: fence → 🎯 → 💡 → ≤2 setup | ✓ | Response opens at ` ``` ` line 1; after close: `🎯 Target: **/plan-it** —…`, `💡 This session is sandboxed…`, 1 setup line ("Run this from the brain system's repo root…"), no questions |
| G2 | ≤10 directives | ✓ | goal(1) + 5 DoD-sketch items + 3 out-of-scope clauses ≈ 9 |
| G3 | no credentials | ✓ | only "credentials stored per the existing integration-secret conventions" — policy reference, no values |
| G4 | intent preserved | ✓ | "MCP section in integrations settings like… backfill and webhooks" + "brain-agent plus brain-apps need visibility" all carried; the two additions (install/configure/remove CRUD; catalog vs BYO-URL) ride the user's own backfill/webhooks analogy or are inline-flagged "(assumed: … — flag if catalog-only.)" — precedent (final-1 S01 G4 row) accepts exactly this |
| G5 | no tiering/teams | ✓ | none in block |
| G6 | runner did not do the task | ✓ | prompt only; no MCP design performed |
| MUST | route plan-it | ✓ | `/plan-it` first line inside fence |
| MUST | GROUNDING | ✓ | "Grounding: The brain platform's tenant integrations settings already have backfill and webhooks sections, but there is no plug-and-play way…" |
| MUST | /goal one sentence | ✓ | "/goal: Spec the delivery package for tenant-installable MCP servers — an 'MCP' section in integrations settings… plus a per-tenant registry that brain-agent and brain-apps read…" — single sentence |
| MUST | CP names the two consumer surfaces | ✓ | CP bullet 1: "brain-agent and brain-apps — the two consumers that must see installed MCPs." |
| MUST | SCOPE FENCES present | ✓ | "Out of scope / do not touch: authoring our own MCP servers for third parties; existing backfill/webhook integrations beyond adding the new section; platform-global (non-tenant) MCP configuration…" |
| MUST-NOT | sizing/shape pre-decision | ✓ (absent) | no "N squads"/"size L" language anywhere |
| MUST-NOT | uncertainty clause | ✓ (absent) | no dedicated UC/ask-don't-guess slot; only sanctioned inline "(assumed: … — flag if wrong)" markers (DoD item 5, fence line) |
| MUST-NOT | output contract | ✓ (absent) | no deliverable-location/format contract; DoD sketch is explicitly "for plan-it to lock during discovery" — the sanctioned light sketch of the exemplar |
| MUST-NOT | discovery performed by prompt-it itself | ✓ (absent) | CP is labeled "all unvalidated — compiled outside the brain repo; target session must confirm these paths first" — lookups assigned to the future session |

No FAIL rows. **PASS.**

---

## S02 — route: fable-it → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape | ✓ | fence opens response → 🎯 → 💡 → 1 setup line ("Run the prompt from the brain-api-core repo root, not from prompt-it."), no questions |
| G2 | ≤10 directives | ✓ | goal(1) + 3 DoD items + fence clause(1) + resolution-chain spec(1) ≈ 6 |
| G3 | no credentials | ✓ | env vars named as `OPENROUTER_API_KEY` / `OPENAI_API_KEY` identifiers only — no values |
| G4 | intent preserved | ✓ | "Build and ship it" → "/goal Make the ontology OpenRouter client resolve its API key per-Space… and ship it" + DoD 3 "Shipped through the repo's normal build/deploy pipeline"; the full fallback chain (per-Space → OPENROUTER_API_KEY → OPENAI_API_KEY) carried verbatim as "Resolution chain (carried from author)" |
| G5 | no tiering | ✓ | none |
| G6 | did not do the task | ✓ | prompt only |
| MUST | route fable-it | ✓ | `/fable-it` first line |
| MUST | pattern-to-imitate named (trigger-draft.service.ts) | ✓ | Grounding: "trigger-draft.service.ts already implements the correct resolution — mirror it, don't reinvent it." + CP bullet: "trigger-draft.service.ts — the pattern to imitate" |
| MUST | DoD sketch numbered, each item with a verification TARGET | ✓ | item 1: "verification target: the ontology-generation flow for a Space that has such a connection"; item 2: "verification target: same flow on a Space without one (current behavior unbroken)" — the exemplar's no-regression case; item 3 names the pipeline as target with an inline-flagged assumption — per precedent (final-1 S02 row: items collectively supplying real targets satisfies the MUST in substance) |
| MUST | SCOPE FENCES | ✓ | "Out of scope / do not touch: trigger-draft.service.ts itself (read-only reference), backbone-connection management UI/schema, other consumers' key resolution." |
| MUST-NOT | tiering note | ✓ (absent) | none (tiering-in-input is S19, not S02) |
| MUST-NOT | persistence/autonomy clauses | ✓ (absent) | "Shipped through the repo's normal build/deploy pipeline" is a DoD outcome, not a run-state/stop-condition contract |
| MUST-NOT | verification protocol prescriptions | ✓ (absent) | "verification target: the ontology-generation flow…" names WHAT proves it, not how to run QA — no tool/setup steps prescribed |

No FAIL rows. **PASS.**

---

## S03 — route: review-it → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape | ✓ | fence opens response → 🎯 → 💡 → 1 setup line → 2 optional refinement questions (≤3, after the contract — sanctioned) |
| G2 | ≤10 directives | ✓ | goal(1) + claim-location/verify-against-existing(2) + both-halves clause(1) + fence(1) ≈ 5 |
| G3 | no credentials | ✓ | none (per-sample MUST-NOT "credentials content" also clean) |
| G4 | intent preserved | ✓ | "check it's actually done — the claim is in the last session's report" → "Confirm or refute the team's claim… as stated in the last session's report"; client-gating stake carried ("this verdict gates what I tell the client") |
| G5 | no tiering | ✓ | none |
| G6 | did not do the task | ✓ | no verdict rendered; the 💡's grep of prompt-it's own ledger is pointer validation (dead-pointer duty), not performing the review |
| MUST | route review-it | ✓ | `/review-it` first line |
| MUST | CP identifies claim-under-test + where the claim lives | ✓ | "Claim under test: 'feedback thumbs up/down component finished and deployed to test env', as stated in the last session's report (assumed: the product repo's latest `.agents/history/INDEX.md` card and the run report it points at, e.g. `.fable-it-reports/report.md` — unvalidated from the compiling session; confirm this path first, flag if wrong)" |
| MUST | SCOPE FENCES | ✓ | "Out of scope / do not touch: no fixes, no code changes, no redeploys — verdict plus evidence only…" |
| MUST-NOT | fresh DoD authored | ✓ (absent) | no numbered DoD; explicitly the opposite: "Verify against that report's own stated done-criteria/test contract — do not invent new criteria." |
| MUST-NOT | HOW-to-verify instructions (tools/env) | ✓ (absent) | "Both halves of the claim count: built, and live in the test env" identifies WHAT is under test (exemplar itself requires CP to name the test env) — no tool/procedure prescribed; precedent final-1 S03 ruled this exact shape in-bounds |
| MUST-NOT | credentials content | ✓ (absent) | none |
| — | questions carry concrete options | ✓ | Q1 offers candidate repos ("the Brief/SOW/Plan generator described in `docs/prompt-examples.txt` or another Devotts project"); Q2 offers two concrete locations (".fable-it-reports/report.md-style run report, or the latest .agents/history/ ledger card") |

Note: the 💡's claim of having validated-absent locally is honest evidence work ("prompt-it's reports and ledger have zero mentions of the feedback component"), and the cross-repo pointer carries the sanctioned unvalidated marker. No FAIL rows. **PASS.**

---

## S04 — route: iterate → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape | ✓ | fence opens response → 🎯 → 💡 → 1 setup line, no questions |
| G2 | ≤10 directives | ✓ | goal(1) + root-cause rule(1) + no-tsconfig-loosening(1) + verify(1) + scope fence(1) ≈ 5 |
| G3 | no credentials | ✓ | none |
| G4 | intent preserved | ✓ | "Make the build green" → "/goal Make `pnpm build` exit green."; no scope added beyond the flagged cascade clause ("If fixing line 42 surfaces further errors, fix those too — done means a clean build"), which is the same goal, not new scope |
| G5 | no tiering | ✓ | none |
| G6 | did not do the task | ✓ | no fix applied; prompt only |
| MUST | route iterate | ✓ | `/iterate` first line |
| MUST | error text carried into the prompt | ✓ | "Failing error: `src/eval/runner.ts(42,18): error TS2345: Argument of type 'string \| undefined' is not assignable to parameter of type 'string'.`" — verbatim |
| MUST | "root cause, not suppression" framing | ✓ | "Fix the type error at its source — narrow or explicitly handle the `undefined` case; no `!` assertions or `as string` casts unless the value is provably present… Do not loosen tsconfig strictness to make the error disappear." |
| MUST | DS names the verifying command | ✓ | "Verify: rerun `pnpm build` until it exits 0." |
| MUST-NOT | multi-step epic structure | ✓ (absent) | single goal, no phases/epics |
| MUST-NOT | cycle-structure instructions | ✓ (absent) | "rerun `pnpm build` until it exits 0" states the done-oracle/target, not a prescribed diagnose→fix→test→verify loop — no loop steps or cycle mechanics enumerated; iterate's own loop untouched |
| — | dead-pointer duty | ✓ | 💡 discloses "this working tree (`prompt-it`) has no `src/eval/runner.ts`… the path is carried verbatim from your error output (assumed: you'll run this in the repo where the build fails — flag if wrong)" — sanctioned cross-tree marker |

No FAIL rows. **PASS.**

---

## S05 — route: bare (non-agentic script task) → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | output shape | ✓ | fence opens response → 🎯 → 💡 → 1 setup line → 2 optional refinement questions (≤3, appended after the contract — sanctioned) |
| G2 | ≤10 directives | ✓ | write-and-run(1) + 6 requirement bullets (incl. UC) + verify(1) + fence(1) ≈ 9 |
| G3 | no credentials | ✓ | none |
| G4 | intent preserved | ✓ | dedupe-by-email + report-rows-removed carried; every judgment call beyond the vague ask (Python, keep-first, `email` header column, in-place + `.bak` backup) is inline-flagged "(assumed — flag if …)" or offered as a refinement question — nothing imposed silently |
| G5 | no tiering | ✓ | none |
| G6 | did not do the task | ✓ | "Write and run a script…" instructs the target session; prompt-it wrote no script |
| MUST | no harness skill header | ✓ | block opens directly with task prose — no `/plan-it`/`/fable-it`/etc. line |
| MUST | UNCERTAINTY CLAUSE present | ✓ | "If the file is missing, unreadable, or has no email column: stop and report the problem — do not guess or emit a partial file." |
| MUST | OUTPUT CONTRACT incl. end-to-end verification (run + show counts) | ✓ | "Print a report: rows read, duplicates removed, rows remaining." + "Verify by running the script and showing its output, plus `wc -l` on the backup and the deduped file." |
| MUST | case-insensitive email rule stated | ✓ | "Duplicate = same email compared case-insensitively; keep the first occurrence (assumed — flag if last-wins or a merge is wanted)." |
| MUST-NOT | @-refs to harness state files | ✓ (absent) | none |
| MUST-NOT | /read-chat refs | ✓ (absent) | none |
| — | S05 note (bare non-agentic): no harness headers | ✓ | confirmed above; uncertainty clause + output contract both inside the block |
| — | questions carry concrete options | ✓ | Q1: "Keep-first or keep-last…?"; Q2: "Overwrite `data/customers.csv` (with `.bak`) or write to a new `data/customers.deduped.csv`?" |

No FAIL rows. **PASS.**

---

## Summary — Judge A

| Sample | Verdict | Driver |
|---|---|---|
| S01 | PASS | All 5 MUSTs hold (plan-it route, grounding, one-sentence goal, both consumer surfaces in CP, fences); all 4 MUST-NOTs absent; assumptions inline-flagged per precedent |
| S02 | PASS | Pattern-to-imitate named, numbered DoD with verification targets, fences; no tiering/persistence/protocol content |
| S03 | PASS | Claim + claim location identified in CP, points at the existing report's own criteria instead of authoring a fresh DoD, review-only fences; questions carry concrete options |
| S04 | PASS | Error verbatim, root-cause-not-suppression explicit, `pnpm build` exits 0 as verifying command; no epic or cycle-structure leakage |
| S05 | PASS | No harness header, uncertainty clause + output contract with run-and-show verification, case-insensitive rule explicit; no @-refs or /read-chat |

5/5 PASS. No FAIL diagnoses required.
