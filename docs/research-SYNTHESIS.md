# Research Synthesis — prompt-it

**Date:** 2026-07-21 · **Inputs:** findings A, B, C1, C2, D1, D2 (see `research-BRIEF.md`) · **Author:** fable-it research run (Fable 5 coordinator)

This document is the bridge from research to build: what the evidence converges on, an honest assessment of Fernando's own prompt patterns against external standards, and a spec-ready brief for the prompt-it skill — its output template, its two workflow modes, its pipeline, its family integration, and the decisions only Fernando can make.

---

## 1. What the evidence converges on (cross-lane findings)

Six themes appear independently in three or more lanes — these are load-bearing for the design:

1. **The DoD/verification step is the highest-leverage transform.** Claude Code's own docs ("give Claude a way to verify its work — without a check, 'looks done' is the only signal"), Spec Kit's measurable-success-criteria gates, Karpathy's Verifier layer (C1), and the Anthropic roundtable all converge: an agentic prompt lives or dies on whether "done" is checkable by the agent itself. Fernando's own best prompt (LLM EXTRACTION, with its binding 11-case test contract) already embodies this; his weaker ones ("create a plan") don't. → prompt-it treats "every DoD item names a verification mechanism" as close to a hard gate. [A §2, C1 #4, D2 §5/§11, D1 §9]

2. **Compact beats thick; pointers beat payloads.** Nate Jones's A/B (compact prompt passed delivery constraints 3/3; thick version broke them twice), Anthropic's "smallest set of high-signal tokens," Claude Code's CLAUDE.md litmus test, and the instruction-stacking anti-pattern (~8–10 directives max) all say the same thing: prompt-it must optimize by *curation*, not expansion. Context goes in as `@file` pointers and named patterns-to-imitate, not pasted content. A rough 1-line ask must NOT come back as a 3-page spec unless complexity is genuinely there. [C1 #2, D2 §3/§5/§12, D1 impl. 1]

3. **Strip the author's hidden context — that's the core rewrite.** Amanda Askell's "externalize your brain" / temp-agency-worker mental model (C2 video 6), Claude Code's "confused colleague" golden rule, and Karpathy's "every assumption is a chance to drift" define what "optimizing" a prompt actually means: surface what the author knows that the agent doesn't. Mode 1's codebase research exists precisely to fill those gaps *from the repo* before bothering the human. [C2 §6, D2 §2, C1 #1]

4. **Every prompt needs an explicit "out" for uncertainty.** Give-it-an-out (`<unsure>`, "ask for the specific file path rather than guess"), Spec Kit's `[NEEDS CLARIFICATION]` marker, and "invite the agent to flag DoD problems rather than game them" — independently convergent across four sources. prompt-it's outputs always specify fallback behavior on ambiguity. [C2 §6/§8, D2 §11/§2]

5. **Split cheap research from expensive authoring.** severity1's stated principle ("search noise lives in cheap subagent tokens, decisions live in main-context tokens") is the same architecture Fernando already demands in his token-aware notes, and the same tiering fable-it codifies. Mode 1 farms grep/read/git-history to haiku/sonnet subagents that return findings, not transcripts; the Fable-tier main context authors the final prompt. [D1 §4a, A §1, family convention]

6. **Contradiction- and ambiguity-checking are distinct final passes.** GPT-5 docs: contradictory instructions are *more* damaging to precise models. Anthropic: dial back CRITICAL/MUST language, newer models overtrigger. The Anthropic roundtable's self-critique trick ("don't follow these instructions — tell me where they're unclear") is cheap to automate as prompt-it's last step before emitting. [D2 §8/§2, C2 §6]

**Honest negative results (things researched and ruled out):** DSPy MIPROv2/GEPA and Microsoft PromptWizard are structurally inapplicable — they need training sets, metric functions, and dozens of scored rollouts; prompt-it is one-shot and interactive. Borrow only GEPA's idea of grounding rewrites in textual failure evidence (= Mode 2 reading review-it findings) and its Pareto lesson (address *all* materially distinct gaps, don't collapse to the top one). Emotional-manipulation phrasing ("vital to my career", "$1000 tip") is contested by Anthropic's own practitioners — excluded. Blanket persona-stuffing ("you are a world-class X") — excluded; a short functional role line only where load-bearing. Videos 2–3 (Oxford learning, loops-of-loops) contributed almost nothing and are honestly labeled low-relevance. [D1 §5/§7, C2 §7, C1 §2–3]

---

## 2. Critical assessment: Fernando's patterns vs. the standards

Scored against the 24-item standards checklist (D2) and the tool landscape (D1). The verdict: the anatomy is fundamentally sound — several of Fernando's idioms are *ahead* of the public standards — but three habits need fixing, and prompt-it can fix all three mechanically.

