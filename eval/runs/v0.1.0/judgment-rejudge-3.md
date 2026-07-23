# Re-judgment (cycle-3, regenerated samples) — S03, S11, S14

Judge: review-it honesty rules — evidence-quoted rows, closed vocabulary (PASS/FAIL), property conformance not byte-similarity. Oracle: `eval/expected-prompts.md`. Inputs: `eval/sample-prompts.md`. Outputs under test: `eval/runs/v0.1.0/{S03,S11,S14}.md` (regenerated post cycle-3 skill fixes). Skill read for diagnosis only: `plugins/prompt-it/skills/prompt-it/SKILL.md` + `references/targets.md`.

---

## S03 — verdict: **FAIL**

Sample: "The team says the feedback thumbs up/down component is finished and deployed to the test env. Before I tell the client, check it's actually done — the claim is in the last session's report."
Oracle route: review-it. Binding nuance: must NOT author a fresh DoD — must point at the existing claim/report as the thing under test; must not prescribe verification tools/methods.

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | Output shape: fence→🎯→💡→(≤2 setup / ≤3 questions) | ✓ | Block lines 1–19, `🎯 Target:` line 21, `💡` line 23, then 2 refinement questions appended after — permitted, appends only, doesn't replace output. |
| G2 | ≤10 directives | ✓ | ~7 directives (goal + 3 DoD items + 3 SF clauses). |
| G3 | No credentials | ✓ | None present. |
| G4 | Intent preserved | ✓ | Verification-only ask kept, no scope drift. |
| G5 | No tiering content | ✓ | None present. |
| G6 | Runner didn't do the task | ✓ | Output is a prompt only. |
| MUST | route review-it | ✓ | `/review-it` (line 2). |
| MUST | CP identifies claim-under-test + where claim lives | ✓ | "Last session's report (assumed…) — source of the 'finished + deployed' claim and its stated DoD/acceptance criteria" (line 9). |
| MUST | SCOPE FENCES present | ✓ | "Out of scope / do not touch: do not fix any bugs found…" (line 18). |
| MUST-NOT | DoD sketch authored fresh (must point at existing claim/contract instead) | ✗ | A full `DoD SKETCH` section is authored with 3 fresh items: "1. Pull the exact claim… 2. Confirm the component is present and functional in the test env deployment itself (not just in code/PR) 3. Confirm each criterion the report claims as 'done' independently, citing what was actually observed vs. what was claimed" (lines 13–16). Item 1 gestures at "not a new checklist" but items 2–3 are new, prescriptive review criteria the skill explicitly forbids authoring for this route. |
| MUST-NOT | instructions on HOW to verify (tools/env) | ✗ | "Confirm the component is present and functional **in the test env deployment itself** (not just in code/PR)" (line 15) — prescribes where/how to check, the exact "tools/env" prescription the oracle forbids. |
| MUST-NOT | credentials content | ✓ | None present. |

**Verdict rationale:** the CP and SF slots are sound and load-bearing, but the presence of an authored `DoD SKETCH` section — with substantive fresh criteria beyond "point at the existing claim" — is a direct, unambiguous MUST-NOT violation. One violated MUST-NOT fails the sample regardless of other correct slots.

**Diagnosis: SKILL-DEFECT.** `SKILL.md` states the review-it omission correctly in three places (HARD OUTPUT RULES table line 34–38: "review-it | any fresh DoD (point at the EXISTING claim/contract only)…"; boundary contract line 50; `targets.md` line 24: "DS — do not sketch a DoD… a DERIVED oracle is review-it's own fallback, not yours to pre-author"). Despite three explicit, unambiguous statements of this rule, the output still emits a section literally titled `DoD SKETCH`. The likely mechanism: Section 5's "6-slot template" (SKILL.md lines 94–111) presents `DoD SKETCH` as slot 5 of a universal template with the per-route omission deferred to a parenthetical ("slots the routed target owns are OMITTED per `references/targets.md`") rather than gated inline at the point of drafting — a structural risk that invites mechanical application of all 6 slots. The skill's content is correct; its presentation doesn't force the omission at the moment of drafting.

---

## S11 — verdict: **FAIL**

