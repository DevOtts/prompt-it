# Judgment D — v0.3.0-final, S16–S20

Judged against `/Users/macbook/Workspace/Devotts/prompt-it/eval/expected-prompts.md` (GLOBALS G1–G7 + per-sample MUST/MUST-NOT), inputs `eval/runs/.samples/S16.txt`–`S20.txt`, outputs `eval/runs/v0.3.0-final/S16.md`–`S20.md`. Precedent honored: `eval/runs/v0.2.1-final/judgment-D.md` (0.2.1 certified 20/20). Standing rulings applied: fence-opens-response = G1 shape check; ≤3 appended refinement questions with ≥2 concrete options after the output contract are accepted; inline `(assumed: … — flag if wrong)` and `(unvalidated — target session must confirm)` markers are sanctioned headless behavior; properties judged, never byte-equality. NEW in 0.3.0, judged strictly: G1's `▶` delivery line (exactly one, literally prefixed, run-here vs fresh-session with one reason, setup rides the same line) and G7 (delivery call matches session signals — fresh session expected for these headless pure-text samples; dangling-evidence guard inside the block). S18 hard cap: 200 words fence-to-fence, measured with `wc -w` (never eyeballed) — and the count/cap must not be narrated in the response. Rename note: `fable-it` → `build-it` (v3.1.0); the oracle now says `build-it`; an output saying `fable-it` is a rename-lag observation, not a fail-on-name.

Mechanical evidence gathered once for all samples: fences at file lines S16 (1,19), S17 (1,12), S18 (1,18), S19 (1,16), S20 (1,43) — fence opens every file; `grep -c '^▶'` → exactly 1 per file; block-scoped dangling-evidence scan (`above|I pasted|screenshot|attached|earlier in this session`) → zero hits in all five blocks.

---

## S16 — route: iterate (flaky UI e2e) → **PASS**

Input: tasks-page dropdown throws "ResizeObserver loop limit exceeded", detaches mid-click, CDP suite red; "Get the e2e passing against the real page, not by skipping the test."

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | Shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ | Fence at file line 1 (fences 1, 19); `🎯 Target: iterate` (l.20); 💡 (l.21); one `▶` line (l.22): `▶ Paste into a fresh session. Run from the app repo root that owns the CDP e2e — this tree isn't it.` — literally prefixed, delivery stated, setup rides the same line, no stray un-prefixed setup line. |
| G7 | Delivery matches signals + no dangling evidence | ✓ | Fresh-session call (expected for headless pure-text input) with a real reason (`this tree isn't it`); evidence scan of the block → zero pointer phrases; the error is carried as pasted *text* (`throws "ResizeObserver loop limit exceeded"`), compliant per G7's paste-don't-point rule. |
| G2 | ≤10 directives in block | ✓ | Goal (1) + two failure-class diagnostics (2) + if-benign-still-resolve rule (1) + DoD 1–3 (3) + out-of-scope line (1, three clauses) ≈ 8 — under ceiling, same counting convention as the 0.2.1 precedent. |
| G3 | No secrets | ✓ | None; no env material in this sample. |
| G4 | Intent preserved | ✓ | Same goal (suite green against the real page); the harness-class vs app-class split is diagnostic framing of the given symptom, not new scope — precedent (0.2.1 S16) accepted the same two-candidate framing. |
| G5 | No tiering in block | ✓ | Scan → zero hits. |
| G6 | Runner produced a prompt, didn't fix | ✓ | Output is a compiled `/iterate` prompt; no test files touched. |
| M1 | MUST: route iterate | ✓ | `/iterate` is the first content line inside the block (l.2). |
| M2 | MUST: error symptom in CP | ✓ | `throws "ResizeObserver loop limit exceeded" and the dropdown detaches mid-click` — both symptoms verbatim (l.4). |
| M3 | MUST: no-test-deletion fence | ✓ | /goal: `with the dropdown test still active and unweakened`; DoD 3: `no .skip, no removed assertions, and no blanket error-swallowing beyond a ResizeObserver-specific allowance (only if the harness class applies)`; plus `suppression that turns the suite green while the dropdown still detaches is not done` (l.11). |
| M4 | MUST: DS names suite-green target | ✓ | DoD 1: `The failing dropdown spec passes — full suite output green, not rescued by retries.` DoD 2 pins the dropdown interaction demonstrably exercised: `The dropdown opens and an item click lands on the real tasks page.` |
| MN1 | MUST-NOT: longer waits as the fix | ✓ (absent) | `grep -i wait` over the whole file → zero hits; retries explicitly disallowed (`not rescued by retries`; `suite-wide timeout or retry inflation to mask the failure` forbidden) — the opposite of the banned shape. |
| — | Cross-tree markers | ✓ | `(assumed: you are in the app repo that owns the tasks page and its e2e suite — this compile ran in a tree with no e2e; flag if wrong.)` — sanctioned. |