### Keep (validated by external standards)
| Pattern | Validation |
|---|---|
| Skill routing header (`plan-it`, `fable-it`) | No public equivalent — it's harness-specific and correct: routes the workflow contract before content. Keep as slot #1. |
| `/goal` marker separating context from ask | Matches checklist #1 (single unambiguous goal) and the metaprompt's structure-first rule. Improvement: also restate the ask at the end when the prompt is long (GPT-4.1 both-ends rule). |
| Numbered DoD | Matches #3. His best version (binding test contract, "never faked") is exactly Spec Kit/Claude-Code doctrine — make that the default, not the exception. |
| `@`-refs, `/read-chat` pre-reads, "Package (read in order)" with per-doc why | Matches pointers-not-payloads (#5) and just-in-time retrieval. The per-doc "why" is *better* than most public guidance. |
| Reference implementation to mirror ("mirror trigger-draft.service.ts") | Matches #6 — the single cheapest ambiguity-collapser known. |
| Scope fences ("out of this scope") | Matches #7; upgrade from ad-hoc notes to an always-present labeled section. |
| Token-aware teams note | No public standard covers execution economics inside the prompt — this is a family invention worth keeping, but see fix #1. |
| Acknowledge-then-catch iteration style (bosslife) | Matches review best practice (fresh-eyes gap-finding + evidence citation). This is the Mode 2 template. |

### Fix (the three real defects)
1. **Boilerplate drift.** The token-aware note is pasted verbatim even where it contradicts the task ("small single-feature fix — one Sonnet builder" on a major docs overhaul). *(v2 correction: the fix is not to compute the note — fable-it v2 now owns tiering canonically via `model-tiers.md`. The fix is to **omit** it: routing to fable-it IS the economics decision. The note in the prompt library is a fossil from before fable-it codified this.)*
2. **Missing verification + output contract on ~half the prompts.** Research/plan asks end at "create a plan" with no acceptance shape and no stated destination for deliverables. prompt-it always emits both (checklist #4, #22; missing-output-schema anti-pattern).
3. **No uncertainty clause, no contradiction pass.** None of the 9 prompts tells the agent what to do when it hits ambiguity; several stack IMPORTANT/WARNING markers that Claude 4+ overtriggers on. prompt-it adds the "out" clause, normalizes emphasis to sparing use, and diffs DoD items against constraints for conflicts before emitting.

### Drop
Duplicated library entries, typos, and narrative verbosity — normalization comes free with generation. Nothing in Fernando's anatomy is actively *wrong*; the gap is consistency, and consistency is exactly what a generator provides.

---

## 3. Spec-ready brief for prompt-it

> **v2 scope correction (2026-07-21, after Fernando's overlap challenge):** the first draft of this section over-scoped prompt-it into responsibilities plan-it/fable-it/review-it already own. §3.0 records the boundary audit; §3.1–3.2 are the slimmed result. Core reframe: **prompt-it is a harness-aware intent compiler, not a mini-planner.** It extracts what lives in the *author's head* and routes it; everything discoverable from the repo, and all execution mechanics, belong to the target skill.

### 3.0 Boundary audit — what prompt-it must NOT do (owned downstream)

| Cut from prompt-it | Owner | Evidence |
|---|---|---|
| Delegation/tiering/economics note ("Claude teams, lower models, escalate…") | **fable-it** Step 3 + `references/model-tiers.md` (explicitly "no divergent copies — copies drift"); plan-it Phase 0 sets its own research method | Emitting a tiering note would recreate the boilerplate-drift defect one level up |
| Heavy codebase research fan-out to spec the task | **plan-it** Phases 3–4 (pre-ground + discovery); **fable-it** Step 2 (pre-grounding gate) | plan-it Phase 0: "Expect pointers, not content — your job is to go fetch the ground truth… one fuzzy paragraph with no pointers… is fine" |
| Binding DoD authoring / test contracts / verification protocols | **plan-it** Phase 1 (DoD lock) + Test Contract; **fable-it** Step 0 (restructure to verifiable criteria); **review-it** Steps 3/5 (oracle ladder, evidence adapter) | prompt-it supplies a DoD *sketch* with verification *targets*; locking and executing are downstream |
| Uncertainty/autonomy posture clause | **fable-it** Step 1 (autonomous posture, assumption-stating); **plan-it** gates G1/G2 | Only needed for bare targets (see harness-aware rule) |
| Output contract / report location | **fable-it** Step 8 defaults (`.fable-it-reports/`); **review-it** Step 6 (`.review-it/`) | Emit only to *override* a default |
| Long-horizon persistence contract (state files, don't-stop-early) | **fable-it** run-state contract | Never emit |
| Continuation-prompt mechanics conventions | **next-session-prompt** (kickoff note + copy-paste prompt + `/read-chat` back-ref) | Mode 2 reuses its conventions, doesn't reinvent |

**The harness-aware rule (the design center):** prompt-it carries a small responsibility map of the family. For each slot, if the routed target owns it, prompt-it **omits it**. A prompt routed to fable-it gets no tiering note, no persistence clause, no report-location boilerplate — routing *is* the economics decision. Only a **bare target** (plain Claude session, a product LLM like the bosslife ZeroClaw chat, an external tool) gets the fuller anatomy (uncertainty clause, output contract), because nothing downstream owns those there.

### 3.1 The optimized-prompt output template (slimmed)

Six slots for harness-routed prompts; ⚖ = sized by the clarity gate:

```
1. ROUTING       — skill invocation line (plan-it / fable-it / review-it / none)
2. GROUNDING ⚖   — 1–3 sentences: situation, why now (compressed narrative)
3. /goal         — one sentence, the real goal (the decision/outcome, not the literal task)
4. CONTEXT PACKAGE ⚖ — author's-head pointers, validated to exist: @file refs with one-line
                   why each, pattern-to-imitate, /read-chat session aliases, evidence URLs
5. DoD SKETCH    — numbered, individually testable items with verification TARGETS
                   (which endpoint/page/table proves it) — at the altitude plan-it Phase 1 /
                   fable-it Step 0 can lock without reinterpretation
6. SCOPE FENCES  — labeled "Out of scope / do not touch" — this is the interface fable-it
                   explicitly lifts from goal text; making it explicit is the hand-off
(+ bare-target only: uncertainty clause, output contract)
```

Formatting rules retained: goal restated at the end when long; reference material above the ask; ≤ ~10 discrete directives; sparing emphasis; no persona stuffing; contradiction-checked.

### 3.2 Mode 1 — new-session intent compiler (slimmed pipeline)

1. **Clarity gate**: already clear + scoped → minimal tighten and stop.
2. **Route**: pick the target (plan-it for fuzzy/large, fable-it for goal+DoD delivery, review-it for QA asks, bare otherwise) — this decision replaces the old "economics" slot entirely.
3. **Author-context extraction**: the one job nobody downstream can do — pull out what's in the user's head that pre-grounding can't find on disk: which prior session (`/read-chat` alias from the history ledger), which reference implementation they mean, the URLs/evidence they've seen, the fences they're assuming. Karpathy interview pattern, ≤3 grounded questions, only for what cheap lookup can't resolve.
4. **Pointer validation (cheap, not research)**: verify the @-refs exist, resolve the session alias against `.agents/history/INDEX.md`, confirm the named pattern file is real. No discovery fan-out — that's plan-it's Phase 3–4.
5. **Self-check passes**: 5-item rubric (grounded / scoped / actionable / faithful / complete-enough) + contradiction diff + ambiguity self-critique.
6. **Emit**: copyable prompt + one-paragraph "what I added and why" trail. Never silent-rewrite.

### 3.3 Mode 2 — post-review continuation optimizer (pipeline)

Template = the bosslife case, generalized:

1. **Ingest evidence**: review-it findings (report/qa files), the implementation's claimed status, evidence ledger if present. Findings are GEPA-style textual feedback — read the actual gap descriptions, not a pass/fail summary.
2. **Acknowledge-then-catch**: open by crediting what's verified working (with its evidence), then pin each gap.
3. **Class over instance**: for each gap, diagnose whether it's a point defect or an instance of a class (the "cliente" disambiguation move); prefer the mechanism-level fix, proposed from *existing* assets (name the file/module that should own it).
4. **Pareto completeness**: address every materially distinct gap review-it found — never just the top-severity one.
5. **Emit continuation prompt** with evidence citations (file:line, report paths, URLs), pointing at the *existing* test contract/DoD as the verification target, plus scope fences. Reuse `/next-session-prompt`'s conventions (copy-paste block, `/read-chat` back-reference to the review session) rather than inventing a new handoff shape. Harness-aware rule applies: the continuation usually routes back into fable-it/iterate — so no tiering, persistence, or report-location content.
6. Same self-check passes as Mode 1.

### 3.4 Family integration

- **prompt-it → plan-it / fable-it**: the ROUTING slot makes the optimized prompt open with the right skill call — fuzzy/large ideas route to plan-it, goal+DoD deliveries route to fable-it. prompt-it is the *front door of the front door*: it doesn't plan or build; it writes the prompt that invokes the planner/builder well.
- **review-it → prompt-it (Mode 2) → main thread**: after review-it reports gaps, prompt-it generates the continuation prompt the user (or conductor) feeds back to iterate. Natural chain: fable-it builds → review-it audits → prompt-it writes the next turn.
- **session-init / session-history ledger**: Mode 1's research step reads the project ledger cards first (~150 tokens) before any expensive /read-chat — same economics the family already enforces.
- **Kinship warning**: `/next-session-prompt` (existing skill) already produces session-handoff prompts. Mode 2 overlaps it partially — resolve in open decisions.

### 3.5 Skill packaging (from findings B)

Follow the family checklist: `.claude-plugin/marketplace.json` (devotts namespace) + `plugins/prompt-it/.claude-plugin/plugin.json` + `plugins/prompt-it/skills/prompt-it/SKILL.md` + root SKILL.md copy + README (300–600 lines) + CHANGELOG + LICENSE, version triple-matched. SKILL.md frontmatter: name, trigger-heavy description, version, `author: DevOtts`, `author_url`, and the DevOtts footer line. Start minimal (parallel-lifecycle-shaped); add machine.json only if the pipeline becomes stateful. Reference files (template, rubric, worked examples) under `skills/prompt-it/references/`.

### 3.5b Adopted from prompt-master (post-v2 addition, 2026-07-23 — full analysis in `research/research-findings-D3-prompt-master.md`)

nidhinjs/prompt-master (a target-tool-aware prompt generator for 30+ AI tools) independently validates our design center: its per-tool routing table is the same move as our harness-aware responsibility map — know the target, emit what it needs, omit what it handles natively. Boundary-checked adoptions:

- **Implement the responsibility map as `references/targets.md` per-target profiles** (plan-it / fable-it / review-it / iterate / bare session / product-LLM): *owns → omit*, *parses → include*, target-specific cautions (e.g. no CoT scaffolding on reasoning-native models).
- **Output contract tightened**: one copyable prompt block + `🎯 Target:` (route + why) + `💡` one-line optimization note; setup lines only if genuinely needed.
- **Final self-check adds the load-bearing audit**: every sentence load-bearing, no vague adjectives, scope bounded ("the best prompt is not the longest — every word is load-bearing").
- **Bare agentic targets get stop conditions + forbidden actions** (harness routes omit them — fable-it owns stop/permission semantics).
- **Mode 2 lists failed attempts** (from `run-memory.md` / review findings) so the next session doesn't re-propose them; restates locked decisions by *reading* `decisions.md` — prompt-it never maintains its own memory store.
- **Credential-safety line**: generated prompts never embed secrets — "requires [ENV_VAR_NAME]" style only.

Rejected (reasons in D3): the 13-template library (our 6-slot anatomy is the template), 30+ tool coverage, its Memory Block subsystem (CLAUDE.md/decisions.md/ledger own that here), signal-word maximization (contradicts Anthropic's Claude 4.x dial-back guidance), and "constraints in first 30%" (conflicts with adopted long-context placement rules).

### 3.6 Decisions — LOCKED by Fernando, 2026-07-23 (no longer open)

Resolved earlier by the boundary audit: question budget → ≤3, since discovery is plan-it's job; quick actions → cut as overengineering, the clarity gate covers the "just tighten it" case.

Locked by Fernando:
1. **Invocation surface**: explicit `/prompt-it` skill ONLY. No always-on hook in v1.
2. **Output destination**: print the optimized prompt in chat as a copyable block (paste into a fresh session). File-write / run-now may come later as flags — not v1.
3. **`/next-session-prompt` relationship**: KEEP BOTH — nsp = post-planning handoff; prompt-it = new-session compiler (Mode 1) + post-review continuation (Mode 2). Add a routing note in each skill's description; Mode 2 reuses nsp's conventions.
4. **Mode 2 trigger**: MANUAL invocation after review-it. No auto-invoke edit to review-it in v1.
5. **Version/namespace**: **0.1.0**, registered in the shared **devotts** marketplace from day one.

The brief is now fully build-ready: template §3.1, pipelines §3.2–3.3, family integration §3.4, packaging §3.5 + §3.5b (target profiles, output contract), decisions locked here.

---

## 4. Source index

- `research/research-findings-A-local-evidence.md` — Fernando's prompt anatomy + bosslife case
- `research/research-findings-B-sibling-plugins.md` — family conventions + skeleton
- `research/research-findings-C1-youtube.md`, `research/research-findings-C2-youtube.md` — 8 videos (transcripts in `research/transcripts/`)
- `research/research-findings-D1-existing-tools.md` — optimizer landscape (Anthropic improver/generator, 5 community skills, DSPy/GEPA/PromptWizard, meta-prompting, rubrics)
- `research/research-findings-D2-best-practices.md` — standards + the 24-item checklist prompt-it scores against
- `research/research-findings-D3-prompt-master.md` — nidhinjs/prompt-master adopt/reject audit (post-v2 addition)
