# D1 — Landscape of existing prompt-optimization tools/skills

Scope: map what already exists so `prompt-it` (a Claude Code skill that turns a rough prompt
into an optimized, context-grounded prompt, in two modes — new-session interpretation and
post-review continuation) can steal proven mechanisms and avoid reinventing wheels.
Every claim below is sourced; primary docs/READMEs preferred over blog commentary.

---

## 1. Anthropic Console — Prompt Improver

- **URL:** https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/prompt-improver
- **What it does (mechanism, verified from docs, not marketing):**
  Takes an *existing* prompt template (plus two optional inputs: free-text feedback on
  what's wrong with current outputs, and example input/ideal-output pairs) and rewrites it
  in **four fixed steps**:
  1. **Example identification** — locates/extracts examples already in the template.
  2. **Initial draft** — restructures into "a structured template with clear sections and
     XML tags."
  3. **Chain-of-thought refinement** — adds/refines explicit step-by-step reasoning
     instructions.
  4. **Example enhancement** — rewrites the extracted examples so they *demonstrate* the
     new step-by-step reasoning (not just input→output, but input→reasoning→output).
- **Output template it produces:** a persona/role sentence → input variables wrapped in
  `<tag_name>{{variable}}</tag_name>` → a numbered instructions list → an explicit
  `<analysis>...</analysis>` (or similarly named) scratchpad section the model must fill
  before answering → an explicit final-answer-only instruction. Concrete before/after pair
  in the docs (Wikipedia-title classification prompt) shows the transformation literally —
  worth keeping as a canonical example.
- **Documented caveats:** explicitly *not* recommended for latency/cost-sensitive apps
  because it "creates templates that produce longer, more thorough, but slower responses."
  Explicitly positioned for "complex tasks requiring detailed reasoning" and "accuracy over
  speed" — i.e. it optimizes for correctness at the cost of verbosity, not a general-purpose
  concision improver.
- **Borrow:** the four-step mental model (extract examples → structure with tags →
  inject CoT → align examples to the new reasoning) is a clean, reusable rewrite algorithm.
  The "feedback + examples as optional inputs" pattern maps directly onto prompt-it's
  post-review mode (review findings = the "feedback," failing/passing cases = the
  "examples"). The explicit "when NOT to use this" caveat is worth mirroring — prompt-it
  should not indiscriminately bloat every prompt with CoT scaffolding.
- **Reject:** the four-step process assumes a *reusable template* fed through an API
  many times (variables, `{{double braces}}`) — that framing is for production LLM
  pipelines, not a single interactive coding-agent turn. prompt-it's target artifact is one
  prompt for one Claude Code turn, not a template library entry.

## 2. Anthropic Console — Prompt Generator (metaprompt)

- **URL:** https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/prompt-generator
- **Underlying prompt (primary source):** https://github.com/anthropics/claude-cookbooks/blob/main/misc/metaprompt.ipynb
- **What it does:** Solves the "blank page problem" — given only a *task description* (no
  existing prompt), Claude drafts a brand-new, high-quality prompt template following
  Anthropic's own prompt-engineering best practices.
- **Mechanism (from the metaprompt notebook):** the metaprompt instructs Claude to emit
  three labeled sections:
  - `<Inputs>` — identify the minimal, non-overlapping set of variables the task needs.
  - `<Instructions Structure>` — plan how the instructions should be organized before
    writing them (a structure-before-content step).
  - `<Instructions>` — the actual generated template, using `{$VARIABLE_NAME}` placeholder
    syntax.
  Key ordering rule stated verbatim: *"Input variables expected to take on lengthy values
  should come BEFORE directions on what to do with them."* Also instructs: for complex
  tasks, tell the assistant to think in a scratchpad/inner-monologue XML tag before
  answering; when scoring/evaluating, "always ask for the justification before the score."
  Six worked examples ship in the metaprompt (customer service, sentence comparison,
  document Q&A, tutoring, function calling) demonstrating the variable + XML-tag
  conventions.
- **Borrow:** the "plan structure before writing content" step is directly transferable —
  prompt-it should decide the shape of the optimized prompt (what context sections it
  needs) before drafting prose. The "long variable content before instructions" ordering
  rule and "justification before verdict" rule are good micro-heuristics for prompt-it's
  own output templates (e.g. put codebase-context findings *before* the ask, put review
  evidence *before* the verdict/next-step).
- **Reject:** built for zero-shot *template* generation for a downstream API-consumed
  prompt (variables get substituted later); prompt-it's job is closer to prompt *editing*
  (rough draft in hand) and needs concrete file paths/line numbers, not abstract variables.

## 3. anthropics/skills (official Agent Skills repo)

- **URL:** https://github.com/anthropics/skills — README: https://github.com/anthropics/skills/blob/main/README.md
- **What it is:** Anthropic's own reference implementation of the Agent Skills
  spec (agentskills.io). No first-party prompt-improvement skill was found in scope at
  time of research — the repo's skills skew toward document manipulation (DOCX/PDF/PPTX/
  XLSX), creative/dev/enterprise workflows, not meta-prompting.