**Verdict: PASS.** All MUSTs hold, MUST-NOT absent, new G1/G7 shape clean (the `▶` line carries call + reason + setup in one line).

---

## S17 — bare agentic: stop conditions mandatory → **PASS**

Input: agent to sort `~/Downloads` into type subfolders (images, pdfs, archives, installers), deleting nothing; pasteable into a plain no-plugins session.

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | Shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ | Fence at file line 1 (fences 1, 12); 🎯 (l.13); 💡 (l.14); one `▶` line (l.15): `▶ Paste into a fresh session — start it with \`cd ~/Downloads && claude\` so the folder is inside the session's allowed working directory.` — setup rides the `▶` line as required. One appended refinement question (l.17) with two concrete options (`stay in place (current assumption), or go into an \`Other\` subfolder?`) — within the ≤3 allowance. |
| G7 | Delivery matches signals + no dangling evidence | ✓ | Fresh-session call with a genuine reason (working-directory allowance for `~/Downloads`); block scan → zero in-session-evidence pointers. |
| G2 | ≤10 directives | ✓ | Opening imperative + move-only declaration (1) + Rules 1–7 (7) = 8 by natural counting — under ceiling (0.2.1 precedent passed this sample at 10). |
| G3 | No secrets | ✓ | None. |
| G4 | Intent preserved | ✓ | Four categories from the sample kept verbatim (Images, PDFs, Archives, Installers); extension lists are elaboration flagged inline as `(assumed extension lists — flag if wrong)`, not silent scope-add. |
| G5 | No tiering | ✓ | Zero hits. |
| G6 | Runner produced a prompt, moved no files | ✓ | Output is a pasteable prompt; 💡 confirms `I couldn't preview ~/Downloads (this session is sandboxed to the prompt-it repo…)`. |
| M1 | MUST: stop conditions | ✓ | Rule 6: `If a file is ambiguous or a move fails, skip it and record why — do not guess or retry destructively.` + Rule 7 hard stop: `Stop there — no further cleanup.` + skipped/unmatched surfaced in the final report. ⚠ borderline: like 0.2.1, this is the fail-safe substitution (skip-and-report) rather than a literal mid-run list-and-ask / >N-moves checkpoint; the 0.2.1 precedent explicitly ruled defer-ambiguity-to-report "a legitimate design substitution for an interactive bare session" — same ruling applied, non-blocking, but this slot must not thin further (it lost the dry-run-plan step the 0.2.1 output had). |
| M2 | MUST: forbidden actions | ✓ | Rule 5: `Forbidden: rm or any deletion, overwriting files, modifying file contents, touching any path outside ~/Downloads.` + Rule 4 collision → numeric-suffix rename (`report-1.pdf`), `never overwrite`. |
| M3 | MUST: file-scope lock | ✓ | Top-level-only lock: Rule 2 `Move top-level files`; Rule 3 `do not recurse into any subfolder`; Rule 5 bans any path outside `~/Downloads`. |
| M4 | MUST: no-deletion carried from intent | ✓ | Header line inside block: `Move-only job — nothing is ever deleted.` + Rule 5 ban. |
| M5 | MUST: output contract (final move report) | ✓ | Rule 7: `Done = every matched file moved and this report printed: files moved per folder, skipped files with reasons, unmatched files left in place. Then show the result by listing ~/Downloads and each of the four subfolders.` — report + run-and-show. |
| MN1 | MUST-NOT: harness headers | ✓ (absent) | Block opens with the bare task (`Organize ~/Downloads by moving files into type subfolders.`); no skill invocation, no @-refs, no /read-chat. |
| MN2 | MUST-NOT: unlimited filesystem scope | ✓ (absent) | Scope bounded to top level of `~/Downloads`; Rule 5 forbids touching anything outside it. |

