# Judgment J4 — S16–S20

Judged against `eval/expected-prompts.md` (globals G1–G6 + per-sample MUST/MUST-NOT). Verdict formula per instructions: **FAIL if ANY MUST is violated, ANY MUST-NOT is present, or ANY global G1–G6 is violated.** Route wording in a sample's section *title* (e.g. "→ route: X") is treated as exemplar/context, not binding, unless the sample's own MUST/MUST-NOT list restates it — consistent with how S07/S08 explicitly accept two routes in the title without restating either in MUST.

---

## S16 — route: iterate

**Verdict: PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| G1 output shape | ✓ | One fenced block + `🎯 Target: **iterate**` + `💡` line; one disclosure para before the block ("Confirmed pointer validation: no `tasks-page`... exists in this repo") functions as the ≤2-line setup/disclosure the skill allows. |
| G2 ≤10 directives | ✓ | ~6 directives (goal, locate-component, race-not-flakiness framing, no-suppression rule, 2 DoD items, 1 fence line). |
| G3 no secrets | ✓ | None present. |
| G4 intent preserved | ✓ | Sample: "Get the e2e passing against the real page, not by skipping the test." Output goal: "get the tasks-page dropdown e2e passing against the real page — root-cause fix, not a workaround." No drift. |
| G5 no tiering content | ✓ | None present. |
| G6 runner didn't do the task | ✓ | Only pointer-validation performed ("no `tasks-page`... exists in this repo"); no task execution. |
| MUST: route iterate | ✓ | "🎯 Target: **iterate** — single fix-test-verify loop on a specific failing e2e assertion, in-session." |
| MUST: error symptom in CP | ✓ | "'ResizeObserver loop limit exceeded' thrown when the dropdown opens, and the element detaches from the DOM mid-click inside the CDP e2e suite. Suite is red." |
| MUST: no-test-deletion fence | ✓ | "do not delete, skip, or weaken the failing test to make the suite pass; do not silence the ResizeObserver error via a global error-suppression handler as the fix." |
| MUST: DS names suite-green target | ✓ | "1. The e2e suite runs green against the real page (no skip, no `.only` bypass, no deleted assertions)." |
| MUST-NOT: longer-waits-as-fix instruction | ✓ (absent) | Explicitly forecloses it: "adding sleeps/retries/longer waits around the click to paper over the timing, does not count as a fix." |

No FAIL rows — no diagnosis needed.

---

## S17 — bare agentic: stop conditions mandatory

**Verdict: PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| G1 output shape | ✓ | One fenced block + `🎯 Target: bare` + `💡`; one disclosure para before the block ("I couldn't `ls ~/Downloads`... blocked outside this repo's working directory"). |
| G2 ≤10 directives | ✓ | ~8 directives (no-delete, list, plan, preview/confirm, create+move, collision-rename, report, ambiguous→manual-sort). |
| G3 no secrets | ✓ | None present. |
| G4 intent preserved | ✓ | Sample: "move files into subfolders by type (images, pdfs, archives, installers), deleting nothing." Output's 4 categories match exactly; added preview-gate/collision-rule are disclosed additions, not silent drift: "Added the pieces a bare session needs that you didn't specify: ... a preview-before-move confirmation step..." |
| G5 no tiering content | ✓ | None present. |
| G6 runner didn't do the task | ✓ | No files were moved; only a prompt was produced. |
| MUST: stop conditions + forbidden actions + file-scope lock | ✓ | Stop/checkpoint: "Print the full plan (source → destination) and wait for my go-ahead before moving anything." Forbidden: "Never delete a file under any circumstance"; "do not overwrite — append '(2)'...". Scope lock: "Out of scope / do not touch: files already inside any existing subfolder..., files outside ~/Downloads..." |
| MUST: no-deletion carried from intent | ✓ | "Do not delete anything, ever." |
| MUST: output contract (final move report) | ✓ | "Report: how many files moved into each subfolder, how many were left untouched at the root and why..., and confirm the total file count before == total file count after." |
| MUST-NOT: harness headers | ✓ (absent) | Block opens with "Organize my ~/Downloads folder..." — no `/plan-it`/`/fable-it`/`/iterate` invocation. |
| MUST-NOT: unlimited filesystem scope | ✓ (absent) | Scope fence restricts to `~/Downloads` only (quoted above). |

