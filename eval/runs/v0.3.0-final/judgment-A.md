# v0.3.0-final certification — Judge A (S01–S05)

Oracle: `eval/expected-prompts.md` (globals G1–G7 + per-sample MUST/MUST-NOT). Inputs: `eval/runs/.samples/S01.txt`–`S05.txt` (byte-identical to `eval/sample-prompts.md`). Precedent applied: `eval/runs/v0.2.1-final/judgment-A.md` — properties, not byte-equality; standing rulings honored: fence-opens-response is the G1 shape check; ≤3 appended refinement questions after the output contract do not violate G1; questions must carry ≥2 concrete candidate options; inline `(assumed: … — flag if wrong)` markers are the sanctioned handling of unresolved points; `(unvalidated — target session must confirm)` markers are sanctioned cross-tree behavior for the headless prompt-it-repo run. NEW in 0.3.0, judged strictly: G1's `▶` delivery line (exactly one, literally prefixed `▶`, states run-here or fresh-session with a reason, setup rides the same line) and G7 (delivery call must match session signals — fresh expected for these headless pure-text samples; no dangling in-session evidence inside the block on a fresh call). Routing rename honored: `fable-it` → `build-it` (v3.1.0); outputs route `/build-it`. All five `.err` files are 0 bytes — no harness noise.

---

## S01 — route: plan-it → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ | Response opens at ` ```` ` line 1; after close: `🎯 Target: plan-it —…`, `💡 This session runs in the prompt-it repo…`, then exactly one `▶` line: "▶ Paste into a fresh session — run from the brain system's repo (or monorepo) root so plan-it's discovery can ground the pointers." — literal `▶` prefix, fresh-session statement, reason ("so plan-it's discovery can ground the pointers"), setup rides the same line. 3 appended refinement questions after the contract — sanctioned (≤3, each with 2 concrete options: invocation-vs-registry-only; in-agent vs shared gateway; curated catalog vs free-form URL) |
| G7 | delivery call + dangling evidence | ✓ | Fresh-session call = the expected call for this headless pure-text input. Nothing in the block points at in-session evidence: all repo pointers are named paths/modules with sanctioned `(unvalidated — confirm path during discovery)` markers; the one URL (modelcontextprotocol.io) is persistent |
| G2 | ≤10 directives | ✓ | goal(1) + 3 discovery-must-resolve items + 4 DoD-sketch items + out-of-scope clause(1) ≈ 9 |
| G3 | no credentials | ✓ | secrets/OAuth mentioned only as discovery *topics* ("whether MCP credentials/OAuth tokens fit that store") — no values, no placeholders needed |
| G4 | intent preserved | ✓ | "MCP section in integrations settings like… backfill and webhooks" + "brain-agent plus brain-apps need visibility" + "figure out how we'd do this" all carried; the two material additions (runtime tool *invocation* by brain-agent; billing out of scope) are inline-flagged "(assumed… — flag if wrong)" — sanctioned per precedent |
| G5 | no tiering/teams | ✓ | none in block |
| G6 | runner did not do the task | ✓ | prompt only; no MCP design performed — open questions assigned to plan-it's discovery ("unresolved scope — plan-it owns this") |
| MUST | route plan-it | ✓ | `/plan-it` first line inside fence |
| MUST | GROUNDING | ✓ | "Grounding: Our brain system's tenant-facing integrations settings already has sections for backfill and webhooks, but no support for third-party MCP servers…" |
| MUST | /goal one sentence | ✓ | "/goal Produce the spec + delivery package for tenant-installable MCP servers: an 'MCP servers' section in integrations settings…, plus a per-tenant registry that gives brain-agent and brain-apps visibility…" — single sentence with an inline-flagged assumption |
| MUST | CP names the two consumer surfaces | ✓ | CP bullets: "brain-agent — candidate MCP client runtime" and "brain-apps — consumer needing read visibility of installed MCPs" |
| MUST | SCOPE FENCES present | ✓ | "Out of scope / do not touch: building our own MCP servers for third parties; the existing backfill and webhooks sections beyond extracting their shared UI pattern; billing/plan-gating…" |
| MUST-NOT | sizing/shape pre-decision | ✓ (absent) | no "N squads"/"size L" language anywhere |
| MUST-NOT | uncertainty clause | ✓ (absent) | no bare-anatomy ask-don't-guess slot; the "Discovery must resolve" list assigns open points to plan-it's own discovery ("plan-it owns this") and the rest are sanctioned inline `(assumed…)` markers |
| MUST-NOT | output contract | ✓ (absent) | no deliverable-location/format contract; DoD sketch explicitly "(for plan-it to lock)" |
| MUST-NOT | discovery performed by prompt-it | ✓ (absent) | CP labeled "all cross-repo — this compile ran outside the brain workspace, so every repo pointer is unvalidated; target session must locate these first" — lookups assigned to the future session |

