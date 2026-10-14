# Changelog

All notable changes to prompt-it are documented here. This project adheres to
[Semantic Versioning](https://semver.org/).

## 0.3.1 — 2026-10-14

do-it integration (companion-change catalog, prompt-it section; contract rule G-11). No behavior change to routing or the `▶` delivery line.

- **Brief budget.** Step 4 (pointer validation) now states that every path or id the emitted prompt cites has been validated (or carries the existing `(unvalidated ...)` marker) and that the emitted prompt block stays at or under 8000 tokens.
- Version bump in `plugin.json`, `marketplace.json` and both `SKILL.md` frontmatters. The 0.3.0 pin drift in build-it, plan-it and review-it is fixed in those repos (separate PRs).

## 0.3.0 — 2026-07-28

Behavioral release: prompt-it now decides **where** its compiled prompt should run and says so in one line. Through 0.2.1 the skill hardcoded an answer to a question it never asked — the emit contract assumed a fresh session and the Install copy promised a block "ready to paste into a fresh session". That is wrong whenever the session holds evidence a copy-paste cannot carry: a compiled prompt is *text*, so pasted screenshots, uploads and live state do not travel, and `/read-chat` — the escape hatch prompt-it leans on — strips attachments from its digest, making them unrecoverable rather than merely degraded. (Field case: a feedback cycle compiled with six screenshots as its primary evidence, where the emitted setup line advised a fresh session and the user had to override it by hand.)

- **D1 — the `▶` delivery line.** The emit contract's setup-line slot (formerly "≤2 setup lines") is replaced by exactly one always-present line stating **run here** or **paste into a fresh session**, plus the one reason. Any genuinely needed setup rides on the same line. The response shape is unchanged in length — `fence → 🎯 → 💡 → ▶ → (≤3 optional questions)` — so Rule 1's output contract still holds; this is a replacement, not a new section.
- **D2 — signal-driven, never a mode.** The decision comes from signals already visible in the session, per a 4-row table in the emit contract: load-bearing images/uploads or live state (open browser, running dev server, active worktree) → run here; a pure-text ask whose every pointer is a file path → fresh session; no signal either way → fresh for overnight/autonomous runs, here for attended work. There is no flag, no CLI arg and no question — a "which session?" question would violate the skill's own earned-questions rule (F3, 0.2.1).
- **D3 — dangling-evidence guard (new).** On fresh-session delivery the block may never reference in-session evidence ("the 5 screenshots above", "the error I pasted"); it must describe that evidence in words or point at a persisted file path. Same failure class as the existing dead-pointer rule, previously unguarded. On run-here delivery such references are allowed.
- **D4 — the shape is restated consistently.** Rule 1 and the Output-hygiene rule both carry the new shape (they state it twice by design); README's emit step, the root SKILL.md Install copy, and a new cross-route note in `references/targets.md` (iterate's live-state signal; product-LLM targets, which never run here at all) are updated to match.

**Eval: 19/20** on the binding 20-sample suite (evidence: `eval/runs/v0.3.0-final/`, four Fable-tier judges against `eval/expected-prompts.md`). The new behavior held everywhere it was tested: all 20 outputs carried exactly one `▶` delivery line, all 20 delivery calls matched their signals (18 fresh-session; 2 reasoned `run here`, both verified genuine), and the dangling-evidence guard held on the sharp cases — S04 pasted its TS2345 error *text* into the block rather than pointing at it, and the Mode 2 samples restated findings or cited persisted paths.

The one FAIL is **S18**, and it is **not a regression**: the block is compliant (154 words), but the `💡` line narrated the 200-word cap, which fix F2 (0.2.1) defines as a violation in itself. Re-running S18 on both skills measured the narration at 2-of-4 on 0.3.0 and 1-of-3 on 0.2.1 — a pre-existing flake at roughly 1-in-3 in both versions. Correction to the 0.2.1 notes above: its S18 pass should be read as a clean draw on a flaky check, not a settled result. Hardening rule 7 is follow-up work.

