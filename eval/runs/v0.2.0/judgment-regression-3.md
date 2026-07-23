# v0.2.0 full-suite regression — judgment set 3 (S12, S13, S15, S16)

Method: property conformance against `eval/expected-prompts.md` GLOBALS G1–G6 + per-sample MUST/MUST-NOT, read against `eval/sample-prompts.md` inputs. Skill/targets.md consulted only for diagnosis, never as the pass bar. No git used.

---

## S12 — dead pointer: caught, not propagated

**Verdict: PASS**

| # | Criterion | Status | Evidence |
|---|---|---|---|
| 1 | Dead path NOT emitted as a live `@`-ref | ✓ | Prompt block opens `Create docs/architecture/overview.md documenting the prompt-it eval suite under eval/.` — plain text naming the file to create, no `@` prefix anywhere in the block; every other pointer in the Context package (`eval/sample-prompts.md`, `eval/expected-prompts.md`, `eval/scripts/run-eval.sh`, `README.md ... (line 254)`) is likewise bare text, not `@`-syntax. |
| 2 | Explicit disclosure of the dead pointer | ✓ | Inline: `(assumed: docs/architecture/overview.md does not exist yet anywhere in the repo — the only current architecture doc is README.md's "## Architecture / What's inside" section...)`. Restated in 💡: `The named target path doesn't exist anywhere in the repo (verified via \`find\`)...` |
| 3 | Intent preserved (documenting the eval suite still happens) | ✓ | `/goal: document what the eval suite is, how its pieces fit together, and how to run it` — DoD sketch items 1–3 carry it through. |
| 4 | MUST-NOT: silently inventing a different path as if user-named | ✓ (not violated) | The prompt keeps the user's literal path and flags it as an assumption rather than substituting README.md silently — README is offered as the flagged alternative, not imposed. |
| 5 | G1 shape (fence-first, 🎯, 💡, ≤2 setup lines) | ✓ | Response begins at the opening fence (line 1); closes with 🎯 (line 24) then 💡 (line 25); no extra setup lines. |
| 6 | G5 no tiering/economics content | ✓ | None present. |
| 7 | G6 runner did not do the task | ✓ | No file was created; only the prompt was produced. |

No FAIL rows. No diagnosis needed.

---

## S13 — legitimate ambiguity

**Verdict: FAIL**

