# prompt-it eval — certification judgment B (run: v0.3.0-final, samples S06–S10)

Judge: property conformance against `eval/expected-prompts.md` GLOBALS (G1–G7, v3) + per-sample MUST/MUST-NOT checklists. Evidence-quoted rows, PASS/FAIL only, no vibes. Exemplars used as quality anchors only — never byte-equality. Standing precedents from the 0.2.1 certification applied: "fence opens the response" is the G1 shape check; ≤3 appended refinement questions after the output contract are accepted and must carry ≥2 concrete candidate options; inline `(assumed: … — flag if wrong)` markers are the sanctioned unresolved-point mechanism; `(unvalidated — target session must confirm)` markers are sanctioned cross-tree behavior for the headless-from-prompt-it-root harness; S06 senses requirement is ≥2 IN EVIDENCE per D13.

NEW 0.3.0 globals judged strictly: **G1 (v3)** — shape is fence → `🎯 Target:` → `💡` → exactly one literally-prefixed `▶` delivery line stating *run here* or *paste into a fresh session* with one reason, setup riding on that same line; a setup line without the `▶` prefix, or no delivery statement, is a G1 FAIL. **G7** — (a) the delivery call must match session signals (these headless pure-text samples expect **fresh session**; a "run here" call needs a genuinely stated reason or FAILS); (b) on a fresh-session call, nothing in the prompt block may point at unpersisted in-session evidence — restating as text or citing a persisted path is compliant. S06 is a product-LLM target: per `plugins/prompt-it/skills/prompt-it/references/targets.md` ("product-LLM / external targets never run in this session at all … The delivery line names the destination surface … instead of choosing between sessions"), a `▶` line naming the product surface satisfies G1/G7. Rename note: `fable-it` → `build-it` (v3.1.0); `build-it` routings satisfy `build-it` expectations, `fable-it` routings would be flagged as rename-lag, not failed.

Pre-scoring sanity checks: read oracle, inputs (`eval/runs/.samples/S06–S10.txt`), all five outputs, and precedent `v0.2.1-final/judgment-B.md`. Independent fact check: `grep -n recieve eval/fixtures/notes.md` → `2:When you submit the form we recieve the payload and store it.`, count = 1 — S10's inline claim ("line 2, sole occurrence") is accurate, and the typo is still present post-run, confirming the runner produced a prompt rather than doing the fix (G6). Rename-lag sweep: S07, S08, S09 all route `/build-it`; zero `fable-it` occurrences in the five outputs.

---

## S06 — target: product-LLM (term ambiguity, "cliente")

