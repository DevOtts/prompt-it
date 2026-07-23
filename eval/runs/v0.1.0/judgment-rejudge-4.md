# prompt-it eval — judgment rejudge-4 (post cycle-4: escalated runner + micro-hardenings)

Re-judge of 3 regenerated samples (S03, S11, S14) per `eval/expected-prompts.md` GLOBALS G1–G6 + per-sample checklists. Property conformance judged, not byte-similarity. All load-bearing factual claims made inside the outputs (file paths, absence-of-file claims) were independently verified against the filesystem before scoring — see per-sample notes.

---

## S03 — route: review-it — **PASS**

Sample: "The team says the feedback thumbs up/down component is finished and deployed to the test env. Before I tell the client, check it's actually done — the claim is in the last session's report."

| Check | ✓/✗ | Evidence |
|---|---|---|
| G1 shape (fence + 🎯 + 💡, ≤2 setup lines) | ✓ | Response opens at the fence; closes with `🎯 Target: review-it...` then `💡 Pointer validation moved the goalposts:...`; one trailing setup line "Run this from the repo where the component was actually built, not from prompt-it." (1 of allowed ≤2). |
| Route = review-it | ✓ | `/review-it` is the first line of the block. |
| /goal states verify-the-claim (not a fresh DoD) | ✓ | `/goal Verify the team's claim that the feedback thumbs up/down component is finished and deployed to the test environment — this is a client-facing go/no-go before Fernando reports it as done.` |
| CP identifies claim-under-test + where it lives | ✓ | "Under test: the completion claim in the last session's report for the component's project — expected at `.fable-it-reports/report.md` or the session card in `.agents/history/` of that repo (unvalidated — target session must locate the report first...)" |
| No fresh DoD authored | ✓ | No "DoD sketch:" list of new acceptance criteria; instead: "Verify the claim against the DoD/test contract **that report was built against**" — points at the existing contract, doesn't invent one. |
| No HOW-to-verify tool/env prescriptions | ✓ | Only states verification *targets* (the original DoD/contract, the live test-env deployment) — no tool names, no CDP/curl/SSH-style method prescriptions. |
| SCOPE FENCES present | ✓ | "Out of scope / do not touch: no fixes or code changes — verdict and evidence only. Only the thumbs up/down component claim is under review, not other items in the report." |
| No credentials/secrets (G3) | ✓ | None present. |
| G2 ≤10 directives | ✓ | ~5 discrete directives (goal, locate report, verify-vs-contract, verify-vs-live-env, 2 fence lines). |
| G6 runner didn't do the task | ✓ | No code/fix attempted; pure prompt output. |

**Grounding fact-check (load-bearing):** the 💡 claims "(prompt-it repo's) `.fable-it-reports/report.md` ... contains zero mention of the feedback/thumbs component." Verified: `.fable-it-reports/report.md` exists in this repo; a case-insensitive grep for "thumbs" or "feedback" across `.fable-it-reports/*.md` returned no matches — claim is accurate, not fabricated. `.agents/history/` does not exist in prompt-it (confirmed absent), consistent with the output only offering it as a candidate location in "that repo," not claiming it exists here.

**Verdict: PASS.** All MUSTs satisfied; no MUST-NOTs violated. The output correctly resists authoring a fresh DoD, correctly avoids prescribing verification tooling, and its claim about the pointer being unvalidated/cross-repo is independently confirmed true rather than asserted on faith.

---

## S11 — route: plan-it (clarity gate: already well-formed) — **PASS**

Sample: `plan-it. /goal add a CONTRIBUTING.md to this repo covering how to add a new target profile to references/targets.md. DoD: 1. file exists with profile-addition steps 2. linked from README. Out of scope: no CI changes.`