The oracle changed for this run, which is disclosed because it is binding: G1 was rewritten to require the `▶` line (it encoded the old "setup lines ≤2" shape), G7 was added for the delivery call and the dangling-evidence guard, and the v3.1.0 `fable-it` → `build-it` rename was propagated into `expected-prompts.md` / `sample-prompts.md`, where it had never landed. Sample inputs were untouched.

Deferred to a later 0.3.x: the **evidence extractor** — dumping session images from the transcript to `.prompt-it/evidence/` and `@`-referencing them so a fresh session can still read them. 0.3.0 ships the signal line first, to find out whether the extractor is ever missed.

## 0.2.1 — 2026-07-23

Certification release: **20/20 pass** on the binding 20-sample eval suite, all samples run on the session-default (Fable) tier and judged by Fable-tier judges against eval/expected-prompts.md property checklists (evidence: eval/runs/v0.2.1-final/). Fixes the 4 residual defects that held 0.2.0 at 16/20 (S11/S13/S14/S18, confirmed real on cross-tier retry — decisions D19/D20). All four fixes are mechanical guards in the HARD OUTPUT RULES box:

- **F1 — S11 (minimal tighten).** Mechanical pre-emit diff: in a minimal tighten, every line of the emitted block must trace to a line the user wrote; untraceable lines (`Grounding:`/`Context:` sections, extra restrictions) are deleted — salvage goes to the 💡 line.
- **F2 — S18 (reasoning-native brevity).** Hard 200-word cap for reasoning-native targets (o1/o3/o4/R1-class): draft to ~150, count fence-to-fence, compress rubrics to 2–3 anchors. The count is a silent internal check — never narrated (narrating it broke fence-first in testing).
- **F3 — S13 (question discipline).** Appended questions are earned: lookup-first (a path/file/repo question is forbidden until the cheap `ls`/`grep` ran) and options-or-assumption (every question offers ≥2 concrete candidates, or converts to an inline flagged assumption).
- **F4 — S14 (routing + facts).** Multi-surface / "extend X to all Y" asks route to plan-it — existing patterns never downgrade to fable-it; repo facts must be earned (existence claims need the lookup that found them, absence claims need the empty search) else marked `(unverified — confirm during discovery)`; user-supplied absolute paths carried verbatim.

Correction to the 0.2.0 notes below: 0.2.0's final certified state was **16/20** (the "20/20" line predated the honest D20 re-judgment; see eval/runs/v0.2.0-final/judgment-retry-final.md).

## 0.2.0 — 2026-07-23

Eval-hardened release: 16/20 certified on the binding 20-sample eval suite (eval/, judged against eval/expected-prompts.md property checklists by review-it-contract judges; the 4 residual defects S11/S13/S14/S18 documented in eval/runs/v0.2.0-final/ and fixed in 0.2.1).

