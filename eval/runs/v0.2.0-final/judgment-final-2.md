# prompt-it eval — FINAL CERTIFICATION judgment (run: v0.2.0-final, pass 2)

Judge: independent QA pass per review-it honesty rules — evidence-quoted rows, closed vocabulary (✓/✗ only, no partial credit language), no vibes. Property conformance against `eval/expected-prompts.md` GLOBALS (G1–G6) + per-sample MUST/MUST-NOT, not byte-similarity against the exemplars. Scope: S06–S10 only, this being the second (final) certification pass over the v0.2.0-final run outputs.

Sanity check before scoring: read `eval/expected-prompts.md` (oracle, incl. the S06 amendment to ≥2 senses per decisions D13), `eval/sample-prompts.md` (inputs), all five outputs in `eval/runs/v0.2.0-final/`, and `plugins/prompt-it/skills/prompt-it/SKILL.md` for diagnosis grounding. Also spot-checked S06's own file-existence claim: `eval/fixtures/notes.md` line 2 is `When you submit the form we recieve the payload and store it.` — confirmed exactly one occurrence of "recieve", matching S10's inline claim.

---

## S06 — target: product-LLM (term ambiguity, "cliente")

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | ≥2 colliding senses named in evidence | ✓ | "1. **Shopify buyer**... 2. **Organization of type=client**" |
| 2 | Ambiguity behavior (state interpretation / offer alternative) | ✓ | "If neither signal is present, default to Shopify buyers and state that interpretation in one sentence, offering the other reading." |
| 3 | ≥1 worked example | ✓ | "**Worked example:** — User: \"quantos clientes recorrentes tivemos este mês?\" — Correct: query Shopify customer/order data..." |
| 4 | Self-contained (no @-refs, no /read-chat) | ✓ | Block contains no `@`-paths, no `/read-chat` — pure system-prompt prose |
| 5 | MUST-NOT: harness slot headers | ✓ (absent) | No GROUNDING/CP/DoD/FENCES headers anywhere in the block |
| 6 | MUST-NOT: CoT scaffolding | ✓ (absent) | No "think step by step" / reasoning-trace instruction; all declarative rules |
| 7 | Assumptions flagged inline | ✓ | "(assumed: the org entity is distinguished by `type=client`...)" and "(assumed definition — flag if the business counts 2+ orders...)" |
| 8 | G1 shape (fence → 🎯 → 💡 → ≤2 setup) | ✓ | Fence closes, then `🎯 Target:` line, then `💡` line, then one `Setup:` line, then appended refinement questions (permitted append, not a shape violation) |
| 9 | G6 runner didn't do the task | ✓ | Produced a system-prompt section only; no query was run, no answer computed |

No FAIL rows. No diagnosis needed.

---

## S07 — Mode 2, route: fable-it

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Acknowledge-then-catch with PASS evidence cited | ✓ | "VERIFIED WORKING — do not rebuild or touch: Langfuse deployed globally, per-tenant projects live, chat traces arriving. Verified in the Langfuse UI, project `praxya`." |
| 2 | Both gaps addressed (Pareto) | ✓ | "GAP 1 — feedback UI coupled to the chat page..." and "GAP 2 — multi-step intel generation traces flat..." both present as numbered work |
| 3 | Verification targets in langfuse/UI terms | ✓ | DoD 1: "lands as a score/feedback record in Langfuse project `praxya`"; DoD 2: "produces a Langfuse trace in `praxya` with one child span per pipeline step" |
| 4 | Fence protecting the verified part | ✓ | "Out of scope / do not touch: the Langfuse deployment itself, per-tenant project provisioning, and the chat tracing path (all verified)" |
| 5 | MUST-NOT: tiering | ✓ (absent) | No teams/model/economics language anywhere |
| 6 | MUST-NOT: re-deploy instructions for what already passed | ✓ (absent) | Verified part is explicitly frozen, not re-instructed |
| 7 | Route rationale present (fable-it or iterate, either accepted) | ✓ | "🎯 Target: fable-it — two undisputed, evidence-backed gaps needing fix + verify across frontend and instrumentation; too multi-surface for a single /iterate loop." |

No FAIL rows.

---