- **Structural convention worth copying exactly** (this is the spec prompt-it's own
  SKILL.md should conform to):
  ```yaml
  ---
  name: my-skill-name
  description: A clear description of what this skill does and when to use it
  ---
  # My Skill Name
  [Instructions Claude follows when the skill is active]
  ## Examples
  ## Guidelines
  ```
  Repo layout: `./skills/` (examples), `./spec/` (the Agent Skills spec itself),
  `./template/` (a skill scaffold to copy from).
- **Borrow:** use `./template/` as the literal starting scaffold for prompt-it's own
  SKILL.md; keep frontmatter to exactly `name` + `description` (+ this user's required
  `author`/`author_url` fields per global CLAUDE.md) since that's the load-bearing
  contract the Claude Code harness parses.
- **Reject:** nothing to reject — there's no competing prompt-improvement design here to
  diverge from; the gap itself is the finding (no first-party "improve my prompt" skill
  exists in the public repo, which is exactly the niche prompt-it fills at the Code layer
  vs. Anthropic's Console-only tools above).

## 4. Community Claude Code skills — prompt improvers/optimizers

Five independent community projects found; all unofficial, all MIT/similar-licensed
personal repos (treat as design inspiration, not authoritative), but useful because they've
already solved the "runs inside Claude Code, not the Console" problem prompt-it also has.

### 4a. severity1/claude-code-prompt-improver
- **URL:** https://github.com/severity1/claude-code-prompt-improver
- **Mechanism:** a **hook**, not a skill invoked on demand — runs on *every* prompt
  submission via two parallel cheap classifier passes: an "improve" nudge (clarity check,
  ~189 tokens) and a "plan-mode" nudge (complexity/planning-worthiness check). Clear
  prompts pass through with *zero* skill overhead ("proceeds immediately"); vague prompts
  trigger a 4-phase escalation: (1) Research Planning — glob/grep/multi-file read farmed
  out to a cheap (Haiku) subagent; (2) Context Gathering — mine conversation history,
  run git/bash as needed; (3) Question Generation — ask 1-6 grounded multiple-choice-style
  questions via `AskUserQuestion` with concrete options drawn from the research; (4)
  Execution — proceed with clarified intent. Explicit bypass prefixes (`*` skip, `/` slash
  commands, `#` memorize) let power users opt out.
  Design principle stated directly: *"Search noise lives in cheap subagent tokens,
  decisions live in main-context tokens."*
- **Borrow — this is the single most relevant precedent for prompt-it's new-session mode.**
  The clarity-gate (proceed silently if already clear; escalate only if vague) avoids
  wasting turns "optimizing" prompts that don't need it. The subagent-for-research /
  main-thread-for-decisions token-cost split matches prompt-it's own architecture needs
  exactly (research the codebase cheaply, keep the optimized-prompt authoring in the
  primary context). The 1-6 grounded question cap with concrete options (not open-ended
  "what did you mean?") is a good UX ceiling to adopt for ambiguity that can't be resolved
  by codebase research alone.
- **Reject:** it's a silent, always-on hook that intercepts every message — prompt-it is
  explicitly invoked (a deliberate skill call), so it doesn't need the auto-trigger
  classifier layer, just the escalation logic once invoked.

### 4b. ndpvt-web/prompt-improver ("Aristotelian First Principles" mode)
- **URL:** https://github.com/ndpvt-web/prompt-improver
- **Mechanism:** 5-step workflow (gather context via questions → analyze unclear elements
  → improve using a framework → present improved version with explanation → iterate on
  feedback). Its differentiator is "Aristotelian Mode": it does NOT do first-principles
  reasoning itself — it writes instructions that direct the *target* LLM to reason from
  first principles (identify irreducible truths, question each assumption, eliminate
  non-essentials, build up deductively, verify against stated axioms). Output template
  includes explicit labeled sections: `REASONING DIRECTIVE`, `GIVEN AXIOMS`, `TASK`,
  `METHOD`, `VERIFICATION`.
- **Borrow:** the meta-level distinction — "the optimizer's job is to write instructions
  that shape *how* the executing model reasons, not to do the reasoning itself" — is a
  useful framing check for prompt-it (its output is a prompt for a future Claude Code
  turn, not the analysis itself). A lightweight `VERIFICATION`/definition-of-done section
  in prompt-it's optimized-prompt template is worth adopting generically (not the full
  Aristotelian framing, which is over-engineered for coding tasks).