No FAIL rows — no diagnosis needed.

---

## S18 — product-LLM, reasoning-native

**Verdict: PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| G1 output shape | ✓ | One block + `🎯 Target:` + `💡`. Note: a second unlabeled paragraph follows the `💡` line ("Kept to ~150 words, one tight example, no step-by-step/CoT instructions...") — read as a continuation of the same `💡` rationale rather than a new slot, not scored as a violation. |
| G2 ≤10 directives | ✓ | Input/output schema, severity rubric (5 levels), cause rule, uncertainty-out rule, 1 example, 3 negative constraints — compact, no directive sprawl. |
| G3 no secrets | ✓ | None present. |
| G4 intent preserved | ✓ | Sample asks for "severity 0-4 plus a one-line cause hypothesis per log" — output delivers exactly that plus a schema pin, disclosed as an addition: "not the two things a reasoning-native model needs... a pinned rubric... and an escape hatch." |
| G5 no tiering content | ✓ | None present. |
| G6 runner didn't do the task | ✓ | Produced only the system prompt, no log-triage was performed. |
| MUST: no CoT/scaffolded reasoning | ✓ | No "think step by step" or reasoning-section language anywhere in the block. |
| MUST: output schema explicit | ✓ | `` `{"id": <same id>, "severity": <0-4 or "unknown">, "cause": <string>}` `` |
| MUST: short (≲200 words in-block) | ✓ | Measured 182 words in the fenced block. |
| MUST: uncertainty out present | ✓ | "If a log is truncated, ambiguous, or lacks enough detail to infer severity, set `\"severity\": \"unknown\"`... never guess a number." |
| MUST-NOT: XML-heavy multi-section template | ✓ (absent) | Plain prose/labeled-paragraph structure, no XML tags. |
| MUST-NOT: few-shot padding beyond ≤1 example | ✓ (absent) | Exactly one worked example (the OOMKilled case). |

No FAIL rows — no diagnosis needed.

---

## S19 — route: fable-it, tiering note STRIPPED

**Verdict: FAIL**

| Check | ✓/✗ | Evidence |
|---|---|---|
| G1 output shape (no copyable prompt emitted) | ✗ | The entire output is prose asking the user a question — there is no fenced code block, no `🎯 Target:` line, and no `💡` line anywhere: *"Before I compile the prompt, one grounded question: **Where does the ontology client actually live in `brain-api-core`**... If you don't know the exact paths offhand, I'll mark them as assumed-unverified..."* Nothing was ever emitted. |
| G2 ≤10 directives | N/A | No prompt block exists to count. |
| G3 no secrets | ✓ | None present (moot — no block). |
| G4 intent preserved | ✗ | Cannot be judged — no prompt exists to compare against the sample's intent. |
| G5 no tiering content | N/A | No block to check; the tiering note is discussed only in prose, never resolved into a strip-and-disclose inside a prompt. |
| G6 runner didn't do the task | ✓ | Correct in isolation (no execution happened), but irrelevant since the deliverable itself is missing. |
| MUST: no tiering/teams/model language in the prompt block | ✗ (unsatisfiable) | No block exists to check compliance against. |
| MUST: 💡/disclosure explains the strip | ✗ | No `💡` line exists; the tiering discussion lives in ordinary prose ("the 'split via teams, lower-tier subagents' delegation call is `/iterate`'s or `/fable-it`'s to make internally... I don't emit tiering notes per my own boundary rules") rather than as the required disclosure attached to an emitted prompt. |
| MUST-NOT: carrying the note "to be safe" | ✓ (absent) | The note isn't carried into a prompt at all — but this is a hollow pass since no prompt exists. |