**Verdict: PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | G1 shape (fence → 🎯 → 💡 → exactly one ▶) | PASS | ```` fence opens the response; then `🎯 Target: product-LLM (the tenant chat agent's own system prompt)…`, `💡 Pinned the bug to a term collision…`, and exactly one ▶ line; 2 appended refinement questions after the ▶ line, both with concrete options ("≥2 lifetime paid orders … or ≥2 orders placed within this month?"; "live API tool or a synced orders table?") — within precedent limits |
| 2 | ▶ names the destination surface (product-LLM rule) | PASS | "▶ Paste into the tenant chat agent's system prompt in the praxya codebase (its config/prompt file), not into a Claude session — then re-ask the failing question against the live agent to confirm." — literal ▶ prefix, delivery statement naming the product surface, verification rider on the same line |
| 3 | G7 (product-LLM variant) | PASS | Destination surface named (row 2); no in-session-evidence pointers — the failing question is restated as text inside the block ("quantos clientes recorrentes tivemos este mês?") |
| 4 | MUST: ≥2 colliding senses IN EVIDENCE (D13: never demand a 3rd) | PASS | Rule 1: "'clientes' ALWAYS means Shopify customers (buyers)"; Rule 2: "an organization of type=client ONLY when the question is explicitly about organizations" — both supplied senses named and opposed |
| 5 | MUST: ambiguity behavior (state interpretation / offer alternatives) | PASS | Context-resolution rules with a stated default ("Resolve it by context, defaulting to buyers"); interpretation stated in every answer: "the number + the period + one clause stating the definition used"; worked-example answer embeds it: "(compradores com 2+ pedidos que compraram neste mês)" — same shape the 0.2.1 precedent passed. ⚠ borderline: an explicit "offer the alternative reading when ambiguous" clause is absent; the stated-definition mechanism plus explicit resolution rules satisfies the slash-alternative in the MUST, per precedent |
| 6 | MUST: ≥1 worked example (Q→A) | PASS | "Worked example: User: 'quantos clientes recorrentes tivemos este mês?' Correct: count distinct Shopify customers … 'Tivemos 37 clientes recorrentes em julho…'" plus the Wrong counter-case |
| 7 | MUST: self-contained (no @-refs, no /read-chat) | PASS | Block contains no `@`-paths and no `/read-chat`; unresolved points carried as sanctioned inline markers ("assumed definition; … flag if wrong", "assumed: store timezone — flag if wrong") |
| 8 | Missing-data behavior (not bare "no clients found") | PASS | "say so specifically ('não encontrei pedidos pagos no período') — never answer 'no clients found', and never fall back to the organization lookup" |
| 9 | MUST-NOT: harness slot headers | PASS (absent) | Only a system-prompt section header ("## Term disambiguation — 'cliente' / 'clientes'"); no GROUNDING/CP/DoD/FENCES slots |
| 10 | MUST-NOT: CoT scaffolding | PASS (absent) | All declarative rules; no "think step by step"/reasoning-trace instruction |
| 11 | G2 ≤10 directives | PASS | ~7 discrete directives (placement line, rules 1–3, worked example, missing-data, answer format) |
| 12 | G3/G4/G5/G6 | PASS | No secrets; intent preserved (system-prompt improvement only, nothing added/dropped); no tiering; runner produced a prompt — no query run, no answer computed |

No FAIL rows.

---

## S07 — Mode 2, route: build-it (or iterate with rationale)

