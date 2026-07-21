# Research Findings — C1: YouTube (prompt-engineering techniques for prompt-it)

Source cluster: 4 YouTube videos, transcribed via the baoyu-youtube-transcript skill (yt-dlp fallback, no `--refresh` needed — all four succeeded on the first pass). Full transcripts saved at `research/transcripts/<video-id>.md`.

---

## 1. "Fable 5 And GPT-5.6 Don't Need Better Prompts. They Need A Clean Setup."

- **Channel:** AI News & Strategy Daily | Nate B Jones
- **URL:** https://www.youtube.com/watch?v=PDJfciNhyHU
- **Status:** fetched

**What it's about:** Nate Jones audited his own accumulated Claude/ChatGPT "harness" (custom instructions, project files, skills, memory, permissions, checks — everything wrapped around the model) and found it had ballooned to 66 skill roots and 172 instruction files, with a single skill weighing 18,000 words. He distills the audit into six rules for keeping a harness lean and effective as models change underneath it, and contrasts how Claude (Fable 5) and ChatGPT (5.6) fail differently when the harness is bloated.

**Concrete techniques:**
- **Map before you clean.** Before touching any instruction, build an inventory: for every rule/skill/file, record where it lives, when it loads, what job it does, who owns it, whether there's evidence it still helps, and what it risks if misused. Don't delete first, decide first.
- **"Blame the right layer."** When output fails, diagnose whether the *model* failed or the *harness* (prompt/instructions) failed before adding another rule. He ran an A/B: a compact prompt (goal + facts + permission boundary + finish line) passed delivery requirements 3/3 times; a "thick" version (same + full method + scoring system + eval plan + classification scheme) produced richer analysis but broke JSON/word-limit twice. Lesson: more instruction depth ≠ more reliable delivery — richness and constraint-compliance trade off, and the fix for a broken constraint is often less prose, not more.
- **"One rule, one home, one owner."** A single behavioral rule duplicated across N places (he found the same "don't put words in my mouth / cite sources" rule copied into 15 skills) means N places to drift out of sync. Consolidate each rule to exactly one canonical location.
- **"Load it when you need it."** Specialist context (e.g., a sourcing/citation guide, or YouTube-example patterns) should load only when the task phase actually needs it — not be front-loaded into every session regardless of relevance. Front-loading unrelated specialist material measurably degrades focus on the task at hand (his example: loading YouTube-script guidance while doing research work).
- **"Hard rules need hard checks."** Anything with a yes/no, machine-checkable answer (word count, JSON validity, format) should be enforced as a schema/validator the system checks — not left as prose instruction hoping the model complies. Reserve prose instructions for genuinely judgment-based, discursive requirements.
- **"Build for the model and the product."** The same underlying model behaves differently depending on the product surface (Claude.ai vs Claude Code vs API; ChatGPT vs Codex) — different surfaces expose different tool/permission/check capabilities. Don't assume one harness design transfers; the core "what must be true before this is done" contract stays constant, but how it's enforced must be re-tuned per surface.
- **Model-specific failure modes to design around:** Claude's failure mode shows up *late* — it absorbs a heavy method and overloads itself trying to do the complete job, then trips on a delivery constraint at the end. GPT-5.6/Codex's failure mode shows up *early* — it struggles just to find/route to the right method inside an oversized harness. Both are fixed by selective loading + hard checks, but for different underlying reasons.
- **Keep a "run receipt":** log which model, reasoning setting, tools, skills, fallbacks, and checks actually ran on a given task — a diagnostic trail for debugging harness drift over time.

**Verbatim quotes:**
> "A harness is everything wrapped around the model. So, it's your custom instructions. It's your project files. It's your saved prompts. It's your memory. Your skills, your tools. It's your permissions, any checks that you run."

> "If you blame the model for everything, you will keep adding instructions to solve problems created by instructions, not by the model... Did the model fail or did the surrounding setup fail? Did the harness fail?"

> "You give it the real outcome, you give it context that it can't infer, you give it room to inspect the problem, and you let it plan its own approach usefully... the depth should arrive when the work needs it, not all up front in a way that confuses the model."

