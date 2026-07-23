# judgment-regression-4.md — v0.2.0 full-suite regression, S17–S20

Method: property conformance against `eval/expected-prompts.md` GLOBALS (G1–G6) + per-sample MUST/MUST-NOT, evidence-quoted from `eval/runs/v0.2.0/{S17,S18,S19,S20}.md`. Exemplars in the oracle are quality anchors, not byte targets. No git was run; diagnosis only references the skill/targets.md text already loaded.

---

## S17 — bare agentic (Downloads sort, stop conditions mandatory)

**Verdict: FAIL**

| Check | ✓/✗ | Evidence |
|---|---|---|
| Response starts at opening fence (G1) | ✓ | File line 1 is the literal fence, no preamble. |
| No harness header inside block (MUST-NOT) | ✓ | Block opens with plain narrative ("Organize my ~/Downloads folder..."), no `/`-skill line. |
| File-scope lock (MUST) | ✓ | "Only sort files sitting directly in ~/Downloads — do not recurse into existing subfolders" (l.8); "Don't touch folders that already exist in ~/Downloads other than the four you create" (l.22). |
| No-deletion carried from intent (MUST) | ✓ | "Do not delete anything — every file must still exist afterward, just relocated." (l.2), restated in DoD item 6 and SF item 1. |
| Forbidden actions present (MUST) | ✓ | "No deleting, renaming (beyond the move itself), or editing file contents" (l.19). |
| Stop/ambiguity conditions present (MUST) | ✓ (weaker than exemplar) | "if a file's type is unclear ... leave it in place and list it at the end rather than guessing" (l.24) — a defer-and-list behavior, not the exemplar's "list and ask" mid-run pause, but satisfies the letter of "stop conditions present." |
| Output contract / final report (MUST) | ✓ | "print a summary: how many files moved into each of the four folders, and a list of anything skipped or flagged as ambiguous" (l.26). |
| Unlimited filesystem scope (MUST-NOT) | ✓ (no violation) | Scope is explicitly capped to `~/Downloads`, non-recursive. |
| **G2 ≤10 discrete directives (global)** | **✗** | Counting the block's own enumerable items (excluding the opening/goal framing lines): 2 Context bullets (l.7–8) + 6 numbered Type-mapping/DoD items (l.11–16) + 4 Out-of-scope bullets (l.19–22) + 1 ambiguity-handling directive (l.24) + 1 final-summary directive (l.26) = **14**, well over the ≤10 cap. Three of those restate "no deletion" independently (l.2, l.16, l.19) — a consolidation miss, not inherent task complexity. |

**Diagnosis (SKILL-DEFECT):** `SKILL.md` states the bare-agentic profile is "the only profile where the full anatomy applies. Still ≤10 directives" (targets.md l.37) but gives no consolidation technique for reconciling a STOP-block-rich task with that cap — and the drafting rule "≤10 discrete directives (consolidate or convert to pointers)" (SKILL.md l.115) wasn't applied to the three redundant no-deletion restatements. This is a repeatable failure mode for any bare-agentic sample with a real STOP anatomy, not a one-off run fluke — worth a fix to SKILL.md's self-check (e.g., an explicit "merge duplicate constraints" pass) rather than the oracle relaxing G2 for this class.

---

## S18 — product-LLM, reasoning-native (log-triage system prompt)

**Verdict: FAIL**