| # | Criterion | Status | Evidence |
|---|---|---|---|
| 1 | One of the two behaviors present (grounded questions OR flagged-assumption prompt) | ✓ | Behavior (b) chosen: full prompt emitted with inline assumption. |
| 2 | If assumed, assumption explicit in the prompt block | ✓ | `Sessions in the auth system are expiring far sooner than intended in the Engine workspace (assumed: "Engine workspace" = the Engine repo/project directory — flag if wrong, since it's outside this session's accessible tree and unvalidated here).` |
| 3 | **Any question present has concrete options (not "what did you mean?")** | ✗ | Appended after the output contract: `Want me to tighten anything once you confirm the actual Engine path or auth module location?` — this offers no candidate options (no "repo A vs repo B", no "TTL vs idle timeout" the way the oracle's own exemplar frames it); it is functionally the open-ended "what did you mean" pattern the oracle and SKILL.md both explicitly forbid. |
| 4 | MUST-NOT: silently picking a repo/module with no flag | ✓ (not violated) | Not silent — flagged. |
| 5 | MUST-NOT: >3 questions | ✓ (not violated) | Only 1 question. |
| 6 | G1 shape (full output contract first, questions only appended after) | ✓ | Fence → 🎯 → 💡 → 1 setup line → 1 question, in that order; the block is not replaced by the question. |

**Diagnosis: SKILL-DEFECT.** The one failing row is narrow — the required behavior (b) is executed correctly and the core assumption is properly flagged — but the optional appended refinement question violates the skill's own explicit rule (SKILL.md Mode 1 §3: "never open-ended 'what did you mean?'") and the oracle's parallel MUST ("any question has concrete options"). This is the skill's stated contract not being honored in execution, not a flaw in the oracle's wording (the oracle correctly enforces the skill's own rule) and not an artifact of how the eval harness invoked the sample (the question is on-topic, content-relevant, not boilerplate bleed).

---

## S15 — route: fable-it (version-check script)

**Verdict: FAIL**

| # | Criterion | Status | Evidence |
|---|---|---|---|
| 1 | **G1: response starts at the opening fence, zero preamble** | ✗ | File's actual first line, preceding the fence: `Skipping that — not load-bearing for the prompt. All four version pointers are validated and currently aligned at 0.2.0.` The fence itself doesn't appear until line 3. HARD OUTPUT RULE #1 ("Your response starts at the opening fence... Zero preamble, zero narration") and the binding nuance given for this judgment ("response starts at the opening fence... setup lines may follow 🎯/💡") are both violated — this is narration *before* the fence, not after. |
| 2 | Route fable-it | ✓ | First line inside the block: `/fable-it`. |
| 3 | DoD includes the negative test (prove it catches a mismatch) | ✓ | Item 3: `With one file's version deliberately diverged from the other three: script exits non-zero and its output names which file(s) disagree and what version each one shows.` |
| 4 | SCOPE FENCES present | ✓ | `Out of scope / do not touch: don't wire this into a git hook or CI workflow — the script itself is the deliverable; don't change the actual shipped version number in any of the four files; don't touch unrelated repo files (eval/, README.md, prompt-examples.txt, etc.).` |
| 5 | MUST-NOT: tiering/persistence content | ✓ (not violated) | None present. |
| 6 | G6 runner did not do the task | ✓ | 💡 confirms validation only: `Validated all four version pointers on disk (they're currently consistent at 0.2.0...)` — no script was actually written by the runner. |

**Diagnosis: SKILL-DEFECT.** Every fable-it-specific MUST (route, negative test, scope fences) is satisfied cleanly — the prompt content itself is a strong exemplar match. The failure is purely structural: a stray meta-comment ("Skipping that — not load-bearing for the prompt...") leaked ahead of the fence, violating the skill's own zero-preamble hard rule. This isn't an oracle wording problem (G1's fence-first rule is unambiguous and correctly applied here) and doesn't look like harness boilerplate bleed (the sentence is topically about the version-pointer validation the prompt itself performed, i.e., genuine model output, not injected scaffolding) — it's the skill's Rule 1 not being enforced strongly enough at the self-check stage.

---

## S16 — route: iterate (flaky e2e dropdown)

**Verdict: PASS**

| # | Criterion | Status | Evidence |
|---|---|---|---|
| 1 | Route iterate | ✓ | First line: `/iterate`. |
| 2 | Error symptom carried into CP | ✓ | CP bullet 3: `Symptom pairing (ResizeObserver loop-limit warning + mid-click detach) reads as the dropdown re-rendering/repositioning while CDP's click is still resolving — a real layout/interaction race, not flaky infra.` (also stated up top in the grounding line). |
| 3 | No-test-deletion fence | ✓ | Out of scope: `do not skip, weaken, or delete the failing test`; DoD item 1 also states the pass must be `unmodified in scope (not skipped, not xfail'd, not deleted)`. |
| 4 | DS names the suite-green target | ✓ | Item 1: `The CDP e2e spec for the tasks-page dropdown passes, unmodified in scope... — target: the e2e suite run output for that spec.` |
| 5 | MUST-NOT: longer-waits-as-fix | ✓ (not violated) | Explicitly forbidden twice: DoD item 3 target requires `no added sleep/retry padding`; Out of scope: `do not paper over the race with sleeps/retries/longer waits`. |
| 6 | G1 shape | ✓ | Fence-first, 🎯, 💡, no extra setup lines. |
| 7 | Cross-tree pointer handling | ✓ (load-bearing, not a checklist MUST but notable) | 💡 correctly flags that this working tree has no matching app code and marks the dropdown/e2e pointers `(assumed — flag if wrong)` per the skill's cross-tree-pointer rule, rather than inventing a validated-looking path. |

No FAIL rows. No diagnosis needed.

---

## Summary regression-3

| Sample | Verdict | Failing row | Diagnosis |
|---|---|---|---|
| S12 | PASS | — | — |
| S13 | FAIL | appended refinement question lacks concrete options ("what did you mean" pattern) | SKILL-DEFECT |
| S15 | FAIL | preamble sentence precedes the opening fence (G1 zero-preamble violated) | SKILL-DEFECT |
| S16 | PASS | — | — |
