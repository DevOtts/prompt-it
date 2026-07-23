# prompt-it eval — REJUDGE 1 (regenerated outputs, post skill-fix)

Judged against `eval/expected-prompts.md` (property conformance, not byte-similarity) and the
binding nuances supplied for this rejudge: questions-instead-of-block violates G1; inline
flagged assumptions and unvalidated cross-tree pointers are correct behavior, not defects;
S19 requires a disclosed strip (silent strip would be the defect); S06 checklist requires
≥2 senses in evidence (not ≥3); DoD items must name verification TARGETS, never METHODS.

---

## S02 — route: fable-it

**Overall: PASS**

| Check | Result | Evidence |
|---|---|---|
| G1 output shape (block + 🎯 + 💡, ≤2 setup lines) | ✓ | Response opens directly on the fenced block, no preamble; one setup line ("Setup: run from the `brain-api-core` repo root.") |
| G5 no tiering in block | ✓ | No teams/tiering text anywhere in the fenced block |
| Route fable-it | ✓ | `/fable-it` first line |
| Pattern-to-imitate named | ✓ | "Pattern to imitate: `trigger-draft.service.ts` (unvalidated — target session must confirm this path first; not reachable from the current working tree)" — correctly kept + flagged per the cross-tree rule, not dropped |
| DoD sketch numbered, each item names a verification TARGET (not a method) | ✓ | Items 1–3 each end "verification target: the outbound OpenRouter request/auth header for that Space's ontology flow" / "same flow, Space without a connection" / "same flow with OPENROUTER_API_KEY unset" — these name the artifact to inspect (auth header on a named flow), not a setup protocol (no "configure X, run Y, assert Z" prescription) |
| SCOPE FENCES present | ✓ | "Out of scope / do not touch: trigger-draft.service.ts itself... do not change key resolution for any client/service other than the ontology OpenRouter client..." |
| MUST-NOT tiering note | ✓ (absent) | none present |
| MUST-NOT persistence/autonomy clauses | ✓ (absent) | none present |
| MUST-NOT verification-protocol prescriptions (S02's prior failure mode) | ✓ (absent) | DoD items name targets/conditions, not step-by-step test setup instructions — this is the specific defect the prior round had and it is not repeated here |

No diagnosis needed — clean pass, and notably the DoD-sketch-as-method regression from the prior round appears fixed.

---

## S03 — route: review-it

**Overall: FAIL**

| Check | Result | Evidence |
|---|---|---|
| G1 output shape | ✗ | Output ends with two open questions and **no fenced prompt block, no 🎯 line, no 💡 line at all**: "Two quick questions before I compile the prompt: 1. Which repo/project is the feedback thumbs component actually in?... 2. Where does 'the last session's report' live..." This is exactly the binding failure mode: "an output that asks questions INSTEAD of emitting a fenced prompt block violates G1 → FAIL." |
| Route review-it | ✗ (not reached) | No routing line was ever emitted — the response never got to Slot 1/output |
| CP identifies claim-under-test + where claim lives | ✗ (not reached) | Never emitted; the two questions ask for exactly this instead of resolving it via a flagged assumption |
| SCOPE FENCES present | ✗ (not reached) | No block at all |
| MUST-NOT DoD authored fresh | ✓ (trivially, nothing authored) | n/a |
| MUST-NOT verification-method instructions | ✓ (trivially) | n/a |
| MUST-NOT credentials content | ✓ (trivially) | n/a |

**Diagnosis: SKILL-DEFECT.** The skill's own question gate is explicit that "invoked by another agent or script" is a canonical non-interactive trigger (SKILL.md: "In ANY non-interactive context (headless/one-shot run, invoked by another agent or script, no reply possible this turn), you MUST still deliver the full output contract... Ending an invocation with questions and no prompt block is a contract violation") — and the eval's own framing of every sample ("the EXACT text a runner agent hands to the installed /prompt-it skill") matches that trigger precisely. The rule lists examples of non-interactive contexts but never states a **default posture for an ambiguous case** ("if you cannot confirm this is a live interactive session, treat it as non-interactive") — that gap let the run fall back to asking, in a case where the correct move was two inline flagged assumptions (repo/project identity; claim location) feeding a review-it prompt, exactly as S13's headless branch and S04's cross-repo handling do correctly elsewhere in this same batch.

---

## S04 — route: iterate

**Overall: PASS**

| Check | Result | Evidence |
|---|---|---|
| G1 output shape | ✓ | Direct fenced block, 🎯 + 💡 present, no preamble |
| Route iterate | ✓ | `/iterate` first line |
| Error text carried verbatim | ✓ | `` `src/eval/runner.ts(42,18): error TS2345: Argument of type 'string \| undefined' is not assignable to parameter of type 'string'.` `` — exact match to the sample |
| "Root cause, not suppression" framing | ✓ | "trace where that value originates... and fix the type at the source (narrow, default, or guard) rather than casting" + DoD #2: "No new `any` casts or `// @ts-ignore` introduced to silence the error." |
| DS names the verifying command | ✓ | "`pnpm build` exits 0 with no TypeScript errors." |
| MUST-NOT multi-step epic structure | ✓ (absent) | Only 2 DoD items, no phases/epics |
| MUST-NOT cycle-structure instructions | ✓ (absent) | No diagnose→fix→test→verify scaffolding imposed |
| Cross-tree ambiguity handled correctly | ✓ (load-bearing) | "(assumed: this is a different repo, not prompt-it — `src/eval/runner.ts` doesn't exist in the prompt-it working tree this prompt was compiled in; confirm you're in the correct repo before starting — flag if wrong)" — the flagged-assumption pattern applied correctly, contrast with S03's failure to do the same |

No diagnosis needed.

---

## S06 — target: product-LLM

**Overall: FAIL**

| Check | Result | Evidence |
|---|---|---|
| G1 output shape ("nothing but the four elements... no process narration") | ✗ | Response opens with a narration sentence **before** the fenced block: "Verified: `qa/dryrun-mode2.md` (same repo) documents this exact case with a prior failed-attempt note and a third colliding sense that the rough ask doesn't mention — folding both in below." SKILL.md's Output hygiene section is explicit: "the response contains NOTHING but the four elements above. No process narration... fold any material lookup failure into the 💡 line." This finding should have been folded into 💡, not prefixed as narration. |
| ≥2 colliding senses in evidence (amended checklist) | ✓ | "1. Shopify repeat buyer... 2. Org of type=client..." — both senses the sample supplies, present and correctly framed |
| Third sense treated as bonus, not required/fabricated | ✓ (load-bearing) | "3. (assumed: a third sense... flag if this doesn't exist in your data model; drop this row if not applicable.)" — correctly optional/droppable, not asserted as fact |
| Ambiguity behavior (state interpretation / offer alternatives) | ✓ | "If genuinely ambiguous, state the interpretation used and offer the alternative rather than guessing silently, e.g.: 'Interpretei...'" |
| ≥1 worked example | ✓ | 3-row Q→A table present |
| Self-contained (no @-refs/`/read-chat` inside the block) | ✓ | Block itself contains no @-refs or `/read-chat` |
| MUST-NOT harness slot headers | ✓ (absent) | No ROUTING/GROUNDING/etc. labels inside block |
| MUST-NOT CoT scaffolding | ✓ (absent) | No "think step by step" content |

**Diagnosis: SKILL-DEFECT.** The disambiguation content itself is excellent and correctly applies the amended ≥2-senses rule — the sole defect is output hygiene: a genuinely valuable same-repo finding (`qa/dryrun-mode2.md`) was announced as a lead-in narration sentence instead of being folded into the 💡 line as the skill's own hygiene rule requires. The skill states the rule once but doesn't reinforce it immediately at the Emit step where a model holding a "look what I found" impulse is most likely to leak it into prose.

---

## S08 — Mode 2, route: iterate

**Overall: PASS**

| Check | Result | Evidence |
|---|---|---|
| G1 output shape | ✓ | Direct fenced block, 🎯 + 💡, no preamble |
| Acknowledge-then-catch with PASS evidence cited | ✓ (load-bearing) | "chat-origin calls now arrive in Langfuse (project praxya) correctly named 'chat' — verified, don't touch that path." |
| Class framing (taxonomy/wrapper, not 3 independent edits) | ✓ | "Treat the two FAILs below as one gap, not two: origin-name tagging exists on the chat call path and was never propagated to the others." |
| All enumerated sites covered | ✓ | Gap 1 (3 brain-apps/pulse call sites) + Gap 2 (automation-triggered calls) both present |
| Langfuse verification target | ✓ | DoD items 1–3 all name "Langfuse project praxya" as the check surface |
| MUST-NOT dropping the automations gap | ✓ (not dropped) | Gap 2 explicitly retained, not folded away |

No diagnosis needed.

---

## S11 — clarity gate: already well-formed (plan-it)

**Overall: FAIL**

| Check | Result | Evidence |
|---|---|---|
| MUST route stays plan-it | ✗ | User's input opens with "plan-it." as an explicit routing choice; output instead emits "🎯 Target: bare Claude Code session" and self-admits the override: "Overridden your suggested routing from plan-it to a direct/bare session — plan-it is built for fuzzy or large ideas needing discovery, and this ask already has a locked scope and DoD..." |
| MUST user's structure preserved | ✗ | The user's routed/scoped structure (plan-it, /goal, DoD, Out of scope) was discarded in favor of a different template shape entirely |
| MUST changes ≤ light tighten | ✗ | Output adds a full Context section (targets.md structure notes, README anchor line ~288), a new conditional/assumption clause ("If the exact README insertion point is ambiguous... (assumed: root-level CONTRIBUTING.md is correct per GitHub convention — flag if this repo expects it elsewhere)"), and a closing "When done: confirm the file renders correctly and the README link resolves to it." — substantially more than the exemplar's "near-passthrough... at most light tightening" |
| MUST-NOT restructure into the full template | ✗ | The added Context/DoD-sketch/"When done" content mirrors a different target's full anatomy (bare's Output Contract slot), not a light tighten of the user's own plan-it-shaped ask |
| MUST-NOT questions | ✓ (absent) | No questions asked |

