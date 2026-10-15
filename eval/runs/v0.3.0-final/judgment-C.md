# Judgment C — v0.3.0-final (S11, S12, S13, S14, S15)

Judge: certification eval judge for prompt-it v0.3.0 candidate.
Oracle: `eval/expected-prompts.md` (G1–G7 globals, v3 with the new `▶` delivery line + G7 delivery-signal/dangling-evidence rule, + per-sample MUST/MUST-NOT).
Inputs: `eval/runs/.samples/S11.txt … S15.txt` (= `eval/sample-prompts.md` S11–S15).
Outputs: `eval/runs/v0.3.0-final/S11.md … S15.md`.
Precedent honored: `eval/runs/v0.2.1-final/judgment-C.md` (0.2.1 certified 20/20 on these
same samples). Standing rulings applied: fence-opens-the-response is the G1 shape check;
≤3 appended refinement questions after the output contract are accepted; every question
must carry ≥2 concrete candidate options; inline `(assumed: … — flag if wrong)` markers
are the sanctioned unresolved-point handling; `(unvalidated — target session must
confirm)` markers are sanctioned cross-tree behavior for these headless runs; S11 is
judged under the strict minimal-tighten rule (F1: every block line traces to user text);
S13 under question discipline (F3); S14 under routing + earned facts (F4).

New in 0.3.0, judged strictly: G1's shape is now fence → 🎯 → 💡 → exactly one `▶`
delivery line (replacing the ≤2-setup-lines slot); G7 requires the delivery call to
match session signals (headless pure-text samples ⇒ **fresh session** expected; a
"run here" call needs a genuinely stated reason) and forbids dangling in-session
evidence references inside the block on a fresh-session call. Interpretation anchor:
the shipped skill's own delivery contract (`plugins/prompt-it/skills/prompt-it/SKILL.md:130,142–143,146`)
— its canonical fresh-session exemplar line is `▶ Paste into a fresh session. Run from
/Users/macbook/Workspace/Engine/Engine-Core.` (call + setup, no reason clause), which
bounds how hard the "one reason" wording can be enforced on fresh-session calls.
Rename note honored: routing target `fable-it` was renamed `build-it` (v3.1.0); the
oracle now says `build-it` and `build-it` outputs satisfy it.

Method: properties judged, never byte-equality. Every factual disk claim in every
output was independently verified with `ls`/`sed`/`grep`/`find` against the prompt-it
repo and (for S14) `/Users/macbook/Workspace/ANM/Beacon` before being accepted.

---

## S11 — clarity gate: minimal tighten (already well-formed) → **PASS**

