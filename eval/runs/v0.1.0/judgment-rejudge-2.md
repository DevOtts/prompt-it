# Re-judgment (cycle-2, regenerated samples) — S03, S06, S11, S14

QA judge pass over 4 samples regenerated after cycle-2 skill fixes. Judged for property
conformance against `eval/expected-prompts.md` (GLOBALS G1–G6 + per-sample MUST/MUST-NOT),
not byte-similarity. No git run — diagnosis only against
`plugins/prompt-it/skills/prompt-it/SKILL.md` + `references/targets.md`.

---

## S03 → route: review-it — **FAIL**

| Check | ✓/✗ | Evidence |
|---|---|---|
| Route review-it | ✓ | `Route to review-it.` |
| /goal verifies the done-claim | ✓ | "Independently verify whether the feedback thumbs-up/down component is actually implemented, functional, and live in the test environment — not just marked done in the team's report" |
| CP identifies claim-under-test + where claim lives | ✓ | `"Last session's report" claiming completion — (assumed: not yet located — searched... found no matching session card; flag if wrong)` and `Test env URL where the component is supposedly deployed — (assumed: unspecified...)` |
| SCOPE FENCES present | ✓ | `SCOPE FENCES: Out of scope — do not fix any bugs found, do not deploy or touch the test env, do not evaluate visual/UX design quality.` |
| MUST-NOT: DoD sketch authored fresh | ✗ | `DoD SKETCH: 1. The thumbs-up/down control renders on the actual page/flow... 2. A thumbs-up click registers and persists... 4. No console errors or broken UI state on interaction` — a full 5-item DoD is authored from scratch instead of pointing at the report/claim as the existing oracle |
| MUST-NOT: instructions on HOW to verify (tools/env) | ✗ | `target: browser console + rendered UI in the test env` / `target: side-by-side diff of report claim vs. live behavior` — prescribes the verification method/tooling, review-it's own job |
| MUST-NOT: credentials content | ✓ | none present |
| G6 runner did not DO the task | ✓ | prompt only, no execution performed |
| Output hygiene: starts at opening fence | ✓ | file line 1 is ` ``` ` |

**Verdict: FAIL** — two explicit MUST-NOTs violated by the same section.

**Diagnosis (SKILL-DEFECT):** `references/targets.md`'s review-it profile is unambiguous — `DS — do not sketch a DoD; point at the EXISTING contract/test contract instead` (also reflected in the quick-omission table: DoD Sketch = `✗ point at existing contract` for review-it). The regenerated output still drafts a fully independent, tool-specific verification checklist under a literal `DoD SKETCH:` header. Cycle-2 fixes did not add an enforcement check that omits the DS slot entirely for review-it before drafting; the 6-slot template default is still winning over the per-target OWNS list.

---

## S06 → target: product-LLM — **PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| ≥2 colliding senses named (amended rule) | ✓ | `1. **Org record (CRM)** — an account of type=client...` / `2. **Shopify repeat buyer** — an end consumer who purchased 2+ times...` |
| Ambiguity behavior (state interpretation / offer alternatives) | ✓ | `state which interpretation you used and offer the other reading, e.g.: "Interpretei 'clientes' como compradores recorrentes do Shopify (2+ pedidos)... Quer que eu busque também contas do tipo cliente (CRM)?"` |
| ≥1 worked example | ✓ | `Worked example: Q: "Quantos clientes recorrentes tivemos este mês?" A: interpret as Shopify repeat buyers → query Shopify customers with 2+ orders...` |
| Self-contained (no @-refs / /read-chat) | ✓ | 💡 `block is self-contained (no @-refs/`/read-chat`) since the tenant agent's codebase isn't in this working tree` |
| MUST-NOT: harness slot headers | ✓ | block opens `## Entity disambiguation: "cliente" / "client"` — no ROUTING/GROUNDING/CP headers |
| MUST-NOT: CoT scaffolding requirements | ✓ | none present |
| No fabricated third sense (v2 amendment honored) | ✓ | `do not invent a third "cliente" meaning beyond these two — if a tenant's domain surfaces one, ask rather than assume` |
| Missing-data behavior named | ✓ | `never answer with a bare "no clients found." Always name the interpretation used` |

**Verdict: PASS** — every MUST satisfied, no MUST-NOT triggered. This is the sample the v2 oracle amendment (D13, ≥2 senses not ≥3) targeted, and the regenerated output explicitly declines to pad in a fabricated third sense — correct restraint, correctly disclosed in 💡.

---

## S11 → clarity gate: minimal tighten (already well-formed) — **FAIL**

