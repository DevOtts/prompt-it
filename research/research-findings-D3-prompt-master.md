# D3 — prompt-master (nidhinjs) — post-v2 addition

Source: https://github.com/nidhinjs/prompt-master (v1.7.0, MIT) — SKILL.md + references/patterns.md (37 anti-patterns) + references/templates.md (13 templates). Reviewed 2026-07-23 at Fernando's request, filtered through the v2 boundary contract (SYNTHESIS §3.0): prompt-it is a harness-aware intent compiler; anything owned by plan-it/fable-it/review-it is out.

## What it is

A Claude skill that generates optimized prompts for **any** AI tool (Claude, GPT/o3, Cursor, Devin, Midjourney, ElevenLabs, ComfyUI…). Pipeline: detect target tool → extract 9 intent dimensions (task, input, output, constraints, context, audience, memory, success criteria, examples) → ≤3 clarifying questions → auto-select one of 13 templates (RTF, CO-STAR, RISEN, CRISPE, CoT, Few-Shot, File-Scope, ReAct+Stop-Conditions, Visual Descriptor, …) → apply 5 bounded techniques → token-efficiency audit → emit ONE copyable prompt block + `🎯 Target` + `💡` one-line note. North star: "User pastes prompt into target tool. It works on first try. Zero re-prompts. That is the only measure." Motto: "The best prompt is not the longest. It's the one where every word is load-bearing."

Its per-target routing rules are the interesting mechanism: Claude gets XML tags + literal-instruction framing; reasoning-native models (o3, R1) get SHORT prompts and **never** CoT scaffolding ("actively degrades output"); agentic tools get starting state + target state + file scope + **mandatory stop conditions** ("runaway loops are the biggest credit killer") + forbidden actions + human-review triggers for destructive ops.

## Structural insight: it independently validates our design center

prompt-master's tool-routing table is the same idea as our harness-aware responsibility map, pointed at a different axis: **know your target, emit only what the target needs, omit what the target handles itself** (e.g. no CoT for o3 because reasoning is native ≙ no tiering note for fable-it because delegation is native). This is convergent evidence that "target profiles" is the right implementation shape — prompt-it's map should live as a per-target profile reference file (`references/targets.md`): for each target (plan-it, fable-it, review-it, iterate, bare-Claude-session, product-LLM), *what it owns → omit* and *what it parses → include*.

## Adopt (7 items, boundary-checked)

1. **Target-profile reference file** as the implementation of the responsibility map (above). Extensible later to product-LLM targets (the bosslife/ZeroClaw case) without touching the core skill.
2. **Strict output contract**: one copyable prompt block, then `🎯 Target:` (the route + why) and `💡` one-line optimization note; setup lines only if genuinely needed. Cleaner than the v2 draft's "prompt + trail paragraph" — the audit trail collapses to one labeled line unless the user asks.
3. **Load-bearing audit** as the final self-check pass: every sentence load-bearing, no vague adjectives, format explicit, scope bounded. Complements (not replaces) our 5-item rubric; same philosophy as the compact-beats-thick A/B evidence in C1.
4. **Stop conditions + forbidden actions for BARE agentic targets only.** For harness routes fable-it owns stop/permission semantics (autonomy posture, state-change gate) — omitted per the boundary contract. For bare targets (a plain session, an external agent tool) prompt-it emits them, because nothing downstream will.
5. **"Disclose failed attempts"** (patterns.md context rule) → Mode 2: the continuation prompt lists what was already tried, pulled from the run's `run-memory.md` / review findings — prevents the next session re-proposing failed approaches. Natural extension of the GEPA evidence-grounding idea already in D1.
6. **Credential-safety rule for generated prompts**: never embed keys/tokens; write "requires [ENV_VAR_NAME]" / "assumes [service] authenticated". Complements review-it's runtime credential boundaries at the authoring layer; one line, zero cost.
7. **Reasoning-model caveat sharpened**: never add CoT/"think step by step" scaffolding to reasoning-native targets. Our D1 had the Console-improver caveat (don't bloat simple tasks with CoT); prompt-master states the model-class rule explicitly — worth one line in the target profiles.

Also validated (already decided, no change): ≤3 clarifying questions cap (identical rule); template depth matched to task type (our clarity-gate sizing).

## Reject (with reasons)

- **The 13-template library** (RTF/CO-STAR/RISEN/CRISPE…): generic consumer frameworks. Our 6-slot anatomy IS the template, derived from Fernando's own field-tested prompts + the D2 standards; maintaining 13 parallel skeletons is the over-templating failure mode D1 warned about.
- **30+ tool coverage** (image/video/audio/no-code): scope creep; prompt-it targets the coding harness + bare sessions. The target-profile file keeps the door open without buying the surface now.
- **Its Memory Block system** (skill maintains stack/decision memory across sessions): owned in our harness by CLAUDE.md, `decisions.md`, and the session-history ledger. prompt-it *reads* those (Mode 2 restates locked decisions from `decisions.md` — the useful half of the idea) but never maintains its own memory store.
- **Signal-word maximization** ("MUST over should; NEVER over avoid"): directly contradicts Anthropic's Claude 4.x guidance already adopted in D2 ("dial back aggressive language — newer models overtrigger"). Follow Anthropic for Claude targets; this is prompt-master being target-generic where we can be target-correct.
- **"Constraints in first 30%"** as a hard rule: conflicts with the long-context placement rule (reference material first, ask restated at the end) from Anthropic/GPT-4.1 docs. Keep our placement rules.

## Implications for prompt-it

The single biggest takeaway is architectural confirmation plus one concrete artifact: implement the responsibility map as `references/targets.md` per-target profiles (owns→omit / parses→include / target-specific cautions), and tighten the output contract to prompt-master's single-block + two-labeled-lines shape. Everything else adopted is a one-line rule folded into existing sections — no new subsystems, no new scope.
