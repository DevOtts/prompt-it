# v0.2.0-final — FINAL CERTIFICATION judgment (S11–S15)

Judge: review-it honesty rules — evidence-quoted rows, closed vocabulary, no vibes.
Oracle: `eval/expected-prompts.md` (G1–G6 + per-sample MUST/MUST-NOT).
Method: read all five outputs, then verified every pointer/fact each output claims
against the real filesystem (prompt-it repo AND the external Beacon repo named in
S14) rather than trusting the prose. All quotes below are verbatim from the run
files unless marked otherwise.

---

## S11 — clarity gate: minimal tighten (already well-formed) — **FAIL**

Sample was already routed by the user (`plan-it. /goal ... DoD: 1. ... 2. ... Out
of scope: ...`) with no `Context:` block of its own.

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Route stays `plan-it` | ✓ | Output opens `/plan-it` |
| 2 | User's structure preserved, in-place fixes only | ✗ | Output inserts a wholly new `Context:` block (`Context:\n- @plugins/prompt-it/skills/prompt-it/references/targets.md — ...\n- @README.md — ...`) that does not exist anywhere in the user's input |
| 3 | Changes ≤ light tighten (exemplar: "at most light tightening, e.g. verification target added to DoD item 1") | ✗ | DoD tightening itself is fine (`DoD:\n1. CONTRIBUTING.md exists ... (verify: the file, and its steps match the actual structure of targets.md)`) but the added `Context:` section is structural, not a tighten |
| 4 | No restructure into the full 6-slot template | ✗ | A `Context:` block is precisely the full-template's Context-Package slot |
| 5 | No added scope | ✓ | No new deliverables introduced |
| 6 | No questions | ✓ | None present |

**Diagnosis:** This is a direct, self-documented violation of the skill's own clarity-gate rule. `SKILL.md` line 69 states verbatim: *"Validation ADDS NO SECTIONS: it either confirms what's written (silently) or fixes/flags a defect in place — **a new `Context:`/`Grounding:` block appearing in a minimal tighten means you've violated this rule.**"* The dead-pointer fix itself (correcting `references/targets.md` → `plugins/prompt-it/skills/prompt-it/references/targets.md`, verified: the former path does not exist at the repo root, the latter does — `ls references/targets.md` → "No such file or directory"; `ls plugins/prompt-it/skills/prompt-it/references/targets.md` → resolves) was legitimately done *in place*, inline in the `/goal` line. But the runner then also promoted that fix into a standalone `Context:` section with two bulleted pointers — exactly the pattern the skill names as the failure mode. Everything else about S11 (DoD light-tighten, no questions, no scope creep, route locked) is correct; the new section is the sole but explicit defect.

---

## S12 — dead pointer: caught, not propagated — **PASS**

Sample: `Update @docs/architecture/overview.md in this repo to document the new eval suite under eval/.` Verified: this repo has no `docs/` directory at all (`ls docs` → "No such file or directory").

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Nonexistent path NOT emitted as a live `@`-ref inside the prompt block | ✓ | Path appears only as plain backticked text — `` Create `docs/architecture/overview.md` `` and `` docs/architecture/overview.md exists `` — never as `@docs/...` |
| 2 | Explicit disclosure of the dead pointer | ✓ | Inline: `(assumed: neither the file nor a \`docs\` dir exists in this repo — you are CREATING it, not updating; flag if you meant a different doc, e.g. README.md)`; also 💡: `Your pointer was dead: docs/architecture/overview.md doesn't exist and the repo has no docs/ directory at all` |
| 3 | Intent preserved — documenting the eval suite still happens | ✓ | `/goal Document the eval suite under eval/ ...` plus a full DoD to create the doc |
| 4 | No silent invention of a different path as if the user named it | ✓ | The substituted context pointers (`eval/sample-prompts.md`, `eval/expected-prompts.md`, `eval/scripts/run-eval.sh`, `eval/fixtures/notes.md`, `eval/runs/`) are disclosed as the runner's own inventory, not attributed to the user |

All six named context pointers verified on disk: `eval/sample-prompts.md`, `eval/expected-prompts.md`, `eval/scripts/run-eval.sh` (present, executable), `eval/fixtures/notes.md`, `eval/runs/{v0.1.0,v0.2.0,v0.2.0-final}` (all present), and the CHANGELOG "20/20" claim (`grep "20/20" CHANGELOG.md` → matches line 8). No fabricated pointers. G1 shape intact (fence + 🎯 + 💡 + one setup line).

