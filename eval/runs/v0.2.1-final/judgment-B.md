# prompt-it eval — certification judgment B (run: v0.2.1-final, samples S06–S10)

Judge: property conformance against `eval/expected-prompts.md` GLOBALS (G1–G6) + per-sample MUST/MUST-NOT checklists. Evidence-quoted rows, ✓/✗ only, no vibes. Exemplars used as quality anchors only — never byte-equality. Standing precedents applied: "fence opens the response" is the G1 shape check; ≤2 setup lines and ≤3 appended refinement questions AFTER the output contract are accepted; questions must carry concrete candidate options; inline `(assumed: … — flag if wrong)` markers are the sanctioned unresolved-point mechanism; "(unvalidated — target session must confirm)" markers are sanctioned cross-tree behavior for the headless-from-prompt-it-root harness.

Pre-scoring sanity checks: read oracle (incl. S06 ≥2-senses amendment per D13 and S10 fixture repoint per D12), inputs, all five outputs, and precedent `v0.2.0-final/judgment-final-2.md` (which covered S06–S10; none of my samples were among the v0.2.0 stragglers in `judgment-retry-final.md`). Independent fact check: `grep -n recieve eval/fixtures/notes.md` → `2:When you submit the form we recieve the payload and store it.`, count = 1 — S10's inline claim ("line 2, sole occurrence") is accurate, and the typo is still present, confirming the runner produced a prompt rather than doing the fix.

---

## S06 — target: product-LLM (term ambiguity, "cliente")

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | ≥2 colliding senses in evidence named (D13: never demand a 3rd) | ✓ | "it means Shopify customers (buyers) — NOT organizations of type=client" — both supplied senses named and opposed |
| 2 | Ambiguity behavior (state interpretation / offer alternatives) | ✓ | Disambiguation rule ("Interpret it as an org only when the question explicitly says org/organização, conta, or contrato") plus interpretation stated in every answer: "Answer format: number + period + one-line definition used"; worked-example answer embeds it: "(compradores com 2+ pedidos)" |
| 3 | ≥1 worked example (Q→A pair) | ✓ | "Worked example: Q: \"quantos clientes recorrentes tivemos este mês?\" → Query Shopify orders… → \"Tivemos N clientes recorrentes…\"" |
| 4 | Self-contained (no @-refs, no /read-chat) | ✓ | Block contains no `@`-paths and no `/read-chat`; 💡 confirms "the block is fully self-contained" |
| 5 | MUST-NOT: harness slot headers | ✓ (absent) | Only a system-prompt section header ("## Term disambiguation…"); no GROUNDING/CP/DoD/FENCES slots |
| 6 | MUST-NOT: CoT scaffolding requirements | ✓ (absent) | All declarative rules; no "think step by step"/reasoning-trace instruction |
| 7 | Missing-data behavior (anchor: not bare "no clients found") | ✓ | "say which source failed or was empty (\"não consegui consultar os pedidos da Shopify\") — never reply \"no clients found\"" |
| 8 | G1 shape | ✓ | Fence opens the response; then `🎯 Target:` line, `💡` line, 1 setup line ("Paste it adjacent…"), 2 appended refinement questions — within precedent limits, both with concrete options (≥2 lifetime vs within-period; stop vs labeled org-count alternative) |
| 9 | G2 ≤10 directives | ✓ | ~8 discrete rules inside the block |
| 10 | G4/G6 | ✓ | Intent preserved (system-prompt improvement only); no query run, no answer computed — runner produced a prompt |

Note (non-blocking): the block's first line is a one-line framing directive ("Add this section to the tenant chat agent's system prompt (assumed: appended as a new section — flag if wrong)"). It uses the sanctioned inline-assumption marker and violates no MUST; the payload below it is the self-contained system-prompt section.

No FAIL rows.

---

