# Research Brief — prompt-it

**Date:** 2026-07-21 · **Run:** fable-it research phase (pre-build discovery)

## The ask (from Fernando)

Create `prompt-it`, the next member of the *-it harness family (plan-it, fable-it, review-it, parallel-lifecycle): a skill that turns a rough user prompt into an optimized, context-grounded prompt.

Two usage modes:
1. **New session** — user writes a simple prompt + calls prompt-it. The skill interprets it, researches the codebase/docs for missing context (asks only if it can't find it), delegates research to lower-model Claude teams to save tokens, and returns the optimized prompt.
2. **Post-review iteration** — after review-it finds gaps in a concluded implementation, prompt-it summarizes the gaps between the implementation and the findings and generates the optimized continuation prompt for the main thread.

## Evidence base gathered

| Lane | Source | Output |
|---|---|---|
| A | prompt-examples.txt (9 hand-written prompts) + analysis-example/ (bosslife/"cliente" case) | research/research-findings-A-local-evidence.md |
| B | 4 sibling plugin repos (structure/conventions) | research/research-findings-B-sibling-plugins.md |
| C1 | YouTube videos 1–4 (Nate B Jones ×2, Python Programmer, Karpathy-method) | research/research-findings-C1-youtube.md + transcripts |
| C2 | YouTube videos 5–8 (Anthropic roundtable, Anthropic-engineers reaction, Ben AI, Google context engineering) | research/research-findings-C2-youtube.md + transcripts |
| D1 | Existing prompt-optimizer tools/skills landscape | research/research-findings-D1-existing-tools.md |
| D2 | 2025–2026 agentic prompting standards (Anthropic, OpenAI, Spec Kit, context engineering) | research/research-findings-D2-best-practices.md |

Synthesis + spec-ready brief: `research-SYNTHESIS.md` (root).
