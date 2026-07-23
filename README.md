<div align="center">

# prompt-it

### The harness-aware intent compiler for the DevOtts `*-it` family

*You are not doing the task. You are writing the prompt that gets the task done right.*

[![Version](https://img.shields.io/badge/version-0.1.0-blue)](./CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Native Claude Code](https://img.shields.io/badge/Claude%20Code-plugin-5A45FF)](#installation)
[![SKILL.md portable](https://img.shields.io/badge/SKILL.md-portable-brightgreen)](#installation)
[![Author](https://img.shields.io/badge/author-DevOtts-black)](https://github.com/DevOtts)

[How it works](#how-it-works) ·
[Installation](#installation) ·
[Key features](#key-features) ·
[The `*-it` family](#the--it-family) ·
[Architecture](#architecture--whats-inside) ·
[License](#license--links)

</div>

---

## Problem / Motivation

The first few turns of almost every session get burned re-establishing context that was never written down: which prior session you mean, which file is the pattern to imitate, which URL you already looked at, which parts of the ask are genuinely in scope. That context isn't missing from the repo — pre-grounding tools can already read the repo. It's missing because it lives **in the author's head**, and nobody downstream goes looking for it unless the prompt carries it in.

Rough asks also get routed wrong, or routed right but re-explain things the target skill already owns. Tell `fable-it` to "use Claude teams and lower-tier models for the boring parts" and you've just duplicated a decision `fable-it`'s own model-tiers reference already makes canonically — the same defect as copy-pasted boilerplate, one level up. Tell `plan-it` to do a deep research pass before it even starts discovery, and you've pre-empted its own Phase 3–4. Every one of these is a rough prompt paying a tax the target skill didn't need it to pay.

`prompt-it` exists to close that gap once, on the way in: pull what's in the user's head out of the conversation and cheap lookups, validate every pointer so the downstream session doesn't burn its first turn on a dead reference, and hand the routed target *exactly* the slots it parses — nothing it already owns.

## How it works

`prompt-it` runs one of two pipelines depending on what's in front of it. Both end the same way: one copyable prompt block, a routing line, and a one-line note on what the optimization actually changed.

### Mode 1 — new-session compiler

```
rough ask
   │
   ▼
1. Clarity gate ───────► already clear + scoped? → minimal tighten, emit, stop.
   │ (needs more work)
   ▼
2. Route ──────────────► plan-it | fable-it | review-it | iterate | bare
   │
   ▼
3. Author-context extraction
   conversation evidence → cheap lookups (.agents/history/INDEX.md, ls/grep, CLAUDE.md)
   → ≤3 grounded questions (only what lookups can't resolve)
   │
   ▼
4. Pointer validation ─► every @ref / alias / pattern-file verified to exist (seconds)
   │
   ▼
5. Draft ──────────────► the 6-slot template, sized by the clarity gate,
   │                     slots the target owns OMITTED per targets.md
   ▼
6. Self-check ─────────► rubric → contradiction diff → load-bearing audit
   │
   ▼
7. Emit ───────────────► copyable prompt + 🎯 Target line + 💡 what-changed line
```

### Mode 2 — post-review continuation

```
review-it / QA findings
   │
   ▼
1. Ingest findings (read the gap descriptions, not the pass/fail counts)
   │
   ▼
2. Acknowledge-then-catch — credit what's verified working (with evidence), then pin each gap
   │
   ▼
3. Class over instance — point defect, or a class? prefer the mechanism-level fix,
   │                      proposed from assets that already exist
   ▼
4. Pareto completeness — every materially distinct gap, not just the worst one
   │
   ▼
5. Failed attempts — list what was already tried (run-memory.md / findings) so the
   │                  next session doesn't re-propose it; restate locked decisions by
   │                  READING decisions.md, never from memory
   ▼
6. Package ────────────► /next-session-prompt conventions: copyable block, evidence
   │                      citations (file:line, report path, URL), /read-chat back-ref
   ▼
7. Same self-check passes + output contract as Mode 1
```

### The 6-slot template

Every optimized prompt is built from the same anatomy. Slots marked ⚖ are sized by the clarity gate (a one-line ask doesn't get a three-page GROUNDING section); slots the routed target already owns are omitted entirely, per `references/targets.md`:

| # | Slot | What goes in it |
|---|------|------------------|
| 1 | **ROUTING** | First line: the target skill invocation (or none, for a bare target) |
| 2 | **GROUNDING** ⚖ | 1–3 sentences: situation, why now — compressed, no epic narration |
| 3 | **`/goal`** | One sentence, the real goal (restated at the end if the prompt runs long) |
| 4 | **CONTEXT PACKAGE** ⚖ | Pointers, not payloads — `@refs` with a one-line why each, pattern-to-imitate, `/read-chat` alias, evidence URLs |
| 5 | **DoD SKETCH** | Numbered, individually testable items, each naming its verification *target* (endpoint/page/table/command) — not the verification protocol |
| 6 | **SCOPE FENCES** | Labeled "Out of scope / do not touch" — always present, even if one line |

Bare targets (no harness skill in the loop) additionally get an **uncertainty clause** and an **output contract**, because nothing downstream owns those there. See the quick table below.

### The harness-aware omission rule

This is the actual design center of the skill: **know the target, include what it parses, omit what it owns.** Duplicating a mechanism the target skill already owns creates drift against the canonical implementation — the same failure mode as a copy-pasted helper function that quietly diverges from the original. `references/targets.md` is the per-target ledger `prompt-it` reads before every draft. Quick reference:

| Slot | plan-it | fable-it | review-it | iterate | bare | product-LLM |
|---|---|---|---|---|---|---|
| GROUNDING | ✔ | ✔ | — | — | ✔ | ✔ (self-contained) |
| `/goal` | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| CONTEXT PACKAGE | ✔✔ | ✔ | ✔ (what's under test) | ✔ (paste the error) | ✔ | ✔ (disambiguation) |
| DoD SKETCH | light | ✔✔ (verification targets) | ✗ points at existing contract | ✔ (1–3 items) | ✔ | ✔ (examples) |
| SCOPE FENCES | ✔ | ✔✔ (lifted verbatim) | ✔ | ✔ | ✔ | ✔ |
| Uncertainty clause | ✗ | ✗ | ✗ | ✗ | ✔ | ✔ |
| Output contract | ✗ | ✗ | ✗ | ✗ | ✔ | ✔ |
| Stop conditions | ✗ | ✗ | ✗ | ✗ | agentic only | ✗ |
| Tiering / teams note | ✗ **NEVER** | ✗ **NEVER** | ✗ | ✗ | ✗ | ✗ |

Some standing rules that fall out of this table:

- **Never emit delegation/tiering/economics notes** ("use Claude teams, lower models…") — `fable-it` Step 3 and its `model-tiers.md` reference own this canonically. Routing to `fable-it` *is* the economics decision.
- **Never run heavy research fan-out** to spec the task — that's `plan-it` Phases 3–4 and `fable-it` Step 2. `prompt-it` only does cheap *pointer validation* (`ls`/`grep`/index lookups, seconds not minutes).
- **Never author binding DoDs, test contracts, or verification protocols** — `plan-it` Phase 1 locks DoDs; `review-it` owns oracles. `prompt-it` emits a DoD *sketch* with verification *targets*, at the altitude the target skill can lock without reinterpretation.
- **Never emit persistence contracts, stop conditions, or autonomy clauses** for harness targets — `fable-it` owns run state and stop/permission semantics. Bare targets are the one exception.
- **Preserve intent** — never silently expand or shrink the user's scope. A one-line ask does not come back as a three-page spec unless the complexity is genuinely there.

## Worked example

**Rough ask (Mode 1):** "prompt-it this: I want to build out the observability dashboard we talked about last week, using the same pattern as the billing one."

What the pipeline does with that:

1. **Clarity gate** — fails (target isn't named, "last week" and "the billing one" are unresolved pointers) → runs the full pipeline instead of a minimal tighten.
2. **Route** — this is a deliverable goal with checkable done-ness, not a fuzzy idea needing discovery → routes to `fable-it`.
3. **Author-context extraction** — checks `.agents/history/INDEX.md` for a session card matching "last week" + "observability", finds `done-observability-beacon`; greps the repo for the billing pattern file.
4. **Pointer validation** — confirms the session alias resolves to a real ledger card, confirms the billing pattern file exists at the path found.
5. **Draft** — 6-slot template, ROUTING = `fable-it`, CONTEXT PACKAGE carries the validated `/read-chat "done-observability-beacon"` alias and the billing file as pattern-to-imitate, DoD SKETCH lists testable items with verification targets (the dashboard route, the metrics endpoint), SCOPE FENCES marks the billing module itself as do-not-touch.
6. **Self-check** — rubric passes; no contradictions between DoD items; load-bearing audit trims a leftover "make it robust" adjective down to the actual constraint it was gesturing at.
7. **Emit:**

```
/fable-it

Building the observability dashboard using the billing dashboard's pattern.

/goal: ship a working observability dashboard that reuses the billing dashboard's
layout and data-fetching pattern.

Context:
- @src/dashboards/billing/ — pattern to imitate: its layout + data-fetching approach
- /read-chat "done-observability-beacon" — prior session where the requirements were discussed

DoD sketch:
1. Dashboard renders at /dashboards/observability with live metrics — verify: the route itself
2. Metrics endpoint returns real data, not mocked — verify: GET /api/metrics response
3. Layout matches the billing dashboard's grid/card structure — verify: side-by-side visual diff

Out of scope / do not touch: the billing dashboard module itself — read from, don't modify.
```

```
🎯 Target: fable-it — deliverable goal with a checkable DoD, fits an autonomous build run
💡 Validated the session alias — you said "last week", the card is done-observability-beacon;
   also confirmed src/dashboards/billing/ exists as the pattern file.
```

Notice what's *not* in that prompt: no tiering note ("use Claude teams for the boring parts"), no persistence contract, no autonomy/stop-condition clause. `fable-it` owns all of that — `prompt-it` routing to it *is* the decision to hand those over.

## Platform compatibility

`prompt-it` is a single `SKILL.md` file with no runtime dependencies, no scripts, and no state directory, so it runs anywhere a `SKILL.md`-compatible agent can load skills:

| Platform | Support | Notes |
|---|---|---|
| Claude Code (plugin) | ✅ Native | Install via `/plugin install prompt-it@devotts` |
| Claude Code (standalone SKILL.md) | ✅ Native | Drop `SKILL.md` + `references/targets.md` into your skills directory |
| Other SKILL.md-compatible agents | ✅ Portable | `npx skills add DevOtts/prompt-it -a <agent>` |
| Claude.ai (Projects / custom instructions) | ✅ Portable | Paste `SKILL.md` content as a project instruction or custom skill |
| Non-Claude agents (Cursor, generic LLM tools) | ⚠️ Manual | The skill's *language* (6-slot template, self-check passes) ports fine; the `*-it` routing targets are DevOtts-specific and won't resolve unless those skills are also present |

## Installation

### Claude Code (plugin)

```
/plugin marketplace add DevOtts/prompt-it
/plugin install prompt-it@devotts
```

`prompt-it` shares the `devotts` marketplace namespace with `plan-it`, `fable-it`, and `review-it` — if you already have the marketplace added for one of those, just install `prompt-it@devotts` directly.

### Standalone SKILL.md fallback

`prompt-it` is a single portable `SKILL.md` with no external dependencies (no scripts, no hooks, no state directory) — it works anywhere a Claude Code–compatible agent can load a skill file:

```bash
npx skills add DevOtts/prompt-it -a claude-code
# or, for any other SKILL.md-compatible agent:
npx skills add DevOtts/prompt-it -a <agent>
```

Or simply copy `SKILL.md` (root of this repo) plus `plugins/prompt-it/skills/prompt-it/references/targets.md` into your agent's skills directory — the skill has no hard dependency on the plugin packaging beyond that one reference file.

## Key features

- **Two modes, one anatomy.** Mode 1 compiles a rough new-session ask into a routed, validated prompt. Mode 2 reads `review-it`/QA findings and produces the evidence-cited continuation prompt for the next iteration — same 6-slot template, same self-check passes, same output contract.
- **A clarity gate that refuses to over-engineer.** If the rough prompt is already clear, scoped, and routed, `prompt-it` does a minimal tighten and stops. Running the full pipeline on a trivial ask is the skill's #1 failure mode, and the gate exists specifically to prevent it.
- **Author-context extraction, cheapest source first.** Conversation evidence, then cheap lookups (`.agents/history/INDEX.md`, `ls`/`grep`, `CLAUDE.md`), then — only for what lookups can't resolve — up to 3 grounded questions with concrete options, never open-ended "what did you mean?". If the user is unavailable, the assumption goes inline in the prompt, marked `(assumed — flag if wrong)`.
- **Pointer validation, not research.** Every `@file` ref, `/read-chat` alias, and pattern-to-imitate file gets verified to exist before it ships. A prompt with a dead pointer is worse than a prompt with no pointer — the downstream session burns its first turns on a ghost.
- **The harness-aware omission rule.** `references/targets.md` is a per-target responsibility ledger (plan-it / fable-it / review-it / iterate / bare session / product-LLM): parses → include, owns → omit, plus target-specific cautions (e.g. no chain-of-thought scaffolding on reasoning-native models). This is what keeps `prompt-it` from drifting into a mini-planner.
- **Three-pass self-check before anything ships.** (1) A five-item rubric — grounded, scoped, actionable, faithful, complete-enough. (2) A contradiction diff across DoD items and constraints. (3) A load-bearing audit — every sentence earns its place, vague adjectives ("robust", "professional") get replaced with concrete facts, format is explicit, scope is bounded. The best prompt is not the longest one; it's the one where every word is load-bearing.
- **A strict, auditable output contract.** One copyable fenced prompt block, a `🎯 Target:` line naming the route and why, a `💡` line naming the single most important thing the optimization added or fixed, and setup lines only when genuinely needed (≤2). Never silent-rewrite — if the user's meaning changed anywhere, that's said out loud.
- **Credential-safe by construction.** Generated prompts never embed secrets or keys — `[ENV_VAR_NAME]` references only, or "assumes `<service>` is authenticated."
- **No memory subsystem of its own.** Mode 2 restates locked decisions by *reading* `decisions.md` and failed attempts by reading `run-memory.md` — it never maintains a parallel memory store that could drift from the source of truth.

## The `*-it` family

`prompt-it` is the front door of the front door. It doesn't plan, and it doesn't build — it writes the prompt that invokes the skill that does either of those well.

```
        rough ask                          finished plan
            │                                    │
            ▼                                    ▼
      ┌───────────┐                      ┌──────────────────┐
      │ prompt-it │ ── Mode 1 routes ──► │  /next-session-   │
      │  (Mode 1) │                      │  prompt (handoff) │
      └───────────┘                      └──────────────────┘
            │
            ├────────────► plan-it     (fuzzy/large idea → discovery + spec package)
            ├────────────► fable-it    (goal + DoD → autonomous delivery run)
            ├────────────► iterate     (single fix-test-verify loop, in-session)
            └────────────► bare        (plain session / product LLM / external agent)

      fable-it builds  ──►  review-it audits  ──►  prompt-it (Mode 2) writes the
                                                     evidence-cited continuation prompt
                                                     back into fable-it / iterate
```

- **`plan-it` plans** — turns a fuzzy idea into discovery + a spec package, with its own DoD lock and human-decision gates.
- **`fable-it` builds** — takes a goal + DoD and runs the delivery, owning its own run state, autonomy posture, and evidence ledger.
- **`review-it` audits** — verifies what `fable-it` built actually obeys the plan, with its own oracle ladder and evidence adapter.
- **`prompt-it` compiles the prompts between them** — Mode 1 gets a rough ask routed and grounded into the right invocation; Mode 2 turns `review-it`'s findings into the next iteration's prompt.
- **`/next-session-prompt` is the sibling for a different moment**: post-planning handoff of an *already-finished* PRD/spec — kickoff note, memory update, and copy-paste launch prompt for a fresh session. `prompt-it` compiles *new* intent (Mode 1) or *post-review* continuations (Mode 2); it does not take over `/next-session-prompt`'s job, and routes there explicitly when that's the actual ask.

None of this is enforced by a shared runtime — it's a set of routing conventions the family agrees on, so that invoking any one member (`fable-it`, `review-it`, `plan-it`, `prompt-it`) never requires re-explaining what the others already do.

## Architecture / What's inside

```
prompt-it/
├── .claude-plugin/
│   └── marketplace.json                  # devotts namespace registration
├── plugins/prompt-it/
│   ├── .claude-plugin/
│   │   └── plugin.json                   # plugin manifest (mirrors marketplace entry)
│   └── skills/prompt-it/
│       ├── SKILL.md                      # the skill — source of truth
│       └── references/
│           └── targets.md                # per-target responsibility map (owns/parses/cautions)
├── SKILL.md                               # root copy, byte-identical to the plugin copy
├── README.md                               # this file
├── CHANGELOG.md
├── LICENSE                                 # MIT
├── research-BRIEF.md                      # research scope for the design phase
├── research-SYNTHESIS.md                  # spec-ready brief this build was written against
└── research/
    ├── research-findings-A-local-evidence.md
    ├── research-findings-B-sibling-plugins.md
    ├── research-findings-C1-youtube.md
    ├── research-findings-C2-youtube.md
    ├── research-findings-D1-existing-tools.md
    ├── research-findings-D2-best-practices.md
    ├── research-findings-D3-prompt-master.md
    └── transcripts/
```

The skill itself is intentionally minimal: no `machine.json` statechart, no hooks, no `.taskstate/`-style persistence directory, no scripts. `prompt-it` doesn't run multi-cycle loops or enforce gates the way `fable-it` or `plan-it` do — it drafts, self-checks, and emits, in a single pass, so there's no run state to persist between turns. If a future version needs a stateful refinement loop, that's the trigger to add `machine.json`; v0.1.0 doesn't need one.

`references/targets.md` is the one load-bearing reference file — it is read before every draft, and it is the only place the per-target omission rules live, so they never drift into copy-pasted duplicates inside the skill body.

## Development notes

This repository documents its own design process in `research-BRIEF.md`, `research-SYNTHESIS.md`, and the numbered `research/research-findings-*.md` files — including a v2 boundary-audit correction where an earlier draft over-scoped `prompt-it` into responsibilities `plan-it`/`fable-it`/`review-it` already own, and a later adoption pass against a third-party prompt-generation tool (`research-findings-D3-prompt-master.md`) that validated the harness-aware design center while explicitly rejecting a template library, a 30+-target coverage goal, and a parallel memory subsystem. If you're extending this skill, read the boundary audit in `research-SYNTHESIS.md` §3.0 first — it's the fastest way to avoid re-introducing a responsibility another `*-it` skill already owns.

## License + links

Licensed under the [MIT License](./LICENSE) — Copyright © 2026 [DevOtts](https://github.com/DevOtts).

- Repository: [github.com/DevOtts/prompt-it](https://github.com/DevOtts/prompt-it)
- Author: [DevOtts](https://github.com/DevOtts)
- Sibling plugins: `plan-it`, `fable-it`, `review-it` (shared `devotts` marketplace namespace)
- Changelog: [CHANGELOG.md](./CHANGELOG.md)

