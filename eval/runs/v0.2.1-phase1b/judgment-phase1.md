# Phase 1 judgment — v0.2.1-phase1b (S11, S18)

Judged against `/Users/macbook/Workspace/Devotts/prompt-it/eval/expected-prompts.md` (GLOBALS G1–G6 + per-sample MUST/MUST-NOT) and the binding nuances carried over from `eval/runs/v0.2.0-final/judgment-retry-final.md`. Evidence-quoted, properties judged (not byte-equality to the exemplar). `wc -w` run directly via Bash on the fenced content for S18 — see word-count section.

---

## S11 — clarity gate: minimal tighten (already well-formed) → **PASS**

Input (`sample-prompts.md` S11): `plan-it. /goal add a CONTRIBUTING.md to this repo covering how to add a new target profile to references/targets.md. DoD: 1. file exists with profile-addition steps 2. linked from README. Out of scope: no CI changes.`

Output under judgment (`eval/runs/v0.2.1-phase1b/S11.md`):
```
plan-it. /goal add a CONTRIBUTING.md to this repo covering how to add a new target profile to plugins/prompt-it/skills/prompt-it/references/targets.md. DoD: 1. file exists with profile-addition steps 2. linked from README. Out of scope: no CI changes.
```
🎯 Target: plan-it — route locked as you specified it.
💡 Fixed a dead pointer: `references/targets.md` doesn't exist at repo root — the real file is `plugins/prompt-it/skills/prompt-it/references/targets.md` (confirmed README currently has no CONTRIBUTING link, so DoD item 2 is a real gap). Note: this reads as a single small doc addition with a locked DoD already — fable-it would run it directly without the planning pass, if you'd rather skip plan-it.

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | G1 output shape (fence opens the response → 🎯 → 💡) | ✓ | Line 1 of the file is the bare fence `` ``` `` (verified with `sed -n '1p'`); `🎯 Target:` and `💡` each appear exactly once, no extra setup lines. |
| 2 | Route stays plan-it (user-locked) | ✓ | `plan-it. /goal …` kept verbatim as the opening of the block, unchanged. |
| 3 | User's structure preserved (single inline paragraph, not re-poured into template) | ✓ | Output is still one paragraph — `/goal … DoD: 1. … 2. … Out of scope: …` — same shape and same three clauses as the input, no 6-slot scaffold. |
| 4 | **Binding nuance: NO new section/label the user didn't write (e.g. standalone `Grounding:`/`Context:` block) = FAIL if present** | ✓ | No such block exists anywhere in the output. This is the exact defect the prior run committed (`Grounding: contributors need a documented path for extending prompt-it's per-target responsibility map…` — v0.2.0-final judgment, S11 check #5) and it is absent here. |
| 5 | In-place defect fix allowed (dead path corrected inside the existing `/goal` line) | ✓ | `references/targets.md` → `plugins/prompt-it/skills/prompt-it/references/targets.md`, edited in place inside the same clause, not moved to a new slot. Verified real: `ls plugins/prompt-it/skills/prompt-it/references/targets.md` resolves; `ls references/targets.md` (repo root) does not exist. |
| 6 | 💡 line disclosure of the fix, not silent | ✓ | `💡 Fixed a dead pointer: … (confirmed README currently has no CONTRIBUTING link, so DoD item 2 is a real gap).` — disclosed, and the "no CONTRIBUTING link in README" claim checks out (`grep -n -i "contributing" README.md` → no hits). |
| 7 | No scope added beyond the user's own out-of-scope line (contrast with prior run's added restriction) | ✓ | `Out of scope: no CI changes.` carried verbatim — no extra restrictions appended (prior run had added "no edits to targets.md's actual profiles or to SKILL.md", which is absent here). |
| 8 | No questions appended | ✓ | None present; the only trailing content is a single optional observation inside the same 💡 line, not a question. |
| 9 | G2–G6 (directive count, no secrets, intent preserved, no tiering content, prompt-it did not do the task) | ✓ | 3 directives total (file exists + steps, linked from README, no CI changes) — well under 10; no credentials; DoD items 1–2 and the out-of-scope clause all preserved unchanged; no tiering/team language; the runner did not create CONTRIBUTING.md itself. |

**Verdict: PASS.** Every binding MUST holds and no MUST-NOT is violated. This is a direct correction of the prior cycle's failure mode: the same input, previously mangled into an unauthorized `Grounding:` block, is now returned as a genuine minimal tighten — one in-place path fix, verified against the real file layout, disclosed in the 💡 line, with no new sections, no added scope, and no questions.

