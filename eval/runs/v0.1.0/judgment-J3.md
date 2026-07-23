# Judgment J3 — prompt-it eval v0.1.0, samples S11–S15

Judge: review-it honesty rules (evidence-quoted rows, closed vocabulary FAIL/PASS, no vibes).
Oracle: `eval/expected-prompts.md` (global G1–G6 + per-sample MUST/MUST-NOT). Judged for
PROPERTY CONFORMANCE against the checklist, not byte-similarity to the exemplar.

Fact-checks run before judging (ls-only, no git): `docs/` absent from prompt-it repo, README
"Architecture / What's inside" section confirmed at line 254 (S12's claims are accurate);
`/Users/macbook/Workspace/ANM/Beacon` is reachable and `FeedbackWidget.tsx`, `Intel.tsx`,
`DesignChat.tsx`, `beacon/docs/ai-context/decisions.md`, and
`beacon/docs/release-notes/2026-07-16-sow-feedback-ux.md` all genuinely exist there (S14's
grounding is real, not hallucinated); `scripts/check-version.sh` and `CONTRIBUTING.md` are
both correctly absent (S15/S11 treat them as not-yet-existing target states, consistent).

---

## S11 — clarity gate: minimal tighten (already well-formed)

**Verdict: FAIL**

| Checklist item | ✓/✗ | Evidence |
|---|---|---|
| G1 output shape (one block + 🎯 + 💡) | ✓ | Block present, `🎯 Target: plan-it — ...`, `💡 Validated both pointers...` all present. |
| G2 ≤10 directives | ✓ | Block contains ~6 discrete directives (goal, 2 CP pointers, 2 DoD items, 1 SF line). |
| G3 no credentials | ✓ | None present. |
| G4 intent preserved | ✓ | Goal and both DoD items map 1:1 to the sample; scope fence ("no CI changes") carried verbatim. |
| G5 no tiering | ✓ | None present. |
| G6 runner didn't do the task | ✓ | Only validated pointers ("`plugins/.../targets.md` exists... `CONTRIBUTING.md` doesn't exist yet"), didn't create the file. |
| MUST: route stays plan-it | ✓ | `/plan-it` first line. |
| MUST: user's structure preserved | ✗ | Sample is a 3-part ask (`/goal` + `DoD` + `Out of scope`); output inserts two sections the sample never had — a GROUNDING sentence ("Documenting the contribution process for adding a new target profile to prompt-it's per-target ledger.") and a full CONTEXT PACKAGE with two annotated `@refs`. |
| MUST: changes ≤ light tighten | ✗ | Same evidence — this is materially more than "a verification target added to DoD item 1" (the exemplar's own definition of light tighten); it drafts a full 6-slot prompt. |
| MUST-NOT: restructure into the full template | ✗ | Output contains all six of SKILL.md's Step-5 slots (ROUTING, GROUNDING, /goal, CONTEXT PACKAGE, DoD SKETCH, SCOPE FENCES) — literally the full template the clarity gate is supposed to bypass. |
| MUST-NOT: added scope | ~✗ | CP annotation adds a prescriptive detail not in the ask: "...the quick omission table at the bottom that also needs a new column per profile" — an interpretive addition to what the CONTRIBUTING.md must cover. |
| MUST-NOT: questions | ✓ | No questions asked. |

**Diagnosis: SKILL-DEFECT.** SKILL.md's clarity gate (Step 1) says "do a minimal tighten... do not run the full pipeline," but gives no distinct output shape for that path — the only drafting mechanism the skill defines is the Step-5 six-slot template. Lacking an alternate template, the compiler defaults to what it knows (full draft), reproducing the exact failure mode SKILL.md itself names as its "#1 failure mode" (over-engineering a trivial ask) on an input that was already well-formed enough to need no more than an added `verify:` annotation.

---

## S12 — dead pointer: caught, not propagated

**Verdict: PASS**

| Checklist item | ✓/✗ | Evidence |
|---|---|---|
| G1 output shape | ✓ | One block, `🎯 Target: bare session...`, `💡 The pointer as given was dead...`. |
| G2 ≤10 directives | ✓ | ~8 directives (create-file instruction, 3 DoD items, assumption flag, output/verify instruction, 3 SF items); the 6 CP bullets are pointers, not directives, per the skill's own "convert to pointers" convention. |
| G3 no credentials | ✓ | None present. |
| G4 intent preserved | ✓ | `/goal` still documents the eval suite under `eval/`, matching the sample's ask. |
| G5 no tiering | ✓ | None present. |
| G6 runner didn't do the task | ✓ | File was not created; verified absent on disk (`ls` above confirms `docs/` doesn't exist). |
| MUST: dead path NOT emitted as a live @-ref | ✓ | `Create \`docs/architecture/overview.md\`...` — plain backticks, no `@` sigil anywhere for that path. |
| MUST: explicit disclosure of the dead pointer | ✓ | "`docs/architecture/overview.md` doesn't exist (no `docs/` directory anywhere in this repo, confirmed via `git log --all`)" and 💡 repeats it. |
| MUST: intent preserved (doc the eval suite still happens) | ✓ | Same as G4 — goal unchanged. |
| MUST-NOT: silently inventing a different path | ✓ | Kept the same path, only reclassified update→create and disclosed why; no substitute path presented as user-given. |

No FAILs — no diagnosis row needed.

---

## S13 — legitimate ambiguity

**Verdict: PASS**

| Checklist item | ✓/✗ | Evidence |
|---|---|---|
| G1 (overridden per task instructions — S13 explicitly permits questions instead of a block) | N/A | "I can't validate the pointer, so I'm not going to fabricate a path. Two questions to ground the prompt:" |
| G3 no credentials | ✓ | None present. |
| G4 intent preserved | ✓ | Closes with routing rationale: "this routes to **iterate**... it's a single bug, not a multi-surface build" — intent (fix the auth bug) unchanged, just gated on info. |
| G5 no tiering | ✓ | None present. |
| G6 runner didn't do the task | ✓ | No fix attempted; only asked questions. |
| MUST: one of the two permitted behaviors (questions or flagged-assumption prompt) | ✓ | Took the questions path. |
| MUST: any question has concrete options | ✓* | Q2 gives 4 concrete options ("session cookie/JWT expiring faster than TTL... idle-timeout... refresh-token flow failing silently... something else"). Q1 ("Where is the Engine workspace?") offers no options, but is grounded in a real, disclosed lookup failure ("this session's sandbox only allows browsing `/Users/macbook/Workspace/Devotts/prompt-it`... no reference to an 'Engine' repo/workspace exists there") rather than a lazy "what did you mean" — there is nothing to draw options from, and inventing fake candidate paths would itself be a fabrication (worse per the no-vibes standard). Judged as satisfying the intent of the rule. |
| MUST-NOT: silently picking repo/module with no flag | ✓ | Explicitly asked instead of guessing. |
| MUST-NOT: >3 questions | ✓ | Exactly 2. |

No FAILs — no diagnosis row needed. (*Q1's lack of options is flagged as a judgment call, not scored as a failure — see note.)

---

## S14 — route: plan-it

**Verdict: FAIL**

| Checklist item | ✓/✗ | Evidence |
|---|---|---|
| G1 output shape (one block + 🎯 + 💡) | ✗ | No fenced prompt block, no `🎯 Target:` line, no `💡` line anywhere in the output — it ends on "Two questions before I compile the prompt:" followed by two questions, full stop. |
| G4 intent preserved | N/A | Nothing to evaluate — no prompt was produced to check intent against. |
| G5 no tiering | ✓ | None present. |
| G6 runner didn't do the task | ✓ | No code changed; but the runner went well past "cheap pointer validation" into heavy discovery (reading `FeedbackWidget.tsx:74-92`, `Intel.tsx:476`, `DesignChat.tsx:468,1441,2095`, an ADR, and a release note) — confirmed real via `find` above, not fabricated, but this is plan-it's Phase-3/4 discovery job, not prompt-it's. |
| MUST: route plan-it | ✗ | No routing line emitted at all. |
| MUST: Beacon path carried | ✗ | Never appears inside any prompt block — there is no block. (The path itself does validate: `/Users/macbook/Workspace/ANM/Beacon` exists and its cited files are real.) |
| MUST: 3 sub-features present (Pareto) | ✗ | No prompt block to carry them; the output only surfaces the modal-vs-intercept conflict, not a structured Pareto covering all three original clusters (feedback-everywhere, review modal, thumbs-down form). |
| MUST: fences | ✗ | None emitted — no block. |
| MUST-NOT: tiering | ✓ | None present. |
| MUST-NOT: implementation-file-edit-list-as-spec | ✓ | N/A — none present, but only because nothing was emitted. |

**Diagnosis: SKILL-DEFECT.** SKILL.md Step 3.3 explicitly covers this exact situation: "If the user is unavailable, state the assumption inline in the prompt and mark it `(assumed — flag if wrong)`." This is a one-shot headless eval run — the user is definitionally unavailable for a follow-up turn — so the skill's own written fallback should have produced a `/plan-it` block with the modal-vs-intercept ambiguity flagged inline (e.g., "assumed: regenerate-intercept pattern per ADR-041, not a blocking popup — flag if wrong"), still carrying the Beacon path and all three sub-features. Instead the compiler halted entirely on real (not fabricated) findings and emitted zero deliverable, violating G1. This is not a HARNESS-ARTIFACT — the Beacon repo and every file cited were reachable and genuine — so the failure is the skill not enforcing its own "user unavailable → assume & flag" fallback rather than a broken/unfair oracle (an ADR-conflict is exactly the kind of thing an assumption-flag was designed to handle without stalling).

---

## S15 — route: fable-it

**Verdict: PASS**

| Checklist item | ✓/✗ | Evidence |
|---|---|---|
| G1 output shape | ✓ | One block, `🎯 Target: fable-it — ...`, `💡 Validated all four version pointers directly...`. |
| G2 ≤10 directives | ✓ | ~7 directives (goal, 3 DoD items, 3 SF items); the 5 CP bullets are pointers, not directives. |
| G3 no credentials | ✓ | None present. |
| G4 intent preserved | ✓ | All four files (marketplace.json, plugin.json, SKILL.md, CHANGELOG.md), the script path, and "prove it catches a mismatch" all carried through. |
| G5 no tiering | ✓ | None present — and none was present in the S15 sample either (unlike S19), so nothing needed stripping. |
| G6 runner didn't do the task | ✓ | `scripts/check-version.sh` confirmed absent on disk — only pointer-validated the four version files, didn't write the script. |
| MUST: route fable-it | ✓ | `/fable-it` first line. |
| MUST: DS includes the negative test | ✓ | DoD item 2: "temporarily bump one file's version (e.g. plugin.json → \"0.1.1\"), rerun the script, confirm non-zero exit + a message identifying the mismatch, then revert the edit." |
| MUST: SF present | ✓ | "Out of scope / do not touch: don't permanently bump any real version number... don't touch the nested duplicate SKILL.md... don't wire the script into a pre-commit hook or CI workflow unless asked separately." |
| MUST-NOT: tiering/persistence content | ✓ | None present. |

No FAILs — no diagnosis row needed.

---

## Summary J3

- S11: FAIL
- S12: PASS
- S13: PASS
- S14: FAIL
- S15: PASS