**Verdict: PASS.** Every MUST present in property, both MUST-NOTs absent; stop-condition slot passes on the standing substitution ruling (⚠ borderline note recorded above).

---

## S18 — product-LLM, reasoning-native (F2 hard-cap case) → **FAIL**

Input: system prompt for a log-triage analyzer on o3-mini; batch of error logs → severity 0–4 + one-line cause hypothesis per log.

### Word count — measured, not eyeballed
Fences at file lines 1 and 18 (`grep -n '^\`\{3,\}'`). Two independent fence-exclusive measurements:
- `sed -n '2,17p' S18.md | wc -w` → **154**
- `awk` fence-counter over the block → **154**

**154 words** — under the 200-word hard cap.

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | Shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ | Fence at file line 1 (fences 1, 18); 🎯 (l.19); 💡 (l.20); one `▶` line (l.21). |
| G7 | Delivery matches signals + no dangling evidence | ✓ | `▶ Paste into your o3-mini system-prompt slot (the API \`instructions\`/system role in your analyzer service) — this is a product system prompt, not a Claude session prompt.` — for a product-LLM target the session-vs-fresh binary is inapplicable; the line names the correct delivery destination with a stated reason. ⚠ borderline on the letter of G1 ("run here or paste into a fresh session"), but the property (one prefixed delivery decision + reason) holds and is the only sane call for this target. Block scan → zero dangling-evidence pointers. |
| G2 | ≤10 directives | ✓ | Role/input (1) + per-log output format (1) + anchors (1) + Rules ×4 + example (data) ≈ 7. |
| G3 | No secrets | ✓ | None. |
| G4 | Intent preserved | ✓ | Severity 0–4 + one-line cause hypothesis per log carried exactly; schema/anchors/edge behavior are format-pinning flagged as assumptions inline. |
| G5 | No tiering in block | ✓ | Zero hits. |
| G6 | Runner wrote a prompt, triaged no logs | ✓ | Output is the system prompt only. |
| M1 | MUST: no CoT / scaffolded reasoning | ✓ | No "think step by step", no reasoning sections anywhere in the block; rules are task rules only. |
| M2 | MUST: output schema explicit | ✓ | `{"id":<1-based index>,"severity":<0-4>,"cause":"<one-line root-cause hypothesis, ≤15 words>"}` + one-object-per-line, input order, `Emit only JSON lines — no prose, no code fences, no markdown.` |
| M3 | MUST: short (hard cap 200 words fence-to-fence) | ✓ | **154 words**, measured twice (above) — shortest run yet (0.2.1: 170). |
| M4 | MUST: uncertainty out present | ✓ | `Truncated or unparseable log: score the worst plausible reading; cause starts with "unparseable:".` — a machine-detectable unknown-state marker in the output, the same best-estimate + explicit-marker shape the 0.2.1 precedent accepted for `(low confidence)`. |
| MN1 | MUST-NOT: XML-heavy multi-section template | ✓ (not violated) | No XML; flowing prose with two inline labels (`Rules:`, `Example:`). |
| MN2 | MUST-NOT: few-shot padding beyond ≤1 example | ✓ (not violated) | Exactly one worked example (one input line, one output object). |
| R1 | 0.3.0 interaction check: no `▶`-ish content inside block; block still under cap after delivery-line addition | ✓ | No delivery/setup content inside the fence; the `▶` line sits outside (l.21) and is excluded from the 154-word count. |
| R2 | **Standing ruling: count/cap must NOT be narrated in the response** | ✗ | 💡 line (l.20) states: `Kept under the 200-word reasoning-model cap; no chain-of-thought scaffolding, since o3-mini reasons natively…` — this **states the cap** ("the 200-word … cap") and narrates compliance with it. The binding ruling for this sample is explicit: "the word count must NOT be narrated in the response — stating the count or the cap is itself a violation." The 💡 line is part of the response. Not borderline: the cap figure is named verbatim. |

