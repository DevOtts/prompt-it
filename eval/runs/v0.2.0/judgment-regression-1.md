# v0.2.0 full-suite regression judgment — S01, S02, S04, S05

Judge: review-it honesty rules (evidence-quoted rows, closed vocabulary: SKILL-DEFECT / ORACLE-DEFECT / HARNESS-ARTIFACT). Property conformance against `eval/expected-prompts.md`, not byte-similarity. No git used.

---

## S01 — route: plan-it — **PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | Output shape: fence → 🎯 → 💡 → ≤2 setup lines | ✓ | Line 1 opens on the fence (`` ``` ``); lines 21–24 are `🎯 Target:`, `💡`, then exactly one setup line ("Run this from the actual product/monorepo...") |
| G2 | ≤10 discrete directives | ✓ | goal(1) + CP(3 bullets) + DS(3 items) + SF(1 line) = 8 |
| G3 | No credentials | ✓ | none present |
| G4 | Intent preserved | ✓ | goal covers self-install + brain-agent/brain-apps visibility, matching the sample 1:1 |
| G5 | No tiering/teams/economics | ✓ | none present |
| G6 | Runner didn't do the task | ✓ | explicitly defers discovery: "target session must locate the actual product/monorepo and confirm these sections' file paths before planning UI parity" (line 9) |
| MUST | route plan-it | ✓ | line 2: `plan-it` |
| MUST | GROUNDING present | ✓ | line 4: "MCP servers are the standard third-party plug-in surface..." |
| MUST | /goal one sentence | ✓ | line 6, single sentence |
| MUST | CP names the two consumer surfaces | ✓ | line 10: "Consumers needing visibility: brain-agent and brain-apps" |
| MUST | SCOPE FENCES present | ✓ | line 13: "Out of scope / do not touch: ..." |
| MUST-NOT | sizing/shape pre-decision | ✓ (absent) | no "N squads"/"size L" language anywhere |
| MUST-NOT | uncertainty clause (dedicated UC slot) | ✓ (absent) | only inline `(assumed:…)`/`(unvalidated—…)` pointer-validation markers, which the binding nuance rules in as correct behavior, not a UC slot |
| MUST-NOT | output contract | ✓ (absent) | no OC slot |
| MUST-NOT | discovery performed by prompt-it itself | ✓ (absent) | flags unvalidated instead of researching brain-agent/brain-apps itself |

No FAILs.

---

## S02 — route: fable-it — **PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | Output shape | ✓ | line 1 fence open; lines 21–24 = 🎯, 💡, one setup line ("Setup: run from the `brain-api-core` repo root.") |
| G2 | ≤10 directives | ✓ | goal(1) + CP(2) + DoD(4) + SF(3) = 10 (at the ceiling, not over) |
| G3 | No credentials | ✓ | none |
| G4 | Intent preserved | ✓ | goal matches sample's resolution order and "build and ship it" |
| G5 | No tiering/teams | ✓ | none present |
| G6 | Runner didn't do the task | ✓ | "I couldn't verify `trigger-draft.service.ts`... both flagged unvalidated for the target session's own discovery step" (💡 line) |
| MUST | route fable-it | ✓ | line 2: `/fable-it` |
| MUST | pattern-to-imitate named | ✓ | line 9: "Pattern to imitate: `trigger-draft.service.ts`" |
| MUST | DoD sketch numbered, each item w/ verification TARGET | ✓ (3/4 explicit, 1 soft) | items 1–3 each end "— verification target: ..." (lines 13–15); item 4 (line 16, "Resolution order/mechanism matches trigger-draft.service.ts's precedence... no divergent logic") has no explicit `verification target:` label — a labeling inconsistency, not a protocol violation (see note) |
| MUST | SCOPE FENCES | ✓ | line 18: "Out of scope / do not touch: trigger-draft.service.ts itself..." |
| MUST-NOT | tiering note | ✓ (absent) | none |
| MUST-NOT | persistence/autonomy clauses | ✓ (absent) | none |
| MUST-NOT | verification protocol prescriptions | ✓ (absent, one soft case) | item 3 folds a precondition ("with OPENROUTER_API_KEY unset") into its "verification target:" label — this names the scenario being tested, not a HOW-TO testing procedure (no mock/intercept/tool steps prescribed); distinguishable from the forbidden example in targets.md ("configure a Space with an invalid env var **and confirm**...", which prescribes the confirm step too) |

**Note (does not flip verdict):** item 4 lacks the explicit `verification target:` label the other three items carry — a consistency gap worth tightening (its implicit target is "diff against `trigger-draft.service.ts`", already named in CP), but it is not a MUST-NOT violation (no method/protocol emitted) and 3 of 4 items fully satisfy the MUST. Judged PASS on balance.

---