**Verdict: PASS.** Textbook dead-pointer handling — reframed as create, flagged inline, real substitute pointers offered, nothing silently invented.

---

## S13 — legitimate ambiguity — **FAIL**

Sample: `There's a bug in auth — sessions die way too early. Fix the auth bug in our Engine workspace.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | One of the two sanctioned behaviors present | ✓ | Both used: inline flagged assumptions in the block AND 3 appended optional questions |
| 2 | Any question has concrete options (not "what did you mean?") | ✗ | Q1/Q2 do; Q3 does not — `3. Exact path of the Engine workspace repo, so the pointer ships validated?` offers no candidate options, it's an open fill-in-the-blank |
| 3 | If assumed, the assumption is explicit in the prompt block itself | ✓ | `(assumed: user login sessions in the Engine workspace app — flag if you mean engine/job sessions)`; `(assumed: the TTL already set in the auth config is the intended value — flag if the config itself is wrong)` |
| 4 | No silent repo/module picking | ✓ | Repo path marked `(unvalidated — confirm this path first; run from its root, not from prompt-it)` |
| 5 | ≤3 questions | ✓ | Exactly 3 |

**Diagnosis:** Q1 (`"Sessions" = user login sessions, or Engine's own job/worker sessions?`) and Q2 (`the configured TTL is correct and being violated, or is the TTL itself set wrong`) are properly closed, concrete-option questions. Q3 is not — it asks the user to supply a raw file path with zero candidate options, which is the "what did you mean?" shape the oracle explicitly bars (global nuance: *"each with concrete options (open-ended = FAIL)"*). It's also slightly self-contradictory: the 💡 line claims the "sessions"/"lifetime" ambiguity is *"pinned as inline flagged assumptions instead of blocking"* — yet Q1/Q2 then re-ask the exact same two ambiguities as optional questions. The assumption-flagging behavior and the questions behavior are both individually fine, but Q3's format is the concrete MUST violation.

---

## S14 — route: plan-it — **FAIL**

Sample: multi-surface Beacon feedback-thumbs extension, no route named by the user (no skill header/mention — unlike S11, so the "user's named route is locked" rule from `SKILL.md` line 30/72 does not apply here; prompt-it had to decide the route itself).

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Route `plan-it` | ✗ | Output opens `/fable-it`, and 🎯 states `Target: fable-it — done-ness is already locked in existing epic test contracts (E3/E4), so plan-it would duplicate a finished plan` |
| 2 | Beacon path carried, validates | ✓ | `/Users/macbook/Workspace/ANM/Beacon/beacon` — verified: this nested dir exists and contains `docs/implementation/2-feedback-observability/{prds/PRD-master.md, epics/epics-feedback-obs.md, research/11-chat-surfaces-and-ids.md}` and `docs/implementation/0-done/3-sow-feedback-ux/PRD-sow-feedback-ux.md`, all present exactly as named; `frontend/src/components/{FeedbackWidget,RegenerateFeedbackModal,FeedbackReasonForm}.tsx` and `frontend/src/pages/{Intel,DesignChat}.tsx` all exist exactly as named |
| 3 | 3 sub-features present | ✓ | `thumbs on every LLM chat/generation surface (Intel, Design chat, all regeneration flows), an active post-generation review prompt, and a structured "what went wrong" reason on thumbs-down` |
| 4 | Fences | ✓ | `Out of scope / do not touch: E1/E2/E5 ... no re-planning the package; no changes to the locked SOW feedback UX from 3-sow-feedback-ux` |
| 5 | No tiering | ✓ | None present |
| 6 | Validation stays pointer-only, no discovery dossier | ✗ | See diagnosis — the CP embeds semantic synthesis (taxonomy, dependency graph, named-stakeholder decision rationale, test-contract case counts), not existence-only pointers |

**Diagnosis (two compounding defects):**

1. **Wrong route.** The oracle fixes S14 as `route: plan-it` with no "or X with rationale" escape hatch (unlike the Mode-2 samples S07/S09/S20, which explicitly permit an alternate route with stated rationale). The output routes to `fable-it` instead. Even granting that the rationale is well-argued, the checklist for this sample is a hard single-route MUST, and it is violated.