**Verdict: FAIL.** The block itself is fully compliant (154 words, schema, uncertainty-out, no CoT, one example), but the response narrates the 200-word cap in the 💡 line, which the standing S18 ruling defines as a violation in its own right. Diagnosis: SKILL-DEFECT (meta-narration leak) — the skill's brevity rule is being *explained* in the delivery notes instead of silently applied. Fix shape: the 💡 may say "no CoT scaffolding — reasoning-native model" but must never mention the word budget or the count.

---

## S19 — route: build-it, tiering note STRIPPED → **PASS**

Input: ship the key-source fix to done, mirroring trigger-draft.service.ts — plus the stale instruction `IMPORTANT: split the work using claude teams and use lower models for the subagents to save tokens, keep the coordinator on the big model.`

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | Shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ | Fence at file line 1 (fences 1, 16); 🎯 (l.18); 💡 (l.20); one `▶` line (l.22): `▶ Paste into a fresh session. Run from the brain-api-core repo root.` — prefixed, delivery call stated, setup rides the same line. ⚠ borderline: the reason for fresh-session is carried implicitly by the setup ("Run from the brain-api-core repo root" — a different repo than this tree) rather than spelled out like S16's "this tree isn't it"; the property (call + why-there) is present, so PASS, but the reason clause should be explicit. |
| G7 | Delivery matches signals + no dangling evidence | ✓ | Fresh-session call (expected); block scan → zero in-session-evidence pointers; the pattern is cited as a persisted path (`trigger-draft.service.ts`), compliant. |
| G2 | ≤10 directives | ✓ | /goal (1) + two context pointers (2) + DoD 1–3 (3) + out-of-scope line (1) = 7. |
| G3 | No secrets | ✓ | `key referenced as the existing env var, never hardcoded` — no literal keys, no credentials. |
| G4 | Intent preserved | ✓ | Per-Space backbone key first, env fallback, mirror trigger-draft.service.ts, ship to done — all carried; the tiering removal is disclosed, not silent (see M2). |
| G5 | No tiering/teams/model content in block | ✓ | Mechanical scan of block (l.2–15) for `tier|team|model|subagent|coordinator|haiku|sonnet|opus|token` → **zero hits**. |
| G6 | Runner shipped nothing itself | ✓ | Output is a compiled prompt only. |
| M1 | MUST: route build-it (renamed oracle target) | ✓ | `/build-it` is the first content line (l.2) — matches the v3.1.0 renamed target; no rename-lag. |
| M2 | MUST: strip disclosed (silent removal = FAIL) | ✓ | 💡 (l.20): `Removed your teams/lower-models instruction from the block on purpose: build-it owns delegation and model tiering (its Step 3 + your global "tier models on team runs" default already enforce coordinator-on-big-model, cheap subagents) — restating it in the prompt is redundant and can conflict with its escalation logic.` |
| M3 | S02-checklist: pattern-to-imitate named | ✓ | `Pattern to mirror: trigger-draft.service.ts (unvalidated — target session must confirm this path first) — it already solves per-Space-key-with-env-fallback; copy its resolution order` (l.7). |
| M4 | S02-checklist: DoD numbered, each item with a verification TARGET | ✓ | DoD 1 `proven by an ontology call on such a Space hitting the LLM with that key`; DoD 2 `proven by an ontology call on such a Space succeeding` (env-fallback branch); DoD 3 `Test suite green, with coverage for both key sources`. |
| M5 | S02-checklist: SCOPE FENCES | ✓ | `Out of scope / do not touch: trigger-draft.service.ts itself, key resolution in other LLM call sites, and how backbone keys are stored or encrypted.` |
| MN1 | MUST-NOT: carrying the tiering note "to be safe" | ✓ (absent) | Not carried in any form inside the block (zero-hit scan above); mentioned only in the mandated 💡 disclosure. |
| MN2 | MUST-NOT (S02): persistence/autonomy clauses | ✓ (absent) | None in the block; "run autonomously to done" appears only in the 🎯 rationale, outside the block. |
| MN3 | MUST-NOT (S02): verification protocol prescriptions | ✓ (absent) | DoD states what proves each branch, never how/where to run QA. |
| — | Cross-tree markers | ✓ | `(unvalidated — target session must confirm this path first)` + `(assumed: a single client module owns the key lookup — flag if the key is read in multiple places)` — sanctioned. |

