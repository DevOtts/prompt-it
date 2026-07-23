# Changelog

All notable changes to prompt-it are documented here. This project adheres to
[Semantic Versioning](https://semver.org/).

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