No FAIL rows. **PASS.**

---

## S02 — route: build-it → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ ⚠ borderline | Fence opens response → `🎯 Target: build-it —…` → `💡 brain-api-core lives outside this working tree…` → exactly one `▶` line: "▶ Paste into a fresh session. Run from the brain-api-core repo root." — literal prefix, fresh-session statement, setup rides the line, no questions. ⚠ borderline: the reason is fused into the setup clause rather than stated separately — "Run from the brain-api-core repo root" entails the why (the target repo is not this tree; the 💡 says so explicitly). The oracle's enumerated G1 FAIL triggers (setup line without `▶`; no delivery statement) are not hit, and G7's hard reason-requirement applies to *run-here* calls; ruled PASS, but a standalone reason clause on the `▶` line would be cleaner |
| G7 | delivery call + dangling evidence | ✓ | Fresh-session call = expected for headless text input. No in-session evidence pointers in the block: the fallback chain is stated in words, `trigger-draft.service.ts` is a persisted repo path, and the cross-tree caveat uses the sanctioned "(unvalidated — confirm the repo path first; it is outside the tree this prompt was compiled in)" marker |
| G2 | ≤10 directives | ✓ | goal(1) + reuse-helper-not-copy(1) + 4 DoD items + fence clause(1) ≈ 7 |
| G3 | no credentials | ✓ | `OPENROUTER_API_KEY` / `OPENAI_API_KEY` named as identifiers only — no values |
| G4 | intent preserved | ✓ | Full resolution chain (per-Space "Direct (OpenRouter)" → `OPENROUTER_API_KEY` → `OPENAI_API_KEY`) carried verbatim; "Build and ship it" → "/goal …and ship it" + DoD 4 "Shipped through brain-api-core's standard merge + deploy pipeline"; single-client assumption inline-flagged "(assumed: a single client/service in the ontology module — …flag if there are several call sites)" |
| G5 | no tiering | ✓ | none |
| G6 | did not do the task | ✓ | prompt only |
| MUST | route build-it | ✓ | `/build-it` first line (oracle's post-rename name — no rename lag) |
| MUST | pattern-to-imitate named (trigger-draft.service.ts) | ✓ | "Pattern to mirror: `trigger-draft.service.ts` — it already resolves the per-Space… key, then falls back… Reuse its resolution helper if one is extractable rather than copying the logic." |
| MUST | DoD sketch numbered, each item with a verification TARGET | ✓ | 1: "proven by unit tests on the ontology client mirroring trigger-draft's coverage"; 2: "proven at the outbound OpenRouter request (auth header / request log attribution)" — the real-Space proof; 3: "existing ontology tests stay green" — the env==connection no-regression case; 4: the merge+deploy pipeline as target |
| MUST | SCOPE FENCES | ✓ | "Out of scope / do not touch: trigger-draft.service.ts itself (reference only); key resolution of any other client; no new env vars or config surfaces." — the single-seam / no-second-copy fence |
| MUST-NOT | tiering note | ✓ (absent) | none |
| MUST-NOT | persistence/autonomy clauses | ✓ (absent) | DoD 4 is an outcome, not a run-state/stop-condition contract |
| MUST-NOT | verification protocol prescriptions | ✓ (absent) | DoD items name WHAT proves each claim (unit tests, outbound request attribution, green suite) — no tool/setup/how-to-run-QA steps |

No FAIL rows. **PASS.**

---

## S03 — route: review-it → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ | Fence opens response → `🎯 Target: review-it —…` → `💡 Couldn't validate "the last session"…` → exactly one `▶` line: "▶ Paste into a fresh session — pure text ask; run from the repo that owns the feedback component (assumed: the ANM/Beacon repo, per the session candidate)." — prefix, fresh-session statement, reason ("pure text ask"), setup rides the line. 1 appended refinement question with 2 concrete candidates (`fix-sow-feedbacks-exec` ANM 07-17 vs `praxya-feedbacks-pt4` 07-17) — sanctioned |
| G7 | delivery call + dangling evidence | ✓ | Fresh-session = expected call, reason stated. The claim source is pointed at via `/read-chat "fix-sow-feedbacks-exec"` — a *persisted*, named session transcript resolvable from any fresh session, i.e. the oracle's "pointed at by a persisted path" case, not a dangling in-session reference; "the last session's report" is immediately pinned to that named target rather than left dangling |
| G2 | ≤10 directives | ✓ | goal(1) + claim-pointer/verify-against-existing(2) + both-halves clause(1) + fence(1) ≈ 5 |
| G3 | no credentials | ✓ | none |
| G4 | intent preserved | ✓ | "check it's actually done — the claim is in the last session's report" → "Verify the team's claim… — I need an evidence-backed verdict before telling the client it's done" — client-gating stake carried |
| G5 | no tiering | ✓ | none |
| G6 | did not do the task | ✓ | no verdict rendered; the 💡's ledger sweep (project + global INDEX through 2026-07-28) is pointer validation — sanctioned per precedent (0.2.1 S03 ruling), and it honestly surfaces a discrepancy ("that card claims prod-verified, not test env") instead of resolving it |
| MUST | route review-it | ✓ | `/review-it` first line |
| MUST | CP identifies claim-under-test + where the claim lives | ✓ | "Claim under test: the completion claim in the last session's report — `/read-chat \"fix-sow-feedbacks-exec\"` (assumed: the Beacon SOW-feedback session is where this component shipped — flag if wrong…)" — claim + location + flagged assumption; test env named as half (2) of the verdict |
| MUST | SCOPE FENCES | ✓ | "Out of scope / do not touch: no fixes, no redeploys, no code changes — verdict and cited evidence only; any gaps become a follow-up iteration prompt." |
| MUST-NOT | fresh DoD authored | ✓ (absent) | no numbered DoD; explicitly "Verify against that report's own claimed status and existing test contract — do not author a new DoD." |
| MUST-NOT | HOW-to-verify instructions (tools/env) | ✓ (absent) | "The verdict must cover both halves of the claim separately: (1) component finished, (2) actually live in the test environment" identifies WHAT is under test (the exemplar itself requires the CP to name the test env) — no tools/procedure prescribed; precedent ruled this exact shape in-bounds |
| MUST-NOT | credentials content | ✓ (absent) | none |
| — | question carries concrete options | ✓ | 2 named candidate sessions with repos and dates |

No FAIL rows. **PASS.**

---

## S04 — route: iterate → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ | Fence opens response → `🎯 Target: iterate —…` → `💡 Validated the pointer…` → exactly one `▶` line: "▶ Paste into a fresh session — run from the root of the repo where `pnpm build` actually fails; this session's working tree can't reach it." — prefix, fresh-session statement, explicit reason ("this session's working tree can't reach it"), setup rides the line, no questions |
| G7 | delivery call + dangling evidence (the sharp case) | ✓ | Fresh-session = expected call with a genuine reason. The TS2345 error is carried as its full TEXT inside the block ("src/eval/runner.ts(42,18): error TS2345: Argument of type 'string \| undefined' is not assignable to parameter of type 'string'.") — the compliant form; the block never says "the error I pasted"/"above". The one relative reference, "the repo where you ran `pnpm build`", addresses the *user's* knowledge, resolvable from any fresh session — not in-session evidence |
| G2 | ≤10 directives | ✓ | goal(1) + root-cause rule(1) + DoD(1) + fences(2: no refactors beyond fix; no tsconfig loosening) ≈ 5 |
| G3 | no credentials | ✓ | none |
| G4 | intent preserved | ✓ | "Make the build green" → "/goal Make `pnpm build` pass"; the root-cause/no-suppression framing is the oracle's own required addition, and the runtime-undefined rationale ("the undefined value can really occur at runtime") explains rather than expands scope |
| G5 | no tiering | ✓ | none |
| G6 | did not do the task | ✓ | no fix applied; the 💡's check that `src/eval/runner.ts` is absent from prompt-it is dead-pointer duty, not doing the task |
| MUST | route iterate | ✓ | `/iterate` first line |
| MUST | error text carried into the prompt | ✓ | verbatim under "Failing check: `pnpm build` →" (see G7 row) |
| MUST | "root cause, not suppression" framing | ✓ | "Fix the error at its source: handle the `undefined` case (narrow, guard, or fix the upstream type) rather than silencing it with `!` or `as string`" + "do not loosen tsconfig strictness flags" |
| MUST | DS names the verifying command | ✓ | "DoD: 1. `pnpm build` exits 0 with no TypeScript errors in the output." |
| MUST-NOT | multi-step epic structure | ✓ (absent) | single goal, single DoD item, no phases/epics |
| MUST-NOT | cycle-structure instructions | ✓ (absent) | the DoD states the done-oracle only — no diagnose→fix→test loop mechanics prescribed; iterate's own loop untouched |
| — | dead-pointer duty | ✓ | block: "(unvalidated — confirm this path exists in the repo you run this from; it is NOT in prompt-it, which has no package.json — assumed: the repo where you ran `pnpm build` — flag if wrong)"; 💡 discloses the validation |

No FAIL rows. **PASS.**

---

## S05 — route: bare (non-agentic script task) → **PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ | Fence opens response → `🎯 Target: bare session —…` → `💡 Locked the ambiguous semantics…` → exactly one `▶` line: "▶ Paste into a fresh session — run from the scratch repo root; `data/customers.csv` is user-supplied and unvalidated from here, the target session confirms it on read." — prefix, fresh-session statement, reason (file unreachable from compile session), setup rides the line. 3 appended refinement questions — sanctioned (≤3, each with 2 concrete options: first vs last survivor; new file vs in-place+`.bak`; Python 3 vs Node) |
| G7 | delivery call + dangling evidence | ✓ | Fresh-session = expected call — and matches the user's own signal ("scratch repo with no plugins installed"). No in-session evidence pointers: `data/customers.csv` is a persisted repo path the target session validates on read |
| G2 | ≤10 directives | ✓ | dedupe rule(1) + script spec with 3 numbered requirements(4) + missing-file clause(1) + run-and-show(1) + fence(1) ≈ 8 |
| G3 | no credentials | ✓ | none |
| G4 | intent preserved | ✓ | dedupe-by-email + report-rows-removed carried; every judgment call the vague ask left open (Python 3, keep-first, non-destructive new-file output, `email` header column) is inline-flagged "(assumed… — flag if wrong)" or offered as a refinement question — nothing imposed silently |
| G5 | no tiering | ✓ | none |
| G6 | did not do the task | ✓ | the prompt instructs the *target* session to write and run the script; prompt-it wrote none |
| MUST | no harness skill header | ✓ | block opens directly with "Dedupe data/customers.csv." — no `/plan-it`/`/build-it`/etc. line |
| MUST | UNCERTAINTY CLAUSE present | ✓ | "If data/customers.csv is missing or unparseable, stop and report the error — never fabricate sample data." + item 1: "if that column is missing or named differently, stop and report what columns exist instead of guessing" |
| MUST | OUTPUT CONTRACT incl. end-to-end verification (run + show counts) | ✓ | script path pinned (`scripts/dedupe_customers.py`), report format pinned ("total data rows read, duplicates removed, rows kept"), and "When done, run the script and show its printed report plus `wc -l` of both files so the removed-row count is verifiable." |
| MUST | case-insensitive email rule stated | ✓ | "Rows are duplicates when their `email` values match case-insensitively (other columns may differ)"; fence adds "lowercasing is the dedupe key only, not a rewrite" |
| MUST-NOT | @-refs to harness state files | ✓ (absent) | none |
| MUST-NOT | /read-chat refs | ✓ (absent) | none |
| — | questions carry concrete options | ✓ | all 3 offer 2 explicit candidates each |

No FAIL rows. **PASS.**

---

## Summary — Judge A

| Sample | Verdict | Driver |
|---|---|---|
| S01 | PASS | New `▶` line fully formed (fresh + reason + setup); fresh call correct; all 5 MUSTs hold, all 4 MUST-NOTs absent; assumptions inline-flagged per precedent |
| S02 | PASS | Routes `/build-it` (post-rename, matches oracle); pattern named, all 4 DoD items carry verification targets, single-seam fence; ⚠ borderline on G1: `▶` reason fused into the setup clause ("Run from the brain-api-core repo root") rather than stated standalone — not an enumerated G1/G7 FAIL trigger since the call is fresh-session and the delivery statement + setup are present |
| S03 | PASS | Claim + location identified via persisted `/read-chat` pointer (compliant under G7's persisted-path rule, not dangling evidence); no fresh DoD; review-only fence; question carries 2 concrete candidates |
| S04 | PASS | The G7 sharp case handled correctly: TS2345 error text pasted verbatim, never pointed at; fresh call with explicit reason; root-cause-not-suppression + `pnpm build` exits-0 oracle; no epic/cycle leakage |
| S05 | PASS | No harness header; uncertainty clause + output contract with run-and-show counts; case-insensitive rule explicit; fresh call matches the user's own no-plugins signal; no @-refs or /read-chat |

5/5 PASS. One ⚠ borderline (S02 G1 reason phrasing) recorded; no FAIL diagnoses required. No rename-lag observed — both build-it-routed samples emit `/build-it`.
