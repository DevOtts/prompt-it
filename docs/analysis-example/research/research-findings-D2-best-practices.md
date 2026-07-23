# D2 — Current (2025–2026) Standards for Writing Prompts for Agentic Coding Models

Research pass for **prompt-it**: a Claude Code skill that turns a rough user prompt into an
optimized, context-grounded task prompt (goal + numbered Definition of Done + context pointers +
scope fences). This document gathers primary-source standards, organized by source, then distills
a testable checklist a prompt optimizer could score against.

---

## 1. Anthropic — Prompt engineering overview

Source: https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview
(canonical redirect: https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/overview)

- Prompt engineering is scoped to problems with **a clear definition of success criteria** and
  **some way to empirically test against those criteria** — the guide explicitly assumes you
  have both before you start, plus "a first draft prompt you want to improve." If you don't have
  success criteria or evals yet, the guide directs you to establish those first
  ("Define success criteria and build evaluations").
- Not every failing eval is a prompt-engineering problem — sometimes model/latency/cost choices
  matter more.
- Points to "Prompting best practices" (Claude 4.x / current models) as the living technique
  reference: clarity/examples, XML structuring, role prompting, thinking, prompt chaining.
- Also references a public blog post, "best practices for prompt engineering"
  (https://claude.com/blog/best-practices-for-prompt-engineering, published 2025-11-10 per its
  own byline) — see §6 below.

## 2. Anthropic — Claude 4.x / Claude 5-era "Prompting best practices" (the master reference)

Source: https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices
(canonical: https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices)

This is the single richest primary source found and covers general principles, output/formatting,
tool use, thinking, and agentic systems — all directly relevant to prompt-it.

**General principles**
- *Be clear and direct*: "Claude responds well to clear, explicit instructions... If you want
  'above and beyond' behavior, explicitly request it rather than relying on the model to infer
  this from vague prompts." **Golden rule**: "Show your prompt to a colleague with minimal
  context on the task and ask them to follow it. If they'd be confused, Claude will be too."
  Use numbered lists/bullets when order or completeness of steps matters.
- *Add context to improve performance*: explain **why** an instruction matters ("Your response
  will be read aloud by a text-to-speech engine, so never use ellipses...") — "Claude is smart
  enough to generalize from the explanation."
- *Use examples effectively*: 3–5 examples, each **relevant** (mirrors the real use case),
  **diverse** (covers edge cases, doesn't leak unintended patterns), **structured** (wrapped in
  `<example>`/`<examples>` tags distinct from instructions).
- *Structure prompts with XML tags*: wrap distinct content types (`<instructions>`, `<context>`,
  `<input>`) in their own tags to reduce misinterpretation; nest tags when content has a natural
  hierarchy; use consistent, descriptive tag names.
- *Give Claude a role*: even one sentence in the system prompt focuses tone/behavior.
- *Long context prompting* (20k+ tokens): put longform data **at the top**, query/instructions
  **at the end** — "Queries at the end can improve response quality by up to 30 percent in tests,
  especially with complex, multidocument inputs." Wrap each document in `<document>` /
  `<document_content>` / `<source>` tags. For grounding, ask Claude to quote relevant passages
  into `<quotes>` before answering.

**Tool use**
- Claude 4.x models are trained for **precise, literal instruction following** — "Can you suggest
  some changes" gets suggestions, not edits; be explicit ("Change this function...") when action
  is wanted.
- *Parallel tool calling* is steerable via an explicit `<use_parallel_tool_calls>` block:
  "If you intend to call multiple tools and there are no dependencies between the tool calls,
  make all of the independent tool calls in parallel... Never use placeholders or guess missing
  parameters in tool calls." (Note: this exact phrasing is echoed verbatim in the harness's own
  system context.)
- Dial back aggressive language ("CRITICAL: You MUST...") on newer models — they overtrigger;
  normal phrasing ("Use this tool when...") suffices.

**Thinking and reasoning**
- Prefer **general instructions over prescriptive steps** for reasoning: "A prompt like 'think
  thoroughly' often produces better reasoning than a hand-written step-by-step plan."
- Ask Claude to **self-check**: "Before you finish, verify your answer against [test criteria]."
- Multishot examples can embed `<thinking>` tags to demonstrate the reasoning pattern.

**Agentic systems — long-horizon reasoning and state tracking** (most relevant section for
prompt-it, since fable-it-style runs are exactly this workload):
- Claude "maintains orientation across extended sessions by focusing on incremental progress,
  making steady advances on a few things at a time rather than attempting everything at once."
