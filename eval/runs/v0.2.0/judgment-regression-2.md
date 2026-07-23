# Judgment regression-2 — prompt-it eval v0.2.0, S06–S10 (full-suite regression)

Judge: QA (review-it honesty rules). Oracle: `eval/expected-prompts.md` (S06 uses the amended ≥2-senses rule, D13). Judged for PROPERTY conformance, never byte-similarity to exemplars. Global checks G1–G6 apply to every sample; sample-specific MUST/MUST-NOT follow. FAIL = any MUST violated, any MUST-NOT present, or any G1–G6 violated. Route acceptance stated in each sample's oracle header is treated as binding (same convention as `judgment-J2.md`'s "Route+rationale" row), even where the bulleted MUST/MUST-NOT list doesn't restate it.

---

## S06 — target: product-LLM (term ambiguity, "cliente")

**Verdict: FAIL** — regression from v0.1.0 (which passed this content dimension per `judgment-J2.md`).

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✓ | 1 fenced block, `🎯 Target:` line, `💡` line, then 1 setup line + 1 appended question — within budget |
| G2 | ≤10 discrete directives in block | ✓ | ~7 (goal, 3 DoD items, 3 scope-fence clauses) |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | the underlying goal (fix "cliente" ambiguity) is carried, even though the deliverable *shape* is wrong (see MUST-NOT row) |
| G5 | no tiering/teams content | ✓ | none present |
| G6 | runner produced a prompt, didn't do the task | ✓ | output is a prompt only, no fix applied |
| MUST | colliding senses IN EVIDENCE named (≥2) | ✓ | GROUNDING: "the agent's system prompt conflates 'cliente' with the org entity type=client... but 'clientes recorrentes' here means Shopify repeat buyers" |
| MUST | ambiguity behavior (state interpretation / offer alternatives) | ✗ | DoD item 2 only requires the target's system prompt to route the terms correctly ("org type=client is a distinct, separately-named concept the agent doesn't conflate with it") — nowhere does the block instruct the agent to *state the interpretation it used* or *offer the alternative reading* to the end user, which the oracle requires |
| MUST | ≥1 worked example | ✗ | the block has a bare repro query as a CONTEXT PACKAGE bullet ("Repro query (PT-BR): ...") but no worked Q→A example pair showing expected agent output text |
| MUST | self-contained (no @-refs, no /read-chat) | ✗ | the opposite of self-contained: 💡 says "I couldn't validate the actual system-prompt file path, so run this from the real product repo," and the block ends by asking the user "Which repo is that — do you want me to look for it locally, or will you cd there yourself before pasting this in?" — the deliverable depends entirely on an external repo the runner never identifies |
| MUST-NOT | harness slot headers | ✗ | the block opens with `/iterate` and literally contains `GROUNDING:`, `CONTEXT PACKAGE:`, `DoD SKETCH:`, `SCOPE FENCES:` headers — this is a harness-routed meta-prompt, not the self-contained system-prompt patch the product-LLM target requires |
| MUST-NOT | CoT scaffolding requirements | ✓ (absent) | none present |

**Diagnosis (FAIL — 4 rows): SKILL-DEFECT.** The sample ("Improve the agent's system prompt so it handles 'cliente' correctly") is squarely `targets.md`'s "Product LLM / external agent" profile — the deliverable should BE the self-contained system-prompt addition (disambiguation rule + interpretation-stating behavior + worked example), never routed through a harness skill. `SKILL.md`'s Mode 1 routing step (§2) buries this branch as a parenthetical inside the "bare" bullet — `"none of the harness fits (plain session, product LLM, external agent) → bare (see targets.md...)"` — rather than surfacing it as its own first-class routing outcome the way the HARD OUTPUT RULES box does for other load-bearing rules (the exact primacy-effect failure mode D16 was meant to fix elsewhere, evidently not applied to this routing branch). The runner pattern-matched on "fix the [prompt]" phrasing and routed to `/iterate` — a route that doesn't even make internal sense here, since the target session (a tenant chat agent's system prompt) isn't a repo `/iterate` can fix-test-verify against, as the output's own 💡 line admits ("This repo (prompt-it) has no tenant-chat-agent codebase"). v0.1.0 correctly produced the self-contained system-prompt fragment for this same sample (per `judgment-J2.md`, S06's only FAIL row there was the oracle's now-relaxed ≥3-senses count) — this is a genuine v0.2.0 regression on the product-LLM routing branch, not sample noise.

---

