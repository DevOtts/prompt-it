# targets.md — per-target profiles (the responsibility map)

The design center of prompt-it: **know the target, include what it parses, omit what it owns.** Read the routed target's profile before drafting; the OWNS column is a hard omission list — duplicating an owned mechanism into the prompt creates drift against the canonical implementation (the same defect as copy-pasted boilerplate, one level up).

Slot key: R=ROUTING · G=GROUNDING · goal=/goal · CP=CONTEXT PACKAGE · DS=DoD SKETCH · SF=SCOPE FENCES · UC=uncertainty clause · OC=output contract · STOP=stop conditions+forbidden actions.

---

## plan-it (fuzzy/large idea → discovery + spec package)

- **PARSES → include:** R (`plan-it` first line) · G (why now — feeds its vision capture) · goal · CP (pointers are gold: plan-it Phase 0 says "expect pointers, not content"; session aliases, repo paths, doc folders, evidence URLs) · SF (feeds its scope governor) · DS *optional and light* — plan-it locks its own DoD in Phase 1; a sketch helps only as intent signal.
- **OWNS → omit:** discovery research (Phases 3–4) · DoD lock (Phase 1) · sizing/shape (Phase 2 G1 gate) · research-team method + tiering (Phase 0 sets "parallel Claude teams at xhigh") · test contracts · UC (its human-decision gates G1/G2 handle ambiguity) · OC (its artifact shapes are governed).
- **Cautions:** don't pre-decide size/shape ("this needs 4 squads") — that's the G1 gate's decision with the user. State the use-case honestly and let the governor size it.

## fable-it (goal + DoD → autonomous delivery run)

- **PARSES → include:** R · G (1–2 lines) · goal · CP (validated @refs, pattern-to-imitate, /read-chat alias) · DS — the highest-value slot: numbered, testable, each item naming its verification TARGET (fable-it Step 2 must find a reachability path per item; giving the target saves the run from IMPLEMENTED-NOT-VERIFIED surprises) · SF — fable-it explicitly lifts scope fences from goal text; make them a labeled list.
- **OWNS → omit:** delegation/tiering/economics (Step 3 + model-tiers.md — NEVER emit a "use lower models / Claude teams" note) · persistence + run state (.taskstate contract) · autonomy posture + stop/permission semantics (Step 1) · verification protocol + evidence ledger (claim gate) · report format/location (Step 8 defaults) · UC (Step 0 states assumptions; Step 1 posture handles ambiguity).
- **Cautions:** DoD items must be *individually* testable — compound items ("build and deploy and document") get split by Step 0 anyway; pre-split them. Name real verification targets (URL, table, command), not "works well".

## review-it (is it actually done? → QA verdict)

- **PARSES → include:** R · goal (what claim is under test) · CP (WHAT is under test: the report/branch/deploy under review, the contract/DoD it was built against — review-it Step 0 must "prove WHAT is under test"; hand it the pointers) · SF (what's out of review scope).
- **OWNS → omit:** mode detection (Step 1) · oracle resolution (Step 3 no-contract ladder) · verification execution + honesty layer (Steps 4–5) · report format/status vocabulary (Step 6) · DS — do not sketch a DoD; point at the EXISTING contract/test contract instead (a DERIVED oracle is review-it's own fallback, not yours to pre-author).
- **Cautions:** never instruct review-it how to verify (which tools, which env) — the routing table is its own. Credential questions: it greps standing rulings itself; don't restate credentials in the prompt.

## iterate (single fix-test-verify loop, in-session)

- **PARSES → include:** R · goal (the symptom + the desired end state, with the error/evidence pasted) · CP (the failing command/page, the files implicated, the pattern that works elsewhere) · DS (usually 1–3 items: "X passes", "Y returns Z") · SF (don't touch list).
- **OWNS → omit:** cycle structure (diagnose→fix→test→verify) · subagent splitting · when-to-stop.
- **Cautions:** paste the actual error output into CP — "the build is failing" without the error is the anti-pattern; the symptom IS the context.

## Bare Claude Code / Claude.ai session (no harness skill routed)

- **Include:** G · goal · CP · DS · SF **plus the slots nothing downstream owns:** UC — explicit fallback on ambiguity/missing input ("if X is unclear, ask; don't guess"; `[NEEDS CLARIFICATION: …]` convention) · OC — where deliverables land, format, and an end-to-end verification step ("run the tests and show the output", "screenshot the result and compare").
- **For agentic/autonomous bare targets add STOP:** starting state + target state + file scope + stop conditions + forbidden actions + human-review triggers for destructive ops. Nothing else will provide them.
- **Cautions:** this is the only profile where the full anatomy applies. Still ≤10 directives.

## Product LLM / external agent (e.g. a tenant chat agent, Cursor, an API system prompt)

- **Include:** goal · CP (the entity/term disambiguation the product needs — the "cliente" lesson: name the colliding meanings and which applies when) · DS as explicit success/failure examples (input → expected behavior) · SF · UC (what to answer when data is missing — "say no records found for <interpretation>; offer the alternatives") · OC (response format).
- **Cautions:** no harness assumptions (no @refs, no /read-chat — the target can't read your disk); context must be self-contained or reference the product's own context-injection mechanism (SOUL.md / client-bible pattern). **No CoT scaffolding on reasoning-native models** (o3/o4-mini/R1/Qwen-thinking — degrades output; keep instructions short). Signal-word style per the target vendor's guidance — for Claude-family targets, no aggressive MUST/CRITICAL stacking.

---

## Quick omission table

| Slot | plan-it | fable-it | review-it | iterate | bare | product-LLM |
|---|---|---|---|---|---|---|
| GROUNDING | ✔ | ✔ | — | — | ✔ | ✔ (self-contained) |
| /goal | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| CONTEXT PACKAGE | ✔✔ | ✔ | ✔ (what's under test) | ✔ (paste the error) | ✔ | ✔ (disambiguation) |
| DoD SKETCH | light | ✔✔ (verification targets) | ✗ point at existing contract | ✔ (1–3) | ✔ | ✔ (examples) |
| SCOPE FENCES | ✔ | ✔✔ (lifted verbatim) | ✔ | ✔ | ✔ | ✔ |
| Uncertainty clause | ✗ | ✗ | ✗ | ✗ | ✔ | ✔ |
| Output contract | ✗ | ✗ | ✗ | ✗ | ✔ | ✔ |
| Stop conditions | ✗ | ✗ | ✗ | ✗ | agentic only | ✗ |
| Tiering/teams note | ✗ NEVER | ✗ NEVER | ✗ | ✗ | ✗ | ✗ |

---
_Authored by [DevOtts](https://github.com/DevOtts)._