- *Context-awareness / token budget*: tell the agent explicitly how compaction works so it
  doesn't prematurely wrap up: "Your context window will be automatically compacted as it
  approaches its limit... do not stop tasks early due to token budget concerns... save your
  current progress and state to memory before the context window refreshes."
- *Workflows across multiple context windows* — concrete, numbered guidance:
  1. Use a different prompt for the first window (set up framework/tests/setup scripts) vs.
     later windows (iterate on a todo-list).
  2. Have the model **write tests in a structured format** (e.g. `tests.json`) up front, and
     forbid deleting/editing them to "fix" failures: "It is unacceptable to remove or edit tests
     because this could lead to missing or buggy functionality."
  3. Set up quality-of-life scripts (`init.sh`) so a fresh context window doesn't repeat setup.
  4. Prefer **starting fresh** over compaction when possible, and be prescriptive about how a
     fresh window should re-orient: "Call pwd; you can only read and write files in this
     directory." / "Review progress.txt, tests.json, and the git logs." / "Manually run through a
     fundamental integration test before moving on to implementing new features."
  5. Provide **verification tools** (Playwright/computer-use) so the agent can check correctness
     without a human in the loop.
  6. Encourage full context utilization but with an explicit save-state safeguard: "just make
     sure you don't run out of context with significant uncommitted work."
- *State management*: structured formats (JSON) for status/test data; unstructured freeform notes
  for progress; **use git** as the state/checkpoint log — "Claude's latest models perform
  especially well in using git to track state across multiple sessions."
- *Balancing autonomy and safety*: name the exact classes of actions that need confirmation —
  destructive ops (delete files/branches, `rm -rf`, drop tables), hard-to-reverse ops
  (`git push --force`, `git reset --hard`, amending published commits), and ops visible to others
  (pushing code, commenting on PRs, messaging, shared infra). Explicitly forbid using destructive
  shortcuts to route around obstacles ("don't bypass safety checks (e.g. `--no-verify`)").
- *Subagent orchestration*: models delegate to subagents proactively; if overused, give explicit
  criteria: "Use subagents when tasks can run in parallel, require isolated context, or involve
  independent workstreams that don't need to share state. For simple tasks... work directly."
- *Reduce file creation / avoid overengineering*: an explicit scope-fence block is given verbatim
  — "Don't add features, refactor code, or make 'improvements' beyond what was asked... Don't add
  docstrings, comments, or type annotations to code you didn't change... Don't create helpers,
  utilities, or abstractions for one-time operations." This is a direct, quotable anti-scope-creep
  clause prompt-it should be able to emit.
- *Avoid focusing on passing tests / hardcoding*: "Implement a solution that works correctly for
  all valid inputs, not just the test cases... If the task is unreasonable or infeasible, or if
  any of the tests are incorrect, please inform me rather than working around them." — i.e., the
  DoD should invite the agent to flag DoD problems rather than silently game them.
- *Minimizing hallucination in agentic coding*: "Never speculate about code you have not opened.
  If the user references a specific file, you MUST read the file before answering."

## 3. Anthropic engineering blog — "Effective context engineering for AI agents"

Source: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents

- Defines the field: prompt engineering is "writing and organizing LLM instructions for optimal
  outcomes"; context engineering is "the set of strategies for curating and maintaining the
  optimal set of tokens during LLM inference," covering system prompt, tools, MCP, external data,
  and message history — "the entire context state."
- **"Right altitude" for system prompts**: avoid two failure modes — too specific ("hardcoding
  complex, brittle logic," fragile to maintain) and too vague ("fails to give the LLM concrete
  signals for desired outputs"). Aim for "specific enough to guide behavior effectively, yet
  flexible enough to provide the model with strong heuristics." Start minimal, test with a capable
  model, add instructions only in response to observed failures.
- **Tool design**: tools should be "self-contained, robust to error, and extremely clear with
  respect to their intended use." Heuristic: "If a human engineer can't definitively say which
  tool should be used, [an] agent can't be expected to do better." Keep a "minimal viable set of
  tools" rather than a bloated one — this both improves reliability and eases context maintenance
  over long interactions.
- **Just-in-time context retrieval**: prefer lightweight identifiers (file paths, stored queries,
  links) that let the agent "dynamically load data into context at runtime" over pre-loading
  everything, enabling **progressive disclosure** — "allows agents to incrementally discover
  relevant context through exploration." A hybrid (retrieve some up front for speed, explore
  further at the agent's discretion) is often optimal.
- **Compaction**: summarize a near-full conversation and reinitiate with the summary; the art is
  "selection of what to keep versus what to discard" — start with high recall, then trim
  redundant already-processed content (e.g. stale tool results).
- **Structured note-taking**: persist notes to memory outside the context window (progress files,
  task lists) for "persistent memory with minimal overhead."
- **Sub-agent architectures**: specialized subagents handle focused tasks in clean context
  windows; each "returns only a condensed, distilled summary of its work (often 1,000-2,000
  tokens)," achieving clear separation of concerns.