| Check | ✓/✗ | Evidence |
|---|---|---|
| **Response starts at opening fence (G1 / HARD OUTPUT RULE #1)** | **✗** | File line 1: *"Good calibration confirms my plan. Writing the final answer now."* — precedes the fence at line 3. SKILL.md is explicit and repeated: "Your response starts at the opening fence... Zero preamble, zero narration" (l.28) and "the FIRST character of your response is the opening fence" (l.130). |
| No CoT/"think step by step" scaffolding (MUST) | ✓ | No reasoning-process instructions anywhere in the block; role/schema/rubric only. |
| Output schema explicit (MUST) | ✓ | `{"id": <same id>, "severity": <integer 0-4 or "unknown">, "cause": <string, ≤120 chars>}` (l.8–9), plus explicit array-in/array-out contract (l.22). |
| Short, ≲200 words in-block (MUST) | ✓ | Independent count of the fenced content ≈185–195 words (model's own "182 words" claim is in the same ballpark) — under the 200-word ceiling. |
| Uncertainty out present (MUST) | ✓ | "If a log is truncated, ambiguous, or lacks enough detail to infer severity, set `"severity": "unknown"`... never guess a number." (l.20). |
| No XML-heavy multi-section template (MUST-NOT) | ✓ | Plain prose + one JSON schema, no XML tags/section scaffolding. |
| No few-shot padding beyond ≤1 tight example (MUST-NOT) | ✓ | Exactly one input/output example pair (l.24–26). |

**Diagnosis (SKILL-DEFECT):** every content-level MUST is satisfied cleanly — this is a pure output-shape failure. The zero-preamble rule is stated three separate times in SKILL.md yet a calibration/confirmation sentence still leaked ahead of the fence. Because this is not sample-specific content but a meta-commentary habit, and it recurs identically in S19 (below), the fix belongs in the skill (a harder enforcement mechanism — e.g., a literal "first token must be a backtick" self-check gate) rather than in the oracle or the run environment.

---

## S19 — route: fable-it, tiering note must be stripped

**Verdict: FAIL**

| Check | ✓/✗ | Evidence |
|---|---|---|
| **Response starts at opening fence (G1 / HARD OUTPUT RULE #1)** | **✗** | File line 1: *"Confirmed fable-it as the route and confirmed the "use lower models / Claude teams" instruction must be dropped..."* — precedes the fence at line 3. Same defect class as S18. |
| Route fable-it, locked/derived correctly (S02-inherited MUST) | ✓ | Block line 4: `/fable-it`. |
| No tiering/teams/model language anywhere in the block (MUST) | ✓ | Full-text scan of the fenced block (l.4–21): no mention of "teams," "lower models," or tiering language. |
| Strip explicitly disclosed, not silent (MUST) | ✓ | 💡 line: "Dropped your 'use Claude teams / lower models for subagents' instruction — that's tiering/economics content fable-it's own Step 3 owns exclusively..." (l.25). |
| Pattern-to-imitate named (S02-inherited MUST) | ✓ | "Pattern to imitate: `trigger-draft.service.ts`..." (l.11). |
| DoD sketch numbered, each with a verification target (S02-inherited MUST) | ✓ | 4 numbered items, each with a `(verify: ...)` clause (l.16–19). |
| Scope fences present (S02-inherited MUST) | ✓ | "Out of scope / do not touch: `trigger-draft.service.ts` itself..." (l.21). |
| Persistence/autonomy clauses (MUST-NOT) | ✓ (no violation) | None present. |
| Verification-protocol prescriptions / how-to-run-QA (MUST-NOT) | ✓ (no violation) | DoD items state WHAT proves each item, not HOW to test it. |
| Carrying the note "to be safe" (MUST-NOT) | ✓ (no violation) | Fully dropped, not hedged/kept. |

**Diagnosis (SKILL-DEFECT):** identical failure shape to S18 — a confirmation/calibration sentence ("Confirmed fable-it as the route...") precedes the fence, violating the same explicit, thrice-stated rule. Every S19-specific and S02-inherited content MUST is otherwise satisfied precisely, including the core regression target (tiering note absent + disclosed). Two independent instances of the identical output-shape defect in this four-sample batch make a strong case that this is systemic to the skill's current enforcement of the zero-preamble rule, not incidental to either sample.

---

## S20 — Mode 2, three point-bugs hiding one class

**Verdict: PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| Response starts at opening fence (G1) | ✓ | File line 1 is the literal fence — no preamble (unlike S18/S19). |
| Class-over-instance framing (MUST) | ✓ | "Fix the three hardcoded-locale defects in brain-admin-ui so tenant.language actually drives rendering — via ONE shared, reusable formatting/localization mechanism, not per-instance ternaries." (l.4). |
| All 3 instances covered as acceptance cases (Pareto, MUST) | ✓ | DoD 1 (header "Painel"), DoD 2 (tasks-table dates), DoD 3 (billing-widget currency) — all three named with individual verify clauses (l.14–16). |
| Failed-attempts section: ternary approach + why rejected (MUST) | ✓ | "Failed approach, do not repeat: inline ternaries (`tenant.language === 'pt' ? X : Y`) directly in each component — reverted for unmaintainability" (l.11), reinforced in the opening framing (l.4). |
| Two-locale verification target (MUST) | ✓ | DoD 2: "verify: tasks table, both an en-locale and a pt-locale tenant session" (l.15) — the dual-locale target the MUST requires is present; DoD 1/3 use single-locale proxies matched to each bug's specific symptom, which is a minor fidelity note but doesn't violate the MUST as literally stated. |
| Three independent point-fix tasks (MUST-NOT) | ✓ (no violation) | Framed and bound as one mechanism; DoD 4 explicitly requires the shared mechanism across all three touched files. |
| Re-proposing inline ternaries (MUST-NOT) | ✓ (no violation) | Explicitly forbidden, with a grep-based regression check against reintroducing them (l.17). |
| G2 ≤10 directives | ✓ | 5 Context bullets + 4 DoD items + 1 SF line = 10, at the cap, not over. |
| G5 no tiering content | ✓ | None present. |

**Note, not a defect:** the oracle header names `fable-it (or plan-it with rationale)` as the expected routes for this sample, but the run routes to `/iterate` instead. The bound MUST/MUST-NOT list for S20 does not restate a route requirement (unlike S01/S02, where "route X" is literally in the MUST line), and SKILL.md's own Mode 2 pipeline step 6 says continuations route "usually fable-it or iterate" — so iterate is a skill-sanctioned general choice, and the 🎯 line gives an explicit rationale ("all three FAILs share one root cause and one prior failed fix, which is exactly iterate's shape"). Flagged for visibility; does not affect the verdict.

---

## Summary regression-4

- S17: FAIL — content and route correct; G2 directive-count blown (14 vs ≤10), three redundant no-deletion restatements not consolidated. SKILL-DEFECT.
- S18: FAIL — preamble before the opening fence ("Good calibration confirms my plan...") violates HARD OUTPUT RULE #1; all content MUSTs (schema, short, uncertainty-out, no CoT) pass clean. SKILL-DEFECT.
- S19: FAIL — same preamble-before-fence defect ("Confirmed fable-it as the route..."); tiering strip + disclosure and all S02-inherited MUSTs pass clean. SKILL-DEFECT, same recurring class as S18.
- S20: PASS — class-over-instance framing, all 3 instances as acceptance cases, failed-attempts section, two-locale verification target all present; route diverges to iterate from the oracle's suggested fable-it/plan-it but isn't a bound MUST, noted only.