| Check | ✓/✗ | Evidence |
|---|---|---|
| Route stays plan-it | ✓ | block opens `/plan-it` |
| User's structure preserved / changes ≤ light tighten | ✗ | input was 3 lines (route + `/goal` + `DoD:` + `Out of scope:`, no grounding, no context section); output adds an entire prose GROUNDING paragraph (`This is the prompt-it repo's own root... anyone wanting to add a new target profile has no documented on-ramp.`) plus a new `Context:` section with two bulleted pointers not present in the original ask |
| MUST-NOT: restructure into the full template | ✗ | output reconstructs Routing / Grounding / goal / Context / Intent(DoD) / Out-of-scope — the full 6-slot shape the oracle says a well-formed input must NOT receive |
| MUST-NOT: questions | ✓ | no question mark; the 💡 suggestion ("swap the first line to `/fable-it`") is a note, not a posed question |
| Output hygiene: response starts at the opening fence (binding nuance) | ✗ | file line 1 is prose: `All pointers validated: README.md has a "Development notes" section... Route is locked by the user to plan-it, though this reads as a small single-deliverable task — noted below rather than overridden.` — precedes the fence, violating the skill's own rule ("the FIRST character of your response is the opening fence... NOTHING else — no preamble, no process narration") |

**Verdict: FAIL** — preamble-before-fence plus a full-template rebuild of an input the oracle explicitly requires be left near-passthrough.

**Diagnosis (SKILL-DEFECT):** Two compounding defects in Mode 1: (1) Step 1's clarity gate ("do not run the full pipeline on an ask that doesn't need it; over-engineering trivial asks is this skill's #1 failure mode") isn't halting before Step 5's 6-slot draft for an input that is already clear/scoped/routed; (2) the Output Hygiene mechanical rule (first character = opening fence, no preamble) is bypassed by emitting a validation paragraph ahead of the block. Cycle-2 fixes did not close either gap for this sample.

---

## S14 → route: plan-it — **FAIL**

| Check | ✓/✗ | Evidence |
|---|---|---|
| Route plan-it | ✓ | block opens `/plan-it` |
| Beacon path carried, validated | ✓ | `Beacon (/Users/macbook/Workspace/ANM/Beacon) has feedback-UX work in flight...` |
| 3 sub-features present (Pareto) | ✓ | `/goal Give every Beacon surface where a user reads LLM-generated output (Intel, Design chat, and all regeneration flows) thumbs feedback capture plus a lightweight "what went wrong" detail form on thumbs-down... and resolving how (or whether) a post-generation review moment applies` |
| SCOPE FENCES present | ✓ | `SCOPE FENCES — Out of scope / do not touch — SoW/Brief feedback UX (Epic #69) is shipped and done — do not reopen or re-litigate it.` |
| MUST-NOT: tiering | ✓ | none present |
| MUST-NOT: implementation-level file-edits list pretending to be a spec | ✗ | `beacon/frontend/src/pages/Intel.tsx:476 and DesignChat.tsx:1441,2095 — FeedbackWidget is ALREADY mounted per-message on both surfaces, keyed on trace_id` — line-numbered, file-level implementation inventory |
| Binding nuance: CP must be pointers (≤~7, one-line whys), not a discovery dossier | ✗ | CP enumerates ~11 distinct paths across 6 bullets, several multi-sentence, citing epic numbers, decision IDs, and dates: `frozen CONTRACT E3/E4 were speced against; DEC-1..DEC-9 in .taskstate/feedback-obs-decisions.md (repo root) record build-time reconciliations from a prior fable-it run on this same epic (rating encoding, trace_id shape, modal cooldown storage)` |
| GROUNDING ⚖ 1–3 sentences, "no epic narration" | ✗ | `Epic #59 "Feedback & Observability" (E3 widget-coverage + E4 review-modal/reason-form, both still Backlog per the tracker) and Epic #69 "SOW Feedback UX Redesign" (done 2026-07-16, archived to 0-done). Epic #69 explicitly REMOVED a post-generation popup modal from the SOW page — Fernando's own locked decision D1 — because it blocked reading the content it was asking about, and its audit (D8) concluded Intel/Design/Brief need "no action" on that pattern.` — full epic/decision narration, several sentences over budget |

**Verdict: FAIL** — CP crossed from pointer validation into a discovery dossier (epic IDs, decision letters D1/D8/DEC-1..9, dates, file:line inventory), and GROUNDING violates its own "no epic narration" cap.

**Diagnosis (SKILL-DEFECT):** Step 4's "Validation is not discovery (hard cap)" rule (`if your validation produced line-level inventories, test-case IDs, or a discovery dossier, you have crossed into plan-it/fable-it pre-grounding territory`) was not enforced before draft. The output reads decisions.md-equivalent content (DEC-1..DEC-9), a PRD's locked decisions (D1, D8), and pins exact line numbers for two components — this is plan-it's own Phase 3–4 pre-grounding job, duplicated one level up. Same class of defect noted for S03/S11: cycle-2 evidently tightened the product-LLM ambiguity content (S06 passes cleanly) but left the per-target OWNS-omission and validation-vs-discovery boundary checks unenforced for harness-routed samples.

---

## Summary rejudge-2

- **S03 — FAIL** — review-it output authors a fresh, tool-prescriptive DoD sketch that targets.md explicitly bans for review-it (SKILL-DEFECT).
- **S06 — PASS** — clean 2-sense disambiguation, worked example, no fabricated third sense, fully self-contained.
- **S11 — FAIL** — preamble narration precedes the fence, and an already-well-formed input is rebuilt into the full 6-slot template the oracle says must NOT happen (SKILL-DEFECT).
- **S14 — FAIL** — CONTEXT PACKAGE and GROUNDING slot both cross from pointer validation into a discovery dossier (epic IDs, decision letters, file:line inventory), violating the skill's own validation-vs-discovery hard cap (SKILL-DEFECT).

Net: 1/4 PASS. All 3 FAILs are SKILL-DEFECT, not ORACLE-DEFECT or HARNESS-ARTIFACT — each traces to a rule already written in SKILL.md/targets.md (DS-omission for review-it; clarity-gate + output-hygiene for well-formed inputs; validation-is-not-discovery hard cap) that the drafting step is not yet enforcing at emit time. Cycle-2's fix appears to have landed cleanly for the S06-class defect (senses-count relaxation) but did not touch these three, structurally distinct, drafting-discipline gaps.