## S07 — Mode 2, route: fable-it (or iterate with rationale)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Acknowledge-then-catch with PASS evidence cited | ✓ | "**Verified working (build on it, don't re-touch):** Langfuse deployed globally, per-tenant projects live, chat traces arriving — verified in the Langfuse UI, project `praxya`." |
| 2 | BOTH gaps addressed (Pareto) | ✓ | "**Gap 1 — feedback coverage.**…Intel and Design pages have LLM interactions with no feedback UI" and "**Gap 2 — flat traces.** Multi-step intel generation emits a single flat `llm.generate` trace" |
| 3 | Feedback gap scoped to Intel/Design surfaces | ✓ | "Generalize the existing chat-page component… then attach it to Intel and Design"; expansion beyond the two is explicitly gated: "(assumed: Intel + Design are the only uncovered LLM surfaces… flag them rather than silently expanding.)" |
| 4 | Trace gap at mechanism level, not a one-off patch | ✓ | "Restructure the instrumentation so it emits a parent trace with one child span per step, each carrying its own token/cost figures" |
| 5 | Verification targets in langfuse/UI terms | ✓ | DoD 1: "a submitted rating appears in Langfuse (project `praxya`) attached to that interaction's trace"; DoD 4: "shows in the Langfuse UI as nested per-step spans with per-step cost" |
| 6 | Fence protecting the verified part | ✓ | "Out of scope / do not touch: Langfuse deployment/infra, per-tenant project provisioning, and the chat tracing pipeline — all verified working in round 1." |
| 7 | MUST-NOT: tiering | ✓ (absent) | No teams/model/economics language anywhere |
| 8 | MUST-NOT: re-deploy instructions for what already passed | ✓ (absent) | Verified part frozen, not re-instructed; DoD 3 is a no-regression check, not a redeploy |
| 9 | Route + rationale | ✓ | "🎯 Target: fable-it — both gaps are review-verified fixes with derivable done-ness…fix + verify in one autonomous run" |
| 10 | G1/G2 shape | ✓ | ````markdown fence opens the response; 🎯, 💡, 1 setup line ("Run from the product repo root (path unvalidated from this repo…)") — sanctioned cross-tree marker; ~8 directives |

No FAIL rows.

---

## S08 — Mode 2, route: iterate or fable-it (trace-naming gaps)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Class framing (taxonomy/wrapper, not 3 independent edits) | ✓ | "Gaps — both instances of one class: call sites that bypass the origin-naming mechanism chat now uses." and "Prefer the class fix over point patches: extend the same mechanism that made chat work… so an origin without a name is defaulted or caught" |
| 2 | All enumerated sites covered | ✓ | "1. `brain-apps/pulse` has 3 LLM call sites still emitting bare \"llm.generate\"" + "2. Automation-triggered LLM calls also arrive unnamed" — both carried into DoD 1 and DoD 2 |
| 3 | Langfuse verification target | ✓ | DoD 1/2: "origin-named traces — visible in Langfuse project `praxya`"; DoD 3: "No new bare \"llm.generate\" traces appear in `praxya`" |
| 4 | MUST-NOT: dropping the automations gap | ✓ (not dropped) | Automations are gap item 2 and DoD item 2 |
| 5 | Route + rationale | ✓ | "🎯 Target: fable-it — undisputed fix + verify across two surfaces… too wide for a single /iterate loop" — within the allowed set |
| 6 | Cross-tree pointers marked, not asserted | ✓ | "(path per review — unvalidated from this tree; confirm it first)"; wrapper assumption flagged: "(assumed: a shared wrapper around llm.generate owns the trace name — flag if naming is per-call-site)" |
| 7 | G4 no silent scope add | ✓ | The no-bare-traces sweep (DoD 3) widens beyond the enumerated sites but is DISCLOSED and reversible: 💡 "added DoD item 3 as a no-bare-traces sweep… drop item 3 if you want only the enumerated fixes" — not silent, and consistent with the class framing the oracle requires |
| 8 | G1/G2/G5 | ✓ | Fence opens; 🎯, 💡, 1 setup line; ~8 directives; no tiering content |