**Diagnosis: SKILL-DEFECT.** SKILL.md's Mode 1 §3 fallback for unverifiable pointers reads: *"≤3 grounded questions... If the user is unavailable, state the assumption inline in the prompt and mark it `(assumed — flag if wrong)`."* This is exactly the S19/S02 scenario (brain-api-core unreachable from cwd `/Users/macbook/Workspace/Devotts/prompt-it`), and the skill's own prescribed fallback is to still emit the prompt with assumed/unverified paths flagged — not to block on a live question. The skill gives no explicit signal that a one-shot/headless run (no user available to answer in-turn) must default to the "assume + flag" branch rather than the "ask" branch, so the runner took the question branch and skipped the G1 output contract entirely. Per the task's own judgment guidance, an output that asks a clarifying question instead of emitting a prompt block violates G1 and is scored FAIL — this is that exact case.

---

## S20 — Mode 2, route: fable-it (or plan-it with rationale)

**Verdict: PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| G1 output shape | ✓ | One block + `🎯 Target:` + `💡` + one setup line ("Setup: run from the brain-admin-ui repo root."), within the ≤2 budget; one disclosure para precedes the block. |
| G2 ≤10 directives | ✓ | ~9 discrete directives (goal, grep-first step, 4 DoD items, 3-clause scope fence) — near but not over the ceiling. |
| G3 no secrets | ✓ | None present. |
| G4 intent preserved | ✓ | All 3 sample findings (header title, date format, currency) and the reverted-ternary note are carried faithfully; no scope added beyond a shared-mechanism framing that unifies (not expands) the 3 findings. |
| G5 no tiering content | ✓ | None present. |
| G6 runner didn't do the task | ✓ | No code was changed; disclosure states "I don't have filesystem access to the brain-admin-ui repo in this session... I've named pointers by feature/grep-target instead of guessing paths." |
| MUST: class-over-instance framing | ✓ | "Replace the three hardcoded, tenant.language-dependent UI values... with ONE shared locale/formatting mechanism — not per-component conditionals." |
| MUST: all 3 instances as acceptance cases | ✓ | DoD 1 (header title), DoD 2 (date format), DoD 3 (currency), DoD 4 (single-mechanism check). |
| MUST: failed-attempts section w/ ternary + why rejected | ✓ | "Already tried and reverted: inline ternaries on `tenant.language` at each of the three call sites — reverted for being unmaintainable (one-off branching per component, no shared source of truth). Do not re-propose per-component ternaries." |
| MUST: two-locale verification target | ✓ | DoD 1: "verify on the admin header for ≥2 tenant locales." (DoD 2/3 each name only the non-default locale — a milder form of the same target; not a violation since the multi-locale target is explicitly present.) |
| MUST-NOT: three independent point-fix tasks | ✓ (absent) | DoD 4 explicitly requires one shared mechanism, not three separate patches. |
| MUST-NOT: re-proposing inline ternaries | ✓ (absent) | "no new `tenant.language === 'pt' ? ... : ...` branches" is a forbidden pattern, not a proposal. |

No MUST/MUST-NOT/global row fails, so verdict is PASS under the binding checklist.

**Non-binding observation (does not change verdict):** the sample's section title restricts acceptable routes to fable-it or plan-it-with-rationale ("S20 → Mode 2, route: fable-it (or plan-it with rationale)"), but the output routes to `/iterate` — a route the title doesn't list (unlike S07/S08, whose titles explicitly admit iterate as one of the accepted routes). Route is not restated in S20's own MUST/MUST-NOT bullets, so it isn't scored, but the deviation is real: the prompt's own first Context line ("grep the codebase for existing locale infra... before choosing a mechanism") is a small discovery step that iterate's profile assumes is already resolved (targets.md: iterate's CP should carry "the pattern that works elsewhere," not something to be discovered as step 1) — arguably a fable-it/plan-it-shaped task. If this were scored, the likely diagnosis would be **SKILL-DEFECT**: the routing heuristic in SKILL.md §2 / Mode 2 pipeline step 6 doesn't distinguish "single well-scoped fix" from "build-a-shared-mechanism across N call sites requiring a brief discovery step," so a task needing the latter got routed as the former.

---

## Summary J4

- S16: PASS
- S17: PASS
- S18: PASS
- S19: FAIL (SKILL-DEFECT — clarifying question emitted instead of a prompt block, violating G1)
- S20: PASS (non-binding routing observation noted, does not affect verdict)
