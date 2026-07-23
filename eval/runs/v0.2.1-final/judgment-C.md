# Judgment C — v0.2.1-final (S11, S12, S13, S14, S15)

Judge: certification eval judge for prompt-it v0.2.1 candidate.
Oracle: `eval/expected-prompts.md` (G1–G6 globals + per-sample MUST/MUST-NOT).
Inputs: `eval/sample-prompts.md`. Outputs: `eval/runs/v0.2.1-final/S11.md … S15.md`.
Precedent applied: `eval/runs/v0.2.0-final/judgment-retry-final.md` (binding FAIL
analyses for S11/S13/S14), `judgment-final-3.md` (S11–S15), and the v0.2.1 phase
judgments (`v0.2.1-phase1b/judgment-phase1.md`, `v0.2.1-phase2/judgment-phase2.md`).
Standing precedents honored: fence-opens-the-response is the G1 shape check; ≤2 setup
lines and ≤3 appended refinement questions AFTER the output contract are accepted;
questions must carry concrete candidate options; inline `(assumed: … — flag if wrong)`
markers are the sanctioned unresolved-point handling; headless cross-tree runs may carry
"(unvalidated — target session must confirm)" markers.

Method: properties judged, never byte-equality. Every factual disk claim in every
output was independently verified with `ls`/`grep`/`find`/`sed` against the prompt-it
repo and (for S14) `/Users/macbook/Workspace/ANM/Beacon` before being accepted.

---

## S11 — clarity gate: minimal tighten (already well-formed) → **PASS**

