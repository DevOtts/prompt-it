# Judgment D — v0.2.1-final, S16–S20

Judged against `/Users/macbook/Workspace/Devotts/prompt-it/eval/expected-prompts.md` (GLOBALS G1–G6 + per-sample MUST/MUST-NOT). Properties judged, not byte-equality to exemplars. Standing precedents applied: fence-opens-response = G1 shape check; ≤2 setup lines and ≤3 appended refinement questions with concrete options after the output contract are accepted; inline `(assumed: … — flag if wrong)` and `(unvalidated — …)` markers are sanctioned (headless run from the prompt-it repo root). S18 word count measured with `wc -w` via Bash, fence-to-fence exclusive — never eyeballed. Precedents consulted: `v0.2.0-final/judgment-retry-final.md` (binding S18 FAIL analysis), `v0.2.0-final/judgment-final-4.md` (S16/S17/S19/S20), `v0.2.1-phase1b/judgment-phase1.md` (S18 PASS precedent).

---

## S16 — route: iterate (flaky UI e2e) → **PASS**

Input: tasks-page dropdown throws "ResizeObserver loop limit exceeded", detaches mid-click, suite red; "Get the e2e passing against the real page, not by skipping the test."

| Check | ✓/✗ | Evidence |
|---|---|---|
| Route iterate | ✓ | `/iterate` is the first content line inside the block. |
| G1: fence opens the response | ✓ | File line 1 is the bare 4-backtick fence (`grep -n '^\`\{3,\}'` → lines 1 and 19); 🎯 and 💡 follow; one trailing setup line ("Run this from the app repo that owns the tasks page…") — within the ≤2 allowance. |
| MUST: error symptom carried in CP | ✓ | `throws "ResizeObserver loop limit exceeded" and the element detaches mid-click` — both symptoms verbatim in the block. |
| MUST: no-test-deletion fence | ✓ | `/goal … not by skipping or weakening the test` plus the explicit fence: `no \`test.skip\`/\`test.fixme\`, no retries-as-fix, no blanket page-error suppression`. |
| MUST: DS names the suite-green target | ✓ | DoD 2: `The full e2e suite is green.` DoD 1 additionally pins the specific failing test (`the click lands on an attached element`), DoD 3 pins flake-resistance (`Green holds across repeated runs`). |
| MUST-NOT: re-propose longer waits as the fix | ✓ (absent) | `grep -i wait` over the whole file → zero hits; `retries-as-fix` is explicitly forbidden — the opposite of the banned shape. |
| G2 ≤10 directives | ✓ | Natural per-rule counting: goal (1) + two diagnostic directives (2) + pick-from-evidence (1) + DoD 1–3 (3) + out-of-scope fence line (1, four clauses) ≈ 8 — under the ceiling; consistent with the ~10-at-ceiling counting the v0.2.0 precedent applied to the same sample. |
| G3/G5/G6 | ✓ | No secrets; no tiering/teams content; output is a prompt, the runner fixed nothing itself. |
| G4 intent preserved | ✓ | Same goal (suite green against the real page), no scope added; the two-candidate diagnosis (app-side re-render loop vs. harness promoting a benign browser error) is diagnostic framing of the given symptom, not new scope. The conditional narrow-filter branch is evidence-gated (`If (and only if) evidence proves it benign here, filter that exact message only — never a blanket error swallow`) and does not skip or weaken the test, so it does not breach the no-deletion fence. |
| Cross-tree markers | ✓ | `(assumed: Playwright-over-CDP suite in the app repo … flag if wrong; this compile ran from the prompt-it repo, so no test/component paths could be validated …)` — sanctioned headless behavior. |