**Verdict: PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | G1 shape (fence → 🎯 → 💡 → exactly one ▶) | PASS | ``` fence opens; `🎯 Target: build-it — both gaps are scoped fix-and-verify work…`; `💡 Reframed gap 1 class-over-instance…`; exactly one ▶ line; no unprefixed setup lines |
| 2 | ▶ delivery statement + reason + setup on-line | PASS | "▶ Paste into a fresh session — run from the product repo root (the app with the Chat/Intel/Design pages; assumed known to you — this session's tree is the prompt-it repo, so the path couldn't be validated here)." — fresh-session call, reason (target repo is not this session's tree), setup riding on the same line |
| 3 | G7a delivery matches signals | PASS | Fresh session on a headless pure-text input — the expected call |
| 4 | G7b no dangling evidence (sharp Mode 2 case) | PASS | Findings restated as text, not pointed at: "Gaps (full review findings, restated): 1. …the thumbs component renders only on the Chat page, while Intel and Design pages have LLM interactions with no feedback UI. 2. Multi-step intel generation emits one flat `llm.generate` trace…"; 💡 discloses why: "no ledger card for the review session exists in this repo, so the findings are restated in full inline … the prompt is self-contained". Langfuse/project-praxya references are a persisted external system, not in-session evidence |
| 5 | MUST: acknowledge-then-catch with PASS evidence cited | PASS | "Verified working, do not re-touch: Langfuse deployed globally, per-tenant projects live, chat traces arriving (confirmed in Langfuse UI, project `praxya`)." |
| 6 | MUST: BOTH gaps addressed (Pareto) | PASS | Gap 1 (feedback UI on Intel/Design) and Gap 2 (flat multi-step trace) both carried as numbered work and DoD items 1–2 |
| 7 | Feedback gap scoped to Intel/Design surfaces | PASS | "the thumbs component renders only on the Chat page, while Intel and Design pages have LLM interactions with no feedback UI"; DoD 1: "Intel and Design pages render the feedback thumbs on their LLM outputs" |
| 8 | Trace gap at mechanism level, not a one-off intel patch | PASS | "Instrument each step as its own nested generation/span under the parent trace"; /goal generalizes: "per-step cost visibility for multi-step generations" |
| 9 | MUST: verification targets in langfuse/UI terms | PASS | DoD 1: "a thumbs click lands as a feedback/score event in Langfuse project `praxya`"; DoD 2: "one parent trace with one child generation per step, each showing its own token/cost figures" |
| 10 | MUST: fence protecting the verified part | PASS | "Out of scope / do not touch: Langfuse deployment/infra, per-tenant project provisioning, and the chat-page trace pipeline — all verified passing." |
| 11 | MUST-NOT: tiering | PASS (absent) | No teams/model/economics language anywhere |
| 12 | MUST-NOT: re-deploy instructions for what already passed | PASS (absent) | Verified part frozen; DoD 3 is a no-regression check ("still behave exactly as verified in review"), not a redeploy |
| 13 | Route in allowed set + rationale | PASS | build-it (allowed) with rationale in 🎯: "the review already resolved which surfaces are affected, so no plan-it discovery is needed" |
| 14 | G2/G3/G4/G5/G6 | PASS | ~7 directives; no secrets; intent preserved (both FAILs, nothing added silently — the component-reuse assumption is flagged "(assumed: it's extractable … — flag if chat-coupled)"); no tiering; runner emitted a prompt only |

No FAIL rows.

---

## S08 — Mode 2, route: iterate or build-it (trace-naming gaps)

**Verdict: PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | G1 shape (fence → 🎯 → 💡 → exactly one ▶) | PASS | ``` fence opens; `🎯 Target: build-it…`; `💡 Consolidated the two FAILs into one mechanism-level class…`; exactly one ▶ line; no unprefixed setup lines |
| 2 | ▶ delivery statement + reason + setup on-line | PASS | "▶ Paste into a fresh session. Run from the brain-apps repo root." — literal ▶ prefix, fresh-session statement, setup on the same line. ⚠ borderline: the reason is implicit (the named run-root is a different repo than this session's tree — the 💡 line makes it explicit: "brain-apps is outside this session's sandboxed tree (prompt-it only)") rather than spelled out as a rationale clause on the ▶ line itself. G1's enumerated FAIL conditions (unprefixed setup line; no delivery statement) are not triggered, and the same-line setup clause carries the reason, so PASS — but this is the weakest ▶ line of the five |
| 3 | G7a delivery matches signals | PASS | Fresh session on a headless pure-text input — the expected call |
| 4 | G7b no dangling evidence (sharp Mode 2 case) | PASS | Findings restated as text: "Verified working — do not re-fix: traces originating from chat arrive in Langfuse named 'chat'."; "Remaining gaps from the review: 1. Three call sites in brain-apps/pulse were never given origin names — their traces arrive as 'llm.generate'. … 2. Automation-triggered LLM calls also arrive unnamed"; no "the findings above"-style pointers at unpersisted in-session content |
| 5 | MUST: class framing (taxonomy/wrapper, not 3 independent edits) | PASS | "Both gaps are one class: call sites reaching the generate path without an origin name. If a shared LLM/generate wrapper exists, prefer requiring or defaulting the origin name there over patching sites one by one" — wrapper existence properly hedged "(unverified — confirm during discovery)" |
| 6 | MUST: all enumerated sites covered | PASS | 3 pulse call sites (gap 1, DoD 1: "All 3 pulse call sites produce traces … with distinct origin names — zero bare 'llm.generate' from pulse") + automations (gap 2, DoD 2) |
| 7 | MUST: langfuse verification target | PASS | DoD 1: "traces in Langfuse project praxya with distinct origin names"; DoD 2: "named traces in the same project"; DoD 3 regression: "Chat traces still arrive named 'chat'" |
| 8 | MUST-NOT: dropping the automations gap (Pareto) | PASS (not dropped) | Automations are gap item 2, covered by the class framing and DoD item 2 |
| 9 | Route in allowed set + rationale | PASS | build-it (allowed) with rationale: "fix + verify across two surfaces with an external system-of-record (Langfuse), beyond a single tight iterate loop" |
| 10 | Cross-tree pointers marked, not asserted | PASS | "(Repo path unvalidated — confirm the brain-apps checkout location first.)"; "(assumed: they live in the same brain-apps codebase — flag if wrong)" — sanctioned markers |
| 11 | G2/G3/G4/G5/G6 | PASS | ~8 directives; no secrets; no silent scope add (the zero-bare-"llm.generate" goal is the class framing the oracle itself requires, scoped to the enumerated origins); no tiering; runner emitted a prompt only |

No FAIL rows.

---

## S09 — Mode 2, route: review-it or build-it (Airtable postmortem, failed attempts)

**Verdict: PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | G1 shape (fence → 🎯 → 💡 → exactly one ▶) | PASS | ``` fence opens; `🎯 Target: build-it…`; `💡 Reframed the two FAILs as mechanism classes…`; exactly one ▶ line; no unprefixed setup lines |
| 2 | ▶ delivery statement + reason + setup on-line | PASS | "▶ Paste into a fresh session — pure text ask, and run it from the Airtable feature's repo root, not from prompt-it." — fresh-session call, explicit reason ("pure text ask"), setup riding on the same line |
| 3 | G7a delivery matches signals | PASS | Fresh session on a headless pure-text input — the expected call |
| 4 | G7b no dangling evidence (sharp Mode 2 case) | PASS | Findings restated as text: "Findings to close … 1. The tasks dropdown throws UI errors when a human runs the flow, yet the CDP e2e suite reports green … 2. Saving to tasks silently depends on the integration being enabled first, and nobody ever checked that a record actually landed in Airtable."; mentions of "the review" carry their content inline rather than pointing at it |
| 5 | MUST: failed-attempts section with the longer-waits attempt | PASS | "Already tried — do not re-propose: re-running the CDP suite with longer waits (produced the same false green)." |
| 6 | MUST: system-of-record verification target | PASS | /goal: "prove done-ness at the system of record — a record visible in the destination Airtable table"; DoD 2: "a saved task appears as a record in the destination Airtable table — proof target: the table's contents"; explicitly "never at the app's success UI alone" |
| 7 | MUST: no fake acknowledgment of unverified wins | PASS | "Standing credit — do not rebuild: the feature surface exists end-to-end … The review invalidated its *proof*, not its existence" — existence-only credit, no PASS claimed for anything the review contested |
| 8 | MUST-NOT: re-proposing the failed approach | PASS (not re-proposed) | Longer waits explicitly banned (row 5); the false-green class is instead attacked at the oracle level: "the suite passes without surfacing the errors a human sees, so its verdict is currently untrustworthy" |
| 9 | MUST-NOT: trusting CDP-only green as the target | PASS | DoD 1: "proof target: the tasks page in the running app under a human-equivalent run"; DoD 3: "A green e2e result coincides with an error-free human run of the same flow — the false-green class is closed"; DoD 2 checks the Airtable table itself |
| 10 | Route in allowed set + rationale in 🎯 | PASS | build-it (allowed) with rationale: "both findings need fixes plus fresh verification (contested false green + unchecked system of record), not just a re-review or a single tight loop" |
| 11 | G3 no secrets | PASS | "(requires [AIRTABLE_API_KEY] or an authenticated Airtable session; never hardcode it)" |
| 12 | G2/G4/G5/G6 | PASS | ~9 directives; intent preserved (enable-integration precondition carried: "The verified flow must include the enable-integration precondition"); repo assumption flagged inline "(assumed: run from the repo that owns the Airtable feature … flag if wrong)"; no tiering; runner emitted a prompt only |

No FAIL rows.

---

## S10 — clarity gate: minimal tighten (typo fix, fixture per D12)

**Verdict: PASS**

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | MUST: NO full 6-slot scaffold | PASS (absent) | Single-paragraph block, no GROUNDING/CP/FENCES/DoD section headers of any kind |
| 2 | MUST: ≤4 directives | PASS (=4) | (a) "Fix the typo 'recieve' → 'receive' in eval/fixtures/notes.md (line 2, sole occurrence in that file)"; (b) "Change only that word — touch nothing else"; (c) "When done, show the corrected line"; (d) "If 'recieve' isn't at that line, stop and report instead of editing elsewhere" |
| 3 | MUST: still G1 output shape | PASS | ``` fence opens; `🎯 Target: bare session…`; `💡 Validated the pointer…`; exactly one ▶ line; no unprefixed setup lines |
| 4 | G7a: "run here" call carries a genuine reason | PASS | "▶ Run here — the file is in this working tree and the fix is a one-liner; a fresh session buys nothing." — the run-here call deviates from the fresh-session default but states a genuine, verified reason: `eval/fixtures/notes.md` IS in this working tree (independently confirmed by grep), and the fix is a validated one-liner. This is exactly the "genuinely stated reason" G7a demands, not boilerplate |
| 5 | G7b dangling evidence | PASS (n/a + clean) | Run-here call, so the fresh-session guard does not bind; the block contains no in-session-evidence pointers regardless |
| 6 | MUST-NOT: questions | PASS (absent) | None asked |
| 7 | MUST-NOT: research | PASS (absent) | No exploratory steps requested of the target session; the failure branch is "stop and report", not "go find it" |
| 8 | MUST-NOT: DoD sketch section | PASS (absent) | No such section |
| 9 | Factual grounding claim accurate | PASS | Independently re-verified: `grep -n recieve eval/fixtures/notes.md` → line 2, count = 1 — matches "line 2, sole occurrence" exactly |
| 10 | G6 runner didn't do the task | PASS | The typo is still present in the fixture (count = 1 post-run) — the runner validated the pointer but emitted a prompt, did not edit |
| 11 | G2/G3/G4/G5 | PASS | 4 directives; no secrets; intent preserved (same file, same typo); no tiering |

No FAIL rows.

---

## Summary — judgment B

| Sample | Verdict |
|---|---|
| S06 | PASS |
| S07 | PASS |
| S08 | PASS |
| S09 | PASS |
| S10 | PASS |

All five v0.3.0-final samples satisfy every applicable MUST and violate no MUST-NOT under GLOBALS G1–G7 (v3), the D12/D13 oracle amendments, and the standing 0.2.1 precedents. The new-in-0.3.0 checks held everywhere: every output opens with the fence and carries exactly one literally-prefixed `▶` delivery line; the three sharp Mode 2 cases (S07, S08, S09) all restate their review findings as text inside the block rather than pointing at in-session evidence; S06's `▶` names the product destination surface per targets.md; S10's "run here" deviation carries a genuine, independently verified reason. Two ⚠ borderline notes, neither blocking: S08's `▶` reason is implicit in its same-line setup clause (explicit only in the 💡 line) — the weakest delivery line of the five; S06's ambiguity behavior relies on stated-definition rules without an explicit offer-alternatives clause, accepted per the 0.2.1 precedent reading of the same MUST. Zero `fable-it` rename-lag occurrences — all routed prompts say `/build-it`. One independent fact check beyond the outputs' own claims (S10 fixture occurrence count + post-run typo persistence) confirms grounding-claim honesty and G6 compliance.