## S08 — Mode 2, route: iterate or fable-it (trace-naming gaps)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Class framing (taxonomy/wrapper, not 3 independent edits) | ✓ | "Remaining gaps (likely two instances of one class: naming was wired at the chat entry point, not at the shared call layer)... Prefer the mechanism-level fix: if these call sites share one LLM client/wrapper, make the origin name required..." |
| 2 | All enumerated sites covered | ✓ | "1. brain-apps/pulse — 3 call sites..." and "2. Automation-triggered calls — also arrive unnamed" both carried forward |
| 3 | Langfuse verification target | ✓ | DoD 1: "shows a distinct origin name in Langfuse project `praxya`"; DoD 2: "shows its origin name in `praxya`" |
| 4 | MUST-NOT: dropping the automations gap | ✓ (not dropped) | Automations gap is item 2 of the remaining-gaps list and DoD item 2 |
| 5 | Route rationale present | ✓ | "🎯 Target: fable-it — two gaps across separate entry paths with external (Langfuse) verification; more than one tight loop, so iterate doesn't fit." |
| 6 | Cross-tree pointers marked, not asserted as verified | ✓ | "(unvalidated — target session must confirm by grepping brain-apps/pulse...)"; "(assumed: a separate entry path from both chat and pulse — flag if wrong)" |

No FAIL rows.

---

## S09 — Mode 2, route: review-it or fable-it (Airtable postmortem, failed attempts)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Failed-attempts section carries the longer-waits attempt | ✓ | "Failed attempts — do not re-propose: re-running the CDP suite with longer waits was already tried and produced the same false green. Timing is not the cause; do not reach for waits/retries or looser assertions." |
| 2 | System-of-record verification target | ✓ | DoD 2: "A saved task exists as a record in the Airtable base/table (target: the Airtable table itself, not the app UI)." |
| 3 | No fake acknowledgment of unverified wins | ✓ | Opens with "What stands: the task-write path and the integration-enable flow are implemented" (a code-exists fact) immediately paired with "What does NOT stand: any green result from that suite — it reported green while the feature was broken for a human" — no PASS/verified claim is made anywhere |
| 4 | Route is review-it or fable-it, with rationale | ✓ | Chose fable-it: "🎯 Target: fable-it — both findings need fixes *plus* re-verification (false green + unchecked system of record), which is fix-and-verify territory, not a pure re-verify (review-it) or a single tight loop (iterate)." |
| 5 | MUST-NOT: re-proposing the failed approach | ✓ (not re-proposed) | Explicitly banned, see row 1 evidence |
| 6 | MUST-NOT: trusting CDP-only green as the target | ✓ | DoD 1 requires a "human-driven browser session" (not CDP) and DoD 2 requires the Airtable table itself; DoD 3 (suite red-then-green) is a supporting item alongside, not the sole target |
| 7 | G3 no secrets | ✓ | "Airtable integration credentials available as env vars (`[AIRTABLE_API_KEY]`-style, not inline)" |

No FAIL rows.

---

## S10 — clarity gate: minimal tighten (typo fix)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | No full 6-slot scaffold (no GROUNDING/CP/FENCES headers) | ✓ (absent) | Single paragraph, no section headers of any kind |
| 2 | ≤4 directives | ✓ (=4) | (a) fix "recieve"→"receive" at pinned location, (b) touch only that word, (c) stop-and-report if missing/multiple, (d) show corrected line via grep as proof |
| 3 | Still G1 output shape | ✓ | Fence → `🎯 Target:` line → `💡` line → one `Setup:` line |
| 4 | MUST-NOT: questions | ✓ (absent) | None asked |
| 5 | MUST-NOT: research | ✓ (absent) | No exploratory steps requested of the target session |
| 6 | MUST-NOT: DoD sketch section | ✓ (absent) | No such section |
| 7 | Factual grounding claim accurate | ✓ | Claims "line 2, the only occurrence — verified"; independently re-checked against `eval/fixtures/notes.md` — matches exactly |

No FAIL rows.

---

## Summary final-2

| Sample | Verdict |
|---|---|
| S06 | PASS |
| S07 | PASS |
| S08 | PASS |
| S09 | PASS |
| S10 | PASS |

All five samples in the v0.2.0-final run satisfy every applicable MUST and violate no MUST-NOT, against GLOBALS G1–G6 and their per-sample checklists (including the S06 amendment to ≥2 senses per decisions D13). No FAILs, no diagnoses required. This pass independently re-derives the same all-PASS result as the run's own verifier reconciliation, with one additional independent fact check (S10's occurrence-count claim against the actual fixture file) — CERTIFIED.