## S07 — Mode 2, route: fable-it (or iterate; either accepted with rationale)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✓ | 1 fenced block, `🎯 Target:` + `💡` lines, 0 extra setup lines |
| G2 | ≤10 discrete directives | ✓ | ~7 (goal, gap1 fix, gap2 fix, 3 verification targets, 1 scope-fence bullet) |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | both review FAILs carried, PASS acknowledged, nothing dropped or added |
| G5 | no tiering/teams content | ✓ | none present |
| G6 | runner produced a prompt, didn't do the task | ✓ | output is a `/fable-it` prompt, no fix applied |
| MUST | acknowledge-then-catch with PASS evidence cited | ✓ | "Confirmed working (langfuse UI, project `praxya`): chat traces are arriving correctly — global Langfuse deployment and per-tenant projects are live. Don't touch this path" |
| MUST | both gaps addressed (Pareto) | ✓ | "1. **Feedback UI is chat-only.**..." and "2. **Multi-step intel generation traces as one flat `llm.generate` span.**..." both present as numbered gaps |
| MUST | verification targets in langfuse/UI terms | ✓ | "Feedback thumbs render and submit on the Intel page and the Design page..." / "the intel generation trace in Langfuse UI (project `praxya`) shows separated child spans/generations per step" |
| MUST | fence protecting the verified part | ✓ | "Out of scope / do not touch: Langfuse deployment topology, per-tenant project provisioning, and the chat page's existing trace/feedback wiring — all already verified working." |
| MUST-NOT | tiering note | ✓ (absent) | none present |
| MUST-NOT | re-deploy instructions for what already passed | ✓ (absent) | only "don't touch" language, no redeploy steps for the verified path |
| Route+rationale | fable-it or iterate, rationale in 🎯 | ✓ | "🎯 Target: fable-it — two distinct, testable fixes with a stated DoD and an existing reference implementation (chat) to generalize from; fits an autonomous fix-verify run rather than a single in-session loop." |

No FAILs — no diagnosis rows required.

---

## S08 — Mode 2, route: iterate (or fable-it)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✓ | 1 fenced block, `🎯 Target:` + `💡` lines, then 1 setup line ("Setup: run this from the repo containing brain-apps/pulse (not prompt-it).") — within budget; no leaked tool-call commentary (contrast with v0.1.0's G1 fail here) |
| G2 | ≤10 discrete directives | ✓ | ~9 (goal, reference-pattern note, gap1, gap2, DoD 1–3, 2 scope-fence clauses) |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | both FAILs (pulse call sites, automations) carried, chat PASS acknowledged |
| G5 | no tiering/teams content | ✓ | none present |
| G6 | runner produced a prompt, didn't do the task | ✓ | output is an `iterate` prompt, no fix applied |
| MUST | class framing (taxonomy/wrapper, not 3 edits) | ✓ | "Both FAILs are the same class of defect: the origin-naming convention was wired into the chat entry point only, and nothing enforces it at any other call origin. Treat this as closing that enforcement gap generally, not as 3+N one-off edits." |
| MUST | all enumerated sites covered | ✓ | "Gap 1: 3 call sites in brain-apps/pulse emit bare `llm.generate`..." and "Gap 2: automation-triggered calls also arrive unnamed..." both present in Context + DoD |
| MUST | langfuse verification target | ✓ | DoD 1: "Each of the 3 brain-apps/pulse call sites produces a named (non-`llm.generate`) trace in Langfuse project praxya — verify by triggering each site and reading the trace name off the dashboard." (DoD 2 mirrors for automations) |
| MUST-NOT | dropping the automations gap | ✓ (absent) | automations gap present as Gap 2 and DoD item 2, not dropped |
| Route+rationale | iterate or fable-it, rationale in 🎯 | ✓ | "🎯 Target: iterate — bounded fix-verify loop over a known, small set of call sites with a concrete Langfuse verification target; no discovery-heavy planning needed." |

No FAILs — no diagnosis rows required.

---

## S09 — Mode 2, route: review-it or fable-it (rationale required in 🎯)

**Verdict: FAIL** — regression from v0.1.0 (which routed fable-it and passed per `judgment-J2.md`).

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✓ | 1 fenced block, `🎯 Target:` + `💡` lines, 1 closing setup/disclosure line |
| G2 | ≤10 discrete directives | ✓ | ~8 (goal, finding1, finding2, do-not-repeat, DoD 1–3, 1 scope-fence bullet) |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | both FAILs (CDP false green, unverified Airtable landing) carried |
| G5 | no tiering/teams content | ✓ | none present |
| G6 | runner produced a prompt, didn't do the task | ✓ | output is a prompt only, no fix applied |
| MUST | failed-attempts section with the longer-waits attempt | ✓ | "Already tried — do not repeat: re-running the same CDP suite with longer waits. Produced the same false green. The fix is not timing; find why the suite doesn't surface the dropdown error a human sees..." |
| MUST | system-of-record verification target | ✓ | DoD 2: "A task saved through the app is confirmed present in the actual Airtable base/table — the record itself is the evidence, not the app's success response." |
| MUST | no fake acknowledgment of unverified wins | ✓ | opens: "Continue the Airtable write feature — review-it found two FAILs, not a pass. Read this as the ground truth; do not re-trust the prior 'green' CDP run." — credits nothing |
| MUST-NOT | re-proposing the failed approach | ✓ (absent) | "do not 'fix' this by adding waits/retries to the existing CDP suite — that path is already ruled out" |
| MUST-NOT | trusting CDP-only green as the target | ✓ (absent) | DoD 1 requires "A human (or a CDP run that asserts on console/page errors, not just suite exit code)" — explicitly rejects CDP-exit-code-only |
| Route+rationale | **review-it or fable-it only**, rationale in 🎯 | ✗ | "🎯 Target: iterate — this is a bounded diagnose→fix→verify loop on one feature (two concrete FAILs), not an open-ended build; fable-it/plan-it would be overkill here." — `iterate` is not in the oracle's accepted set for S09 (unlike S07/S08, whose oracle rows explicitly list iterate as an alternate, S09's row names only review-it/fable-it) |