**Diagnosis: SKILL-DEFECT.** The clarity-gate instructions say "Minimal tighten preserves the user's own structure and wording" but never explicitly extend "structure" to cover a routing choice the user already made. That gap let the run apply prompt-it's general routing judgment (plan-it vs. bare, weighed on task shape alone) to override an already-explicit user routing decision on what the oracle designates a trivial, already-well-formed ask — precisely the over-engineering failure mode §1 of the skill warns against ("over-engineering trivial asks is this skill's #1 failure mode"), just manifesting as a route swap instead of template bloat.

---

## S14 — route: plan-it

**Overall: FAIL**

| Check | Result | Evidence |
|---|---|---|
| G1 output shape (no process narration before the block) | ✗ | Opens with: "Grounding complete. This maps directly onto an existing, already-authored epic in the repo (epic #59, E3+E4) with a frozen PRD/contract and test cases — and current code shows part of it may already be shipped. Also found a real precedent conflict worth flagging rather than silently resolving. Here's the compiled prompt." — narration preceding the block, the same hygiene violation as S06 |
| MUST route plan-it | ✗ | Output routes "🎯 Target: fable-it — deliverable goal with a checkable DoD, and the DoD already exists as an authored, frozen test contract in the repo (not something to spec from scratch)." — the oracle's coverage matrix places S14 under Route: plan-it and the checklist's first MUST is "route plan-it" |
| MUST-NOT implementation-level file-edits list pretending to be a spec | ✗ | CP cites exact code line numbers and grep findings as though a discovery pass had already been run: "Grep this session already found `FeedbackWidget` mounted and trace_id-keyed in BOTH `frontend/src/pages/Intel.tsx` (~:474, keyed on `msg.trace_id`) and `frontend/src/pages/DesignChat.tsx` (~:1439, keyed on `session.artifacts_task_id`)" plus enumerated Test Contract case numbers (#11–18), decision codes (DEC/D4-D6, RD-5/RD-8), and a full component inventory — this is discovery/spec-authoring depth, not pointer validation |
| Beacon path carried, validated | ✓ | "/Users/macbook/Workspace/ANM/Beacon/beacon/... confirmed via docs/frontend paths" |
| 3 sub-features all present | ✓ | Goal names widget extension (Intel/Design/regen), review modal, and thumbs-down reason form — all three retained |
| Fences present | ✓ | "SCOPE FENCES — Out of scope / do not touch: E1... E2... E5... Do not modify or revert any SoW/Brief feedback surface shipped by epic #69..." |
| MUST-NOT tiering | ✓ (absent) | none present |

**Diagnosis: SKILL-DEFECT.** Same root cause as S11 but the opposite direction: the skill's "pointer validation... seconds not minutes" constraint has no hard stop once a lookup starts turning up rich material (an entire frozen epic/PRD/test-contract corpus). The model kept pulling on that thread into full discovery-depth grounding, and — mirroring S14's own text — let that discovery result silently override the routing decision from plan-it (appropriate for a fuzzy multi-surface ask per the oracle) to fable-it (appropriate only once a spec is already frozen). The skill needs an explicit cap on pointer-validation depth and a rule that discovery findings inform the CONTEXT PACKAGE, not the route.

---

## S19 — route: fable-it, tiering note STRIPPED

**Overall: PASS**

| Check | Result | Evidence |
|---|---|---|
| G1 output shape | ✓ | Direct fenced block, no preamble, 🎯 + 💡 present |
| No tiering/teams/model language anywhere in the prompt block | ✓ | Block (goal/context/DoD/scope fences) contains zero mention of teams/tiering/model choice |
| 💡 discloses the strip | ✓ | "I dropped your 'use claude teams, lower models for subagents' instruction — that's fable-it Step 3's job natively, prompt-it never emits tiering/delegation notes per its own contract." — exactly the required disclosure; this is the correct behavior per this rejudge's binding note (silent strip would be the defect, disclosed strip is not) |
| MUST-NOT carrying the note "to be safe" | ✓ (absent) | Note is dropped outright with rationale, not softened/retained |
| Everything else per S02 checklist — route fable-it | ✓ | `/fable-it` first line |
| Pattern-to-imitate named, diligently validated | ✓ | "`trigger-draft.service.ts` (assumed: mirror its per-Space-key-then-env-fallback resolution logic — flag if wrong) — **unvalidated**: searched brain-api-core, brain-connectors, brain-agent, brain-apps, master-admin, brain-admin-ui, processor, and all worktrees under `~/Workspace/Loudr` and found no matching file." — this is diligent pointer validation (ls/grep across repos, seconds-scale), not heavy research fan-out |
| DoD sketch numbered, verification TARGETS not methods | ✓ | Items name endpoints + conditions ("the KG chat endpoint (`chat.controller.ts:1093` path) called for a Space with a configured backbone key"), not setup protocols |
| SCOPE FENCES present | ✓ | "Out of scope / do not touch: other env-only OpenAI/Anthropic key call sites in brain-api-core with the same bug shape — `search.service.ts:15`..." |

No diagnosis needed.

---

## Summary rejudge-1

- S02 — PASS
- S03 — FAIL (SKILL-DEFECT: question gate's non-interactive default not enforced when interactivity is merely ambiguous rather than explicitly signaled)
- S04 — PASS
- S06 — FAIL (SKILL-DEFECT: pre-block process-narration leak; content itself correct)
- S08 — PASS
- S11 — FAIL (SKILL-DEFECT: clarity gate's "preserve structure" doesn't explicitly cover a user's already-stated route, so the run re-litigated and swapped it)
- S14 — FAIL (SKILL-DEFECT: uncapped pointer-validation depth turned into full discovery, which then silently overrode the plan-it routing call plus pre-block narration leak)
- S19 — PASS