**Verdict: PASS.** Tiering note fully absent from the block (mechanical zero-hit scan), strip explicitly disclosed with the canonical build-it-owns-delegation rationale, route uses the renamed `build-it` target, all S02-equivalent MUSTs hold. One ⚠ borderline note on the `▶` reason being implicit-by-setup.

---

## S20 — Mode 2, three point-bugs hiding one class → **PASS**

Input: three brain-admin-ui FAILs (hardcoded "Painel" title, DD/MM/YYYY dates, "R$" currency), all previously "fixed" by inline `tenant.language` ternaries that were reverted as unmaintainable.

| # | Check | Status | Evidence |
|---|---|---|---|
| G1 | Shape: fence → 🎯 → 💡 → exactly one `▶` | ✓ | Fence at file line 1 (fences 1, 43); 🎯 (l.45); 💡 (l.47); one `▶` line (l.49): `▶ Paste into a fresh session — run from the brain-admin-ui repo root (path unvalidated from here; confirm it before starting).` — prefixed, call + reason + setup on one line. |
| G7 | Delivery matches signals + no dangling evidence | ✓ | Fresh-session call (expected); the three findings are carried as pasted *text* inside the block (`Findings to resolve … 1. Header title hardcoded "Painel" …`), not pointed at ("the findings above" appears nowhere); block scan → zero pointer phrases. |
| G2 | ≤10 directives | ✓ | /goal (1) + no-per-component-fixes rule (1) + discovery-must-resolve line (1, three clauses — grouped-clause counting per the 0.2.1 precedent's convention for the out-of-scope line) + do-not-re-propose fence (1) + DoD 1–4 (4) + out-of-scope line (1) = 9. At-ceiling note: counting each discovery bullet separately would give 11; the standing natural-per-rule convention groups clause-lines, so 9 stands. |
| G3 | No secrets | ✓ | None. |
| G4 | Intent preserved | ✓ | All three findings carried verbatim; the reverted-ternary history carried; out-of-scope additions (`no languages beyond those tenants already have; no surfaces outside brain-admin-ui; no backend changes beyond reading the existing tenant locale field`) are fences, not scope-adds. |
| G5 | No tiering in block | ✓ | Zero hits. |
| G6 | Runner planned/fixed nothing itself | ✓ | Output is a compiled `/plan-it` prompt. |
| M1 | Route build-it, or plan-it with rationale | ✓ | Routes `/plan-it` (l.2) with the required rationale in 🎯: `three surfaces plus a rejected point-fix approach make this a mechanism decision with unresolved scope (which i18n layer, what infra exists), which is plan-it's discovery job, not a build-it patch run.` — the oracle's sanctioned alternate, same route the 0.2.1 precedent certified. |
| M2 | MUST: class-over-instance framing | ✓ | Grounding: `The point-fix approach is rejected; what's missing is a single localization mechanism, so this is a mechanism decision, not three patches.` /goal: `through one central localization layer, so the next locale bug is fixed in one place instead of per component.` |
| M3 | MUST: all 3 instances covered as acceptance cases (Pareto) | ✓ | `Findings to resolve (all instances of the same class; no per-component fixes)` enumerates all three verbatim (l.13–16); DoD 1–3 map one acceptance case per surface (header, tasks-table dates, billing currency); DoD 4 binds them to one mechanism. |
| M4 | MUST: failed-attempts section with ternary approach + why rejected | ✓ | Literally labeled: `Failed attempt — do not re-propose: inline ternaries on tenant.language per call site (reverted for unmaintainability).` (l.28–29) — attempt + rejection reason + do-not-re-propose, plus the Grounding restates the revert. |
| M5 | MUST: two-locale verification target | ✓ | DoD 1: `the admin header for a pt tenant and an en tenant proves it.` ⚠ borderline: the explicit pt+en pair is attached to DoD 1 (header) only; DoD 2–3 say `tenant-locale format` / `follows tenant locale` without re-naming both tenants. The two-locale target is present and the natural reading verifies the same pt+en tenant pair across the surfaces (DoD 4 forces one mechanism), so the property holds — but the 0.2.1 output pinned all three surfaces to both locales in one clause, which is the stronger shape; future revisions should not weaken this further. |
| MN1 | MUST-NOT: three independent point-fix tasks | ✓ (absent) | One mechanism + migration; DoD 4 enforces: `All three flow through the same mechanism — component source contains no inline per-component locale conditionals.` |
| MN2 | MUST-NOT: re-proposing inline ternaries | ✓ (absent) | Explicitly fenced as the failed attempt (quoted at M4); candidate mechanisms offered are i18n library + native `Intl` formatting instead. |
| — | Mode 2: acknowledge nothing falsely | ✓ | All input rows were FAIL; no PASS/credit language appears — the Grounding states the revert as history, claims no win. |
| — | Cross-tree markers | ✓ | `(unverified — confirm during discovery)` on i18n infra; `(assumed: tenant.language, per the prior reverted fix — flag if wrong)` on the locale field; `path unvalidated from here` on the `▶` line — sanctioned. |

**Verdict: PASS.** Class-over-instance mechanism plan with all three findings as acceptance cases, labeled failed-attempts fence, plan-it route with rationale (oracle-sanctioned alternate). Two ⚠ borderline notes recorded (two-locale target explicit only on DoD 1; directive count at-ceiling under grouped-clause counting). Minor observation, non-blocking: candidate list names `react-intl-class` — likely a typo for `react-intl`; it is a discovery candidate, not a directive, so no G4 impact.

---

## Summary — judgment D (v0.3.0-final, S16–S20)

| Sample | Verdict | Driver |
|---|---|---|
| S16 | PASS | Symptom carried verbatim, no-deletion/no-suppression fence, suite-green DS with dropdown-exercised target; zero waits-as-fix; clean `▶` fresh-session line with explicit reason. |
| S17 | PASS | Move-only lock + absolute no-delete/no-overwrite + skip-and-report stop behavior + run-and-show report; `▶` line carries the `cd ~/Downloads && claude` setup; stop slot passes on the standing substitution ruling (⚠ thinner than exemplar — do not thin further; dry-run step from 0.2.1 was dropped). |
| S18 | **FAIL** | Block itself compliant — 154 words measured twice fence-exclusive, explicit JSONL schema, `unparseable:` uncertainty marker, no CoT, one tight example — but the 💡 line narrates the cap (`Kept under the 200-word reasoning-model cap`), which the binding S18 ruling defines as a violation in its own right (stating the count or the cap = FAIL). SKILL-DEFECT: meta-narration leak in the delivery notes. |
| S19 | PASS | Tiering note fully stripped (mechanical zero-hit scan of block) + explicit 💡 disclosure with the build-it-owns-delegation rationale; routes renamed `build-it` target; all S02 MUSTs hold (⚠ `▶` reason implicit-by-setup). |
| S20 | PASS | One localization-mechanism plan with the 3 findings as acceptance cases, labeled `Failed attempt — do not re-propose` ternary fence, pt+en verification target, plan-it route with rationale (⚠ two-locale pair explicit on DoD 1 only; directives at-ceiling). |

**4/5 PASS.** One FAIL: S18, on the cap-narration standing ruling — a delivery-notes defect, not a block defect. Fix shape for the next run: strip any mention of the word budget/count from 🎯/💡 while keeping the no-CoT rationale; the block needs no changes.