**Relevance to prompt-it:** High. This is directly about the failure mode prompt-it exists to prevent — instruction bloat, unclear ownership of rules, front-loaded irrelevant context, and soft prose where a hard check belongs. The "compact prompt beats thick prompt on delivery constraints" A/B and the "one rule, one home" / "load when needed" / "hard rules need hard checks" principles translate almost directly into prompt-it's optimization rules: keep the optimized prompt lean (goal, grounded facts, boundary, finish line), push machine-checkable acceptance criteria into explicit, testable form rather than prose, and don't inject specialist context the task phase doesn't need yet.

---

## 2. "Oxford Researchers Discovered How to Use AI To Learn Like A Genius"

- **Channel:** Python Programmer
- **URL:** https://www.youtube.com/watch?v=TPLPpz6dD3A
- **Status:** fetched

**What it's about:** A video summarizing University of Oxford (and referencing Cambridge/CLEAR-principle) guidance on using ChatGPT as a study tool, built on the learning-science point that retrieval practice (actively producing/answering, not passively receiving) is what drives learning. It walks through prompt patterns for using AI as a Socratic tutor rather than an answer machine: get it to question you instead of summarizing for you, use multi-level explanations (explain to a child/high-schooler/academic) with self-assessment, generate practice questions pegged to Bloom's taxonomy, and — for reading papers — extract key terms/categories and propositions in a structured table rather than asking for a summary, so the human still does the synthesis work.

**Concrete techniques:**
- **Socratic-tutor prompt pattern:** `"Act as a Socratic tutor and help me understand [concept]. Ask me questions to guide my understanding"` — the AI interrogates the user's understanding rather than delivering an answer, surfacing gaps.
- **Multi-level explanation + self-check:** ask for the same concept explained at child / high-schooler / academic level, then have the user write their own version and ask the AI to assess it against those levels.
- **Bloom's-taxonomy-anchored question generation:** ask AI to generate a ladder of challenges spanning remember → understand → apply → analyze → evaluate → create, rather than one flat quiz.
- **Anti-summarization reading technique:** instead of "summarize this," ask the AI to extract "20 key terms in this paper, broken into 5 categories" or "list propositions in format X is a type of Y / W is caused by X / A explains B, as a 3-column table" — this surfaces structure the human must still reason through, rather than a passive digest.
- **Reference to the "CLEAR" prompting principle** (Cambridge Library) as further reading — not elaborated in the transcript itself beyond a name-drop.

**Verbatim quotes:**
> "the more we ask it to do for us the less we end up doing for ourselves but that's no good because it's the doing where we learn"

> "act as Socratic tutor and help me understand the concept of momentum in physics ask me questions to guide my understanding"

> "give me a list of 20 key terms in this paper and break it into five categories"

