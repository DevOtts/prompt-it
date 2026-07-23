# Research Findings — Cluster C2 (YouTube, videos 5-8)

Source videos transcribed via the `/youtube-transcriber` skill (yt-dlp fallback). All four fetched successfully on the first fallback attempt — no `--refresh` retries were needed.

---

## Video 5 — How Anthropic Engineers ACTUALLY Prompt Claude Code

- **Channel:** Austin Marchese
- **URL:** https://www.youtube.com/watch?v=qOvc9IUKEIc
- **Status:** Fetched (yt-dlp fallback). Transcript saved to `research/transcripts/qOvc9IUKEIc.md`.

**What it's about:** A secondary/reaction video (not primary Anthropic material) that synthesizes clips of Anthropic engineers (Barry, Eric, and others) speaking at an "AI Code Summit," repackaged into "4 rules" for prompting Claude Code — built around Claude Skills as the real unit of leverage, not one-off prompts.

**Concrete techniques:**
- **Prompt skills, not Claude directly.** Reframe repetitive tasks as reusable Skills (folders with description + instructions + tools) invoked via `/skill-name` rather than re-writing a bespoke prompt every time. Mental model: model (L1) → agents/prompts (L2) → skills (L3, the "app layer" you actually build in).
- **Skill anatomy — three layers, and most people only do layer 2:**
  1. *Description* — acts like a title/label Claude scans to decide whether to invoke the skill. Vague description = Claude won't reliably trigger it; specific description = reliable auto-invocation without the user typing the slash command.
  2. *Instructions* — the step-by-step playbook (what most people stop at).
  3. *Tools* — scripts, API calls, reference files bundled inside the skill. Anthropic engineers spend disproportionate effort here, treating tool interfaces with the same rigor a software engineer would give a function signature (well-named parameters, documented, not just "param A, param B"). Direct quote-worthy anti-pattern: people write "really beautiful, detailed prompts" then ship "incredibly bare-bones" undocumented tools.
- **Composable over monolithic skills.** Anti-pattern: one giant skill doing everything (e.g., a single `/content-creation` skill covering ideation + scripts + social posts) becomes unmanageable — you can't isolate what broke, fixes don't propagate, nothing is reusable. Fix: split into small, single-purpose skills that call each other; Claude auto-coordinates which to use. Rationale given: (1) issues are localized and diagnosable, (2) improvements compound — fixing the shared skill fixes every workflow using it, (3) reuse instead of rebuilding per workflow.
- **Save scripts inside the skill folder** the first time Claude writes one (e.g., a Python styling script it kept rewriting each session) so future sessions execute the deterministic script instead of regenerating it — trades "AI tokens for code compute," cheaper/faster/more consistent. General heuristic: if code can do it, prefer code over model inference.
- **Two invocation-control flags on skills:** `user_invocable: false` hides a skill from the human's slash-menu (agent-only tool); `disable_model_invocation: true` blocks the model from calling it (human-only trigger) — useful for high-risk actions like sending messages or deploying to production.
- **Compounding improvement loop:** after every skill run where output isn't quite right, ask "is this a one-off fix, or should this be baked into the skill permanently?" If permanent, update the skill's instructions/examples/edge-cases immediately (can literally ask the model to "review this back-and-forth and update the skill so this doesn't happen again"). Goal per Anthropic: "Claude on day 30 of working with you is going to be a lot better [than] Claude on day one" — because skills persist across sessions while raw chat prompts don't.

**Verbatim quotes:**
> "Skills are organized collections of files that package composable procedural knowledge for agents."

> "People obsess over the prompt and skip the tools... [Anthropic engineers] focus on these tools." (paraphrasing Eric of Anthropic)

> "Every time Claude learns something about how you work, your voice, your process, your edge cases, you write it down in the skill. Next session starts smarter than the last."

**Relevance to prompt-it:** High-value but at a layer above single-prompt optimization — this is about *systemizing* recurring prompts into versioned, tool-backed skills, and it directly validates prompt-it's own packaging as a Skill. Two transferable rules for the optimizer itself: (1) a good task prompt should read like a well-specified function signature, not vague prose — name inputs/outputs/edge cases explicitly; (2) the optimizer should treat "should this become a reusable skill instead of a one-off prompt" as a judgment call it can surface to the user. Less directly useful: content is a reaction/curation video, not primary source, so treat the Anthropic-engineer quotes as secondhand.