## S04 — route: iterate — **PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | Output shape | ✓ | line 1 fence open; lines 20–23 = 🎯, 💡, one setup line |
| G2 | ≤10 directives | ✓ | goal(1, plus a redundant restatement) + CP(2) + DS(3) + SF(2) ≈ 9 |
| G3 | No credentials | ✓ | none |
| G4 | Intent preserved | ✓ | "Make the build green" carried into goal + DS |
| G5 | No tiering | ✓ | none |
| G6 | Runner didn't do the task | ✓ | flags "this path does not exist in the current working directory `prompt-it`... run this from the correct project root" (line 10) rather than fabricating a build run |
| MUST | route iterate | ✓ | line 2: `/iterate` |
| MUST | error text carried verbatim | ✓ | line 9 quotes the exact TS2345 string byte-for-byte against the sample |
| MUST | "root cause, not suppression" framing | ✓ | DS item 2 (line 14): "a real narrowing/guard (or corrected signature), not a type-cast/`as string` suppression"; SF (line 17): "don't relax `strict`/`strictNullChecks`... to silence the error" |
| MUST | DS names the verifying command | ✓ | line 13: "`pnpm build` exits 0 with zero TS errors" |
| MUST-NOT | multi-step epic structure | ✓ (absent) | single DS block, 3 items, no epic/phase language |
| MUST-NOT | cycle-structure instructions | ✓ (absent) | no diagnose→fix→test→verify narration; iterate's own loop is left untouched |

**Minor observation (not a violation):** line 3 ("Fix the pnpm build failure and get it green.") duplicates the `/goal` line's content and sits in a slot (GROUNDING) the omission table marks "—" for iterate — mild redundancy/bloat, not a MUST/MUST-NOT breach.

---

## S05 — bare (non-agentic script task) — **FAIL**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | Output shape | ✓ | line 1 fence open; lines 5–6 = 🎯, 💡 |
| G2 | ≤10 directives | ✓ | dedupe rule, keep-first, output file, stdout report, language choice ≈ 5 |
| G3 | No credentials | ✓ | none |
| G4 | Intent preserved | ✓ | dedupe + row-count report both carried |
| G5 | No tiering | ✓ | none |
| G6 | Runner didn't do the task | ✓ | no script actually executed/written to disk; a prompt was produced |
| MUST | no harness skill header | ✓ | no plan-it/fable-it/iterate/review-it header anywhere |
| MUST | case-insensitive email rule stated | ✓ | "duplicates when their email addresses match case-insensitively (e.g. \"Foo@Bar.com\" and \"foo@bar.com\"...)" |
| MUST | UNCERTAINTY CLAUSE present (bare-target UC slot) | ✗ | the only uncertainty language present is prompt-it's own resolved-assumption tags — "(assumed — flag if you'd rather keep the last...)", "(assumed: Python — flag if...)" — none of these is a runtime fallback instruction telling the **executing session** what to do on missing/malformed input (the oracle's own exemplar: "if data/customers.csv missing or schema differs → ask, don't guess"); that distinct instruction is absent from the block |
| MUST | OUTPUT CONTRACT present incl. end-to-end verification step (run + show counts) | ✗ | the block specifies what the stdout report must *contain* ("Print a report to stdout with the original row count, the deduped row count, and how many rows were removed") but never instructs the executing session to **run the script and show the resulting output** as a deliverable/verification step, and never names the script's own file path — both explicitly required by the binding nuance ("output contract required INSIDE the block") and the S05 exemplar ("output contract (script path, dedupe report format, run it and show output)") |
| MUST-NOT | @-refs to harness state files | ✓ (absent) | none |
| MUST-NOT | /read-chat refs | ✓ (absent) | none |

**Diagnosis (per-FAIL):**
- Missing UC (runtime ask-don't-guess instruction) — **SKILL-DEFECT**: `targets.md`'s bare profile and the S05 exemplar both require this slot, but `SKILL.md`'s HARD OUTPUT RULES box (the section explicitly flagged "memorize — do not rely on reading targets.md") only tabulates the universal *never-emit* omissions per route; it carries no equivalent always-include reminder for the bare profile's extra UC/OC/STOP slots, so under compression the model reliably drops them in favor of resolving ambiguity itself via inline `(assumed:…)` tags instead of installing a genuine runtime fallback.
- Missing OC (script path + run-and-show-output verification step) — **SKILL-DEFECT**: same root cause — the OC requirement lives only in the secondary reference (`targets.md` bare profile: "OC — where deliverables land, format, and an end-to-end verification step"), which the skill's own self-check (Rubric/Contradiction/Load-bearing passes in SKILL.md §6) does not explicitly re-verify per-route; nothing in the main skill file forces a check of "did I include OC for this bare target" the way it forces the never-emit omissions.

---

## Summary regression-1

| Sample | Verdict |
|---|---|
| S01 | PASS |
| S02 | PASS (one non-blocking labeling-consistency note on DoD item 4) |
| S04 | PASS (one non-blocking redundancy note) |
| S05 | FAIL — missing bare-target uncertainty clause and output contract (both SKILL-DEFECT: `targets.md`'s bare-profile required additions aren't reinforced in `SKILL.md`'s hard-rules/self-check the way the never-emit omissions are) |

3 of 4 samples pass; S05 is the one regression, and it is a repeatable skill-authoring gap (bare-target required slots under-enforced), not a one-off run fluke or an oracle miscalibration.