- **M1 — output contract.** HARD OUTPUT RULES box at top of SKILL.md: response starts at the opening fence; emit-first is unconditional — questions may only append after the prompt block, never replace it (unresolved points become inline flagged assumptions).
- **M2 — routing.** User-named routes are locked (never overridden); plan-it heuristic sharpened (pointers don't make scope resolved); inline per-route omission table (review-it: never author a fresh DoD).
- **M3 — grounding discipline.** Cross-tree pointers kept but marked unvalidated; validation-is-not-discovery cap (≤7 pointers, no file:line dossiers); clarity-gate minimal tighten preserves the user's structure and adds no sections.
- **M4 — DoD altitude.** Sketch items name verification TARGETS (what proves it), never METHODS/protocols (whose design belongs to fable-it/review-it).
- **M5 — hygiene.** No process narration/tool commentary in output; lookup failures fold into the 💡 line.
- **M6 — eval suite.** eval/sample-prompts.md (20 cases + coverage matrix), eval/expected-prompts.md (binding property oracle), headless runner (eval/scripts/run-eval.sh), v0.1.x run outputs + 8 judgment files retained for regression baselines.

Known limitation (documented): 17/20 pass with sonnet-tier headless runners; S03/S11/S14 (deep conditional rule-following) required the session-default model — matches real usage where /prompt-it runs on the session model.

## 0.1.0 — 2026-07-23

Initial release. prompt-it is a harness-aware intent compiler for the DevOtts `*-it`
family: it turns a rough ask into an optimized, context-grounded prompt, routed to the
right sibling skill with exactly the slots that target parses — nothing it already owns.

- **M1 — Core skill.** `plugins/prompt-it/skills/prompt-it/SKILL.md` ships both modes.
  Mode 1 (new-session compiler) runs a clarity gate, routes to plan-it / fable-it /
  review-it / iterate / bare, extracts author-context (conversation evidence → cheap
  lookups → ≤3 grounded questions), validates every pointer before it ships, and drafts
  against the 6-slot template (ROUTING, GROUNDING, `/goal`, CONTEXT PACKAGE, DoD SKETCH,
  SCOPE FENCES). Mode 2 (post-review continuation) ingests review-it/QA findings,
  acknowledges verified work before pinning gaps, prefers mechanism-level fixes over
  point patches, guarantees Pareto-complete gap coverage, and packages the result using
  `/next-session-prompt` conventions.
- **M2 — Self-check passes.** Every draft runs three passes before emission: a five-item
  rubric (grounded / scoped / actionable / faithful / complete-enough), a contradiction
  diff across DoD items and constraints, and a load-bearing audit (no vague adjectives,
  every sentence earns its place, format explicit, scope bounded).
- **M3 — Output contract.** Strict emission format: one copyable fenced prompt block, a
  `🎯 Target:` line naming the route and why, a `💡` one-line note on the single most
  important thing the optimization added or fixed, and setup lines only when genuinely
  needed (≤2). Never silent-rewrite — any change to the user's meaning is surfaced.
  Generated prompts never embed secrets — `[ENV_VAR_NAME]` references only.
- **M4 — `references/targets.md`.** Per-target responsibility ledger covering six
  profiles (plan-it, fable-it, review-it, iterate, bare Claude Code / Claude.ai session,
  product LLM / external agent), each with a PARSES → include list, an OWNS → omit list,
  target-specific cautions (e.g. no chain-of-thought scaffolding on reasoning-native
  models), plus a quick omission table across all six slots and all six profiles. This
  is the mechanism that keeps the skill from duplicating machinery its siblings already
  own canonically — most notably the standing rule to never emit a delegation/tiering/
  economics note, since routing to fable-it *is* the economics decision.
- **M5 — Packaging.** Family-standard plugin skeleton: `.claude-plugin/marketplace.json`
  (devotts namespace, joining plan-it/fable-it/review-it), `plugins/prompt-it/.claude-
  plugin/plugin.json`, root `SKILL.md` copy (byte-identical to the plugin copy), this
  CHANGELOG, `LICENSE` (MIT), and a family-shaped README (hero, problem/motivation, how
  it works, worked example, platform compatibility, installation, key features, family
  integration diagram, architecture). Version 0.1.0 held identical across
  marketplace.json, plugin.json, root SKILL.md, and this file.
- **M6 — Research phase reference.** The design brief this build was written against
  (`research-BRIEF.md`, `research-SYNTHESIS.md` §3, and eight `research/research-
  findings-*.md` documents) is retained at the repo root/`research/` for traceability,
  including the v2 boundary-audit correction that slimmed prompt-it from an earlier
  over-scoped draft down to a pure intent compiler, and the D3 adoption pass against a
  third-party prompt-generation tool that validated the harness-aware design center
  while rejecting a template library, 30+-target coverage, and a parallel memory
  subsystem.

### Write-time invariants

- Version triple-match: `marketplace.json`, `plugin.json`, root `SKILL.md`, and this
  CHANGELOG's release header all carry `0.1.0`.
- No `machine.json`, hooks, or `.taskstate/`-style persistence directory shipped in
  v0.1.0 — the skill runs single-pass (draft → self-check → emit) with no run state to
  persist between turns.