- **Unifying principle**: find "the smallest set of high-signal tokens that maximize the
  likelihood of some desired outcome."

## 4. Anthropic engineering blog — "Writing effective tools for agents — with agents"

Source: https://www.anthropic.com/engineering/writing-tools-for-agents (published 2025-09-11)

- "More tools don't always lead to better outcomes" — choose high-leverage tools that meaningfully
  expand capability (e.g. `search_contacts` over `list_contacts`) rather than thin 1:1 API wrappers.
  Consolidate multi-step operations into one tool call to save token budget.
- **Namespacing**: group tools by service/resource (`asana_projects_search`) to prevent agent
  confusion; prefix vs. suffix namespacing measurably affects performance.
- **Return meaningful, high-signal context**: strip technical IDs (UUIDs, MIME types) in favor of
  semantic language; expose a `response_format` enum (`"concise"` / `"detailed"`) so the agent
  can choose granularity.
- **Token efficiency**: pagination, range selection, filtering, truncation with sensible defaults;
  truncated responses should include steering guidance toward more targeted follow-up queries;
  errors should give "specific and actionable improvements," not opaque codes.
- **Prompt-engineer the tool description itself**: write it "as if describing your tool to a new
  hire on your team" — make implicit context (query syntax, terminology, resource relationships)
  explicit; use unambiguous parameter names (`user_id` not `user`).
- **Evaluation**: build realistic multi-tool-call eval tasks with verifiable outcomes; inspect
  reasoning traces for tool-call redundancy; "simply concatenate the transcripts from your
  evaluation agents and paste them into Claude Code" to iterate on tool quality systematically.
- Relevance to prompt-it: the same discipline (name things unambiguously, return only high-signal
  content, make constraints explicit rather than implicit) applies to how prompt-it should phrase
  its "context pointers" section — point at specific files/globs, not vague areas.

## 5. Anthropic — Claude Code best practices (product docs)

Source: https://code.claude.com/docs/en/best-practices

This is the most operationally relevant source for prompt-it, since it directly documents how to
write good task prompts for Claude Code sessions.

- **Core constraint**: "Claude's context window fills up fast, and performance degrades as it
  fills... this matters since LLM performance degrades as context fills." Most other advice
  follows from managing this constraint.
- **Give Claude a way to verify its work** — arguably the single most load-bearing practice:
  "Claude stops when the work looks done. Without a check it can run, 'looks done' is the only
  signal available, and you become the verification loop." A verification check (tests, build,
  screenshot diff, linter) closes the loop autonomously. Concrete before/after table:
  - Before: *"implement a function that validates email addresses"*
  - After: *"write a validateEmail function. example test cases: user@example.com is true,
    invalid is false, user@.com is false. run the tests after implementing"*
  - Before: *"make the dashboard look better"*
  - After: *"[paste screenshot] implement this design. take a screenshot of the result and
    compare it to the original. list differences and fix them"*
  - Before: *"the build is failing"*
  - After: *"the build fails with this error: [paste error]. fix it and verify the build
    succeeds. address the root cause, don't suppress the error"*
  - "Have Claude show evidence rather than asserting success: the test output, the command it ran
    and what it returned, or a screenshot of the result."
- **Explore, then plan, then code, then commit** — a four-phase workflow. "Letting Claude jump
  straight to coding can produce code that solves the wrong problem." Planning is most valuable
  "when you're uncertain about the approach, when the change modifies multiple files, or when
  you're unfamiliar with the code being modified. If you could describe the diff in one sentence,
  skip the plan."