**Verdict: PASS.** All MUSTs hold, no MUST-NOT violated. Improvement over the v0.2.0 pass: no appended open-ended question this time (the prior run's only flagged defect) — zero questions appended.

---

## S17 — bare agentic: stop conditions mandatory → **PASS**

Input: agent to sort `~/Downloads` into type subfolders, deleting nothing, pasteable into a plain no-plugins session.

| Check | ✓/✗ | Evidence |
|---|---|---|
| MUST-NOT: harness headers | ✓ (absent) | Block opens directly with the task text (`Organize ~/Downloads by moving files into type subfolders.`); no skill invocation, no @-refs to harness state. |
| MUST: file-scope lock | ✓ | Rule 1: `Top level of ~/Downloads only — never descend into or move existing subfolders`. |
| MUST: forbidden actions | ✓ | `Do not delete or overwrite anything.` + Rule 2: `Move, never copy-then-delete; never delete anything under any circumstance.` + Rule 3: collision → rename `" (2)" / " (3)"` — `never overwrite`. |
| MUST: no-deletion carried from intent | ✓ | Sample's "deleting nothing" carried as an absolute ban (Rule 2, quoted above). |
| MUST: stop conditions | ✓ (property, thinner than exemplar) | Off-plan states all have defined halt-that-action behavior: unmatched/ambiguous types → `stay where they are, untouched` + listed at end (Rule 4, with the ambiguity also surfaced to the human as appended Q1); per-move failure → `skip it, continue, and list every skipped file at the end` (Rule 7); full plan disclosed before execution via `Dry-run first: print the planned moves as a table (filename → destination), then execute` (Rule 6). The human-review-before-destructive trigger is vacuously satisfied: destructive ops are categorically forbidden, so none is reachable. Precedent (judgment-final-4 S17) already ruled defer-ambiguity-to-report "a legitimate design substitution for an interactive bare session"; same ruling applies. Flagged: no literal mid-run stop-and-ask clause — a property gap vs. the exemplar's `list and ask` / `>N moves → checkpoint` mechanisms, non-blocking under the properties-not-bytes standard. |
| MUST: output contract (final move report) | ✓ | `When done, show: count of files moved per folder, the skipped/unmatched list, and the output of \`ls ~/Downloads\` so I can see the result.` — report + run-and-show verification. |
| MUST-NOT: unlimited filesystem scope | ✓ (absent) | Scope bounded to top level of `~/Downloads`; nothing written or read elsewhere. |
| G1 shape | ✓ | Fence at file line 1 (fences at 1 and 20); 🎯 + 💡; 2 appended refinement questions — Q1 (`leave in place as written, or sweep into an \`Other/\` folder?`) and Q2 (`count as Installers, or … only … the four you named plus my extension guesses?`) both carry concrete options. |
| G2 ≤10 directives | ✓ (at ceiling) | Opening imperative (1) + category mapping (1) + Rules 1–7 (7) + output contract (1) = 10 by natural counting — at the ceiling, not over; same count the v0.2.0 precedent passed. |
| G3/G4/G5/G6 | ✓ | No secrets; four categories from the sample kept, extension lists are elaboration not scope-add (and flagged in 💡 as added rails); no tiering; runner produced a prompt, moved no files. `~/Downloads` unvalidated-from-sandbox disclosure in 💡 with the `--add-dir` setup note — sanctioned. |

**Verdict: PASS.** Every MUST present in property, no MUST-NOT violated. Non-blocking note carried forward from precedent: the stop-condition slot remains fail-safe-by-design rather than interactive; any future revision should not thin it further.

---

## S18 — product-LLM, reasoning-native → **PASS**

Input: system prompt for a log-triage analyzer on o3-mini; batch of error logs → severity 0–4 + one-line cause hypothesis per log.

### Word count — measured, not eyeballed
Fences at file lines 1 and 19 (`grep -n '^\`\{3,\}'`). Two independent measurements of the fence-exclusive span:
- `awk` fence-counter over the block → **170**
- `sed -n '2,18p' S18.md | wc -w` → **170**

**170 words**, under the ≲200 MUST (v0.2.0-final failed this at 340; phase1b passed at 197; this run is the shortest yet).

| Check | ✓/✗ | Evidence |
|---|---|---|
| MUST: no CoT / "think step by step" / scaffolded reasoning | ✓ | No such phrase anywhere in the block; `Judge each log independently` is a task rule, not reasoning scaffolding. 🎯 confirms intent: `reasoning-native model, so … no CoT scaffolding`. |
| MUST: output schema explicit | ✓ | `Schema per log: {"id": <0-based index>, "severity": <0-4>, "hypothesis": "<one line, ≤15 words>"}` + `output a JSON array with one object per log, in input order — no prose, no code fences`. |
| MUST: short (≲200 words in-block) | ✓ | **170 words**, measured twice (above). |
| MUST: uncertainty out present | ✓ | `If a log is truncated, ambiguous, or missing context, still assign your best-estimate severity and end the hypothesis with "(low confidence)". Never skip a log`. The `(low confidence)` suffix is an explicit, machine-detectable unknown-state marker in the output — the property the v0.2.0 FAIL analysis demanded (uncertainty surfaced, not papered over with a silent default), and the same shape (best-estimate + explicit marker) the phase1b PASS precedent accepted. |
| MUST-NOT: XML-heavy multi-section template | ✓ (not violated) | No XML tags; flowing prose with three short inline labels (`Schema per log:`, `Severity anchors:`, `Example:`) — materially the compliant shape phase1b certified, not the 7-section ALL-CAPS dossier that failed v0.2.0. |
| MUST-NOT: few-shot padding beyond ≤1 tight example | ✓ (not violated) | Exactly one worked example: one input line, one output object. |
| G1 shape | ✓ | Fence at file line 1; 🎯 + 💡; one setup line (`Paste as the system message; send the raw log batch as the user message.`) ≤2; 3 appended refinement questions, each with concrete options (JSON array vs. `severity<TAB>hypothesis`; 4=critical vs. inverted; 0-based index vs. own IDs). |
| G2–G6 | ✓ | ~6 directives; no secrets; intent preserved (severity 0–4 + one-line hypothesis per log — the severity anchors and truncation rule are format-pinning flagged as assumed in 💡, not scope-add); no tiering; the runner wrote a system prompt, did not triage logs. |

**Verdict: PASS.** The sole driver of the binding v0.2.0 FAIL (340 words, sectioned template, undetectable uncertainty) is fully corrected: 170 words, flowing shape, detectable low-confidence marker.

---

## S19 — route: fable-it, tiering note STRIPPED → **PASS**

Input: ship the key-source fix to done, mirroring trigger-draft.service.ts — plus the stale instruction `IMPORTANT: split the work using claude teams and use lower models for the subagents to save tokens, keep the coordinator on the big model.`

| Check | ✓/✗ | Evidence |
|---|---|---|
| MUST: no tiering/teams/model language anywhere in the prompt block | ✓ | Mechanical scan of the block (file lines 1–18) for `tier|team|model|subagent|coordinator|haiku|sonnet|opus|token` → **zero hits**. |
| MUST: strip disclosed (silent removal = FAIL) | ✓ | 💡: `Dropped your teams/model-tiering instruction from the prompt on purpose: fable-it Step 3 owns delegation and model economics canonically — routing to fable-it IS that decision, and restating it in the prompt would conflict with its own tiering logic.` |
| MUST-NOT: carrying the note "to be safe" | ✓ (absent) | Not carried in any form. |
| S02-checklist: route fable-it | ✓ | `/fable-it` is the first content line. |
| S02-checklist: pattern-to-imitate named | ✓ | `trigger-draft.service.ts — the pattern to mirror: it already does per-Space backbone key with env fallback` (named in /goal and Context). |
| S02-checklist: DoD numbered, each item with a verification target | ✓ | DoD 1 (precedence property, proven by items 2–3), DoD 2 `proven by the key-resolution test for that path`, DoD 3 `proven by its companion test`, DoD 4 `Existing suite green; both resolution branches covered`. |
| S02-checklist: SCOPE FENCES | ✓ | `Out of scope / do not touch: trigger-draft.service.ts itself, key resolution in any other service, no new env vars — reuse the existing \`[ENV_VAR_NAME]\` fallback.` |
| MUST-NOT (S02): persistence/autonomy clauses | ✓ (absent) | None. |
| MUST-NOT (S02): verification protocol prescriptions | ✓ (absent) | DoD states targets (tests exist and prove branches), never how/where to run QA. |
| G1/G3 | ✓ | Fence opens file line 1 (fences at 1, 18); 🎯 + 💡 + one setup line (`Run the prompt from the brain-api-core repo root.`); `[ENV_VAR_NAME]` placeholder style, no secrets. |
| Cross-tree markers | ✓ | `brain-api-core repo (unvalidated — this compile ran outside that tree; confirm the repo path before starting)` + `(assumed: … — flag if wrong)` on the ontology-client pointer — sanctioned. |
| G4/G6 | ✓ | Full intent carried (per-Space backbone key, env fallback, mirror pattern, ship to done); runner shipped nothing itself. |

**Verdict: PASS.** Clean: the tiering note is fully absent from the block, the strip is explicitly disclosed with the canonical rationale, and every S02-equivalent MUST holds.

---

## S20 — Mode 2, three point-bugs hiding one class → **PASS**

Input: three brain-admin-ui FAILs (hardcoded "Painel" title, DD/MM/YYYY dates, "R$" currency), all previously "fixed" by inline `tenant.language` ternaries that were reverted as unmaintainable.

| Check | ✓/✗ | Evidence |
|---|---|---|
| Route fable-it or plan-it with rationale | ✓ | Routes `/plan-it`; rationale given in 🎯: `three surfaces plus an unresolved mechanism decision (which i18n approach) is scope-shaped work, not a fix loop; the ternary revert proves the point-fix path is dead.` — the oracle's alternate route, with the required rationale. |
| MUST: class-over-instance framing (one mechanism, not 3 patches) | ✓ | Grounding: `these are three instances of one missing mechanism (no tenant-locale layer), not three point defects` + /goal: `a single tenant-locale layer — strings, dates, and currency driven by tenant.language — and migrate the three failing surfaces onto it.` |
| MUST: all 3 instances covered as acceptance cases (Pareto) | ✓ | `Findings to resolve (seed instances)` enumerates all three verbatim; DoD 1 makes them acceptance cases: `Header title, tasks-table dates, and billing-widget currency each render per tenant locale — verified on those three live surfaces`. |
| MUST: failed-attempts section with the ternary approach + why rejected | ✓ | Carried twice: Grounding — `all previously "fixed" with inline ternaries on tenant.language — a fix that was reverted as unmaintainable`; fence — `inline ternaries on tenant.language are forbidden (already tried, reverted)`. Attempt + rejection reason + do-not-re-propose all present (property satisfied; not a literally-labeled "Failed attempts:" heading — exemplars are anchors, not targets). |
| MUST: two-locale verification target | ✓ | DoD 1: `verified on those three live surfaces for a pt tenant and an en tenant.` |
| MUST-NOT: three independent point-fix tasks | ✓ (absent) | One mechanism + migration; DoD 2 enforces it: `All locale handling lives in the one shared mechanism — verified at the three fixed call sites: no per-component locale conditionals remain.` |
| MUST-NOT: re-proposing inline ternaries | ✓ (absent) | Explicitly forbidden in the fence (quoted above). |
| Acknowledge nothing falsely | ✓ | All input rows were FAIL; no PASS/credit language appears (`The revert was the right call` validates a decision, claims no win). |
| G1 shape | ✓ | Fence at file line 1 (fences at 1, 38); 🎯 + 💡 + one setup line (`Run the compiled prompt from the brain-admin-ui repo root.`); 2 appended questions, both with concrete options (only-the-three vs. full sweep; ledger card via `/read-chat` vs. pasted-only). |
| G2/G3/G5/G6 | ✓ | ~7 directives (goal, DoD 1–2, four fence clauses); no secrets; tiering scan of the block → zero hits; runner planned nothing and fixed nothing itself. |
| G4 + cross-tree | ✓ | No scope silently added — the possible wider sweep is explicitly deferred (`sweep scope is a discovery decision, not pre-committed — flag if you want all hardcodes fixed now`) and mirrored as Q1; `brain-admin-ui (unvalidated — target session must confirm this path first)` — sanctioned. |

**Verdict: PASS.** All MUSTs hold on the alternate (rationale-carrying) plan-it route; both MUST-NOTs absent.

---

## Summary — judgment D (v0.2.1-final, S16–S20)

| Sample | Verdict | Driver |
|---|---|---|
| S16 | PASS | Symptom carried, no-deletion fence, suite-green DS; no waits-as-fix anywhere; the prior run's open-ended-question defect eliminated (zero questions appended). |
| S17 | PASS | Scope lock + absolute no-delete/no-overwrite + fail-safe off-plan behavior + dry-run plan + move report; stop slot thinner than exemplar (non-blocking, per precedent's substitution ruling). |
| S18 | PASS | 170 words measured twice fence-exclusive (`wc -w`) vs. ≲200; explicit JSON schema; `(low confidence)` detectable uncertainty-out; no CoT; one tight example; flowing non-sectioned shape. |
| S19 | PASS | Tiering note fully stripped (mechanical scan: zero hits in block) and explicitly disclosed in 💡; all S02 MUSTs hold. |
| S20 | PASS | One tenant-locale mechanism with the 3 findings as acceptance cases, ternary failed-attempt carried + forbidden, pt+en two-locale verification; plan-it route with rationale (oracle-sanctioned alternate). |

5/5 PASS. No FAIL diagnoses required — no SKILL-DEFECT, ORACLE-DEFECT, or HARNESS-ARTIFACT findings in this batch.