No FAIL rows.

---

## S09 — Mode 2, route: review-it or fable-it (Airtable postmortem, failed attempts)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Failed-attempts section with the longer-waits attempt | ✓ | "Already tried, do NOT re-propose: re-running the CDP suite with longer waits — same false green." |
| 2 | System-of-record verification target (record in Airtable, not our UI) | ✓ | DoD 2: "A task saved through the UI appears as a record in the Airtable tasks table"; /goal: "saved record visible in Airtable" |
| 3 | No fake acknowledgment of unverified wins | ✓ | "What stands: the write feature and its CDP e2e suite exist and run, and once the integration is enabled the UI save path completes (downstream unverified). Nothing else is trusted — both green claims were contested by a human run." — code-exists facts only, with explicit unverified marker; no PASS claim anywhere |
| 4 | MUST-NOT: re-proposing the failed approach | ✓ (not re-proposed) | Explicitly banned (row 1); the fix instead targets the suite's oracle: "the suite's oracle never observes page/console errors… Fix that mechanism in the suite first" |
| 5 | MUST-NOT: trusting CDP-only green as the target | ✓ | DoD 1: "zero UI/console errors in the running app, not just in the suite"; DoD 3 forces the suite red against the pre-fix error; DoD 2 checks the Airtable table itself |
| 6 | Route + rationale (review-it or fable-it) | ✓ | "🎯 Target: fable-it — both findings need fixes plus fresh verification (a false green and an unchecked system of record), not just a re-review." |
| 7 | G3 no secrets | ✓ | "(assumes authenticated Airtable access via the project's existing [AIRTABLE_API_KEY]-style env)" |
| 8 | G1 shape | ✓ | Fence opens; 🎯, 💡, 1 setup line ("Run from the repo that owns the Airtable feature…"), 1 refinement question with concrete candidate options (Ottimus vs a repo outside ~/Workspace/Devotts) — within precedent limits |
| 9 | G2/G4/G5/G6 | ✓ | ~9 directives; intent preserved (integration-enable precondition carried with an inline assumption marker); no tiering; runner produced a prompt only |

No FAIL rows.

---

## S10 — clarity gate: minimal tighten (typo fix, fixture per D12)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | NO full 6-slot scaffold (no GROUNDING/CP/FENCES sections) | ✓ (absent) | Single-paragraph block, no section headers of any kind |
| 2 | ≤4 directives | ✓ (=4) | (a) "Fix the typo \"recieve\" → \"receive\" in eval/fixtures/notes.md (line 2, sole occurrence)"; (b) "Change only that word — touch nothing else"; (c) "When done, show the corrected line"; (d) "If \"recieve\" isn't found at that line, stop and report instead of editing elsewhere" |
| 3 | Still G1 output shape | ✓ | Fence opens the response; `🎯 Target:` line, `💡` line, 1 setup line ("Run from the prompt-it repo root.") |
| 4 | MUST-NOT: questions | ✓ (absent) | None asked |
| 5 | MUST-NOT: research | ✓ (absent) | No exploratory steps requested of the target session |
| 6 | MUST-NOT: DoD sketch section | ✓ (absent) | No such section |
| 7 | Factual grounding claim accurate (D12 fixture) | ✓ | Independently re-verified: `eval/fixtures/notes.md:2` contains "recieve", grep count = 1 — matches "line 2, sole occurrence" exactly |
| 8 | G6 runner didn't do the task | ✓ | The typo is still present in the fixture (count = 1 post-run) — the runner validated the pointer but emitted a prompt, did not edit |

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

All five v0.2.1-final samples satisfy every applicable MUST and violate no MUST-NOT under GLOBALS G1–G6, the D12/D13 oracle amendments, and the standing precedents. No FAILs; no diagnoses required. One independent fact check beyond the outputs' own claims (S10 fixture occurrence count + post-run typo persistence) confirms grounding-claim honesty and G6 compliance.
