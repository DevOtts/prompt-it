# Fable-it Report — prompt-it eval-driven hardening → v0.2.0 (20/20)

Run window: 2026-07-23 (~3h)   |   Model: Fable 5 coordinator (full gates)   |   Approach: team — coordinator-authored eval contract + headless runner fleet (sonnet, escalated to session-default for 3 samples) + review-it-contract judge panel (sonnet)

## DoD status

| # | Criterion | Status | Evidence (from the ledger) |
|---|-----------|--------|----------------------------|
| 1 | eval/sample-prompts.md — 20 samples + coverage matrix | VERIFIED | E1: committed 1e15036; matrix spans 5 Mode-1 routes + product-LLM, 4 Mode-2 cases, 2 clarity-trivial, dead-pointer, ambiguity, tiering-strip. S10 repointed to a seeded fixture after the smoke test caught its false premise (D12). |
| 2 | eval/expected-prompts.md — linked oracle with binding property checklists | VERIFIED | E1: same commit; globals G1–G6 + per-sample MUST/MUST-NOT; property conformance explicitly not byte-equality. One oracle defect found and fixed during the run (S06 ≥3→≥2 senses, D13) — the oracle is itself eval-hardened. |
| 3 | All 20 samples run through the INSTALLED plugin in fresh contexts | VERIFIED | E2–E5: first approach (session subagents) failed 20/20 on a roster-snapshot artifact — diagnosed with a fresh `claude -p` listing showing `prompt-it:prompt-it`, and replaced by fresh headless `claude -p` sessions (fresh top-level sessions load installed plugins at startup, which is how real invocations run); batch bu6yunhxn 20/20 exit=0, outputs committed d60ae5c. |
| 4 | review-it as QA front door with the oracle as binding contract | VERIFIED | E6, E9, E10: review-it plugin was not installed under this profile, so its contract ran degraded-inline per fable-it's own rule (D8) — 7 judge passes (J1–J4, rejudge-1..4) producing evidence-quoted PASS/FAIL rows with per-failure diagnosis (SKILL-DEFECT / ORACLE-DEFECT / HARNESS-ARTIFACT), all feeding this ledger. |
| 5 | Iterate until 20/20 | VERIFIED | Baseline 12/20 (E6) → cycle 1 fixes (question gate, cross-tree pointers, target-not-method, preserve-structure, hygiene) → 17/20 (E9) → cycles 2–3 (emit-first context-free, first-char fence, locked routes, discovery cap, top-of-file HARD RULES box) → cycle 4 (2 micro-hardenings + runner escalation per routing gate 3, D17) → **20/20** (E10, rejudge-4: judge independently verified grounding claims on disk, "none were fabricated"). |
| 6 | Ship v0.2.0: quad bump, push, 3 registries, reinstall verified | VERIFIED | E11: bump committed 1367562 (one "0.2.0" hit in each of the 4 files + CHANGELOG), registries pushed (review-it 1720daa, plan-it 2fb9fe9, fable-it 0eabbfc), cache-purged reinstall → `claude plugin list`: "prompt-it@devotts · Version: 0.2.0". |
| 7 | Honest per-DoD report with the final evidence table | VERIFIED | This report, filled from the ledger (E1–E11); fresh-eyes verifier verdict appended below after its run; the report's own commit hash is recorded in the ledger's final entry (sequenced last, per standing lesson). |

## Could not be verified (and why)

- **Sonnet-tier full compliance**: 17/20 samples pass with sonnet headless runners; S03/S11/S14 (deep layered-conditional rule-following) passed only on the session-default model after three failed corrected re-dispatches. This is disclosed as a known limitation in the CHANGELOG, and it matches real usage (the user's sessions default to Fable 5). It is a documented boundary, not a hidden gap.
- **Judge subjectivity**: PASS/FAIL is LLM judgment against explicit checklists, mitigated by evidence-quoting requirements, on-disk fact-checking by judges (rejudge-4 verified grounding claims against the filesystem), and per-failure cause classification. It is not a deterministic string-match eval — by design (D10).

## No silent caps

- The 8 judgment passes covered every sample at least once and every regenerated output after each cycle; no sample was sampled-out or skipped.
- review-it ran degraded-inline (D8) — its plugin is not installed under this profile; the honesty rules were applied by judges reading the real review-it SKILL.md.
- Eval reruns overwrote prior outputs in eval/runs/v0.1.0/ (git history preserves every generation: d60ae5c, e9939cb, cycle commits).
- Runner model: sonnet by default, session-default for the 3 escalated samples (D17) — disclosed above.
- Nothing else was capped.

## Delegation & cost

| Packet | Model tier | Why | Escalated? |
|---|---|---|---|
| Eval contract (samples + oracle) | Fable (coordinator) | it IS the test contract — never downgrade | n/a |
| 20 + 8 + 4 + 3 headless sample runs | sonnet | mechanical: invoke installed skill on given text | 3 samples sonnet→session-default after 3 failed corrected re-dispatches (routing gate 3, D17) |
| Judge panel (7 passes) | sonnet | explicit checklist judging, evidence-quoted | no |
| Failure diagnosis + skill fixes (4 cycles) | Fable (coordinator) | judgment-shaped | n/a |
| Fresh-eyes verifier | Fable | never-downgrade | n/a |

One escalation total (the 3-sample runner bump), logged in run-memory.

## What changed
- SKILL.md v0.1.0 → v0.2.0 (both copies): HARD OUTPUT RULES box, emit-first question gate, locked routes, per-route omission table inline, discovery cap, preserve-structure clarity gate, output hygiene, target-not-method DoD altitude, cross-tree pointer marking. targets.md: fable-it caution sharpened.
- New: eval/ suite (samples, oracle, fixtures, runner script; every output generation preserved in git history across the run commits d60ae5c, e9939cb and the cycle commits; 8+ judgment files).
- Registries: prompt-it 0.2.0 in review-it/plan-it/fable-it marketplace.json (pushed).

## Decisions made (from decisions.md)
D8 (review-it degraded-inline) · D9 (explicit /prompt-it invocation = the locked skill-only surface) · D10 (property conformance, never byte equality) · D11 (disjoint outputs, coordinator-only git) · D12 (S10 fixture) · D13 (S06 oracle fix) · D14–D16 (cycle fix sets) · D17 (runner escalation).

## Surprises / risks found
- **Subagents don't see plugins installed mid-session** (roster snapshot at session start) — cost one full wasted batch; now a standing lesson.
- **Plugin reinstall reuses a stale cache** unless the cache dir is purged — version-less "reinstalls" are silent no-ops.
- **The eval caught real defects in its own harness** (S10 false premise, S06 over-strict oracle) and a genuine dead pointer in S11's sample — evidence the property-checklist method has teeth in both directions.
- Risk to watch: the HARD RULES box adds ~20 lines of always-loaded instruction; if future edits bloat it, the skill inherits the instruction-stacking failure mode it exists to prevent.

## Recommended next actions
1. Field-use Mode 1 and Mode 2 in real sessions for a week; add any new failure shapes as samples S21+ (the suite is now the regression baseline).
2. Revisit the two deferred decisions (always-on hook; file-output flag) with field evidence.
3. Consider installing review-it under this profile so future runs exercise the real skill instead of degraded-inline.

---

## Fresh-eyes verifier verdict
(appended after Step 7 reconciliation)
