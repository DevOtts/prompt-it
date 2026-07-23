# prompt-it eval — expected optimized prompts + binding property checklists (v1)

Linked by ID to `eval/sample-prompts.md`. Per sample: (a) a compact REFERENCE EXEMPLAR of the expected optimized prompt — a quality anchor, NOT a byte-equality target; (b) the **binding checklist** — the oracle review-it judges against. A sample PASSES iff every MUST holds and no MUST-NOT is violated. Global checks applying to EVERY sample unless its checklist overrides them:

- G1 output shape: exactly one copyable fenced prompt block + `🎯 Target:` line + `💡` line (setup lines ≤2 only if needed).
- G2 ≤10 discrete directives inside the prompt block.
- G3 no credentials/secrets; `[ENV_VAR_NAME]`-style only.
- G4 intent preserved: no scope silently added or dropped vs the sample.
- G5 no tiering/teams/model-economics content inside the prompt block (any route).
- G6 the runner did not DO the task — it produced a prompt.

---

## S01 → route: plan-it
Exemplar: `plan-it` header; grounding (integrations has backfill/webhooks, no MCP surface); /goal plan tenant-installable third-party MCPs; context pointers to integrations settings area + brain-agent/brain-apps visibility requirement; light DoD sketch (research MCP install UX, impact map for agent/apps surfaces); fences (no implementation).
MUST: route plan-it; GROUNDING; /goal one sentence; CONTEXT PACKAGE with the two consumer surfaces named; SCOPE FENCES present. MUST-NOT: sizing/shape pre-decision ("4 squads", "size L"); uncertainty clause; output contract; discovery performed by prompt-it itself.

## S02 → route: fable-it
Exemplar: `fable-it` header; /goal per-Space key resolution; CP names brain-api-core + trigger-draft.service.ts as pattern-to-imitate; DoD sketch with verification targets (unit cases green; a per-Space key proven honored on a real Space; no regression where env==connection); fences (single seam, no second copy of precedence logic).
MUST: route fable-it; pattern-to-imitate named (trigger-draft.service.ts); DoD sketch numbered, each item with a verification TARGET; SCOPE FENCES. MUST-NOT: tiering note; persistence/autonomy clauses; verification protocol prescriptions (how to run QA).