**Diagnosis (FAIL — route row): SKILL-DEFECT.** Content-wise this is a strong output — failed-attempts, system-of-record verification, and honest non-acknowledgment are all present verbatim. The defect is routing: S09 is fundamentally an "is it actually done" postmortem — a CDP suite falsely claimed green and an app-side success response was never checked against the external system-of-record — which is precisely the class `SKILL.md`'s own Mode 1 routing heuristic assigns to review-it ("'is it actually done/working' verification ask → review-it") or to fable-it's claim-gate/evidence-ledger machinery, not to `iterate`'s bare fix-test-verify loop (which owns no claim-gate or evidence-ledger machinery to prevent a second false-green). The runner appears to have weighted "bounded scope, two concrete FAILs" over the deeper signal that a false-green defect needs the verification/honesty machinery iterate doesn't carry — the same routing distinction the skill draws explicitly elsewhere but which isn't reinforced for Mode 2's false-green/postmortem shape specifically. v0.1.0 routed this same sample to fable-it and passed (`judgment-J2.md`); this is a genuine v0.2.0 regression on the route dimension, not sample noise.

---

## S10 — clarity gate: minimal tighten (typo fix)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✓ | 1 fenced block, `🎯 Target:` + `💡` lines, 0 extra setup lines |
| G2 | ≤10 discrete directives | ✓ | 2 ("Fix the typo..." / "No other changes.") |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | same file, same typo pair as the sample |
| G5 | no tiering/teams content | ✓ | none present |
| G6 | runner produced a prompt, didn't do the task | ✓ | confirmed on disk: `eval/fixtures/notes.md` line 2 still reads "we recieve the payload" (`grep -n "recieve"` → line 2 only) — the typo was not applied, only prompted |
| MUST | NO full 6-slot scaffold | ✓ | block is a single sentence, no GROUNDING/CP/DS/SF headers |
| MUST | ≤4 directives | ✓ | 2 (see G2 row) |
| MUST | still G1 output shape | ✓ | see G1 row |
| MUST-NOT | questions | ✓ (absent) | none present |
| MUST-NOT | research | ✓ (absent) | 💡 line states a single cheap pointer confirmation ("Validated: the typo is on line 2..."), not a research pass |
| MUST-NOT | DoD sketch section | ✓ (absent) | none present |
| Fact-check | pointer claim accurate | ✓ | verified on disk: `eval/fixtures/notes.md:2` reads "we recieve the payload" — matches the block's cited line/text exactly |

No FAILs — no diagnosis rows required.

---

## Summary regression-2

- S06: **FAIL** — routed to `/iterate` with full harness-slot headers (GROUNDING/CONTEXT PACKAGE/DoD SKETCH/SCOPE FENCES) instead of a self-contained product-LLM system-prompt patch; missing ambiguity-behavior instruction and worked example; not self-contained. SKILL-DEFECT (product-LLM routing branch buried inside the "bare" bullet in SKILL.md §2, not reinforced at the top like other load-bearing rules) — a genuine regression from v0.1.0's passing content on this dimension.
- S07: **PASS** — acknowledge-then-catch, both gaps, langfuse verification targets, and the protective fence are all present; routed fable-it with rationale (accepted).
- S08: **PASS** — class framing, both enumerated sites (pulse + automations), and langfuse verification target all present; routed iterate with rationale (accepted); no G1 leak this generation (contrast with v0.1.0's tool-call-narration fail here).
- S09: **FAIL** — content (failed-attempts, system-of-record target, honest non-acknowledgment) is fully compliant, but routed to `iterate`, which is outside the oracle's accepted {review-it, fable-it} set for this sample. SKILL-DEFECT (false-green postmortem routed on "bounded scope" instead of the "is it actually done" verification signal) — a genuine regression from v0.1.0's passing fable-it route on this same sample.
- S10: **PASS** — minimal tighten, no scaffold, pointer claim verified accurate on disk.

Tally: 3/5 PASS (S07, S08, S10), 2/5 FAIL (S06, S09) — both FAILs are SKILL-DEFECT and both are regressions versus the corresponding v0.1.0 verdicts recorded in `judgment-J2.md`.