| Check | ✓/✗ | Evidence |
|---|---|---|
| G1 shape | ✓ | Fence → 🎯 → 💡 → 1 trailing setup line ("Run from the prompt-it repo root..."). |
| Route stays plan-it | ✓ | `/plan-it` preserved verbatim as first line. |
| User's structure preserved | ✓ | `/goal`, `DoD: 1./2.`, `Out of scope:` — same skeleton, same order, same item count as the input. |
| Changes ≤ light tighten | ✓ | Only two deltas: (a) dead-pointer path fix, (b) one inline assumed-clause. No new sections, no reordering. |
| In-place defect fix correct, not a violation | ✓ | `references/targets.md` → `plugins/prompt-it/skills/prompt-it/references/targets.md` (a fixed dead pointer, explicitly the CORRECT behavior per binding nuance). |
| No restructure into full template | ✓ | No GROUNDING/CONTEXT PACKAGE/SCOPE FENCES headers added — still just goal/DoD/out-of-scope. |
| No added scope | ✓ | DoD items 1 and 2 restate the same two acceptance criteria, no new criterion added. |
| No questions | ✓ | Only an inline `(assumed: ... — flag if wrong)` marker, not an interrogative — consistent with the allowed marker convention, not a violation. |
| 💡 discloses the fix, doesn't hide it | ✓ | "Fixed a dead pointer: `references/targets.md` doesn't exist at the repo root — the real file is `plugins/prompt-it/skills/prompt-it/references/targets.md`; everything else is your text, validated (README.md exists, CONTRIBUTING.md doesn't yet)." |

**Grounding fact-check (load-bearing):** confirmed via filesystem — `references/targets.md` does NOT exist at repo root; `plugins/prompt-it/skills/prompt-it/references/targets.md` DOES exist (6828 bytes). `README.md` exists at root; `CONTRIBUTING.md` does not exist. Every factual claim in the 💡 line checks out exactly.

**Verdict: PASS.** Route survived, structure preserved, only a correct in-place dead-pointer fix plus one flagged assumption — exactly the sanctioned minimal-tighten behavior, and every underlying grounding claim is independently verified true.

---

## S14 — route: plan-it (multi-surface feature) — **PASS**

Sample: "Extend the Beacon feedback thumbs to every page where users chat with the LLM (Intel, Design, all the regenerations), pop a review modal after each generation, and add a small 'what went wrong' form on thumbs-down. The Beacon repo is at /Users/macbook/Workspace/ANM/Beacon."

| Check | ✓/✗ | Evidence |
|---|---|---|
| G1 shape | ✓ | Fence → 🎯 → 💡 → trailing "Run from ..." line → "Optional refinements" question block APPENDED last (questions-after-block+🎯+💡 is the sanctioned position). |
| Route = plan-it | ✓ | `/plan-it` first line. |
| Beacon path carried | ✓ | "Run from `/Users/macbook/Workspace/ANM/Beacon`." — the user's path is carried through, not dropped. |
| CP = validated pointers ≤~7, one-line whys, no file:line/epic/decision codes | ✓ | 5 bulleted pointers (bundling 8 file mentions), each with a one-line why (e.g. "the thumbs pattern to generalize"); no line numbers, no epic IDs, no decision codes anywhere. |
| All 3 sub-features present (Pareto) | ✓ | DoD 1–2: thumbs on all surfaces; DoD 3: review modal after each generation; DoD 4: thumbs-down "what went wrong" form. All three of the sample's asks appear as acceptance criteria. |
| SCOPE FENCES present | ✓ | "Out of scope / do not touch: nightly-curation logic itself, Langfuse scoring internals, prompt content, and generation quality — this extends the capture surface only." |
| No tiering/teams/model-economics content | ✓ | None present anywhere in the block. |
| No implementation-level file-edit list masquerading as a spec | ✓ | Pointers name existing components as *pattern-to-imitate* / *context to check* ("check whether it already accepts non-SOW target types before adding endpoints") — no "edit line X" instructions, no prescribed diff. |
| Intent preserved, no scope silently added/dropped (G4) | ✓ | All 3 asked-for features carried; the reframe from "build new" to "generalize existing" is disclosed in 💡, not silent. |

**Grounding fact-check (load-bearing):** every file the CP names was independently confirmed to exist in `/Users/macbook/Workspace/ANM/Beacon`: `beacon/frontend/src/components/SowFeedbackCard.tsx`, `RegenerateFeedbackModal.tsx`, `FeedbackReasonForm.tsx`, `beacon/backend/api/routes/feedback.py`, `beacon/frontend/src/pages/Intel.tsx`, `DesignChat.tsx`, and both named `.taskstate/` files (`sow-fb-ux-run-state.md`, `feedback-obs-grounding.md`). Nothing in the CP is fabricated — this is real grounding, not invented plausible-sounding paths.

**Minor note (not a FAIL):** CP pointer density (5 bullets / 8 distinct file paths) sits at the upper edge of the "~7" guidance band. It reads as grounding/pattern-to-imitate context (consistent with S02's oracle exemplar naming `trigger-draft.service.ts` as pattern-to-imitate) rather than a prescriptive edit list, and stays within the fuzzy "~7" tolerance — flagged for visibility, does not change the verdict.

**Verdict: PASS.** Route, Beacon path, all 3 sub-features, and fences all present; CP is validated (not fabricated) and stays in pattern-to-imitate register rather than a file-edit inventory; no tiering language.

---

## Summary rejudge-4

| Sample | Verdict | Diagnosis (if FAIL) |
|---|---|---|
| S03 | PASS | — |
| S11 | PASS | — |
| S14 | PASS | — |

3/3 regenerated samples PASS. No SKILL-DEFECT, ORACLE-DEFECT, or HARNESS-ARTIFACT findings this round — the escalated runner + micro-hardenings resolved whatever prompted the cycle-4 regeneration. All grounding claims embedded in the three outputs (dead-pointer fixes, "file doesn't exist here" assertions, cross-repo file pointers) were independently verified against the actual filesystem and found accurate, not fabricated.