Sample: `plan-it. /goal add a CONTRIBUTING.md to this repo covering how to add a new target profile to references/targets.md. DoD: 1. file exists with profile-addition steps 2. linked from README. Out of scope: no CI changes.`
Oracle: clarity gate, already well-formed. Binding nuance: the user's stated plan-it route must survive; output must preserve the user's own structure with only light defect fixes — re-templating into new sections = FAIL.

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | Output shape | ✓ | Block lines 1–15, `🎯` line 17, `💡` line 18, no trailing questions. |
| G2 | ≤10 directives | ✓ | ~6 directives. |
| G3 | No credentials | ✓ | None. |
| G4 | Intent preserved | ✓ | Same deliverable (CONTRIBUTING.md + README link), no dropped scope. |
| G5 | No tiering | ✓ | None. |
| G6 | Runner didn't do the task | ✓ | Prompt only. |
| MUST | route stays plan-it | ✓ | `plan-it` (line 2), never overridden. |
| MUST | user's structure preserved | ✗ | Original input has exactly 3 parts: routing+`/goal`, `DoD:` list, `Out of scope:` line — no context/pointer section at all. Output inserts a brand-new `Context:` section not present in the input: "Context:\n- @plugins/prompt-it/skills/prompt-it/references/targets.md — …\n- @README.md — …" (lines 6–9). |
| MUST | changes ≤ light tighten | ✗ | Adding a whole new section (CONTEXT PACKAGE) exceeds "light tighten" (oracle's own example of acceptable tightening is adding a verification target to an existing DoD item, which the output also does correctly — but the added section goes well beyond that). |
| MUST-NOT | restructure into the full template | ✗ | The inserted `Context:` section is exactly the CONTEXT PACKAGE slot from the skill's 6-slot template (SKILL.md line 101) — this is re-templating into a new section, the explicit FAIL condition named in the binding nuance. |
| MUST-NOT | added scope | ✓ (not violated) | Deliverable itself unchanged; the addition is pointers/context, not new scope items. |
| MUST-NOT | questions | ✓ (not violated) | None present. |

**Verdict rationale:** the route-lock and DoD-tightening (adding "verify: …" targets to each DoD item, lines 11–12) are both legitimate light touches and correctly executed. But the newly authored `Context:` section is an added structural block absent from the user's already-well-formed input — precisely the re-templating the binding nuance calls out as FAIL, independent of how well-validated its content is (the pointer resolution to the real `references/targets.md` path is accurate and would be a fine 💡 note, but promoting it into a new prompt-block section oversteps).

**Diagnosis: SKILL-DEFECT.** SKILL.md states this rule twice, unambiguously: HARD OUTPUT RULES item 6 ("Already-well-formed input… return the user's own text, fixing only actual defects in place. Adding sections to it is a violation") and the clarity-gate section (Step 1: "Never re-pour an already-well-formed prompt into the 6-slot template… your value is validation and a light touch, not reformatting"). The pointer-validation step (Section 4) is scoped to validating pointers *already present* in the input, not manufacturing new ones — yet the output invents a pointer section where none existed. The skill's self-check (Section 6) has no explicit pass that re-verifies "did I add a section not present in an already-well-formed input," which is the gap that let this recur after cycle-3 fixes.

---

## S14 — verdict: **FAIL**

Sample: "Extend the Beacon feedback thumbs to every page where users chat with the LLM (Intel, Design, all the regenerations), pop a review modal after each generation, and add a small 'what went wrong' form on thumbs-down. The Beacon repo is at /Users/macbook/Workspace/ANM/Beacon."
Oracle route: plan-it. Binding nuance: route must be plan-it; context package = validated pointers (≤~7, one-line whys) — file:line inventories/epic IDs/decision codes = FAIL.

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | Output shape | ✓ | Block lines 1–57, `🎯` line 59, `💡` line 61. |
| G2 | ≤10 directives | ✗ (borderline) | CP has 5 bullets and DS has 4 items and SF has 4 clauses — each individually dense with sub-directives (e.g. DS item 2 bundles two test cases + two paths), effectively well past 10 discrete instructions once file:line-scoped sub-tasks are counted. |
| G3 | No credentials | ✓ | None present. |
| G4 | Intent preserved | ✗ | Sample asks to extend thumbs to "every page" (Intel, Design, all regenerations) + a modal + a thumbs-down form. Output's Grounding asserts "Per-turn thumbs (FeedbackWidget) already cover every LLM chat surface — Intel…, Design…, SOW…and Brief" and narrows the ask to only "Design chat's two regenerate paths" (lines 8–14, 59–61) — the user's stated 3-part, multi-surface ask is silently reinterpreted/shrunk to a single-surface gap based on the runner's own codebase research, not carried forward as stated intent for the target skill to resolve. |
| MUST | route plan-it | ✗ | Output routes `/fable-it` (line 2), not plan-it — a direct, unambiguous violation of the named MUST. |
| MUST | Beacon path carried | ✗ | The user's stated path `/Users/macbook/Workspace/ANM/Beacon` never appears anywhere in the output; all references are bare relative paths (e.g. `frontend/src/pages/DesignChat.tsx:468`) with no repo-root pointer carried at all. |
| MUST | 3 sub-features present (Pareto at intent level) | ✗ | Only the thumbs-down "what went wrong" form gap is carried as work; "extend to every page" and "modal after each generation" are declared already-done via the runner's own research rather than preserved as the user's stated ask (see G4 quote above). |
| MUST | fences present | ✓ | "Scope fences — do not touch:" section present (lines 48–56). |
| MUST-NOT | tiering | ✓ (not violated) | None present. |
| MUST-NOT | implementation-level file-edit list pretending to be a spec | ✗ | CP bullets are dense file:line inventories: "DesignChat.tsx:468 (handleRegenerateLast, sync call, no Celery task_id)", "DesignChat.tsx:1029… poll-terminal completion handler (~DesignChat.tsx:627, referenced as :622 in …KICKOFF.md)" (lines 21–26); plus epic IDs ("E4… test cases #15-18", "Epics E1… E2… E5", lines 13, 28, 40–46, 53) and a decision code ("PRD-sow-feedback-ux.md §4 (G-rules v1.0)", line 30) — exactly the three FAIL triggers the binding nuance names. |

**Verdict rationale:** this is a compounding, multi-dimensional violation, not a single defect — wrong route, dropped user-stated path, silently shrunk scope, and a CP that is a discovery dossier (file:line/epic/decision-code detail) rather than validated pointers. Any one of these fails the sample; all four are present.

**Diagnosis: SKILL-DEFECT.** SKILL.md states the correct rules in multiple places — Section 2's routing rule ("fuzzy/large idea, multi-surface feature cluster, or unresolved scope — even WITH good repo pointers → plan-it… pointers make planning easier; they don't make scope resolved," line 71) and the hard discovery cap ("Validation is not discovery (hard cap)… if your validation produced line-level inventories, test-case IDs, or a discovery dossier, you have crossed into plan-it/fable-it pre-grounding territory — cut it back to pointers and route accordingly," line 92; "NEVER run heavy research fan-out to spec the task," line 49). All three rules directly and correctly describe what should not have happened, yet the output is close to a textbook instance of the forbidden behavior. Because this is the one sample among the three where the runner had live access to a real, explorable target repo (Beacon), the discovery cap appears to fire too late in practice — once the agent starts reading the actual codebase, it accumulates exactly the line-level/epic/decision-code detail the cap forbids, and then *retroactively* rationalizes a different (fable-it) route from those findings rather than routing plan-it first and letting plan-it own the deep dive. The rule exists in the skill but isn't structured as a hard gate that fires *before* any repo exploration on a stated multi-surface ask — that ordering gap is the defect.

---

## Summary rejudge-3

| Sample | Verdict | Primary violated rule | Diagnosis |
|---|---|---|---|
| S03 | FAIL | Fresh `DoD SKETCH` authored for review-it (must point at existing claim only) + verification-env prescription | SKILL-DEFECT |
| S11 | FAIL | New `Context:` section re-templated into an already-well-formed plan-it input | SKILL-DEFECT |
| S14 | FAIL | Wrong route (fable-it not plan-it) + dropped Beacon path + scope silently shrunk + CP is a file:line/epic/decision-code discovery dossier | SKILL-DEFECT |

All 3 re-judged samples FAIL. Cycle-3 fixes did not resolve any of the three defects re-tested here: each output violates a rule that is already stated correctly, explicitly, and in most cases redundantly inside `SKILL.md`/`targets.md` — the recurring pattern across all three is a gap between correct rule text and the skill's ability to force that rule at the moment of drafting (generic template application overriding per-route omissions in S03/S11; discovery-then-rationalize overriding the routing rule in S14). None of the three failures trace to an oracle error or a harness/tooling artifact.