---

## S18 — product-LLM, reasoning-native → **PASS**

Input (`sample-prompts.md` S18): `Write the system prompt for our log-triage analyzer that runs on o3-mini. It gets a batch of error logs and must output severity 0-4 plus a one-line cause hypothesis per log.`

Output under judgment (`eval/runs/v0.2.1-phase1b/S18.md`), fenced block spans file lines 1–23; the fence itself is at line 1 and line 23 (`grep -n '^```' eval/runs/v0.2.1-phase1b/S18.md` → `1:` and `23:`).

### Word count (measured, not eyeballed)
Ran `sed -n '2,22p' eval/runs/v0.2.1-phase1b/S18.md | wc -w` (content strictly between the opening and closing fence, both exclusive) and independently cross-checked with an `awk` fence-counter extracting the same span:
```
     197
```
Both methods agree: **197 words**, in-block, fence-to-fence exclusive.

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | No CoT / "think step by step" / scaffolded reasoning | ✓ | No such phrase anywhere in the fenced block; the 💡 line states it was deliberately avoided: "Capped at 200 words with no CoT scaffolding since o3-mini is reasoning-native". |
| 2 | Output schema explicit | ✓ | `` `<log_id>|<severity 0-4>|<cause hypothesis>` `` — pinned pipe-delimited format, fields named. |
| 3 | **Short (≲200 words in-block)** | ✓ | Measured 197 words via `wc -w` on the fence-exclusive span — under the ≲200 MUST (previous run measured 340, ~70% over; this run is compliant). |
| 4 | Uncertainty out present | ✓ | "If a log lacks enough detail to infer a cause, still emit a line: give your best-estimate severity and cause `insufficient context: <what's missing>`. Never skip a log or leave a field blank." — explicit uncertainty-out behavior (different literal wording than the exemplar's `severity: unknown`, but the required property — don't silently drop/refuse, name the gap — is present). |
| 5 | MUST-NOT: XML-heavy multi-section template | ✓ (not violated) | No XML tags; only short plain-text labels (`Severity anchors:`, `Cause hypothesis:`, `Example:`) inline in a single flowing prompt, not a multi-section labeled dossier — a materially different (and compliant) shape from the prior run's 6 ALL-CAPS sections that drove the 340-word overage. |
| 6 | MUST-NOT: few-shot padding beyond ≤1 tight example | ✓ (not violated) | Exactly one worked example (`Input: … Output: …`), 2 lines. |
| 7 | G1 output shape (fence opens the response → 🎯 → 💡, appended refinement questions allowed per precedent) | ✓ | File line 1 is the bare fence; `🎯 Target:` and `💡` lines follow; then one `Setup:` line (≤2 setup lines allowed) and 3 appended "Optional refinements" questions after the output contract — per the stated precedent, ≤3 appended refinement questions after the output contract do not violate G1. |
| 8 | G2–G6 (directive count, no secrets, intent preserved, no tiering content, prompt-it did not do the task) | ✓ | ~6 core directives (line format, severity anchors, cause-hypothesis rule, missing-data rule, batch/order rule, no-commentary rule) — well under 10; no credentials; task intent (severity 0–4 + one-line cause hypothesis per log) preserved and not scope-expanded beyond format-pinning and uncertainty handling appropriate to "write the system prompt" itself; no tiering/model-economics content; the runner produced a system prompt rather than running log triage itself. |

**Verdict: PASS.** The explicit word-count MUST — the sole driver of the prior cycle's FAIL (340 words) — now measures 197 words, under the ≲200 threshold, and every other checklist item continues to hold. The structural fix (flowing prose with short inline labels instead of a fully-sectioned rubric with a 5-tier severity scale) is what bought back the word budget without dropping the schema, the uncertainty-out clause, or the worked example.

---

## Summary — v0.2.1-phase1b (S11, S18)

| Sample | Verdict | Driver |
|---|---|---|
| S11 | PASS | No `Grounding:`/`Context:` section added (the prior cycle's exact failure mode); dead pointer fixed in place and verified real; scope and DoD preserved verbatim. |
| S18 | PASS | Fenced content measures 197 words (`wc -w`, fence-exclusive) — under the ≲200 MUST; no XML-heavy multi-section template; schema, uncertainty-out, and single tight example all present. |

Both samples reverse their v0.2.0-final FAIL verdicts. No ORACLE-DEFECT or HARNESS-ARTIFACT diagnosis needed for either — both are clean PASSes against the binding checklist.
