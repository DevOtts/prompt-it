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
1. **Boilerplate drift.** The token-aware note is pasted verbatim even where it contradicts the task ("small single-feature fix — one Sonnet builder" on a major docs overhaul). prompt-it must *compute* this note from task shape (size, risk, parallelizability) every time. This is the #1 automatable win.
2. **Missing verification + output contract on ~half the prompts.** Research/plan asks end at "create a plan" with no acceptance shape and no stated destination for deliverables. prompt-it always emits both (checklist #4, #22; missing-output-schema anti-pattern).
3. **No uncertainty clause, no contradiction pass.** None of the 9 prompts tells the agent what to do when it hits ambiguity; several stack IMPORTANT/WARNING markers that Claude 4+ overtriggers on. prompt-it adds the "out" clause, normalizes emphasis to sparing use, and diffs DoD items against constraints for conflicts before emitting.

### Drop
Duplicated library entries, typos, and narrative verbosity — normalization comes free with generation. Nothing in Fernando's anatomy is actively *wrong*; the gap is consistency, and consistency is exactly what a generator provides.

---

## 3. Spec-ready brief for prompt-it

### 3.1 The optimized-prompt output template (the "anatomy")

Nine ordered slots. Slots marked ⚖ are **sized by the clarity gate** — present only when task complexity warrants (matching structural depth to task risk; simple asks get slots 1, 3, 5, 9 only):

```
1. ROUTING     — skill invocation line (plan-it / fable-it / review-it / none)
2. GROUNDING ⚖ — 1–3 sentences: situation, why now, why it matters (compressed narrative)
3. /goal       — one sentence, the real goal (the decision/outcome, not the literal task)
4. CONTEXT PACKAGE ⚖ — pointers, not payloads: @file refs with one-line why each,
                 pattern-to-imitate, /read-chat pre-reads, read-order if it matters
5. DoD         — numbered, individually testable; EVERY item names its verification
                 mechanism (command, test, URL, screenshot-diff); binding language
6. SCOPE FENCES — labeled "Out of scope / do not touch" list, always present even if short
7. UNCERTAINTY CLAUSE — what to do on ambiguity/missing input: ask (max N grounded
                 questions) or flag [NEEDS CLARIFICATION: …] — never guess silently
8. EXECUTION & ECONOMICS ⚖ — COMPUTED per task: teams/tiering (coordinator model, subagent
                 tiers, escalate-on-struggle), and for long-horizon runs the persistence
                 contract (state files, git checkpoints, don't-stop-early permission)
9. OUTPUT CONTRACT — where deliverables land, report format, end-to-end verification step
```

Formatting rules baked in: goal near the top AND restated at the end when long; long reference material above the ask; ≤ ~10 discrete directives (consolidate or move to pointers); sparing emphasis markers; no persona stuffing; no contradictions (checked); "why" attached to instructions where it changes generalization.

### 3.2 Mode 1 — new-session optimizer (pipeline)

1. **Clarity gate** (from severity1, the strongest community precedent): if the rough prompt is already clear + scoped → minimal tighten (`[VERB] [WHAT] in [WHERE]. [CONSTRAINT].` compression) and stop. Don't over-engineer trivial asks — the #1 failure mode of existing community optimizers.
2. **Goal extraction**: identify the real goal behind the stated task (Karpathy interview pattern). If material ambiguity survives research → up to N grounded, concrete-option questions (AskUserQuestion), never open-ended "what did you mean?".
3. **Research fan-out (cheap tiers)**: haiku/sonnet subagents grep/read the codebase, docs, git history, session-history ledger (`.agents/history/`), CLAUDE.md — returning findings, not transcripts. Research fills hidden-context gaps *before* asking the human.
4. **Structure before content** (metaprompt rule): decide which ⚖ slots this task needs, then draft.
5. **Self-check passes**: (a) 5-item rubric — grounded / scoped / actionable / faithful (intent preserved, no silent scope change) / complete-enough; (b) contradiction diff across DoD + constraints; (c) ambiguity self-critique ("where is this unclear?").
6. **Emit**: the optimized prompt in a copyable block + a short "what I changed and why" trail (assumptions made, research that grounded each addition). Never silent-rewrite — auditability is the value proposition.

### 3.3 Mode 2 — post-review continuation optimizer (pipeline)

Template = the bosslife case, generalized:

1. **Ingest evidence**: review-it findings (report/qa files), the implementation's claimed status, evidence ledger if present. Findings are GEPA-style textual feedback — read the actual gap descriptions, not a pass/fail summary.
2. **Acknowledge-then-catch**: open by crediting what's verified working (with its evidence), then pin each gap.
3. **Class over instance**: for each gap, diagnose whether it's a point defect or an instance of a class (the "cliente" disambiguation move); prefer the mechanism-level fix, proposed from *existing* assets (name the file/module that should own it).
4. **Pareto completeness**: address every materially distinct gap review-it found — never just the top-severity one.
5. **Emit continuation prompt** with evidence citations (file:line, report paths, URLs), pointing at the *existing* test contract/DoD as the verification target, plus the standard slots (scope fences, uncertainty clause, output contract).
6. Same self-check passes as Mode 1.

### 3.4 Family integration

- **prompt-it → plan-it / fable-it**: the ROUTING slot makes the optimized prompt open with the right skill call — fuzzy/large ideas route to plan-it, goal+DoD deliveries route to fable-it. prompt-it is the *front door of the front door*: it doesn't plan or build; it writes the prompt that invokes the planner/builder well.
- **review-it → prompt-it (Mode 2) → main thread**: after review-it reports gaps, prompt-it generates the continuation prompt the user (or conductor) feeds back to iterate. Natural chain: fable-it builds → review-it audits → prompt-it writes the next turn.
- **session-init / session-history ledger**: Mode 1's research step reads the project ledger cards first (~150 tokens) before any expensive /read-chat — same economics the family already enforces.
- **Kinship warning**: `/next-session-prompt` (existing skill) already produces session-handoff prompts. Mode 2 overlaps it partially — resolve in open decisions.

### 3.5 Skill packaging (from findings B)

Follow the family checklist: `.claude-plugin/marketplace.json` (devotts namespace) + `plugins/prompt-it/.claude-plugin/plugin.json` + `plugins/prompt-it/skills/prompt-it/SKILL.md` + root SKILL.md copy + README (300–600 lines) + CHANGELOG + LICENSE, version triple-matched. SKILL.md frontmatter: name, trigger-heavy description, version, `author: DevOtts`, `author_url`, and the DevOtts footer line. Start minimal (parallel-lifecycle-shaped); add machine.json only if the pipeline becomes stateful. Reference files (template, rubric, worked examples) under `skills/prompt-it/references/`.

### 3.6 Open decisions for Fernando

1. **Invocation surface**: explicit `/prompt-it` skill only (recommended for v1), or also an always-on clarity-gate hook (severity1-style) that intercepts vague prompts automatically? Hook adds value but changes every session's behavior.
2. **Output destination**: print the optimized prompt for copy/paste into a fresh session (recommended — auditable, matches usage vision #1), and/or write it to a file (`NEXT-PROMPT.md`), and/or offer "run it now in this session"?
3. **Question budget**: cap grounded clarifying questions at 3 (lean) or 6 (severity1's ceiling)?
4. **`/next-session-prompt` relationship**: fold it into prompt-it Mode 2, keep both with a routing note, or have next-session-prompt call prompt-it?
5. **Mode 2 trigger**: manual invocation after review-it (recommended v1), or should review-it's report end by auto-invoking prompt-it?
6. **Quick actions** (LangSmith-style named transforms: "add acceptance criteria", "narrow scope", "add repro steps"): v1 or backlog?
7. **Version start**: 0.1.0 (alpha) or 1.0.0 — and standalone marketplace vs. devotts namespace from day one?

---

## 4. Source index

- `research/research-findings-A-local-evidence.md` — Fernando's prompt anatomy + bosslife case
- `research/research-findings-B-sibling-plugins.md` — family conventions + skeleton
- `research/research-findings-C1-youtube.md`, `research/research-findings-C2-youtube.md` — 8 videos (transcripts in `research/transcripts/`)
- `research/research-findings-D1-existing-tools.md` — optimizer landscape (Anthropic improver/generator, 5 community skills, DSPy/GEPA/PromptWizard, meta-prompting, rubrics)
- `research/research-findings-D2-best-practices.md` — standards + the 24-item checklist prompt-it scores against