Input: `plan-it. /goal add a CONTRIBUTING.md to this repo covering how to add a new target profile to references/targets.md. DoD: 1. file exists with profile-addition steps 2. linked from README. Out of scope: no CI changes.`

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | G1 shape: fence opens → 🎯 → 💡 → exactly one `▶` line | ✓ | File line 1 is the bare fence; `🎯 Target: plan-it — your route, kept as named.`; 💡 follows; exactly one delivery line, literally prefixed: `▶ Run here — the repo tree this prompt points at is the current working directory, and no in-session evidence is needed elsewhere.` No un-prefixed setup line exists. |
| 2 | G7(a): delivery call matches signals | ✓ ⚠ borderline | The call is **Run here** where the oracle's expected call for these headless pure-text samples is fresh-session, and the signal table (SKILL.md:138) sends "pure text ask; every pointer is a file path" to fresh. However G7's own escape hatch is "a run-here call needs a genuinely stated reason or it FAILS" — and a reason IS genuinely stated and factually TRUE: the prompt targets this very repo (`this repo` in the user's text = prompt-it = the cwd), so running in place costs nothing and the guard's failure mode (dangling evidence at the target) cannot occur when there is no session boundary. Reason present, stated, true ⇒ not the FAIL shape. Marked borderline because cwd-match is not one of the signal table's listed run-here signals (images / live state); a fresh-session call would have been the cleaner match. |
| 3 | G7(b): dangling evidence | ✓ | Guard applies to fresh-session calls only; this is run-here. Block contains no evidence references at all regardless. |
| 4 | MUST: route stays plan-it (user-locked) | ✓ | Block opens `/plan-it`; 🎯 `plan-it — your route, kept as named.` The 💡 aside ("build-it would take it directly … your plan-it route is kept regardless") lives outside the block and does not re-route. |
| 5 | MUST: user's structure preserved — **F1 strict: every block line traces to a line the user wrote; any added `Grounding:`/`Context:` section or extra restriction = FAIL** | ✓ | Block contains ONLY the user's own labels: `/plan-it`, `/goal …`, `DoD:` items 1–2, `Out of scope: no CI changes.` (verbatim). No `Grounding:`/`Context:` section, no added restriction, anywhere. Line-by-line trace: `/goal` = user's goal with the dead pointer fixed in place (`references/targets.md` → `plugins/prompt-it/skills/prompt-it/references/targets.md`, the sanctioned in-place fix from the 0.2.1 PASS); DoD 1 = user's "file exists with profile-addition steps" + the light locator "at the repo root" (within the oracle exemplar's "light tightening" allowance); DoD 2 = "linked from README" → "README.md". The 0.2.0 defect shape (added Grounding/Context block) is absent. |
| 6 | F1 × ▶ interaction (per certification brief) | ✓ | The `▶` line sits OUTSIDE the fence (after 💡, line 14 of the file); no delivery/setup content leaked inside the block. Correct per the ruling that a `▶` line on S11 is not an F1 violation. |
| 7 | MUST: changes ≤ light tighten; claims accurate | ✓ | Verified on disk: `ls references/targets.md` → "No such file or directory"; `plugins/prompt-it/skills/prompt-it/references/targets.md` resolves; `README.md` exists; `CONTRIBUTING.md` does not exist (so G6 also holds — the runner did not write it). 💡's "validated; README.md confirmed too" is TRUE. |
| 8 | MUST-NOT: restructure into full template | ✓ (not violated) | No GROUNDING/CP/SCOPE-FENCES scaffold — only the user's three clauses. |
| 9 | MUST-NOT: added scope | ✓ (not violated) | `Out of scope: no CI changes.` carried verbatim; no extra fences or invented verification prose appended. |
| 10 | MUST-NOT: questions | ✓ (not violated) | Zero questions anywhere in the output. |
| 11 | G2–G6 | ✓ | ~4 directives ≤10; no secrets; intent preserved exactly; no tiering; runner produced a prompt, not the CONTRIBUTING.md. |

**Verdict: PASS.** Genuine minimal tighten with zero new sections; verified in-place dead-pointer fix disclosed in 💡; `▶` line present, outside the block, with a stated true reason. ⚠ borderline on G7's run-here call (reason genuine but not a signal-table signal); accepted via G7's own reasoned-run-here escape hatch.

---

## S12 — dead pointer: caught, not propagated → **PASS**

Input: `Update @docs/architecture/overview.md in this repo to document the new eval suite under eval/.`

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | Path really doesn't exist (verified) | ✓ | `ls docs/architecture` → "No such file or directory"; `docs/` holds only `analysis-example`, `research-SYNTHESIS.md`, `v0.2.1-eval-fixes-KICKOFF.md`, `v0.3.0-delivery-signal-KICKOFF.md` — matching 💡's "no docs/architecture/ at all — docs/ holds only kickoff/research notes". |
| 2 | MUST: nonexistent path NOT emitted as a live @-ref inside the block | ✓ | The path appears only as plain text: `Create docs/architecture/overview.md documenting…` — never as `@docs/…`. Zero @-refs anywhere in the block. |
| 3 | MUST: explicit disclosure of the dead pointer | ✓ | Inline in the block: `(assumed: create — docs/architecture/ does not exist in this repo yet; flag if you meant updating an existing doc instead.)`; and in 💡: `Fixed a dead pointer: docs/architecture/overview.md doesn't exist … so "update" was recompiled as "create", flagged inline`. |
| 4 | MUST: intent preserved — documenting the eval suite still happens | ✓ | Update reframed as a disclosed create; Done-when 1–3 require the doc to exist, cover all five eval/ areas, and carry the real run command; the appended refinement additionally offers the fold-into-existing-doc alternative (the exemplar's sanctioned shape). |
| 5 | MUST-NOT: silently inventing a different path as if the user named it | ✓ (not violated) | The user's own path is kept as a disclosed create. All substitute grounding pointers verified real on disk: `eval/sample-prompts.md`, `eval/expected-prompts.md`, `eval/fixtures/notes.md`, `eval/scripts/run-eval.sh` all exist; `eval/runs/` holds `v0.1.0 … v0.3.0-final` (the block's "v0.1.0 through v0.3.0-final" range is accurate); the question's candidate `docs/research-SYNTHESIS.md` exists. |
| 6 | G1 shape + question precedent | ✓ | Fence is file line 1 → 🎯 → 💡 → exactly one `▶` line → 1 appended refinement question (≤3) carrying 2 concrete candidates: `README.md or docs/research-SYNTHESIS.md`. Closed-choice, lookup-could-not-answer (user intent), per the F3 discipline. |
| 7 | G7(a): delivery call matches signals | ✓ ⚠ borderline | `▶ Paste into a fresh session. Run from /Users/macbook/Workspace/Devotts/prompt-it.` — **fresh session, the oracle's expected call for these samples**; setup rides on the same line. No explicit reason clause — a deviation from the oracle's "with one reason" wording, but this line is shape-identical to the shipped skill's own canonical fresh-session exemplar (SKILL.md:143, `▶ Paste into a fresh session. Run from …` — no reason), and the oracle's enumerated G1-FAIL shapes (setup line without ▶ prefix; no delivery statement) are both absent. G7 makes the reason load-bearing only for the against-expectation run-here call. PASS with the omission noted. |
| 8 | G7(b): dangling evidence on a fresh call | ✓ | Nothing in the block points at in-session evidence; every pointer is a persisted file path (all verified above). |
| 9 | G2–G6 | ✓ | ≈9 directives (create + 5 grounding reads + purpose-unclear rule + Done-when + out-of-scope; precedent accounting) ≤10; no secrets; no scope drop; no tiering; G6 holds — `docs/architecture/` still absent, the runner did not write the doc. |

**Verdict: PASS.** Dead pointer caught (verified nonexistent), disclosed inline and in 💡, never emitted as a live @-ref; intent preserved as a grounded create with every grounding pointer verified real; fresh-session call correct. ⚠ noted: the `▶` line omits an explicit reason clause (matches the skill's own canonical exemplar, so not failed).

---

## S13 — legitimate ambiguity → **PASS**

Input: `There's a bug in auth — sessions die way too early. Fix the auth bug in our Engine workspace.`

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | MUST: one of the two sanctioned behaviors | ✓ | Behavior (b): a full emitted prompt (`/build-it` → /goal → Grounding → Context → DoD sketch → fence) whose assumptions are flagged inline, plus 1 appended refinement question — the combination the 0.2.1 precedent accepted. |
| 2 | MUST: assumption explicit in the prompt block | ✓ | Two inline markers inside the fence: `(assumed: the defect is in session-lifetime config or the token/refresh flow, not in credential validation — flag if wrong)` and `Repo: the Engine workspace (unvalidated — this compile ran sandboxed to another repo; target session must confirm the repo root first)` — the sanctioned cross-tree marker. |
| 3 | MUST: any question has concrete options (F3: lookup-first, options-or-assumption; open-ended = FAIL) | ✓ | Exactly 1 appended question, closed with two named candidates: `Do sessions die *mid-activity* (points at an idle-timeout/TTL misconfig) or *at token refresh time* (points at a failing refresh flow)?` — precisely the oracle's own TTL-vs-idle-timeout disambiguation. It is also correctly lookup-first: this is a behavioral fact only the user can supply; no repo lookup could answer it (and the Engine tree is unreachable from this sandbox — the path point is handled as the flagged assumption, not burned as a question, an improvement over shapes the 0.2.0 precedent failed). |
| 4 | MUST-NOT: >3 questions | ✓ (not violated) | 1 ≤ 3. |
| 5 | MUST-NOT: silently picking a repo/module with no flag | ✓ (not violated) | No path is guessed at all (cleaner than 0.2.1's off-target `Devotts/…` guess): the repo pointer is carried as explicitly unvalidated with a hard gate ("target session must confirm the repo root first"), reinforced by 💡 ("sandbox-locked to the prompt-it repo"). |
| 6 | Route (oracle exemplar: iterate; not a MUST for S13) | ✓ note | Block opens `/build-it` with a stated rationale (🎯: "a deliverable bug fix with derivable done-ness … autonomous fix-and-verify run"). The S13 checklist binds behaviors and question shape, not route; the exemplar is a quality anchor, not byte-equality. Intent ("fix the auth bug") is fully served by build-it; DoD 1–3 give real verification targets (root cause at file:line; session survives past the prior death window on the live app; auth suite + regression test green). Noted as a divergence from the exemplar's iterate, not scored. |
| 7 | G1 shape | ✓ | Fence is file line 1 → 🎯 → 💡 → exactly one `▶` line → 1 appended question. No un-prefixed setup line (setup rides on the ▶ line: "Run from the Engine repo root"). |
| 8 | G7(a): delivery call | ✓ | `▶ Paste into a fresh session. Run from the Engine repo root — clean context wins and nothing here depends on this session's state.` — fresh session (the expected call), WITH a stated reason, setup on the same line. Fully conformant, and the call is forced anyway (the target repo is not this repo). |
| 9 | G7(b): dangling evidence on a fresh call | ✓ | Nothing in the block points at in-session evidence; the only session reference is the sanctioned `(unvalidated — this compile ran sandboxed…)` provenance marker, which demands nothing from this session at the target. Symptom is described in words ("sessions die way too early", behavioral-only), not pointed at. |
| 10 | G2–G6 | ✓ | ≈8 directives ≤10; no secrets; intent carried whole (auth bug, premature session death, Engine workspace); fence blocks scope drift (no SSO/roles/refactor); no tiering; runner touched no auth code. |

**Verdict: PASS.** Behavior (b) with two inline flagged assumptions; single appended question with two concrete candidates matching the oracle's own disambiguation; no silent path pick; fresh-session delivery with reason. Route build-it (vs exemplar iterate) noted, not scored — no MUST binds it.

---

## S14 — route: plan-it (routing + earned facts, F4) → **PASS**

Input: multi-surface Beacon feedback extension; user names `/Users/macbook/Workspace/ANM/Beacon`, no route.

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | **MUST: route plan-it (F4: multi-surface "extend X to all Y" ⇒ plan-it)** | ✓ | Block opens `/plan-it`; 🎯: `plan-it — an "extend to every page" cluster spanning multiple surfaces is unresolved scope; which pages already have which pieces is plan-it's discovery job.` |
| 2 | MUST: Beacon path carried (it exists — validation succeeds) | ✓ | `Context (repo root: /Users/macbook/Workspace/ANM/Beacon — the app code lives in the nested beacon/ directory)` — the user's literal absolute path anchors the block; verified: the repo exists and app code is in nested `beacon/`. |
| 3 | MUST: all 3 sub-features present at intent level (Pareto) | ✓ | /goal names all three (`thumbs on each response, a review modal after each generation, and a "what went wrong" form on thumbs-down`); DoD 2 = thumbs on every surface, DoD 3 = modal after each generation/regeneration, DoD 4 = thumbs-down form + submission landing in the store. Nothing dropped. |
| 4 | MUST: fences | ✓ | `Out of scope / do not touch: non-LLM pages (dashboards, admin, list views); redesigning the existing widget/modal/form UX or the feedback backend schema beyond what universal coverage requires.` |
| 5 | MUST-NOT: tiering | ✓ (not violated) | None present anywhere. |
| 6 | MUST-NOT: implementation-level file-edits list pretending to be a spec | ✓ (not violated) | The CP is grounding (existing components as the pattern to extend; where they're already wired; prior-run decision files to honor); DoD 1 explicitly makes the surface inventory plan-it's discovery output; the block twice defers the unresolved part ("Which surfaces are still uncovered is unresolved — resolving that inventory is the discovery job"; "discovery must map which of the three pieces each LLM surface still lacks"). Planning context, not an edit list. |
| 7 | **F4 earned facts: every existence claim carries a verified lookup; unverified claims must be marked** | ✓ | All in-block existence claims independently re-verified TRUE (ledger below); the genuinely unknown parts are explicitly marked unresolved-for-discovery, and the one design assumption is the sanctioned inline marker: `(assumed: reuse the existing feedback endpoint/schema — flag if wrong)`. No unearned absence claims. |
| 8 | G1 shape | ✓ | Fence is file line 1 → 🎯 → 💡 → exactly one `▶` line. No questions, no un-prefixed setup line. |
| 9 | G7(a): delivery call | ✓ ⚠ borderline | `▶ Paste into a fresh session. Run from /Users/macbook/Workspace/ANM/Beacon/beacon.` — fresh session, the expected call, and materially forced (the target repo is not this cwd — the setup clause itself carries that reason implicitly). No explicit reason clause; same disposition as S12 row 7 (shape-identical to the skill's own canonical fresh exemplar; the oracle's enumerated G1-FAIL shapes are absent). Noted. Minor non-scoring wart: ▶ says run from the nested `beacon/` while the `.taskstate` pointers are disclosed as "at the outer repo root" — internally disclosed, resolvable, not misleading. |
| 10 | G7(b): dangling evidence on a fresh call | ✓ | Every pointer in the block is a persisted path in the target tree (components, pages:line, `.taskstate/*.md`); the validation provenance ("Validated the pointers…") lives in 💡, outside the block. Nothing points at in-session evidence. |
| 11 | G2–G6 | ✓ | ≈7 directives (goal + 4 DoD + fence + honor-decisions) ≤10; no secrets; intent preserved and truthfully reframed (💡 discloses the reframe: most components already exist, so the work is coverage-gap discovery — a grounded sharpening, not scope change); no tiering; runner produced a prompt, not the feature. |

### Fact-check ledger (every factual claim vs `/Users/macbook/Workspace/ANM/Beacon`)

| # | Claim in output | Verification | Result |
|---|---|---|---|
| 1 | App code lives in nested `beacon/` under the repo root | `ls /Users/macbook/Workspace/ANM/Beacon` → `beacon/` present | TRUE |
| 2 | `FeedbackWidget.tsx`, `RegenerateFeedbackModal.tsx`, `FeedbackReasonForm.tsx` exist under `beacon/frontend/src/components/` | `ls` — all three resolve exactly | TRUE |
| 3 | Modal "wired in SowEditor.tsx:1164" | `sed -n '1164p' …/pages/SowEditor.tsx` → `<RegenerateFeedbackModal` — exact line | TRUE |
| 4 | "Already wired: Intel.tsx:476, DesignChat.tsx:1441 + 2095" | `sed -n '476p' Intel.tsx` → `<FeedbackWidget`; `sed -n '1441p;2095p' DesignChat.tsx` → `<FeedbackWidget` both — all three cites exact | TRUE |
| 5 | `.taskstate/sow-fb-ux-decisions.md` and `.taskstate/feedback-obs-decisions.md` exist at the outer repo root | `ls /Users/macbook/Workspace/ANM/Beacon/.taskstate/` → both present | TRUE |
| 6 | 💡: components "built and live on Intel, DesignChat, and SowEditor"; "app code is in the nested beacon/ directory, not the repo root you gave" | Per #1–#4 above | TRUE |

6/6 claims TRUE, including every file:line cite re-verified to the exact line — the F4 earned-facts bar met with zero materially false claims.

**Verdict: PASS.** Route plan-it with rationale; user's absolute path anchors the block; all three sub-features present; fences in place; every existence claim verified true on disk to the exact line; the genuinely unknown inventory correctly deferred to discovery. ⚠ noted: ▶ omits an explicit reason clause (fresh call, per-exemplar shape).

---

## S15 — route: build-it → **PASS**

Input: version-check script across marketplace.json, plugin.json, SKILL.md, CHANGELOG.md; `prove it catches a mismatch. Run it to done.`

| # | Check | Status | Evidence |
|---|---|---|---|
| 1 | MUST: route build-it (oracle updated post-rename; `build-it` satisfies it) | ✓ | Block opens `/build-it`; 🎯: `build-it — deliverable with stated done-ness ("prove it catches a mismatch, run it to done") for an unattended run.` No rename-lag — the output already uses the new name. |
| 2 | **MUST: DoD includes the negative test (prove it catches a seeded mismatch)** | ✓ | DoD 4: `Mismatch proof: with one file temporarily edited to a different version, the script exits non-zero — then the edit is reverted and git status shows only the new script as the change.` DoD 3 additionally requires the failure output to name each file + version found. Restore-clean discipline explicit. |
| 3 | MUST: SF present | ✓ | `Out of scope / do not touch: no version bumps; no CI/hook wiring; no edits to the branch's existing uncommitted changes (eval/, docs/, README) — the working tree has in-flight v0.3.0 work, leave it exactly as found.` (The uncommitted-work fence is TRUE — the tree does carry in-flight v0.3.0 eval/docs changes — and protects the user's intent; a legitimate compile-added fence, S15 not being a minimal-tighten case.) |
| 4 | MUST-NOT: tiering/persistence content | ✓ (not violated) | No tiering/teams/model language and no persistence/autonomy clauses inside the block; the unattended framing lives only in 🎯/▶, outside the block. |
| 5 | Pointer/fact accuracy | ✓ | All verified on disk: `.claude-plugin/marketplace.json` line 13 → `"version": "0.3.0"`; `plugins/prompt-it/.claude-plugin/plugin.json` line 4 → `"version": "0.3.0"`; both `SKILL.md` files (root + plugin — `find` returns exactly two) line 17 → `version: 0.3.0`; `CHANGELOG.md` line 6 → `## 0.3.0 — 2026-07-28` (verbatim); `ls scripts` → "No such file or directory" ("scripts/ does not exist yet — create it" correct); "all five currently agree on 0.3.0" correct. Every line-number cite exact. |
| 6 | Two-SKILL.md expansion handled as flagged assumption, not silent scope add | ✓ | `(assumed: both SKILL.md copies in scope, not just root — flag if wrong)` — the sanctioned inline marker; the CHANGELOG comparison is also correctly pinned to the newest entry only ("older entries are history"), closing a real ambiguity in the user's 4-file list. |
| 7 | G1 shape | ✓ | Fence is file line 1 → 🎯 → 💡 → exactly one `▶` line. No questions, no un-prefixed setup line. |
| 8 | G7(a): delivery call | ✓ | `▶ Paste into a fresh session — pure text ask, every pointer is a file path, and you're leaving it to run unattended. Run from /Users/macbook/Workspace/Devotts/prompt-it.` — fresh session (expected call) with an explicit reason that is verbatim the signal table's own row ("pure text ask; every pointer is a file path") plus the unattended tiebreak; setup on the same line. Fully conformant — the strongest ▶ line of the five. |
| 9 | G7(b): dangling evidence on a fresh call | ✓ | Nothing in the block points at in-session evidence: the evidence's actual TEXT is pasted in (file paths, exact line numbers, exact version strings, the verbatim CHANGELOG heading) — the compliant shape. ⚠ borderline note: the header phrase `Grounding (validated this session — …)` mentions the compile session; judged compliant because it is a provenance assertion in the sanctioned validated/unvalidated-marker family, not a pointer requiring anything from this session — all data it vouches for is inline in the block. |
| 10 | G2–G6 | ✓ | ≈7 directives (goal + 4 DoD + grounding + fence) ≤10; no secrets; intent fully carried ("wire it as scripts/check-version.sh" → DoD 1; "prove it catches a mismatch" → DoD 4; "Run it to done" → build-it route); no tiering; G6 holds — `scripts/` still absent, the runner did not create the script. |

**Verdict: PASS.** build-it route (new name, no rename lag); seeded-mismatch negative test with restore-clean; fences present and truthful; all five version-string facts (both line-number cites, two-SKILL.md detail, verbatim CHANGELOG heading, absent scripts/) exactly correct on disk; exemplary ▶ line.

---

## Summary — judgment-C (v0.3.0-final, S11–S15)

| Sample | Verdict | Driver |
|---|---|---|
| S11 | PASS ⚠ | Strict F1 minimal tighten holds (zero new sections; every block line traces to user text; ▶ correctly outside the block); dead pointer fixed in place and verified. Borderline: G7 run-here call against the expected fresh, accepted via the reasoned-run-here escape hatch (reason stated, genuine, true — target repo IS the cwd). |
| S12 | PASS | Dead `docs/architecture/overview.md` caught (verified nonexistent), disclosed inline + 💡, never a live @-ref; intent preserved as a grounded create with all five grounding pointers verified real; fresh call correct; one closed-choice question with 2 candidates. ▶ reason clause omitted (matches skill's own canonical fresh exemplar — noted, not failed). |
| S13 | PASS | Behavior (b): full prompt with 2 inline flagged assumptions incl. the sanctioned unvalidated-repo marker (no path guessed); 1 appended question with 2 concrete candidates = the oracle's own TTL-vs-refresh disambiguation; fresh call with reason. Route build-it vs exemplar iterate noted — no MUST binds route on S13. |
| S14 | PASS | Route plan-it (F4); user's absolute Beacon path anchors the block; all 3 sub-features present; 6/6 factual claims verified TRUE to the exact file:line (earned-facts bar met); unknowns correctly deferred to discovery. ▶ reason clause omitted (noted, not failed). |
| S15 | PASS | build-it (post-rename name); DoD 4 is the required seeded-mismatch negative test with restore-clean; SF truthful; every version-file fact exactly correct; ▶ line fully conformant with explicit signal-table reason. |

**5/5 PASS.** No SKILL-DEFECT / ORACLE-DEFECT / HARNESS-ARTIFACT diagnoses required.

Cross-cutting observation (non-scoring, for the release notes): the `▶` reason clause is
inconsistently emitted on fresh-session calls (present on S13/S15, absent on S12/S14).
The shipped skill's own canonical fresh exemplar (SKILL.md:143) omits it, so this is
skill-conformant and was not failed — but if the oracle's "with one reason" wording is
meant to bind on fresh calls too, either the skill's exemplar at line 143 should gain a
reason clause or the oracle should relax to "reason required on run-here". Tightening
either side would make this row mechanically judgeable next cycle.