2. **The re-route is built on research the skill itself forbids.** Every fact underpinning the fable-it decision was independently confirmed real on disk — this is not fabrication, it's unusually well-grounded work. But `SKILL.md` draws an explicit hard line at line 94: *"Validation is not discovery (hard cap): pointer validation confirms pointers EXIST — it never expands into researching the task... if your validation produced line-level inventories, test-case IDs, or a discovery dossier, you have crossed into plan-it/fable-it pre-grounding territory — cut it back to pointers and route accordingly."* The S14 output's Grounding section does exactly what this forbids: it names the W1/W2/W3 gap taxonomy, the E3→E4 epic dependency chain with per-epic test-contract case counts (confirmed real: `epics-feedback-obs.md` literally contains "### Test Contract (E3) — 4 cases" / "(E4) — 4 cases" and a "Coverage self-audit ... 20 cases total"), and a named-stakeholder decision rationale (confirmed real: `PRD-sow-feedback-ux.md` line 4, *"Origin: Matthew Good (Webex, 2026-07-14): the post-generation ReviewModal is a chicken-and-egg"*, verbatim to what the S14 output paraphrases). That is a discovery dossier, not pointer validation. Per the skill's own instruction, the correct move on hitting this depth of research was to *"cut it back to pointers and route accordingly"* (i.e., route plan-it and let planning re-derive this synthesis inside its own discovery phase) — not to use the over-researched findings to justify skipping plan-it. This is a G6-adjacent violation: the runner performed a meaningful slice of plan-it's synthesis work itself rather than confining itself to producing a routing prompt.

Everything else about S14 (pointer accuracy, 3-sub-feature Pareto coverage, fences, no tiering) is excellent — this is the strongest grounding work in the batch, but it fails on route conformance and scope-of-validation.

---

## S15 — route: fable-it — **PASS**

Sample: `Add a version-check script ... exits non-zero when the 0.x.y version differs across marketplace.json, plugin.json, SKILL.md and CHANGELOG.md, wire it as scripts/check-version.sh, and prove it catches a mismatch. Run it to done.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Route `fable-it` | ✓ | Output opens `/fable-it` |
| 2 | DS includes the negative test (prove it catches a mismatch) | ✓ | DoD item 3: `The run report shows evidence of a real catch: an invocation against a mismatched state returning non-zero, with the tree restored afterward (git status clean except the new script)` |
| 3 | SF present | ✓ | `Out of scope / do not touch: no version bumps, no CI/git-hook wiring, no edits to eval/ or the four version files beyond any temporary mismatch you fully revert` |
| 4 | No tiering/persistence content | ✓ | None present |
| 5 | Pointer accuracy | ✓ | All four version sources verified: `.claude-plugin/marketplace.json` → `"version": "0.2.0"`; `plugins/prompt-it/.claude-plugin/plugin.json` → `"version": "0.2.0"`; root `SKILL.md` → `version: 0.2.0`; nested `plugins/prompt-it/skills/prompt-it/SKILL.md` → `version: 0.2.0` — the output's claim of **two** SKILL.md copies, both at 0.2.0, is exactly right (`find . -iname SKILL.md` returns exactly these two paths), and the flagged assumption `(assumed: the script must ALSO check the second copy ... flag if only the root copy matters)` is the correct disclosure for a genuinely underspecified point |

**Verdict: PASS.** No defects found — route, negative-test DoD item, scope fence, and all four pointer/version claims check out exactly against the live repo.

---

## Summary final-3

- S11: **FAIL** — inserts a new `Context:` section not in the user's structure, directly contradicting the skill's own "minimal tighten adds no sections" rule (SKILL.md L69), despite an otherwise-correct in-place dead-pointer fix and route lock.
- S12: **PASS** — dead pointer (`docs/architecture/overview.md`) correctly reframed as create, disclosed inline and in 💡, never emitted as a live `@`-ref; all substitute pointers verified real on disk.
- S13: **FAIL** — one of three appended refinement questions (repo path) is open-ended with no concrete options, violating the closed-question MUST even though the other two questions and the inline flagged assumptions are correctly formed.
- S14: **FAIL** — routes to `/fable-it` against the oracle's fixed `plan-it` MUST, built on grounding that itself crosses the skill's explicit "validation is not discovery" hard cap (line-level test-contract counts, named-stakeholder decision quotes) — verified accurate but out of scope for prompt-it to have surfaced.
- S15: **PASS** — correct route, negative-test DoD item present, scope fence present, all four version-file pointers (including the two-SKILL.md-copies detail) verified exactly correct on disk.