---

## Video 6 — AI prompt engineering: A deep dive

- **Channel:** Anthropic
- **URL:** https://www.youtube.com/watch?v=T9aRN5JkmL8
- **Status:** Fetched (yt-dlp fallback). Transcript saved to `research/transcripts/T9aRN5JkmL8.md`.

**What it's about:** A ~75-minute roundtable of four actual Anthropic prompt-engineering practitioners (Amanda Askell — alignment finetuning; Alex Albert — DevRel, ex-prompt-engineering team; David Hershey — applied AI/customers; Zack Witten — prompt engineer) discussing what prompt engineering really is, what separates good from bad prompt engineers, concrete refinement tactics, honesty/persona framing, chain-of-thought, enterprise-vs-research prompting, and where prompting is headed. This is the single richest primary source of the four for prompt-it, because it is Anthropic's own people describing their actual working process, not a secondary summary.

**Concrete techniques (high density — organized by theme):**

*Iteration & self-critique loop*
- Ask the model to critique your prompt *before* running it for real: "I don't want you to follow these instructions — just tell me the ways they're unclear or any ambiguities." Run this as a dry pass ahead of the real task.
- When the model gets something wrong, ask it directly: "You got this wrong — why? Can you write an edited version of my instructions that would make you not get it wrong?" Practitioners report this frequently produces a working fix you can paste straight back in.
- Iteration is the "engineering" in prompt engineering — the value of a chat interface is the reset button: you can return to a clean slate and try an independent variant without cross-contamination from prior attempts, which is what makes it an experimental/engineering discipline rather than pure writing.

*Systematically finding the unclear/ambiguous cases (edge-case hunting)*
- The single most common mistake: testing only the "typical" case and stopping. Instead deliberately construct adversarial/edge inputs: empty string, no matching rows, malformed data, wrong format entirely — anything that forces you to add explicit handling instructions.
- Real user input is messy — "they never used the shift key and every other word is a typo," no punctuation, not phrased like a clean eval example. Design for actual traffic, not idealized traffic.
- **Always give the model an "out"** for uncertain/unexpected input — e.g., "if you're really not sure what to do, output `<unsure>`" — rather than forcing a forced-choice answer on out-of-distribution input. Benefit is double: (1) you can grep for `<unsure>` cases afterward, (2) it surfaces flaws in your own eval/example set (Amanda: "iterating on tests with Claude, the most common outcome is I find all of the terrible tests I accidentally wrote").

*Strip your own hidden context — theory of mind*
- The hardest and most differentiating skill: "It's so hard to untangle in your own brain all of the stuff that you know that Claude does not know and write it down." Bad prompts are "so conditioned on [the author's] prior understanding of the task" that a third party (or the model) cannot parse them.
- Mental model recommended: imagine briefing a *competent temp-agency worker* who knows the general domain but nothing about your specific company/task/edge cases. Write the prompt as if speaking to that person out loud, then transcribe that spoken explanation — it is reliably better than the "polished" written version, because verbal explanation naturally includes context you'd otherwise omit ("laziness shortcut" fix: literally voice-record yourself explaining the task, transcribe it, paste it in as the prompt).
- Practical test for this: hand your prompt to a person with zero context on your use case and see if it's parseable.

*Persona/role-prompting — nuanced, not a blanket "yes"*
- Consensus leans against fake-persona framing ("You are a high school teacher") as a shortcut — it substitutes a *similar* task for the *actual* task and loses nuance. Instead, be maximally honest/prescriptive about the real context: "You're the support chat window embedded in [product]. You're a language model, not a human — that's fine, but here is exactly the situation you're in."
- Where persona-as-metaphor still helped: not "you are a teacher" but "grade this chart the way a high-school assignment would be graded" — a *scale/calibration* metaphor rather than an identity swap. The distinction matters: use metaphors to convey a calibration point, not as a substitute for describing the actual task and product context.
- One practitioner (Zack) reported never getting value from persona-prompting at all, even on older/weaker models — signals this technique is genuinely contested/model-and-task-dependent, not a universal win.
- Emotional/incentive framing ("it's vital to my career") gets mixed/skeptical treatment in this video (contrast with video 7, which recommends it uncritically) — treat as a soft, unproven lever, not a reliable core technique.