- **Provide specific context in prompts** — "Claude can infer intent, but it can't read your
  mind." Four concrete strategies with before/after pairs:
  - *Scope the task* (name the file, the scenario, testing preferences).
  - *Point to sources* ("look through ExecutionFactory's git history and summarize...").
  - *Reference existing patterns* ("look at how existing widgets are implemented... HotDogWidget.php
    is a good example. follow the pattern... build from scratch without libraries other than the
    ones already used in the codebase").
  - *Describe the symptom* ("users report that login fails after session timeout. check the auth
    flow in src/auth/... write a failing test that reproduces the issue, then fix it").
  - Notably: "Vague prompts can be useful when you're exploring and can afford to course-correct" —
    the guide does not claim maximal specificity is always right; it's contingent on whether
    the task is exploratory or execution-scoped.
- **CLAUDE.md guidance** (directly reusable for prompt-it's "context pointers" idea):
  - Keep it **short and human-readable**; "keep CLAUDE.md small."
  - Litmus test per line: *"Would removing this cause Claude to make mistakes?"* If not, cut it.
  - "Bloated CLAUDE.md files cause Claude to ignore your actual instructions!"
  - Include/exclude table: include bash commands Claude can't guess, non-default code style,
    testing instructions, repo etiquette, project-specific architectural decisions, environment
    quirks, non-obvious gotchas. Exclude anything inferable from code, standard conventions, API
    docs (link instead), frequently-changing info, long tutorials, file-by-file descriptions,
    self-evident practices ("write clean code").
  - Emphasis markers ("IMPORTANT", "YOU MUST") can be used sparingly to improve adherence.
- **Course-correct early and often**; if corrected on the same issue twice, `/clear` and rewrite a
  better initial prompt rather than continuing to patch — "A clean session with a better prompt
  almost always outperforms a long session with accumulated corrections."
- **Common failure patterns** (explicit named anti-patterns):
  - *The kitchen-sink session* — mixing unrelated tasks pollutes context. Fix: `/clear` between
    tasks.
  - *Correcting over and over* — context fills with failed approaches. Fix: `/clear` + rewrite.
  - *The over-specified CLAUDE.md* — important rules get lost in noise. Fix: ruthlessly prune.
  - *The trust-then-verify gap* — plausible-looking output that doesn't handle edge cases. Fix:
    always provide verification; "if you can't verify it, don't ship it."
  - *The infinite exploration* — an unscoped "investigate X" burns context reading hundreds of
    files. Fix: scope investigations narrowly or delegate to subagents.
- **Spec quality for larger features**: "The most useful specs are self-contained: they name the
  files and interfaces involved, state what is out of scope, and end with an end-to-end
  verification step that proves the feature works." This sentence is close to a direct spec for
  what prompt-it should output (goal, scope fences, DoD, verification step).
- **Adversarial review step**: before treating work as done, "have a subagent review the diff in a
  fresh context and report gaps," scoped to correctness/requirements only — "Tell the reviewer to
  flag only gaps that affect correctness or the stated requirements, and treat the rest as
  optional," to avoid over-engineering churn from a reviewer that over-reports.

## 6. Anthropic blog — "Best practices for prompt engineering" (2025-11-10)

Source: https://claude.com/blog/best-practices-for-prompt-engineering

Core techniques: be explicit and clear (lead with direct action verbs, skip preambles, state
output expectations); provide context/motivation behind requests; be specific (constraints,
audience, structure); use examples (one-/few-shot, start with a single example before expanding);
**give permission to express uncertainty** — "explicitly allow models to acknowledge limitations"
to reduce hallucination. Advanced: prefill, chain-of-thought, format control ("tell the AI what
TO do rather than what NOT to do"), prompt chaining.

Anti-patterns named directly: **"Don't over-engineer"** — longer prompts aren't inherently better;
don't skip the basics chasing advanced techniques; don't assume the model reads minds; don't stack
every technique at once; don't skip iteration/testing; don't over-rely on outdated techniques
(heavy XML tags, role-playing) where simpler direct instruction now suffices for capable models.

## 7. OpenAI — GPT-4.1 Prompting Guide

Source: https://developers.openai.com/cookbook/examples/gpt4-1_prompting_guide (also mirrored on
GitHub: https://github.com/openai/openai-cookbook/blob/main/examples/gpt4-1_prompting_guide.ipynb)

- **Three canonical agentic system-prompt reminders**, reported to raise internal SWE-bench score
  by ~20%:
  1. *Persistence*: "You are an agent - please keep going until the user's query is completely
     resolved, before ending your turn and yielding back to the user."
  2. *Tool-calling*: "If you are not sure about file content or codebase structure pertaining to
     the user's request, use your tools to read files and gather the relevant information: do NOT
     guess or make up an answer."
  3. *Planning* (optional): "You MUST plan extensively before each function call, and reflect
     extensively on the outcomes of the previous function calls."
- **Instruction-following literalism**: GPT-4.1 "follows instructions more literally than
  predecessors and doesn't as strongly infer unstated intent" — a single clarifying sentence
  materially changes behavior. **When instructions conflict, the model favors whichever appears
  later in the prompt** — a direct, actionable ordering rule for prompt-it: don't bury the
  authoritative instruction above a looser one.
- **Long-context placement**: put instructions at **both the start and end** of a long context
  block; if only once, place above the context, not below.
- **Tool definition**: use the API's structured `tools` field, not inline prompt text; for complex
  tools, put worked examples in an `# Examples` system-prompt section rather than in the tool
  description itself.
- **Diff format** ("V4A"): context-based identification instead of line numbers, explicit old/new
  delimiters, optional `@@` markers for disambiguation — relevant if prompt-it or its consumer
  agent emits diffs.

## 8. OpenAI — GPT-5 Prompting Guide

Source: https://developers.openai.com/cookbook/examples/gpt-5/gpt-5_prompting_guide

- **`reasoning_effort`**: default `medium`; scale up for complex multi-step tasks ("we recommend
  higher reasoning to ensure the best possible outputs"); minimal effort needs more explicit,
  GPT-4.1-style prompting to compensate.
- **Tool preambles**: model is trained to restate the goal, output a structured plan, and narrate
  progress before/during tool calls — "Always begin by rephrasing the user's goal in a friendly,
  clear, and concise manner, before calling any tools" then "outline a structured plan detailing
  each logical step you'll follow."
- **Controlling agentic eagerness** — a two-directional dial relevant to prompt-it's scope fences:
  - *Less eagerness* (tighter scope): lower `reasoning_effort`; "define clear criteria in your
    prompt for how you want the model to explore the problem space"; set a fixed tool-call budget
    ("maximum of 2 tool calls"); give explicit escape hatches for proceeding under uncertainty.
  - *More eagerness* (more autonomy): raise `reasoning_effort`; "Never stop or hand back to the
    user when you encounter uncertainty"; "Do not ask the human to confirm or clarify assumptions,
    as you can always adjust later."
- **Self-reflection / rubric technique** (zero-to-one app generation): "spend time thinking of a
  rubric until you are confident"; "create a rubric that has 5-7 categories"; "use the rubric to
  internally think and iterate on the best possible solution" before finalizing — i.e., have the
  model author its own acceptance criteria when none are given, then grade its own output against
  them.
- **Instruction-following precision and the cost of contradictions**: GPT-5 follows instructions
  with "surgical precision," which means **"poorly-constructed prompts containing contradictory or
  vague instructions can be more damaging to GPT-5"** than to looser models — it burns reasoning
  tokens trying to reconcile contradictions rather than picking one arbitrarily. Guidance:
  "thoroughly review [prompts] for poorly-worded instructions" and resolve instruction-hierarchy
  conflicts explicitly rather than leaving them latent.

## 9. Lance Martin (LangChain) — "Context Engineering for Agents"

Source: https://rlancemartin.github.io/2025/06/23/context_engineering/

- Frames context engineering as "the delicate art and science of filling the context window with
  just the right information for the next step" (crediting Karpathy's framing of the context
  window as the model's RAM).
- **Four-strategy taxonomy** applicable to how prompt-it structures context pointers:
  1. **Write** — persist information outside the window (scratchpads, cross-session memories) for
     later retrieval instead of cramming everything into one prompt.
  2. **Select** — pull only relevant material in; RAG over tool descriptions alone reportedly
     improves selection accuracy up to 3x; keep a narrow "always-on" procedural file (his example:
     `CLAUDE.md`) rather than a sprawling one.
  3. **Compress** — retain only essential tokens (summarization, trimming) — same idea as
     Anthropic's compaction guidance from a different vendor's lens.
  4. **Isolate** — split context across subagents/sandboxes/state objects so each component only
     sees what it needs.
- Quotes Cognition calling context engineering "effectively the #1 job of engineers building AI
  agents," and frames the risk as **context poisoning, distraction, confusion, and clash** —
  useful vocabulary for prompt-it's anti-pattern checks (e.g. "clash" = contradictory instructions
  within one prompt, directly matching the GPT-5 and Claude 4 contradiction guidance above).

## 10. Manus — "Context Engineering for AI Agents: Lessons from Building Manus"

Source: https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus
(also: https://medium.com/@peakji/context-engineering-for-ai-agents-lessons-from-building-manus-71883f0a67f2)

- Frames context engineering as an architectural, economic constraint, not just a quality knob:
  "the single most important metric for a production agent is its KV-cache hit rate" — even a
  single-token difference (e.g. a timestamp in the system prompt) invalidates the cache
  downstream, so **keep prompt prefixes stable/deterministic** (no live timestamps at the top of
  a reusable prompt template).
- **Leave failed actions/observations visible in context** rather than silently erasing them —
  seeing its own mistake helps the model avoid repeating it; don't sanitize the trace to look
  clean.
- **Introduce small variation** in serialization/phrasing to avoid the model getting stuck
  imitating a rigid repeated pattern (relevant if prompt-it's own output templates get reused
  verbatim across many tasks).

## 11. GitHub Spec Kit — Spec-Driven Development methodology

Source: https://github.com/github/spec-kit/blob/main/spec-driven.md

- Four-phase pipeline: **Specify → Plan → Tasks → Implement**. Specify turns a natural-language
  ask into a PRD-like spec through iterative dialogue ("Specifications as the Lingua Franca");
  Plan maps requirements to technical decisions with documented rationale; Tasks converts the plan
  into an executable, parallelizable task list; Implement generates code from the now-stable spec,
  with production incidents feeding back into future spec revisions.
- **Definition-of-Done is embedded as a machine-checkable gate**, not prose:
  - *Requirement completeness checklist*: "No [NEEDS CLARIFICATION] markers remain," every
    requirement is "testable and unambiguous," and "success criteria are measurable."
  - *Constitutional gates*: pre-implementation checks for Simplicity / Anti-Abstraction /
    Integration-First before the agent is allowed to proceed.
  - *Test-first mandate*: "No implementation code shall be written before: 1. Unit tests are
    written 2. Tests are validated and approved by the user 3. Tests are confirmed to FAIL" —
    i.e. red-before-green is a hard gate, not a suggestion.
- **Abstraction discipline for specs**: capture "WHAT users need and WHY," explicitly excluding
  tech-stack/implementation decisions from the feature spec itself (those belong in Plan).
- **Explicit uncertainty markers**: use a literal `[NEEDS CLARIFICATION: specific question]` token
  instead of silently assuming an answer to an ambiguous requirement — a directly reusable pattern
  for prompt-it when the source prompt under-specifies something.
- Keep plans "high-level and readable," pushing code samples/detailed algorithms into separate
  files rather than bloating the plan doc.

## 12. Documented anti-patterns (cross-source synthesis)

Source: https://www.digitalapplied.com/blog/prompt-engineering-anti-patterns-10-mistakes-2026
(secondary source, but a clean checklist worth recording; cross-checked against the primary
sources above where overlapping)

1. **Few-shot pollution** — examples that contradict the stated instructions; models follow the
   demonstrated pattern over the stated rule (matches Anthropic's "examples...diverse...avoid
   unintended patterns" guidance and the classic stale-example anti-pattern named in the task).
2. **Instruction stacking** — each new rule erodes the last; attention degrades past roughly 8–10
   distinct directives in one prompt.
3. **Format-via-example only** — output structure shown only through examples, not an explicit
   schema, causing brittleness on unfamiliar inputs.
4. **Persona stuffing** — an elaborate persona ("world-renowned expert who only speaks in
   technical jargon...") adds stylistic noise that degrades instruction-following on technical
   work; simpler role statements outperform maximal ones (also flagged independently as an
   anti-pattern by other 2026 guides surfaced in search).
5. **Over-correction** — tightening a constraint so hard in response to one bad output that ten
   subsequent reasonable outputs get strangled too (mirrors Anthropic's own migration note: "dial
   back aggressive language... these models may now overtrigger").
6. **Missing output schema** — format implied, never stated, leaving downstream parsing dependent
   on undocumented behavior.
7. **Ungrounded chain-of-thought** — a reasoning trace invented without anchoring in the actual
   task/codebase (mirrors Anthropic's "never speculate about code you have not opened" guidance).
8. **Prompt-response coupling** — downstream code parses specific model phrasing instead of a
   validated schema field, breaking on any wording drift.
9. **Eval-blind iteration** — hand-tuning prompts without structured measurement causes silent
   regressions.
10. **Silent model/version drift** — prompts have no instrumentation to detect behavior changes
    when the underlying model version changes.

Also independently documented (from the anti-pattern search): vague top-level instructions like
"be helpful" are too weak for production agents — replace with concrete, falsifiable rules ("never
invent missing tool arguments," "do not take account actions without verified identifiers"); and
most system prompts "define the role but skip the constraints," leaving the agent knowing what it
is but not what it can't do, causing unscoped improvisation.

---

## Standards checklist

A numbered, testable rubric a prompt optimizer (prompt-it) could score a candidate task prompt
against. Each item names its supporting source(s).

1. **States a single, unambiguous goal in the first line or two**, not buried in preamble.
   [Anthropic §2 "be clear and direct"; Claude Code §5 "provide specific context"]
2. **Passes the "confused colleague" test** — a person with minimal context on the task could
   follow it without asking a clarifying question. [Anthropic §2, "golden rule"]
3. **Includes a numbered, testable Definition of Done** (not prose bullets) — each item is
   independently checkable pass/fail. [Claude Code §5 verification table; Spec Kit §11
   "measurable success criteria"]
4. **At least one DoD item names a concrete verification mechanism** — a test command, build
   step, screenshot-diff, or specific example inputs/outputs — rather than relying on "looks
   done." [Claude Code §5 — "Give Claude a way to verify its work"]
5. **Names specific files/paths/patterns to touch or read**, not vague area references ("the
   auth stuff") — uses `@file` pointers or explicit globs where possible. [Claude Code §5 "Point
   to sources", "Scope the task"]
6. **Points to an existing pattern to imitate** when one exists in the codebase, named explicitly
   (e.g. "follow the pattern in X.ts"). [Claude Code §5 "Reference existing patterns"]
7. **Contains an explicit scope fence — what is out of scope / must not change** — not just what
   to build. [Claude Code §5 "self-contained specs... state what is out of scope"; Anthropic §2
   overengineering block]
8. **Contains no internally contradictory instructions**; where two constraints could conflict,
   the prompt resolves which wins rather than leaving it implicit — because both Claude and GPT-5
   spend disproportionate effort (or fail outright) reconciling silent contradictions.
   [Anthropic §2 "dial back aggressive language"; OpenAI GPT-5 §8 "surgical precision... more
   damaging"; GPT-4.1 §7 "later instruction wins" ordering rule]
9. **States context/motivation ("why"), not just the instruction**, wherever the "why" would
   change how the agent generalizes to edge cases. [Anthropic §2 "add context to improve
   performance"]
10. **Uses structured tags/sections for distinct content types** (goal vs. context vs. DoD vs.
    constraints) rather than one undifferentiated wall of text. [Anthropic §2 "structure prompts
    with XML tags"]
11. **Long/reference context is placed before the instructions, and the actual ask is restated at
    the end** if the prompt is long. [Anthropic §2 "long context prompting"; OpenAI GPT-4.1 §7
    "instructions at both start and end"]
12. **Any included examples are current, diverse, and don't contradict the stated instructions**
    (no stale few-shot pollution). [Anthropic §2; anti-patterns §12 item 1]
13. **Instruction count stays bounded** — avoid stacking more than ~8–10 discrete directives in
    one prompt; consolidate or move detail to a linked doc/CLAUDE.md instead. [anti-patterns §12
    item 2; Claude Code §5 "over-specified CLAUDE.md"]
14. **Constraints are stated as concrete, falsifiable rules, not vague adjectives** ("be careful"
    → name the specific destructive/irreversible actions that require confirmation).
    [Anthropic §2 "balancing autonomy and safety"; anti-patterns §12 closing note]
15. **Does not over-specify implementation** when the goal-level spec is what's needed — captures
    WHAT/WHY, defers HOW to the agent's plan, unless the task is genuinely execution-scoped.
    [Spec Kit §11 "abstraction discipline"; Claude Code §5 "vague prompts can be useful when
    exploring"]
16. **Explicitly invites the agent to flag its own ambiguities** rather than silently guessing —
    e.g. a `[NEEDS CLARIFICATION]`-style convention or "ask if X is unclear." [Spec Kit §11;
    Anthropic §2 "if the task is unreasonable... inform me rather than working around them"]
17. **For long-horizon/multi-session tasks, tells the agent how to persist and recover state**
    (progress file, structured test-status file, git as the checkpoint log) instead of assuming
    one continuous context window. [Anthropic §2 "workflows across multiple context windows";
    Lance Martin §9 "write" strategy]
18. **Gives the agent permission to be persistent** on agentic/autonomous tasks — an explicit
    "keep going until fully resolved" style instruction — when unattended completion is wanted.
    [OpenAI GPT-4.1 §7 persistence reminder; Anthropic §2 context-awareness block]
19. **Does not ask the model to guess instead of investigating** — directs it to read files /
    use tools rather than speculate when uncertain about codebase facts. [OpenAI GPT-4.1 §7
    tool-calling reminder; Anthropic §2 "minimizing hallucinations"]
20. **Anti-overengineering clause present when scope discipline matters**: don't add
    unrequested features, refactors, defensive code, or abstractions beyond what's asked.
    [Anthropic §2 "reduce file creation / avoid overengineering"]
21. **Doesn't ask the agent to game the DoD** — states that tests/checks define correctness but
    are not themselves the spec, and a general solution is wanted over hardcoding to pass the
    given cases. [Anthropic §2 "avoid focusing on passing tests and hardcoding"]
22. **Ends with (or otherwise specifies) an end-to-end verification step that proves the whole
    feature works**, not just that individual pieces exist. [Claude Code §5 "self-contained specs
    ... end with an end-to-end verification step"]
23. **Avoids persona/role stuffing that isn't load-bearing** — a role, if given, is short and
    functional, not an elaborate character that competes with the task instructions for
    attention. [anti-patterns §12 item 4]
24. **Keeps any always-on project context (CLAUDE.md-equivalent) short** and prunes anything the
    agent could infer from the code itself; the checklist should treat a bloated "context
    pointers" section as a defect, not a virtue. [Claude Code §5 CLAUDE.md guidance]

---

## Implications for prompt-it

- **The DoD is the highest-leverage lever.** Nearly every primary source converges on the same
  point from a different angle: Claude Code's "give Claude a way to verify its work," GitHub
  Spec Kit's test-first/measurable-success-criteria gates, and Anthropic's "avoid focusing on
  passing tests" caveat all say the same thing — an agentic prompt lives or dies on whether
  "done" is checkable by the agent itself, not asserted. prompt-it's optimizer should treat "does
  this prompt contain at least one runnable/checkable verification step per DoD item" as close to
  a hard gate, and should reject vague DoD items ("works well," "looks good") the same way a
  linter rejects untyped code.
- **Context pointers should be pointers, not payloads.** The convergent guidance (Anthropic's
  "just-in-time" retrieval, Claude Code's `@file` referencing, the tool-writing post's
  "high-signal, low-noise" principle, Lance Martin's "select" strategy) argues against prompt-it
  stuffing full file contents into the optimized prompt. Prefer named files/globs/patterns the
  downstream agent can load itself, plus one or two concrete anchor examples — this also keeps
  prompt-it's own output cheap to generate and cache-stable (Manus's KV-cache point applies to
  the *consuming* agent's system prompt too, if prompt-it's output becomes a stable prefix).
- **Scope fences deserve their own explicit section, not just an implicit "don't."** Both
  Anthropic's verbatim anti-overengineering block and Claude Code's "state what is out of scope"
  line suggest prompt-it should always emit a labeled "Out of scope / do not touch" list, even
  when short, rather than relying on the goal statement to imply boundaries by omission — omission
  is exactly what produces scope creep per the "kitchen sink" and "over-correction" anti-patterns.
- **Contradiction-checking is a distinct pass, not a side effect of clarity-checking.** GPT-5's
  documented sensitivity to contradictory instructions (spending reasoning tokens reconciling
  them rather than picking one) and Claude's "dial back aggressive/CRITICAL language" migration
  note both imply prompt-it should explicitly diff the DoD items and constraints against each
  other for conflicts before finalizing — this is a good candidate for a distinct internal
  verification step in prompt-it's own generation pipeline, separate from "is this prompt clear."
- **Ambiguity should surface, not get silently resolved.** Spec Kit's `[NEEDS CLARIFICATION]`
  convention is a clean, adoptable pattern: when the rough input prompt underspecifies something
  material (which test framework, which of two plausible files, etc.), prompt-it's output should
  either ask one targeted question or explicitly flag the assumption it made and why — matching
  Anthropic's own "if the task is unreasonable... inform me" framing, applied one level earlier
  (at prompt-authoring time rather than at execution time).
- **Long-horizon tasks need a persistence contract, and prompt-it can template it.** Since
  fable-it-style overnight/autonomous runs are exactly the multi-context-window scenario Anthropic
  documents in detail (structured `tests.json`/progress files, git as checkpoint log, explicit
  "don't stop early due to token budget" permission), prompt-it could offer this as an optional
  appended block for tasks flagged as long-horizon/unattended, rather than reinventing it per
  prompt.
- **Keep prompt-it's own output disciplined about length and instruction count.** The convergent
  "instruction stacking" and "over-specified CLAUDE.md" anti-patterns argue prompt-it should treat
  its own output size as a quality signal too — a 40-line DoD with 10 scope-fence bullets is
  itself an anti-pattern instance, not a sign of thoroughness. The `24`-item checklist above scores
  the *input's* quality; prompt-it's *output* prompt should independently be checked against the
  same brevity/no-contradiction/schema-explicitness bar.
