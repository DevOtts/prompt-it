# Research Findings A — Local Evidence: Fernando's Prompt Anatomy

Sources: `prompt-examples.txt` (9 prompts, ~309 lines) and `analysis-example/image-{1,2,3-prompt}.png` (the bosslife/"cliente" case). Analyzed inline by the coordinator (Fable), which read both in full.

## 1. The recurring anatomy (extracted from the 9 examples)

Nearly every effective prompt in the library shares this skeleton, in roughly this order:

1. **Library title** — `# ADD MCP TO ENGINE PLAN` style header. Not for the model; it's Fernando's prompt-library index key.
2. **Skill routing header** — first content line names the harness skill(s): `plan-it`, `fable-it`, `fable-it plan-it`. Routes the session before any content. Sometimes doubled inline later (`Let's research and plan-it`).
3. **Narrative grounding** — 1–3 sentences of situation ("This weekend we made a MAJOR refactor…", "Engine already has a lot of modules… we have ZERO visibility"). Often opens with acknowledgment of prior work ("Great job at complete the observability") — continuity + morale framing that also anchors *which* prior session this continues.
4. **`/goal` marker** — an explicit single-sentence goal, flagged with a literal `/goal` token mid-prompt. This is the strongest recurring idiom: it separates context from objective so the model can't mistake background for ask.
5. **Numbered DoD / feedback items** — individually testable items; sometimes nested (1.1, 1.2). In the strongest example (LLM EXTRACTION) the DoD is explicitly labeled "binding" with a test contract ("Test Contract 11/11 green… never faked").
6. **Context pointers, not context dumps** — `@`-refs to files/dirs (`@brain-docs/architecture/database-design.md`), URLs to third-party docs (5 MCP server docs), and "Package (read in order)" reading lists where each doc gets a one-line *why* ("hard-won context: the one client factory, the reference impl to copy…").
7. **Pre-read rituals** — `/read-chat "done-observability-beacon"`, `/read-chat --recent` before starting; names the exact session alias when known.
8. **Worked examples of desired output** — e.g. trace-naming examples (`"chat"`, `"app:pulse"`, `"automation:[name]"`); the reference implementation to copy (`trigger-draft.service.ts`).
9. **Token-aware teams note** — recurring boilerplate: split research across Claude teams, lower models for subagents, Fable coordinator escalates on struggle.
10. **Scope fences / non-goals** — "`.understand-anything` is out of this scope", "Focus only on the Fable and builder parts. We handle planning and tests in other plugins."
11. **Emphasis markers** — `WARNING:`, `IMPORTANT:`, `notes:` blocks carrying constraints and urgency ("Today is the last day I have access to Fable 5").
12. **Postmortem-as-context** — the review-it build prompt embeds a concrete failure postmortem (3 numbered problems from the airtable session) as the motivating evidence, explicitly framed "not as your fault, but an opportunity".

## 2. What makes them effective (hypotheses to test against DoD-4 standards)

- **Routing before content**: the model knows which workflow contract applies before reading the ask.
- **Goal/context separation** via `/goal` prevents the classic "model optimizes for the backstory" failure.
- **Testable DoD** converts "done" from vibes to checklist — same philosophy as fable-it's claim gate.
- **Pointers over dumps** keeps prompts short while making deep context one tool-call away (@-refs, /read-chat, read-in-order packages).
- **Reference implementations** ("mirror trigger-draft.service.ts") collapse ambiguity better than paragraphs of description.
- **Cost governance inside the prompt** (tiered teams note) — the prompt carries its own execution economics.

## 3. Observed weaknesses (candidates for prompt-it to fix automatically)

- **Boilerplate drift**: the token-aware note is copy-pasted verbatim even where it mismatches — e.g. the brain-docs refactor prompt carries "this is a small single-feature fix — one Sonnet builder" on a large docs-overhaul task. A generator must *instantiate* the note per task shape, not paste it.
- **Duplicates in the library** (BEACON FEEDBACKS ≡ Enhance Observability) — library hygiene is manual today.
- **Typos/mixed idioms** ("reasearch", "andresearch", "lasy") — harmless to LLMs mostly, but a generator normalizes for free.
- **Inconsistent success criteria**: some prompts have binding DoDs; others (MCP plan) end at "create a plan" with no acceptance shape for the plan itself.
- **No explicit output contract** in several (where should results land, what format).
- **Verbosity creep** in narrative sections that a generator could compress without losing grounding.

## 4. The bosslife/"cliente" case (analysis-example images) — the deep-thought follow-up bar

Context (images 1–2): the ZeroClaw chat agent was asked "list the clients configured for the bosslife org" and answered "No clients configured" — a plausible-looking but wrong answer rooted in term ambiguity. Image 3 is Fernando's follow-up prompt after testing, written instead of lazily accepting the prior session's green status. Its qualities:

1. **Acknowledge-then-catch**: opens "this is good, I saw this working, but… you just expose another misconception/potential bug" — credits verified progress, then pins the new defect. Keeps iteration momentum without letting the gap slide.
2. **Evidence, not anecdote**: exact chat URL + exact interaction URL + image attachments. Every claim is checkable.
3. **Entity disambiguation**: decomposes one word ("cliente") into three colliding meanings — org of `type=client` (bosslife is praxya's B2B client), a Shopify recurring *buyer* (Leila), and a Meta-ads "client config" in campaign-creator. Names the case where each interpretation is the right one.
4. **Instance → class generalization**: refuses the point-fix ("we might have so many different variables and business cases that we would change the prompt forever") and reframes as an architecture need: per-organization context injection.
5. **Mechanism grounded in existing assets**: proposes the fix in terms of things that already exist (SOUL.md/USER.md analogy from other harnesses → `@brain-docs/features/client-bible/` already developed) rather than inventing greenfield.
6. **Explicit, scoped ask**: "Before implement this… Let's think more… If necessary research benchmarks on how they solve this context problem." Think-first, research-backed — not "go fix it".

**The lazy-accept counterfactual** would have been: "the bosslife query returned nothing, fix it" — which would have produced a prompt patch and left the ambiguity class unfixed. This case is the quality bar for prompt-it Mode 2 (post-review iteration prompts): evidence-cited, ambiguity-decomposed, class-level, mechanism-proposing, explicitly scoped.

## Implications for prompt-it

- The optimized-prompt output template should encode the §1 anatomy as ordered slots: routing header → narrative grounding (compressed) → `/goal` → numbered binding DoD → context package (pointers with per-item why) → worked examples → scope fences → execution/economics note (instantiated, not boilerplate) → output contract.
- prompt-it must *compute* the token-aware note from task shape (size, risk, parallelism) — §3's boilerplate-drift is the #1 automatable fix.
- Mode 2 (post-review) should follow the bosslife structure: acknowledge verified wins → cite gap evidence (from review-it findings, with file/URL refs) → disambiguate/diagnose the class → propose mechanism from existing assets → explicit scoped ask.
- prompt-it should always emit an output contract (where deliverables land) and an acceptance shape even for research/plan asks — the two most common omissions in the library.