Input: `plan-it. /goal add a CONTRIBUTING.md to this repo covering how to add a new target profile to references/targets.md. DoD: 1. file exists with profile-addition steps 2. linked from README. Out of scope: no CI changes.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | G1 shape: fence opens response → 🎯 → 💡 (+ ≤2 setup lines) | ✓ | File line 1 is the bare fence; `🎯 Target: plan-it — your named route, kept as locked…` and `💡 Fixed a dead pointer: …` follow; one setup line (`Run from the prompt-it repo root.`) — within allowance. |
| 2 | MUST: route stays plan-it (user-locked) | ✓ | Block opens `/plan-it`; 🎯 keeps it: "your named route, kept as locked" (the parenthetical fable-it/bare aside lives outside the block and does not re-route). |
| 3 | MUST: user's structure preserved — **binding nuance: any new section/label the user did not write (e.g. standalone `Grounding:`/`Context:` block) = FAIL** | ✓ | The block contains ONLY the user's own labels: `/goal`, `DoD:` (items 1–2), `Out of scope:`. No `Grounding:`/`Context:` or any other new slot exists anywhere in the output — the exact defect of both v0.2.0-final S11 FAILs (`Context:` block in final-3, `Grounding:` line in retry-final) is absent. Splitting the user's one-line paragraph into vertical lines re-uses only labels the user wrote — no new section introduced. |
| 4 | MUST: changes ≤ light tighten; in-place defect fix allowed | ✓ | Two changes only: dead pointer `references/targets.md` → `plugins/prompt-it/skills/prompt-it/references/targets.md` fixed IN PLACE inside the user's own `/goal` clause, and `README` → `README.md`. Verified on disk: `ls references/targets.md` → "No such file or directory"; `ls plugins/prompt-it/skills/prompt-it/references/targets.md` → resolves. |
| 5 | 💡 disclosure of the fix, claims accurate | ✓ | `💡 Fixed a dead pointer: … (verified; also confirmed README.md exists and CONTRIBUTING.md doesn't yet)` — checked: `README.md` exists, `CONTRIBUTING.md` does not. |
| 6 | MUST-NOT: restructure into the full template | ✓ (not violated) | No GROUNDING/CONTEXT-PACKAGE/SCOPE-FENCES scaffold; only the user's three clauses. |
| 7 | MUST-NOT: added scope | ✓ (not violated) | `Out of scope: no CI changes.` carried verbatim — no extra restrictions appended (retry-final's added "no edits to targets.md's actual profiles or to SKILL.md" is absent here). DoD items carried without invented verification prose. |
| 8 | MUST-NOT: questions | ✓ (not violated) | Zero questions anywhere. |
| 9 | G2–G6 | ✓ | ~4 directives (≤10); no secrets; intent preserved; no tiering; runner did not create CONTRIBUTING.md. |

**Verdict: PASS.** Genuine minimal tighten: one verified in-place dead-pointer fix, disclosed in 💡, no new sections, no added scope, no questions, route locked.

---

## S12 — dead pointer: caught, not propagated → **PASS**

Input: `Update @docs/architecture/overview.md in this repo to document the new eval suite under eval/.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Path really doesn't exist (verified per instruction) | ✓ | `ls docs/architecture` → "No such file or directory"; `ls docs/` → only `analysis-example`, `research-SYNTHESIS.md`, `v0.2.1-eval-fixes-KICKOFF.md` — exactly matching the 💡 claim. |
| 2 | MUST: nonexistent path NOT emitted as a live @-ref inside the block | ✓ | The path appears only as plain backticked text: `` Create `docs/architecture/overview.md` `` and in the Done-when line — never as `@docs/…`. No `@`-refs anywhere in the block. |
| 3 | MUST: explicit disclosure of the dead pointer | ✓ | Inline in the block: `(assumed: creating the file is intended — `docs/architecture/` does not exist in this repo yet; flag if the doc actually lives elsewhere)`; and in 💡: `Fixed a dead pointer: docs/architecture/overview.md (and the whole docs/architecture/ dir) doesn't exist…`. |
| 4 | MUST: intent preserved — documenting the eval suite still happens | ✓ | Update reframed as create (disclosed), full grounding + Done-when (`covers all four eval/ areas … every path it cites resolves on disk`); refinement Q1 additionally offers the exemplar's README-fold alternative. |
| 5 | MUST-NOT: silently inventing a different path as if the user named it | ✓ (not violated) | The user's own path is kept (as a disclosed create); the substitute grounding pointers are presented as the runner's inventory, and all verified real: `eval/scripts/run-eval.sh` (exists), `eval/sample-prompts.md` + `eval/expected-prompts.md` (exist), `eval/fixtures/` (exists, holds `notes.md`), `eval/runs/` with `v0.2.1-final/` present (and it is the most recent run dir). |
| 6 | G1 shape + appended questions precedent | ✓ | Fence opens the file → 🎯 → 💡 → 2 "Optional refinements" questions, both with concrete options: Q1 `new docs/architecture/overview.md, or folded into the existing README.md / docs/v0.2.1-eval-fixes-KICKOFF.md?`; Q2 `explain how eval/runs/v0.2.1-final/ maps to the recent … eval-fix commits, or stay a pure structural overview?` — both closed-choice, ≤3 total. |
| 7 | G2–G6 | ✓ | ~8 directives (create, 4 grounding reads, purpose-unclear rule, Done-when, out-of-scope) ≤10; no secrets; no scope drop; no tiering; the runner did not write the doc (G6) — `docs/architecture/` still absent. |

**Verdict: PASS.** Dead pointer caught, disclosed inline and in 💡, never emitted as a live @-ref, intent preserved as a grounded create, nothing silently invented.

---

## S13 — legitimate ambiguity → **PASS**

Input: `There's a bug in auth — sessions die way too early. Fix the auth bug in our Engine workspace.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | MUST: one of the two sanctioned behaviors | ✓ | Behavior (b) executed: a full emitted prompt (`/iterate` → symptom/context → `/goal` → DoD sketch → fence) with TWO inline flagged assumptions, plus 2 appended refinement questions — the combination final-3 already accepted as valid when question format holds. |
| 2 | MUST: assumptions explicit in the prompt block | ✓ | `(assumed: repo lives at ~/Workspace/Devotts/… under the name "Engine" — confirm the exact path before starting; this prompt was compiled outside that tree and could not validate it.)` and `(assumed: "sessions" means end-user auth sessions, not DB/worker sessions — flag if wrong.)` — both inside the fence. |
| 3 | **Binding nuance: any open-ended question = FAIL; each question needs concrete candidate options** | ✓ | Exactly 2 appended questions, both closed with named candidates: Q1 `Do sessions die mid-activity (idle timeout too aggressive) or at a fixed early moment regardless of activity (absolute TTL/refresh misconfigured)?` — two concrete candidates, and precisely the oracle's own "TTL vs idle timeout" disambiguation. Q2 `Is there a target lifetime to hit (e.g. "stay logged in 24h" vs "until browser closes")?` — closed yes/no with two named candidate targets ("24h" **vs** "until browser closes"). Distinct from retry-final's failed shapes: no fill-in-the-blank ("what's the gap…?") and no bare path-request question at all. |
| 4 | MUST-NOT: >3 questions | ✓ (not violated) | 2 ≤ 3. |
| 5 | MUST-NOT: silently picking a repo/module with no flag | ✓ (not violated) | The path is NOT silently picked — it is carried as an explicit assumption with a hard gate: "confirm the exact path before starting; this prompt was compiled outside that tree and could not validate it", reinforced by 💡 ("sandbox is locked to the prompt-it repo… carried as an explicitly unvalidated assumption the target session must confirm first"). This is the sanctioned cross-tree "(unvalidated — target session must confirm)" behavior for the headless run. |
| 6 | Route (oracle exemplar: iterate) | ✓ | `/iterate` opens the block; 🎯: "a single known-bug fix-test-verify loop". |
| 7 | G1 shape | ✓ | Fence is file line 1 → 🎯 → 💡 → one setup line (`Run this from the Engine repo root, not from prompt-it.`) → 2 appended questions. Within all allowances. |
| 8 | G2–G6 | ✓ | ~8 directives ≤10; no secrets; intent carried whole (auth bug, premature session death, Engine workspace); no tiering; runner touched no auth code. DoD names real verification targets (root cause as file:line; session survives past prior death window against the running app; auth suite green) and the fence blocks fix-becomes-migration drift with a stop-and-report escape. |

**Note (non-scoring):** the assumed location guess is factually off — `ls ~/Workspace/` shows the workspace at `/Users/macbook/Workspace/Engine`, not under `Devotts/` — but the claim is explicitly marked `(assumed: … confirm the exact path before starting … could not validate it)`, which per the standing precedent and the assumed-claims exemption is the sanctioned handling, not a violation. A neutral flag without the `Devotts/…` guess (as in the phase-2 PASS) would have been cleaner.

**Verdict: PASS.** Option (b) with inline flags, plus 2 appended questions that both carry concrete candidate options; no MUST-NOT triggered.

---

## S14 — route: plan-it → **PASS**

Input: multi-surface Beacon feedback extension; user names `/Users/macbook/Workspace/ANM/Beacon`, no route.

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | **MUST: route plan-it (the prior cycle's FAIL driver)** | ✓ | Block opens `/plan-it`; 🎯: `plan-it — "extend X to every page" across ≥3 surfaces is unresolved scope; discovery must map what's already covered before anything is built.` |
| 2 | MUST: user's absolute Beacon path anchors the block | ✓ | `Context (repo: /Users/macbook/Workspace/ANM/Beacon — app code lives in the nested `beacon/` directory)` — the user's literal absolute path is the stated anchor; every CP path resolves against it (see fact-check #1–#5). Prior-cycle defect (path dropped entirely) fixed. |
| 3 | MUST: all 3 sub-features present at intent level (Pareto) | ✓ | `/goal` names all three (`thumbs on each response, a review modal after each generation, and a "what went wrong" form on thumbs-down`); DoD 2 = thumbs rows, DoD 3 = review modal after each generation/regeneration, DoD 4 = thumbs-down form landing in `llm_feedback` with the reason. Nothing dropped, silently or otherwise. |
| 4 | MUST: fences | ✓ | `Out of scope / do not touch: feedback analytics/reporting dashboards, the SOW editor's existing feedback flow (extend from it, don't redesign it), backend feedback schema changes beyond what the form itself needs.` |
| 5 | MUST-NOT: tiering | ✓ (not violated) | None present. |
| 6 | MUST-NOT: implementation-level file-edits list pretending to be a spec | ✓ (not violated) | CP is 5 grounding pointers (existing widget = "the pattern to extend"; modal/form = "discovery decides reuse vs. new"; the two named pages; two prior-run state files) — planning context, not an edit list; DoD 1 explicitly makes the surface inventory plan-it's discovery job. |
| 7 | Validation-not-discovery cap (prior final-3 defect) | ✓ | Grounding stays at existence/reference level and defers the unresolved part: "Which chat/generation surfaces still lack it is unresolved (confirm during discovery)". No line numbers, no test-contract case counts, no stakeholder-decision synthesis (the final-3 dossier defect is absent). |
| 8 | G1 shape | ✓ | Fence opens file → 🎯 → 💡 → one setup line (`Run plan-it from /Users/macbook/Workspace/ANM/Beacon.`). No questions. |
| 9 | G2–G6 | ✓ | 1 goal + 5 DoD + 1 fence ≈ 7 directives ≤10; no secrets; intent preserved (DoD 5's component-reuse point is an explicit `(assumed … flag if wrong)` marker, the sanctioned form); no tiering; runner produced a prompt, not the feature. |

### Fact-check ledger (mandated: every factual repo claim vs `/Users/macbook/Workspace/ANM/Beacon`)

| # | Claim in output | Verification | Result |
|---|---|---|---|
| 1 | App code lives in nested `beacon/` under the repo root | `ls /Users/macbook/Workspace/ANM/Beacon` → `beacon/` present, containing `frontend/`, `backend/`, `docs/` | TRUE |
| 2 | `FeedbackWidget.tsx`, `RegenerateFeedbackModal.tsx`, `FeedbackReasonForm.tsx` exist under `beacon/frontend/src/components/` | `ls` — all three resolve exactly | TRUE |
| 3 | `Intel.tsx` + `DesignChat.tsx` (in `beacon/frontend/src/pages/`) already reference feedback | `grep -c -i feedback` → Intel.tsx: 3, DesignChat.tsx: 7; both import and mount `FeedbackWidget` (Intel.tsx:19/476; DesignChat.tsx:4/1441) | TRUE |
| 4 | `.taskstate/feedback-obs-grounding.md` exists; "feedback rows land in `llm_feedback` keyed on trace_id; thumbs-down persists dimensions + comment" | File exists at `/Users/macbook/Workspace/ANM/Beacon/.taskstate/` (resolves against the CP's stated root); content: `llm_feedback` table with `trace_id` column (L16–17), case 14 "thumbs → llm_feedback row keyed on trace_id", case 16 "thumbs-down persists dimensions+comment" | TRUE |
| 5 | `.taskstate/sow-fb-ux-decisions.md` exists; "locked UX decisions from the SOW feedback run" | File exists at the same root; header "SOW Feedback UX — Shared Decision Contract", inherited invariants + RD-n run decisions | TRUE |
| 6 | 💡: "partially built already … Intel + DesignChat already reference feedback"; "path trap: app code is one level down, in `Beacon/beacon/`" | Per #1–#3 above | TRUE |

6/6 claims TRUE; zero materially false claims. Unlike the phase-2 output, this CP anchors at the user's own root (`…/ANM/Beacon`), so BOTH the `beacon/frontend/...` paths AND the `.taskstate/...` paths resolve against the single stated anchor — the phase-2 anchor-ambiguity is absent here.

**Verdict: PASS.** Route correct, path anchored, all three sub-features present, fences in place, every factual claim verified true on disk.

---

## S15 — route: fable-it → **PASS**

Input: version-check script across marketplace.json, plugin.json, SKILL.md, CHANGELOG.md; `prove it catches a mismatch. Run it to done.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | MUST: route fable-it | ✓ | Block opens `/fable-it`; 🎯: "deliverable goal with derivable done-ness, explicitly an unattended run-to-done." |
| 2 | **MUST: DoD includes the negative test (prove it catches a seeded mismatch)** | ✓ | DoD 2: `A deliberate version mismatch in any one of the files makes it exit non-zero and name the disagreeing file(s); the repo is restored clean afterward.` DoD 3 additionally requires captured output of both the passing run and the mismatch run. |
| 3 | MUST: SF present | ✓ | `Out of scope / do not touch: no real version bumps (beyond the reverted mismatch test), no CI/hook wiring, no edits to skill or changelog content.` |
| 4 | MUST-NOT: tiering/persistence content | ✓ (not violated) | None present. |
| 5 | Pointer/fact accuracy | ✓ | All verified on disk: `.claude-plugin/marketplace.json` `"version": "0.2.0"` at **exactly line 13**; `plugins/prompt-it/.claude-plugin/plugin.json` `"version": "0.2.0"`; `find` returns **exactly two** SKILL.md files (root + `plugins/prompt-it/skills/prompt-it/`), both `version: 0.2.0` in frontmatter; CHANGELOG first heading `## 0.2.0 — 2026-07-23` (verbatim match); `ls scripts` → "No such file or directory" ("No scripts/ dir exists yet — create it" is correct); "all currently 0.2.0" is correct across all four sources. |
| 6 | Two-SKILL.md expansion handled as flagged assumption, not silent scope add | ✓ | `(assumed: both must match — flag if only one was intended)` — the sanctioned inline marker for a genuinely underspecified point the user's 4-file list didn't anticipate. |
| 7 | G1 shape | ✓ | Fence opens file → 🎯 → 💡. No setup lines, no questions. |
| 8 | G2–G6 | ✓ | 1 goal + 3 DoD + 1 fence ≈ 5 directives ≤10; no secrets; intent fully carried ("prove it catches a mismatch. Run it to done" → DoD 2/3 + fable-it run-to-done); no tiering; the script was not created by the runner (`scripts/` still absent — G6 holds). |

**Verdict: PASS.** Route, negative-test DoD, restore-clean discipline, scope fence, and every version-file claim (including the two-copies detail and the literal line-13 cite) verified exactly correct on disk.

---

## Summary — judgment-C (v0.2.1-final, S11–S15)

| Sample | Verdict | Driver |
|---|---|---|
| S11 | PASS | Minimal tighten with zero new sections/labels (prior FAIL mode absent); dead pointer fixed in place and verified; scope, DoD, route all preserved. |
| S12 | PASS | Dead `docs/architecture/overview.md` caught (verified nonexistent), disclosed inline + 💡, never emitted as a live @-ref; intent preserved as a grounded create; both refinement questions closed-choice. |
| S13 | PASS | Option (b): full prompt with 2 inline `(assumed…)` flags; 2 appended questions, both with concrete candidate options; unvalidated Engine path flagged per the sanctioned cross-tree marker, not silently picked. |
| S14 | PASS | Route corrected to plan-it; user's absolute Beacon path anchors the block; all 3 sub-features present; 6/6 factual repo claims verified TRUE against the Beacon tree. |
| S15 | PASS | fable-it route; DoD 2 is the required seeded-mismatch negative test; SF present; all version-file facts (line 13, two SKILL.md copies, CHANGELOG heading, no scripts/) exactly correct. |

5/5 PASS. No SKILL-DEFECT / ORACLE-DEFECT / HARNESS-ARTIFACT diagnoses required.