- **Reject:** the "always-on Aristotelian mode" and heavy philosophical framing (AXIOMS,
  deductive verification) is unnecessary ceremony for a coding-agent prompt; most
  prompt-it targets (fix this bug, add this endpoint) don't need first-principles
  scaffolding — that's solving a different, more abstract problem than "ground this
  prompt in the actual codebase."

### 4c. Hashaam101/prompt-optimizer
- **URL:** https://github.com/Hashaam101/prompt-optimizer
- **Mechanism:** two modes — silent auto-mode (every message silently gets rewritten
  internally and executed; "the user should never see the optimized prompt separately")
  vs. explicit `/optimize {prompt}` mode (shows the rewritten prompt as copyable text,
  doesn't execute it). Five refinement strategies: decompose vagueness into enumerated
  issues, add hierarchical structure/sequencing, eliminate ambiguity by inferring success
  criteria + scope, deepen diagnostics (investigation questions before action), preserve
  original intent (don't expand/shrink scope).
- **Output template (manual mode):** problem context → categorized requirements → scope
  boundaries → expected deliverables (numbered) → constraints → a collapsible code block
  with the final copyable prompt.
- **Borrow:** the "preserve intent, don't expand/shrink scope" rule is an important
  guardrail — prompt-it must not turn a one-line ask into a multi-page spec unless the
  complexity is genuinely there. The explicit two-mode split (silent-execute vs.
  show-me-the-prompt-as-text) maps onto prompt-it's own two modes conceptually (new-session
  = show/hand off the optimized prompt; post-review = same, but seeded by review output).
  The final structured template (context → requirements → scope → deliverables →
  constraints) is a solid generic skeleton to adapt.
- **Reject:** the fully-silent auto-mode (never shows the user what changed) removes
  the auditability that makes an "optimized prompt" trustworthy — prompt-it should always
  surface what it did and why (research findings that grounded the rewrite), especially
  since its whole value proposition is bridging rough intent to codebase-grounded specifics.

### 4d. hancengiz/claude-code-prompt-coach-skill
- **URL:** https://github.com/hancengiz/claude-code-prompt-coach-skill · writeup: https://www.cengizhan.com/p/claude-code-prompt-coach-skill-to
- **What it actually does (different category — it's retrospective, not prospective):**
  analyzes a user's *past* Claude Code session logs/transcripts (token usage, cost, cache
  efficiency, prompt patterns) and scores historical prompts against prompt-engineering
  technique checklists, producing coaching recommendations. It is NOT a live rewrite-this-
  prompt-now tool.
- **Borrow:** the idea of a rubric/checklist of prompt-engineering techniques to score
  against (even if applied historically here) is transferable to prompt-it's own internal
  self-check before emitting an optimized prompt — a short checklist ("did I name concrete
  files? did I state a definition of done? did I avoid assuming unstated architecture?").
- **Reject:** the entire log-mining/historical-analytics engine is out of scope — prompt-it
  is a per-invocation tool, not an analytics dashboard.

### 4e. cristianoaredes/claude-prompt-optimizer
- **URL:** https://github.com/cristianoaredes/claude-prompt-optimizer
- **Mechanism:** a broader "control layer" plugin (15 slash commands, 9 tuning profiles,
  4 CLAUDE.md templates) built by reverse-engineering Claude Code's documented internals
  (env vars, system-prompt assembly, hook schemas) — all officially-supported knobs, no
  exploits. The one prompt-focused piece is `/sharpen`: compresses a loose/verbose prompt
  into a fixed formula `[VERB] [WHAT] in [WHERE]. [CONSTRAINT].`, shown as a before/after
  diff, not auto-executed.
- **Borrow:** the `[VERB] [WHAT] in [WHERE]. [CONSTRAINT].` compression formula is a good
  minimum-viable rewrite target for the *simple* end of prompt-it's new-session mode (when
  a prompt is already almost clear and just needs tightening, not full codebase research).
- **Reject:** the tuning-profiles/env-var-hacking surface (9 profiles, `/tune`, `/yolo`,
  `/swarm`, etc.) is an entirely different product (global Claude Code behavior tuning) —
  irrelevant scope creep for prompt-it, which should stay narrowly about one prompt at a
  time.

## 5. DSPy programmatic optimizers (MIPROv2, GEPA) — and why they mostly don't apply

- **MIPROv2 — URL:** https://dspy.ai/api/optimizers/MIPROv2/
  Mechanism: (1) bootstrap few-shot example candidates from a training set, keeping only
  ones that produced correct outputs; (2) propose instruction candidates by summarizing
  the data/program/traces; (3) Bayesian-optimization search over instruction×example
  combinations, scored on minibatches then periodically on the full validation set.
  **Requires:** a training dataset, a metric function, and many (dozens-hundreds) of
  scored trial runs.
- **GEPA — URL:** https://dspy.ai/api/optimizers/GEPA/overview/ · paper: https://arxiv.org/pdf/2507.19457
  Mechanism: reflective mutation — an LLM reads full execution traces (inputs, outputs,
  failures, error messages) in natural language (not collapsed to a scalar reward) and
  proposes targeted instruction edits; maintains a **Pareto frontier** of non-dominated
  prompt candidates instead of converging on one "best" (avoids local optima, preserves
  complementary strategies); samples next candidates from the frontier weighted by
  coverage. Claimed to beat MIPROv2 by ~13% and RL (GRPO) by ~20% with 35x fewer rollouts,
  per the paper. **Requires:** a metric function returning `(score, feedback)` per
  example, a training set (for reflective updates), optionally a separate validation set,
  and a reflection LLM. Confirmed explicitly: **GEPA is fundamentally iterative and cannot
  produce an optimized prompt from a single pass** — unsuitable for one-shot prompt
  authoring; it's built for pipelines with an eval dataset and repeated rollouts.
- **Verdict for prompt-it (explicit, not hedged):** Neither MIPROv2 nor GEPA applies
  directly. prompt-it is a *one-shot, interactive* rewrite of a single human-authored
  prompt for a single upcoming Claude Code turn — there is no training set, no repeated
  rollouts, no metric function to optimize against, and no time budget for dozens of
  trial executions. These tools optimize *programs* (DSPy modules called thousands of
  times in production) against *held-out data*; prompt-it optimizes *one utterance* against
  *this codebase, right now*.
- **What's still worth stealing (the transferable idea, not the machinery):** GEPA's core
  insight — ground the rewrite in concrete execution *evidence* (traces, failures, error
  text) rather than abstract rules — maps directly onto prompt-it's post-review mode: the
  code-review skill's findings ARE the "trace/feedback" GEPA would read, and prompt-it's
  job is the reflective-mutation step (propose a better next prompt) minus the
  optimization loop (do it once, well, using the review as ground truth). Also worth
  borrowing conceptually: "preserve diverse complementary information rather than
  collapsing to one score" → when post-review finds multiple independent gaps, don't
  silently pick one and drop the others; the optimized prompt should address all
  materially distinct gaps found, not just the highest-severity one.

## 6. Meta-prompting (OpenAI cookbook pattern)

- **URL:** https://developers.openai.com/cookbook/examples/enhance_your_prompts_with_meta_prompting · notebook: https://github.com/openai/openai-cookbook/blob/main/examples/Enhance_your_prompts_with_meta_prompting.ipynb
- **Mechanism:** simplest pattern in this whole survey. Wrap the target prompt in a
  meta-instruction and hand both to a stronger/more-reasoning-capable model:
  ```
  Improve the following prompt to generate a more detailed summary.
  Adhere to prompt engineering best practices.
  Make sure the structure is clear and intuitive and contains [specific required elements].

  {simple_prompt}

  Only return the prompt.
  ```
  The stronger model (originally o1-preview improving prompts for gpt-4o) returns a
  restructured version with explicit multi-part sections (e.g., "1. Type of News 2.
  Summary 3. Tags 4. Sentiment Analysis").
- **Borrow:** this is essentially the minimum viable version of what prompt-it does, and
  confirms the core mechanism (stronger/more-context-aware model rewrites a target prompt
  given explicit desired-elements) is a legitimate, widely-used pattern — not something
  needing programmatic optimization machinery. It also validates a "self-refining loop"
  variant (same model critiques its own prior output) as a legitimate lightweight fallback
  when no stronger model is available. The "only return the prompt" instruction is a handy
  literal line to prevent the optimizer from wrapping output in commentary.
- **Reject:** the cookbook's meta-prompt is generic/task-agnostic and has zero grounding in
  a codebase or execution context — prompt-it's differentiator vs. this baseline pattern
  MUST be the codebase-research step (missing context lookup) that plain meta-prompting
  doesn't do at all.

## 7. Microsoft PromptWizard

- **URL:** https://github.com/microsoft/PromptWizard · blog: https://www.microsoft.com/en-us/research/blog/promptwizard-the-future-of-prompt-optimization-through-feedback-driven-self-evolving-prompts/
- **Mechanism:** feedback-driven self-evolving prompts via four stages: (1) **Mutate &
  Score** — generate prompt variants from different "thinking styles," score against
  training examples; (2) **Critique & Refine** — an LLM critiques where the current best
  prompt succeeded/failed and uses that critique to refine it, iteratively; (3) **Example
  Optimization** — select/synthesize diverse, task-aware few-shot examples, using
  positive/negative performance data; (4) **Chain-of-Thought synthesis** — generate
  detailed reasoning chains for the selected examples. Three input scenarios: task
  description only (zero examples), task description + synthetic example generation, or
  task description + real training set. Final output bundles: refined instructions +
  in-context examples with reasoning chains + an expert persona + intent keywords.
- **Borrow:** the "task description only, no examples required" scenario is the most
  relevant mode for prompt-it (matches new-session mode where there's no eval set, just a
  rough ask) — confirms it's *possible* to do example-free structured optimization.
  The "expert persona + intent keywords" as explicit final-output components is a small,
  cheap addition worth keeping in prompt-it's template (a one-line framing of what kind of
  task/expertise this is, e.g. "this is a backend auth bug fix in the billing service").
- **Reject:** like DSPy, the multi-iteration mutate/score/critique/refine loop assumes a
  scorable training set and repeated trials over minutes-to-hours — not compatible with a
  single interactive invocation. Don't try to replicate the iterative scoring loop; borrow
  only the final-output shape.

## 8. LangSmith Prompt Canvas / promptfoo (tooling landscape, not agent skills)

- **Prompt Canvas — URL:** https://www.langchain.com/blog/introducing-prompt-canvas
  Mechanism: dual-panel human-in-the-loop UI — a chat panel to converse with an LLM agent
  about the prompt, and a canvas for direct text editing with inline agent feedback on
  selections. Ships built-in "quick actions" (e.g. adjust reading level/length) plus
  org-defined custom quick actions to enforce house style. Not autonomous — always a
  human approving/iterating each suggested edit.
  **Borrow:** the "quick actions" concept (small, named, one-click transform recipes) is a
  nice pattern for prompt-it to offer canned transforms (e.g. "add repro steps," "add
  acceptance criteria," "narrow scope to one file") rather than one monolithic rewrite.
  **Reject:** it's a GUI product requiring a human clicking through iterations — prompt-it
  runs inside a text-only agent turn and must produce a finished result in one pass, no UI
  loop.
- **Promptfoo — URL:** (referenced via search, CLI tool docs at promptfoo.dev)
  Mechanism: CLI-based, test-driven prompt evaluation — write test cases first, then
  compare prompt variants against them in CI/CD. This is an *evaluation* harness, not a
  rewriter.
  **Borrow:** the "tests before optimization" discipline is a good validation step prompt-
  it could recommend as a follow-up (e.g., in post-review mode, if the review skill already
  has a test contract, the optimized prompt should explicitly point at it as the
  definition of done) — but promptfoo itself is orthogonal tooling, not something prompt-it
  needs to integrate directly.

## 9. Prompt-quality rubrics / LLM-as-judge scoring

- **General findings (via search, cross-referenced against Braintrust/Evidently AI
  practitioner docs):** https://www.braintrust.dev/articles/what-is-prompt-evaluation ·
  https://www.evidentlyai.com/llm-guide/llm-as-a-judge
- **Key mechanism:** an LLM judge scores against *explicit, narrow* criteria — vague
  instructions like "rate the quality of this prompt" produce inconsistent scores because
  the judge lacks a shared definition of "quality." Multi-dimensional rubrics (commonly:
  clarity, specificity/scope, factual grounding, structure/organization) outperform a
  single holistic score. Calibration requires humans scoring 100-200 examples and checking
  agreement with the judge; poor agreement means the rubric/prompt needs sharpening, not
  the underlying task.
- **Borrow:** prompt-it should define its own narrow, explicit self-check rubric before
  emitting an optimized prompt rather than a vague "is this a good prompt?" pass — concrete
  candidate dimensions distilled from this research: (1) **grounded** — does it cite actual
  files/functions/lines found by codebase research, not assumed ones; (2) **scoped** — does
  it state what's explicitly out of scope; (3) **actionable** — does it name a concrete
  next step / definition of done; (4) **faithful** — does it preserve the user's original
  intent without silently expanding or shrinking it (echoes Hashaam101's "preserve intent"
  rule above); (5) **complete-enough** — for post-review mode, does it address every
  materially distinct gap the review found, not just the top one (echoes GEPA's Pareto
  point above). This gives prompt-it a checkable, five-item rubric instead of a vibe check.
- **Reject:** don't build a separate LLM-as-judge *call* to score prompt-it's own output —
  that's an extra round-trip with its own calibration burden for a task this narrow; the
  rubric is better used as an inline self-check the skill instructions bake in, not a
  separate judged pass.

---

## Implications for prompt-it

Ranked by expected impact on the two required modes (new-session, post-review):

1. **Adopt the clarity-gate pattern from severity1/claude-code-prompt-improver as the
   entry branch.** Before doing any research, classify: is this prompt already clear and
   scoped? If yes, do minimal tightening (borrow cristianoaredes's `[VERB] [WHAT] in
   [WHERE]. [CONSTRAINT].` compression) and skip heavy research. If vague, escalate to
   full codebase research. This prevents prompt-it from over-engineering trivial asks —
   the single biggest failure mode across the community skills reviewed (Hashaam101 and
   ndpvt-web both risk turning small asks into bloated specs).

2. **Split research (cheap subagent/tool calls) from authoring (main-context decision).**
   Directly reuse severity1's stated principle: "search noise lives in cheap subagent
   tokens, decisions live in main-context tokens." prompt-it's new-session mode should
   dispatch codebase lookups (file locations, existing patterns, relevant tests) to
   cheap exploration, then author the final optimized prompt in the primary context using
   only the *findings*, not the raw search transcript.

3. **Borrow Anthropic's four-step rewrite algorithm as the core transform, adapted for
   code tasks instead of API templates:** (a) identify what's already given/known
   (files, prior context) → (b) draft structure with clear labeled sections → (c) add an
   explicit reasoning/plan step only where the task's complexity warrants it (respect the
   Console docs' own caveat: don't add CoT scaffolding to simple/fast tasks) → (d) if
   examples or prior review findings exist, fold them in aligned to the new structure.

4. **Bake the five-item rubric (grounded / scoped / actionable / faithful / complete-
   enough) into the skill's own instructions as an inline final self-check**, rather than
   a separate LLM-judge call. This gives prompt-it a checkable definition of "optimized"
   without new infrastructure.

5. **For post-review mode specifically, treat the review skill's findings as GEPA-style
   "textual feedback"**: read the actual failure/gap descriptions (not a collapsed
   pass/fail score), and make sure the generated continuation prompt addresses every
   materially distinct gap (Pareto-style completeness), not just the most severe one.
   Explicitly point the optimized prompt at any existing test contract/DoD as the
   verification target (echoes promptfoo's "tests before optimization" discipline).

6. **Reject wholesale: DSPy MIPROv2/GEPA/PromptWizard's iterative optimization loops
   (training sets, metric functions, dozens of scored rollouts) — structurally
   inapplicable to a one-shot interactive skill.** Take only the transferable ideas listed
   above, not the machinery. Also reject: silent/opaque auto-rewrite modes (Hashaam101's
   "user never sees the optimized prompt"), heavy philosophical scaffolding
   (ndpvt-web's Aristotelian axioms), and unrelated scope creep (cristianoaredes's
   env/tuning-profile surface) — none of these serve prompt-it's narrow job.

7. **Offer a small set of named "quick actions"/transform recipes** (inspired by LangSmith
   Prompt Canvas), e.g. "narrow scope to one file," "add repro steps," "add acceptance
   criteria," as optional lightweight modifiers rather than one monolithic always-the-same
   rewrite — cheap to implement, gives users a way to nudge the output without a full
   re-invocation.

8. **Conform SKILL.md to anthropics/skills' template exactly** (frontmatter: `name`,
   `description`, plus this user's required `author`/`author_url` per global CLAUDE.md;
   body: instructions → Examples → Guidelines) so prompt-it is a well-formed Agent Skill
   from day one.