## S03 → route: review-it
Exemplar: `review-it` header; /goal verify the done-claim; CP points at WHAT is under test (the component, the test env, the prior session's report as the claim source); fences (review only, no fixes).
MUST: route review-it; CP identifies claim-under-test + where the claim lives; SCOPE FENCES. MUST-NOT: DoD sketch authored fresh (must point at the existing claim/contract instead); instructions on HOW to verify (tools/env); credentials content.

## S04 → route: iterate
Exemplar: `iterate` header; the TS2345 error pasted verbatim in CP; goal = build green addressing root cause; DS 1-2 items ("pnpm build exits 0"); fence (don't suppress with ts-ignore/casts hiding undefined).
MUST: route iterate; the error text carried into the prompt; "root cause, not suppression" framing; DS names the verifying command. MUST-NOT: multi-step epic structure; cycle-structure instructions (iterate owns its loop).

## S05 → route: bare (non-agentic script task)
Exemplar: full anatomy including the bare-only slots: uncertainty clause (e.g. if data/customers.csv missing or schema differs → ask, don't guess) and output contract (script path, dedupe report format, run it and show output).
MUST: no harness skill header; UNCERTAINTY CLAUSE present; OUTPUT CONTRACT present incl. an end-to-end verification step (run + show counts); case-insensitive email rule stated. MUST-NOT: @-refs to harness state files; /read-chat refs.

## S06 → target: product-LLM
Exemplar: self-contained system-prompt addition disambiguating "cliente": org type=client vs Shopify repeat buyer vs campaign-creator client config; instruction to state the interpretation used and offer alternatives when ambiguous; missing-data behavior ("no records for <interpretation>" not bare "no clients found"); example Q→A pair for the recurring-buyers question.
MUST: the ≥3 colliding senses named; ambiguity behavior (state interpretation / offer alternatives); ≥1 worked example; self-contained (no @-refs, no /read-chat). MUST-NOT: harness slot headers; CoT scaffolding requirements.

## S07 → Mode 2, route: fable-it (or iterate; either accepted with a route rationale)
Exemplar: acknowledge (langfuse live, chat traces verified) → two gaps as numbered work; feedback-UI gap scoped to Intel/Design surfaces; trace gap framed at mechanism level (step-span instrumentation for multi-step flows, not a one-off intel patch); DS with verification targets (feedback UI visible on both pages; intel trace shows ≥N named child steps in langfuse); fences (don't touch verified chat tracing).
MUST: acknowledge-then-catch with the PASS evidence cited; BOTH gaps addressed (Pareto); verification targets in langfuse/UI terms; fence protecting the verified part. MUST-NOT: tiering; re-deploy instructions for what already passed.

## S08 → Mode 2, route: iterate or fable-it
Exemplar: acknowledge chat-trace naming verified → gap: unnamed origins as a CLASS (naming taxonomy applied at call-site wrapper level), the 3 pulse call sites + automations enumerated; DS: every brain-apps/automation call arrives named `app:<name>`/`automation:<name>` (verify in langfuse project praxya).
MUST: class framing (taxonomy/wrapper, not 3 independent edits); all enumerated sites covered; langfuse verification target. MUST-NOT: dropping the automations gap (Pareto violation).

## S09 → Mode 2, route: review-it or fable-it (rationale required in 🎯)
Exemplar: acknowledge nothing falsely — the review found false greens; gaps: CDP false-green vs human-visible dropdown errors; unverified Airtable landing; FAILED ATTEMPTS section carrying "longer waits — same false green"; DS: human-equivalent repro of the dropdown path + a record verified INSIDE Airtable (real system-of-record check).
MUST: failed-attempts section with the longer-waits attempt; system-of-record verification target (record seen in Airtable, not in our UI); no fake acknowledgment of unverified wins. MUST-NOT: re-proposing the failed approach; trusting CDP-only green as the target.

## S10 → clarity gate: minimal tighten
Exemplar: ≤3 lines, e.g. `Fix the typo in README.md: "recieve" → "receive". Verify with grep that no "recieve" remains.` + 🎯/💡.
MUST: NO full 6-slot scaffold (no GROUNDING/CP/FENCES sections); ≤4 directives; still G1 output shape. MUST-NOT: questions; research; DoD sketch section.

## S11 → clarity gate: minimal tighten (already well-formed)
Exemplar: near-passthrough of the sample with at most light tightening (e.g. verification target added to DoD item 1); 💡 notes it was already well-formed.
MUST: route stays plan-it; user's structure preserved; changes ≤ light tighten. MUST-NOT: restructure into the full template; added scope; questions.

## S12 → dead pointer: caught, not propagated
Exemplar: the emitted prompt either drops the @-ref with disclosure or redirects to a real location; 💡 (or a setup line) explicitly discloses that docs/architecture/overview.md does not exist in this repo.
MUST: the nonexistent path is NOT emitted as a live @-ref inside the prompt block; explicit disclosure of the dead pointer; intent preserved (documenting the eval suite still happens — e.g. propose README section or creating the doc). MUST-NOT: silently inventing a different path as if the user named it.

## S13 → legitimate ambiguity
Exemplar: either (a) ≤3 grounded questions with concrete options (which repo/module of Engine workspace; what "die early" means — TTL vs idle timeout), grounded in a real lookup of the Engine workspace; or (b) headless behavior: an emitted prompt whose assumption is flagged inline `(assumed — flag if wrong)`.
MUST: one of the two behaviors; any question has concrete options (not "what did you mean?"); if assumed, the assumption is explicit in the prompt block. MUST-NOT: silently picking a repo/module with no flag; >3 questions.

## S14 → route: plan-it
Exemplar: plan-it header; /goal extend feedback to all LLM surfaces + modal + thumbs-down form; CP: @Beacon repo path (validated), the three feature clusters enumerated; SF (planning only; existing chat-page component is the pattern, don't rebuild it).
MUST: route plan-it; Beacon path carried (it exists — validation should succeed); the 3 sub-features all present (Pareto at intent level); fences. MUST-NOT: tiering; implementation-level file edits list pretending to be a spec.

## S15 → route: fable-it
Exemplar: fable-it header; /goal version-check script; DS: script exists at scripts/check-version.sh; exits non-zero on seeded mismatch (prove by temporarily seeding one); exits 0 on current tree; SF (don't change the actual versions).
MUST: route fable-it; DS includes the negative test (prove it catches a mismatch); SF present. MUST-NOT: tiering/persistence content.

## S16 → route: iterate
Exemplar: iterate header; symptom carried (ResizeObserver error + mid-click detach); goal: e2e green against the real page; explicit fence: fixing by skipping/removing the test is forbidden; DS: suite green + the dropdown interaction demonstrably exercised.
MUST: route iterate; error symptom in CP; no-test-deletion fence; DS names the suite-green target. MUST-NOT: instructions to re-run with longer waits as the fix (that's the known false-green shape).

## S17 → bare agentic: stop conditions mandatory
Exemplar: full bare anatomy + STOP block: starting state (~/Downloads), target state (subfoldered by type), file scope locked to ~/Downloads, forbidden actions (no deletion, no overwrites — collision → rename; nothing outside ~/Downloads), stop conditions (unknown/ambiguous file types → list and ask; >N moves → checkpoint summary), human-review trigger before anything destructive.
MUST: stop conditions + forbidden actions + file-scope lock present; no-deletion carried from intent; output contract (final move report). MUST-NOT: harness headers; unlimited filesystem scope.

## S18 → product-LLM, reasoning-native
Exemplar: SHORT system prompt (target <200 words): role line, input shape, output schema (severity 0-4 + one-line hypothesis per log, format pinned), uncertainty out (`severity: unknown` when logs are truncated), no reasoning instructions.
MUST: no CoT/"think step by step"/scaffolded reasoning sections; output schema explicit; short (≲200 words in-block); uncertainty out present. MUST-NOT: XML-heavy multi-section template; few-shot padding beyond ≤1 tight example.

## S19 → route: fable-it, tiering note STRIPPED
Exemplar: same shape as S02; the input's "claude teams / lower models" instruction is ABSENT from the prompt block; 💡 explicitly notes the tiering note was dropped because fable-it owns delegation.
MUST: no tiering/teams/model language anywhere in the prompt block; the 💡 (or a disclosure line) explains the strip — silent removal of user text violates the no-silent-rewrite rule; everything else per S02 checklist. MUST-NOT: carrying the note "to be safe".

## S20 → Mode 2, route: fable-it (or plan-it with rationale)
Exemplar: acknowledge nothing (all rows FAIL) → the three hardcodings framed as ONE class (missing localization/formatting layer — i18n strings, locale date/currency formatting) with the three instances enumerated as acceptance cases; FAILED ATTEMPTS: inline tenant.language ternaries (reverted, unmaintainable); DS: all three surfaces render locale-correct for an en + a pt-BR tenant (verify on both), no inline conditionals reintroduced.
MUST: class-over-instance framing (one mechanism, not 3 patches); all 3 instances covered as acceptance cases (Pareto); failed-attempts section with the ternary approach + why rejected; two-locale verification target. MUST-NOT: three independent point-fix tasks; re-proposing inline ternaries.