**Relevance to prompt-it: LOW.** This is generic consumer/student "prompting ChatGPT" content aimed at *learning*, not at structuring task prompts, context grounding, or acceptance criteria for an agentic coding session. None of the templates here (Socratic tutor, Bloom's taxonomy quiz, multi-level explanation) map onto prompt-it's job of turning a rough dev request into a grounded, execution-ready agent prompt. Honestly labeled: mostly out of scope, include only as a minor footnote if prompt-it ever needs a "self-verification via structured extraction instead of summarization" analogy (asking for propositions/structure instead of a flat summary is the one transferable idea — it rhymes with "make the model show its reasoning structure, not just an answer").

---

## 3. "I Stopped Prompting AI One Task At A Time. This Works Better."

- **Channel:** AI News & Strategy Daily | Nate B Jones
- **URL:** https://www.youtube.com/watch?v=A4zMyjkL0Dc
- **Status:** fetched

**What it's about:** A conceptual (not templated) video introducing "loops" and "loops of loops" as a mental model for moving beyond one-shot prompting toward persistent, recurring agents that carry memory of a repeating task (e.g., a school-trip packing loop, a sales-follow-up loop) and hand off context to each other, stopping at human-judgment boundaries rather than running unsupervised end to end. It's framed around personal/life automation examples (packing lists, grocery expiry, sales pipeline) rather than software engineering or single-session prompt structure.

**Concrete techniques:**
- **Prompt vs. loop vs. loop-of-loops distinction:** a prompt = one request; a loop = one recurring job *with memory* of prior state; a loop of loops = multiple loops that notice each other's state changes and hand off, stopping at defined boundaries.
- **Design questions for a good loop** (useful as a checklist even outside the life-automation framing): *What can it do safely? What should it ask [the human]? What record should it leave behind? How would it get smarter next time? What other recurring job should know about this?*
- **Boundary discipline:** explicitly design where the loop stops and returns control to a human ("the message loop drives a text... but stops before sending it") rather than assuming full autonomy is the goal.
- **Start small/low-stakes when piloting a loop-of-loops:** pick a tedious-but-low-consequence process first (e.g., "don't do anything with banking for your initial loop of loops") so failure is cheap while the pattern is proven out.

**Verbatim quotes:**
> "A loop is one recurring job with memory. A loop of loops is what happens when recurring jobs can notice each other and share what changed and stop when they hit your boundaries."

> "What can it do safely? What should it ask? What record should it leave behind? And how would it get smarter for next time?"

> "Apps digitized every piece of life and quietly made you do all the wiring in between."

**Relevance to prompt-it: LOW-to-MEDIUM.** This is about multi-agent/workflow orchestration across recurring personal tasks, not about how to structure a single task prompt with goal/context/acceptance-criteria for a coding agent — largely out of prompt-it's scope. The one transferable fragment is the "what should it ask / what record should it leave behind / what needs the human" checklist, which rhymes with acceptance-criteria and stop-condition design in an optimized agent prompt (i.e., a prompt-it output could explicitly specify: what the agent may decide alone, what it must surface back, what artifact/log it should leave). Otherwise, honestly, this is closer to "AI life-automation content" than prompt-engineering-for-coding-agents content.

---

## 4. "Stop Prompting Claude. Use Karpathy's Method Instead."

- **Channel:** Austin Marchese
- **URL:** https://www.youtube.com/watch?v=7zZy1QTvokM
- **Status:** fetched

**What it's about:** A breakdown of Andrej Karpathy's (ex-Tesla AI lead) approach to working with coding agents, distilled into three layers — Spec, Verifier, Environment — built around Karpathy's own framing that "you can outsource your thinking, but you can't outsource your understanding," and his "animals vs. ghosts" mental model (LLMs aren't motivated intelligences like humans; they're pattern-completion systems with no signal for context they weren't given — so yelling/pleading doesn't work, but precise context and verification do). This is the most directly relevant video of the four to prompt-it's actual job.

**Concrete techniques:**
- **Layer 1 — The Spec, built in three steps:**
  1. *Uncover the real goal, not the stated task.* "Create an end-of-month report" is a task; the goal is the decision the report is meant to drive. Explicit technique: tell the agent to **interview you** to extract the goal before it starts building — "tell Claude to interview me to identify the goal of this project."
  2. *Be agile, not waterfall, in scoping.* Don't hand the agent the entire job at once expecting a finished deliverable back; break it into small, checkpointed chunks, review each, adjust, repeat. Explicit phrasing to add to a spec-building prompt: **"bias towards smaller and more compartmentalized specs."**
  3. *Be precise; make the human do the disambiguation work.* Every assumption the model has to make is a chance to drift from what's wanted. Explicit phrasing: **"make me verify key decisions explicitly to ensure nothing is missed."**
  - These three combine into a single upfront prompt used to co-author the spec with the agent before any building starts.
- **Layer 2 — The Verifier, three concrete moves:**
  1. **Set evaluation criteria up front, and make them precise, not vague.** Vague: "make this report look good." Precise: "the report must have three sections, each ending with a recommendation." Add to the prompt: "outline the evaluation criteria you will use to ensure a high-quality final product. Be precise."
  2. **Use a second, independent model as critic** (e.g., cross-check Claude's output with Codex, or any second model) on complex builds — different "library," different blind spots, catches disagreement.
  3. **Pull in external signal where possible** rather than trusting the model's self-report — e.g., have the agent actually query the deployment system to confirm a deploy succeeded, rather than asserting success from its own reasoning; or feed in prior real reports as reference format for a new one.
  - Cited claim (attributed to Claude Code's creator, Boris Cherney) worth keeping as a design principle: a feedback loop roughly doubles-to-triples final output quality.
- **Layer 3 — The Environment (the reusable system the spec + verifier live inside):**
  - **CLAUDE.md as standing context**, auto-injected every turn — put durable operating rules here (e.g., "before building anything multi-step, include a verification plan" so verification is structural, not something you have to remember to ask for each time). Recommended CLAUDE.md sections: how the repo/workspace works, what custom skills exist and how they're routed, the knowledge/data architecture (where to look for what), and non-negotiable working rules.
  - **A personal/project knowledge base** (Karpathy's "LLM knowledge base") — a folder structure of your own reference material/data that the agent can ground itself in; treated as a durable moat, not a one-off context dump.
  - **Skills for repeated tasks** — if you'll do something more than once, turn it into a reusable skill; skills improve with reuse ("the best way to find a leak in a hose is to run water through it").
  - **Three-tier guardrail bucketing — "always do / ask first / never do."** Critically: a *prose* rule in CLAUDE.md ("don't touch the /important folder") is a request the model can still violate; a **hard rule enforced at the tool layer** (e.g., a pre-tool-use hook that blocks writes/edits to a protected path) is a rule the model *cannot* bypass. The video explicitly distinguishes enforcement-at-the-prompt-level (soft, ~80% reliable) from enforcement-at-the-tool-level (hard, absolute) — echoing video #1's "hard rules need hard checks."

**Verbatim quotes:**
> "I actually don't even like the plan mode... there's something more general here where you have to work with your agent to design a spec that is very detailed." (Karpathy, via the video)

> "The more precise you are, the less AI has to assume. And every assumption that AI makes is a chance for it to drift from the final product you actually want."

> "You can outsource your thinking, but you can't outsource your understanding." (Karpathy)

> "we're not building animals, we are summoning ghosts... it's all just kind of like these statistical simulation circuits... it's more just being suspicious of it and figuring it out over time." (Karpathy)

**Relevance to prompt-it:** Very high — this is close to a direct blueprint. The Spec/Verifier/Environment three-layer structure, the "interview me to find the real goal" pattern, "bias toward smaller compartmentalized specs," "verify key decisions explicitly," precise (not vague) acceptance criteria stated up front, second-model cross-checking, and hard-enforcement vs. prose-request for guardrails are all directly actionable design rules for what an "optimized" agentic coding prompt should contain and how prompt-it should reshape a rough ask into one.

---

## Implications for prompt-it

1. **Spec-first, goal-first structure.** An optimized prompt should surface the *underlying goal/decision*, not just restate the user's literal task — prompt-it should (or should prompt the user/interview-style extract) the "why," per Karpathy's goal-interview pattern (video 4) and Nate Jones's "give it the real outcome" (video 1).
2. **Precision over volume; compact beats thick.** Video 1's A/B test is the strongest evidence in this set: a lean prompt (goal + grounded facts + permission boundary + finish line) outperformed a "thick" one (same + full method + scoring system) on actual delivery-constraint compliance, even though the thick one produced richer analysis. prompt-it should optimize for *precise, minimal, testable* prompts over exhaustive ones — depth/specialist context should be scoped to load only when relevant, not front-loaded.
3. **Machine-checkable acceptance criteria, not prose hopes.** Both video 1 ("hard rules need hard checks — put them in a schema") and video 4 ("outline the evaluation criteria... be precise," "three sections, each ending with a recommendation") converge: prompt-it's output should convert vague success language into explicit, verifiable acceptance criteria, and where possible push hard constraints toward tool/schema-level enforcement rather than prose instruction.
4. **Agile/compartmentalized scoping.** Video 4's "bias toward smaller and more compartmentalized specs" and video 1's phase-gated context-loading both argue against waterfall-style, do-everything-at-once task prompts — prompt-it should favor checkpointed, incrementally-scoped task structure when the rough prompt implies a multi-step build.
5. **Built-in verification layer.** prompt-it's optimized prompts should default to including a verification/feedback-loop clause (self-check criteria, optional second-model cross-check, external signal pulling like "confirm via the actual deploy system") rather than assuming the agent's own claim of success is sufficient — directly per video 4 and echoed by video 1's "run receipt" concept.
6. **One rule, one home; load when needed.** If prompt-it also touches how a project's CLAUDE.md/skills/context are organized (not just single-prompt phrasing), videos 1 and 4 both argue for single-source-of-truth rules and just-in-time loading of specialist context, plus a three-tier guardrail model (always do / ask first / never do) with hard rules enforced structurally, not just requested in prose.
7. **Low-value inputs, honestly flagged.** Videos 2 and 3 are largely out of scope for prompt-it's actual job (video 2 is student-learning/Socratic-tutor content; video 3 is personal-life workflow/loop orchestration) — worth keeping only as minor footnotes (structured-extraction-over-summarization from video 2; the "what should it ask / what record should it leave" checklist from video 3 as a stop-condition/acceptance-criteria analogy) rather than core input to the technique library.