*Chain-of-thought / reasoning*
- Whether CoT is "real reasoning" is treated as unresolved/philosophical, but empirically it reliably improves outcomes — tested by adversarial ablation: if you strip a model's correct-answer reasoning and substitute plausible-looking reasoning that leads to a wrong answer, the model's final answer degrades accordingly (cited from the Sleeper Agents / alignment research), confirming the reasoning trace is doing real work, not just filling token-budget/compute space (control test used: replacing CoT with meaningless filler tokens like "um, ah" repeated does NOT reproduce the benefit — rules out "it's just extra compute steps").
- Explicitly instructing "think step-by-step" is *necessary but not sufficient* — read the actual model output to verify it is literally writing structured reasoning in the format you asked for (e.g., specific tags), not reasoning in some other implicit/abstract way. **Read your outputs closely — this is the prompting equivalent of "look at your data" in ML.**
- CoT effectiveness improves further if you structure/iterate the reasoning format with the model rather than leaving "think step by step" unstructured.

*Enterprise vs. research vs. consumer-chat prompting differ mainly in example density and tolerance for variance*
- Consumer/enterprise system prompts: use MANY few-shot examples, because reliability/consistency across huge unknown input volume matters more than creative range; the prompt must be right on the first try because you get zero back-and-forth with the actual end user (unlike Claude.ai chat where you can always re-edit).
- Research prompting: use FEW examples (or none), because you want the model to explore genuine variety and range, not converge onto the format/tone of a couple of examples. Amanda: deliberately uses *illustrative, dissimilar* examples (e.g., a children's-story example for a factual-document extraction task) specifically so the model generalizes the *concept* rather than pattern-matching the *literal words/format* of the example.
- Never construct few-shot examples that put words in the model's own "mouth" (fake prior-turn model outputs) — this intuition is inherited from pretrained-model prompting and doesn't transfer well to RLHF'd models.

*Trust calibration / when a prompt genuinely can't fix a task*
- Look for whether the model's reasoning process is "in the right zip code" even when the literal output is wrong — if every tweak sends it in a completely different, unrelated wrong direction with zero convergence, that's the signal to abandon prompting and wait for a better model rather than keep grinding (illustrated via the "Claude Plays Pokémon" vision-grounding anecdote — a full weekend of prompt engineering got it from "no signal" to "some signal" on reading a Game Boy screen, but never to usable; correctly diagnosed as a model-capability ceiling, not a prompting problem).
- High-signal small n vs. low-signal large n: a well-constructed set of ~100 carefully varied prompts/cases, read closely, can give more actionable signal than several thousand loosely constructed ones. Read outputs, don't just count pass/fail.

*Style mechanics (lower-stakes findings)*
- Markdown/grammar/punctuation correctness in prompts: doesn't measurably hurt or help model comprehension directly, but the *discipline* of caring about it correlates with catching real ambiguities (the by-product of attention-to-detail, not the typo-fixing itself).
- Give models the source material directly instead of paraphrasing it down: e.g., feed the actual research paper and ask the model to extract/apply the technique, rather than writing your own dumbed-down description of what the paper says — "treat the model as smart," don't over-simplify or "baby" it.
- Have the model interview *you* to extract a prompt: ask it to ask clarifying questions about your task, then turn that Q&A transcript into the actual prompt — addresses the "I know things I forgot to write down" problem directly.

**Verbatim quotes:**
> "It's so hard to untangle in your own brain all of the stuff that you know that Claude does not know and write it down... A lot of people will just write down the things they know. But they don't really take the time to systematically break out what is the actual full set of information you need to know to understand this task."

> "If you instead say something like, 'If something weird happens and you're really not sure what to do, just output in tags unsure'... [that's] my favorite thing about iterating on tests with Claude — the most common outcome is I find all of the terrible tests I accidentally wrote."

> "[Prompting is] taking things that are in your brain, analyzing them enough to feel like you fully understand them, and could take any person off the street... and just externalize your brain into them. I feel like that's the core of prompting." (Amanda Askell — called out in the video itself as possibly "the best summary of how to prompt well")

**Relevance to prompt-it:** The single highest-value source of the four. This is exactly the discipline prompt-it needs to encode as an *optimizer*: (1) strip-the-author's-hidden-context as the core transformation (temp-agency mental model → make the rough prompt legible to an agent with zero shared history), (2) force explicit edge-case/"out" clauses into every generated prompt (unsure/ask-for-clarification paths), (3) calibrate example density to task type (few illustrative examples for open-ended/creative agentic tasks, many concrete examples for narrow high-volume deterministic tasks), (4) treat persona-prompting as optional/contested rather than a default template slot, (5) build in a self-critique pass ("here are the ambiguities in this prompt") as an actual step in the optimizer's pipeline, not just a tip for humans.

---

## Video 7 — MASTER Prompt Engineering in 50 min

- **Channel:** Ben AI
- **URL:** https://www.youtube.com/watch?v=hqkAH_65-vY
- **Status:** Fetched (yt-dlp fallback). Transcript saved to `research/transcripts/hqkAH_65-vY.md`.

**What it's about:** A practitioner (AI automation consultant, not Anthropic) walks through his own template system for prompting inside no-code AI-agent/automation tools (specifically Relevance AI), aimed at builders wiring up business automations rather than chatting with an assistant. Presents three named frameworks (Long Structured, Short Structured, Agent) plus a use-case-to-framework/model mapping table.

**Concrete techniques — template structures (most directly reusable for an optimizer):**

- **Conversational vs. structured prompting distinction:** chat/back-and-forth prompting tolerates ambiguity because you can always re-ask; single-shot automation prompts cannot — this is the explicit rationale for needing a template/framework at all. Directly analogous to why prompt-it exists for agentic sessions (no back-and-forth mid-run).
- **"Long Structured Framework"** — 7 ordered sections, each with a stated purpose and suggested phrasing:
  1. *Role/Persona* — assign role + qualities + hype ("You're a world-class X with particular expertise in Y").
  2. *Objective/Task* — one direct, clear description of what must be done; embed chain-of-thought here ("Your goal is... You'll think step by step through the following process: 1... 2... 3...").
  3. *Context* — why the task matters / how it fits the bigger picture (this section is also where he inserts "emotional manipulation" framing like "it is vital to my career" — presented uncritically, unlike video 6's skeptical treatment).
  4. *Instructions/Rules* — the detailed constraints; explicitly authored by "predicting what could go wrong in the output" ahead of time, plus output-format specification as a nested sub-header.
  5. *Examples* — input/output pairs; explicit tip: if you don't have real examples yet, run the prompt once with the best available model, review/edit that output, and use it as your worked example rather than skipping this section.
  6. *Variables* — the actual runtime input slotted in under its own header.
  7. *Notes* — a closing recap section that **doubles down on the most important rules/format/CoT instructions**, justified by the claim that models weight the beginning and end of a long prompt more than the middle (primacy/recency emphasis) — also the fastest place to patch a newly discovered failure mode without restructuring the whole prompt.
- **"Short Structured Framework"** — reduced to Objective + Instructions (+ example output, + variable if needed). Explicit rule for simple/narrow tasks (e.g., "extract this one field"): **always specify what to output on failure** ("if no name found, output 'no name found', nothing else") — otherwise the model hallucinates or echoes example text. Also: for pure-extraction output, explicitly forbid extra prose ("only output X, no summary, no explanation").
- **"Agent Prompting Framework"** — Long Structured framework plus two agent-specific additions:
  - An **SOP section**: a numbered, branch-capable procedure ("1. If X, then 1.1/1.2/1.3, else 2...") describing exactly which sub-agent/tool to invoke in which order/condition — argued to matter more for agents than for single-shot prompts because agent failures are usually SOP-ambiguity failures.
  - A **Tools & Sub-agents section**: for each tool/sub-agent, describe (a) what it does, (b) when to use it, (c) *how to communicate with it* — with a worked example of the exact message to send it. Explicit warning: if the orchestrating agent doesn't communicate precisely to a sub-agent, "the system will fail."
  - Agent examples section reframed: not input/output pairs but **example-request → example-SOP-trace** pairs (a worked run showing which agents were invoked, what was said to each, and what got reported back) — and explicitly recommends putting **known failure edge-cases** here as worked examples, not just happy-path runs.
  - Core design principle stated directly: **give the orchestrating agent as few responsibilities as possible** — ideally only decision-making (which tool/sub-agent, in what order) and communication; offload all actual task execution to tools/sub-agents. Quoted maxim: "the solution to problems of AI is usually more AI" — i.e., if an agent misbehaves, decompose further into an additional tool/sub-agent rather than cramming more instructions into one agent's prompt.
- **Use-case → framework/model mapping** (his own heuristic table): extraction/summarization and simple classification/data-transformation → Short framework + cheap models (LLMs are already good at these); generation and evaluation and decision-making/agents → Long framework + best-available models (highest hallucination/failure risk, most context-dependent).
- **Anti-pattern flagged explicitly:** sending an orchestrating agent unorganized raw tool output (e.g., 50 raw scraped emails) — instead have the tool/sub-agent pre-clean and pre-summarize before it reaches the orchestrator, because the orchestrator is already overloaded with decision-making responsibility ("send clean data back to your agent").
- **GPT-o1-specific caveat** (dated, reasoning-model-specific, likely stale for current models): keep prompts simpler/shorter for reasoning models, skip explicit CoT instruction (it's baked in), but still use markdown structure.

**Verbatim quotes:**
> "L[L]Ms are not good at performing multiple tasks so we always want to optimize these prompts for one specific... small task... if we have complex tasks... that's where chain prompting comes into play... we break that complex task down into separate tasks and put it in a chain."

> "[Notes section] language models actually take the beginning and the end of prompts more into account than the middle of the prompts... if you see your model making mistakes... add those things where it goes wrong... in the note section... it will actually start correcting itself very quickly."

> "The solution to problems of AI is usually more AI" (quoting an unnamed agent-builder) — i.e. when an agent's prompt keeps failing at some sub-task, decompose into another tool/sub-agent rather than further inflating one prompt.

**Relevance to prompt-it:** Medium-high, with caveats. The section *ordering* (role → objective/CoT → context/why-it-matters → instructions/rules incl. output-format and failure-mode handling → examples → variables → notes-recap) is a genuinely reusable template skeleton an optimizer could target when restructuring a rough prompt — especially the "predict what could go wrong and pre-author the rule for it" authoring method, the failure-output specification pattern, and the SOP/tool-communication structure for agentic/multi-step prompts. However: this is a no-code business-automation creator's personal system (Relevance AI specific in the second half — labeling, naming, flow-builder are 100% platform-specific and should be discarded), not derived from published research, and the "emotional manipulation" ($1000 tip, "vital to my career") advice is presented uncritically here despite being contested/soft-evidence per video 6 and broader community consensus — flag this as a low-confidence technique to omit or heavily caveat in the actual skill rather than adopt verbatim. The Short vs. Long framework selection heuristic (match structure depth to task risk/ambiguity, don't over-template trivial extractions) is directly useful for how prompt-it should decide how much scaffolding to add to a given rough prompt.

---

## Video 8 — Context engineering explained: What every AI developer should know

- **Channel:** Google Cloud Tech
- **URL:** https://www.youtube.com/watch?v=BBPQYtR7oUk
- **Status:** Fetched (yt-dlp fallback). Transcript saved to `research/transcripts/BBPQYtR7oUk.md`.

**What it's about:** A short (~10 min), tightly produced explainer distinguishing "context engineering" from "prompt engineering," built around a worked toy example (an agent called "LogLook" that triages security-log alerts), and landing on a named 4-step method: Write, Select, Compress, Isolate.

**Concrete techniques:**
- **Core reframe:** prompt engineering = how you word the instructions; context engineering = deciding *everything else the model sees at each step* — system message, tools + their descriptions, retrieved facts, short-term notes, long-term memory, output-format schema, and recent history. Framed as "curating the smallest set of high-signal tokens," explicitly opposed to "bigger prompts fix bad answers" (that's called out as the wrong instinct up front).
- **Bigger context ≠ better** — longer context windows increase accuracy risk once filled, via four named failure modes worth using as a checklist/vocabulary when diagnosing a bad agent prompt:
  1. **Poisoning** — a hallucinated fact enters context and gets reused/compounded turn after turn.
  2. **Distraction** — the model fixates on accumulated history instead of forming a fresh plan.
  3. **Confusion** — irrelevant extra detail nudges the model toward a wrong answer.
  4. **Clash** — two contradictory context sources are present and the model picks the wrong one.
- **Seven components of a "context stack"** to audit for any agent call: (1) instructions/system prompt+guardrails, (2) current user input, (3) retrieved facts (top-k relevant snippets only), (4) tools + their descriptions, (5) short-term notes (running summary of what changed recently), (6) long-term memory (stable facts, pulled on demand not always-on), (7) output format (schema/examples that lock response shape).
- **Worked contrast example (LogLook):** naive prompt = "analyze today's logs and tell me what's wrong" → invites guessing. Context-engineered version instead assembles: explicit system instructions (summarize + severity score 0-4, "only use provided context," and — critically — an explicit instruction for the missing-data case: "ask for a specific file path" rather than guess) + an enumerated tool list (read file, grep, get-known-false-positives) + pre-filtered retrieved facts (only error/critical log lines from the last hour, plus the team's known-false-positive list) + short-term notes ("already checked this file, scan this one instead") + a locked output schema (JSON in/out). This is a template shape prompt-it can borrow directly for agentic coding-session prompts: system rules + tool inventory + scoped/filtered context + running state note + explicit output contract.
- **The 4-step method (Write / Select / Compress / Isolate)** — applicable as an authoring checklist:
  1. **Write** — externalize working state (plans, intermediate results, open questions) to a scratchpad/file outside the context window (e.g., `investigation_steps.md`) instead of stuffing it all into the next call; pull back in only what's relevant.
  2. **Select** — retrieve only what's needed for *this* turn, not everything available; hybrid keyword+semantic retrieval is called out as typically beating embedding-only search on messy/log-like data. "Selection, not hoarding."
  3. **Compress** — periodically summarize long running history into short, loss-aware notes and continue from a fresh window rather than dragging the full raw history forward every turn; keep a small buffer of the most recent raw items for safety (example given: keep last 5 findings verbatim, roll everything older into a 3-line recap).
  4. **Isolate** — sandbox by splitting a big job into sub-agents/phases, each with its own scoped context, each returning only a short digest to a coordinator — reduces cross-talk/leakage and stops one noisy source from poisoning the rest (reader sub-agent → scorer sub-agent → writer sub-agent, each seeing only what it needs).
- **Closing operating principle:** "curate, don't dump" — treat context as scarce working memory to be actively assembled per call, not a bucket to pour everything into.

**Verbatim quotes:**
> "If prompt engineering is how you word the ask, then context engineering is everything you feed the model so it can actually do the job."

> "Models keep getting larger context windows, but longer context isn't always better. When you fill up that window, accuracy often drops because errors sneak in and the model gets distracted by stale or irrelevant text, or two pieces of context which actually quietly contradict each other."

> "It's really important to curate instead of dumping a large chunk of prompts... a discipline of building robust, reliable, and truly useful applications."

**Relevance to prompt-it:** Very high and directly applicable — this is arguably the most structurally relevant video of the four for an agentic-coding prompt optimizer, since Claude Code sessions are exactly the multi-turn, tool-using, long-running agent case this video targets. Directly actionable for prompt-it: (a) the optimizer should treat "what context to include/exclude/scope" as a first-class output alongside prompt wording — not just polish the ask, curate the context stack; (b) the seven-component checklist (instructions, user input, retrieved facts, tools+descriptions, short-term notes, long-term memory, output format) is a usable audit list for "did this optimized prompt specify enough of the surrounding context?"; (c) the four failure-mode vocabulary (poisoning/distraction/confusion/clash) gives prompt-it good diagnostic language for explaining *why* a rough prompt might fail in a long agentic session, and for coaching users to explicitly scope file/tool access rather than dump everything; (d) explicitly instructing the model what to do on missing/ambiguous input ("ask for a file path" rather than guess) is a directly reusable acceptance-criteria pattern, echoing video 6's "give it an out" finding independently.

---

## Implications for prompt-it

Cross-video synthesis of what a prompt *optimizer* for agentic coding sessions should actually encode, ranked by convergent evidence across sources:

1. **Strip hidden context, don't assume shared history** (video 6, core finding; reinforced by video 8's "instructions" component). The optimizer's central transformation should be: take a rough prompt written by someone who has context in their head that the agent doesn't, and make that context explicit — using the "brief a competent stranger/temp-agency worker" mental model as the working heuristic, not blind expansion of prose length.

2. **Every optimized prompt needs an explicit "out" clause for uncertainty/missing data** (video 6 + video 8, independently convergent). Don't let the agent guess silently on ambiguous input, missing files, or out-of-scope requests — specify the fallback behavior (ask for the specific missing input; flag as unsure; stop and report) as a required section, not an afterthought.

3. **Context curation is as important as prompt wording, and is a *separate* axis for an agentic coding tool** (video 8, core finding). For Claude Code sessions specifically, prompt-it should treat "what files/tools/history should this session see" as an explicit output — scoped retrieval over full-dump, a running-state note pattern (Write step) for long sessions, and sub-task isolation for independent pieces of work. The four failure modes (poisoning, distraction, confusion, clash) are useful diagnostic labels to surface to users when explaining why a prompt needs tightening.

4. **Match structural depth to task risk, don't over-template everything** (video 7, echoed loosely by video 6's enterprise-vs-chat distinction). Simple, low-ambiguity asks (single extraction/transformation) need only objective + instructions + failure-mode output spec; complex/generative/agentic/decision-making tasks warrant the fuller structure (role, why-it-matters context, detailed rules pre-authored against predicted failure modes, worked examples, explicit SOP for multi-step/tool-using work). The optimizer should size its output to the task, not always produce a maximal template.

5. **Self-critique as a literal pipeline step, not just a human habit** (video 6). Before finalizing an optimized prompt, run (or instruct the user to run) an ambiguity-check pass: "here is what's unclear/underspecified about this instruction" — genuinely improves prompts and is cheap to automate.

6. **Reusable-skill judgment call** (video 5). When a rough prompt looks like it will recur, the optimizer should be able to flag "this looks like a candidate for a Skill, not a one-off prompt" and note that a well-built skill's leverage lives disproportionately in its tools/scripts layer, not just its instructions — worth a light-touch mention in prompt-it's output when relevant, without turning the optimizer into a skill-authoring tool.

7. **Explicit anti-patterns / low-value techniques to actively avoid baking in:**
   - Emotional-manipulation phrasing ("I'll tip you $1000," "it's vital to my career") — presented uncritically in video 7, but treated skeptically/inconsistently even by Anthropic's own practitioners in video 6. Do not adopt as a default lever; if mentioned at all in prompt-it's guidance, label it explicitly as low-confidence/contested, not a recommended pattern.
   - Blanket persona/role-prompting as a default template slot ("You are a world-class X") — mixed evidence in video 6 (one practitioner reports never getting value from it at all); prefer being maximally concrete about the *actual* task/product/context over swapping in a fictional identity. Where persona-like framing helps, it works as a calibration metaphor (e.g., "grade this like a high-school assignment"), not an identity assignment.
   - Video 7's Relevance-AI-specific mechanics (labeling tasks, naming tasks, the visual flow-builder) are platform UI features, not portable prompt-engineering technique — explicitly out of scope for prompt-it.
   - Generic "prompting frameworks" content of the ChatGPT-tips-listicle variety is largely absent from these four (all four had at least some structurally specific, actionable content), so no video needs to be flagged as pure low-value filler — video 7 is the closest to generic/personal-opinion territory and should be weighted lowest of the four, with its "emotional manipulation" advice specifically excluded.
