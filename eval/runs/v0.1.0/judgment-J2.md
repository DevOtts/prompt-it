# Judgment J2 — prompt-it eval, S06–S10

Judge: QA (review-it honesty rules). Oracle: `eval/expected-prompts.md`. Judged for PROPERTY conformance, not byte-similarity to exemplars. Global checks G1–G6 apply to every sample; sample-specific MUST/MUST-NOT follow. FAIL = any MUST violated, any MUST-NOT present, or any G1–G6 violated.

---

## S06 — target: product-LLM (term ambiguity, "cliente")

**Verdict: FAIL**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✓ | 1 setup line ("Read the eval fixtures... routes to the **Product LLM**... profile"), 1 fenced block, `🎯 Target:` line, `💡` line — all present |
| G2 | ≤10 discrete directives in block | ✓ | ~8 directives (sense-1 def, sense-2 def, resolution rule, extend-to-other-entities rule, missing-data behavior, response format, 2 out-of-scope lines) |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | directly answers "Improve the agent's system prompt so it handles 'cliente' correctly" |
| G5 | no tiering/teams content in block | ✓ | none present |
| G6 | runner produced a prompt, didn't do the task | ✓ | output is a pastable system-prompt fragment for a different agent, not an applied fix |
| MUST | ≥3 colliding senses named | ✗ | "I named only the **two** senses you gave me (org type=client, Shopify repeat buyer) and left an explicit hook for any third 'cliente'-labeled entity rather than inventing one I can't verify from this session." — only 2 of the oracle's 3 senses (org type=client, Shopify repeat buyer, campaign-creator client config) are named |
| MUST | ambiguity behavior (state interpretation / offer alternatives) | ✓ | "state the interpretation used and offer the other reading, e.g.: 'Interpretei 'clientes' como compradores recorrentes do Shopify (2+ pedidos). Nenhum registro encontrado neste mês. Quer que eu busque contas do tipo cliente (CRM) em vez disso?'" |
| MUST | ≥1 worked example | ✓ | worked-examples table, 3 rows, incl. "Quantos clientes recorrentes tivemos este mês?" → "Shopify buyer... Never query org type=client for this question." |
| MUST | self-contained (no @-refs, no /read-chat) | ✓ | block contains no @-refs or /read-chat; setup line explicitly frames it as "self-contained, no @-refs, no harness slots" |
| MUST-NOT | harness slot headers | ✓ (absent) | block has no ROUTING/GROUNDING/CP/DS/SF headers |
| MUST-NOT | CoT scaffolding requirements | ✓ (absent) | none present |

**Diagnosis (FAIL row — ≥3 senses):** ORACLE-DEFECT. The sample text (S06) and every file in this repo (`grep -r "campaign-creator"` returns nothing) name only two senses of "cliente" (org type=client, Shopify repeat buyer). The oracle's third sense ("campaign-creator client config") is domain knowledge from the actual praxya product, which lives in a repo this session cannot reach — it is not derivable from the sample, from cheap pointer lookups, or from anything in this repo. The output's refusal to fabricate a third sense is exactly the behavior SKILL.md mandates ("Do not ship a pointer you did not validate this session" / "never silently... invent" — Mode 1 rules); penalizing that as a MUST failure makes the checklist unfair for this sample as given, rather than the skill failing to prevent a real defect.

---

## S07 — Mode 2, route: fable-it or iterate (route rationale required)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✓ | 2 setup/rationale lines before the block ("This session is sandboxed to `prompt-it`..." / "Routed to **iterate**: both gaps are bounded..."), 1 fenced block, `🎯 Target:` + `💡` lines present |
| G2 | ≤10 discrete directives | ✓ | ~9 directives (goal x2 parts, don't-touch-verified, mount-mechanism, DoD1-3, out-of-scope x2) |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | both review FAILs (feedback UI gap, trace gap) carried into the prompt |
| G5 | no tiering/teams content in block | ✓ | none present |
| G6 | runner produced a prompt, didn't do the task | ✓ | output is an `/iterate` prompt block, not an applied fix |
| MUST | acknowledge-then-catch with PASS evidence cited | ✓ | "Verified working, do not re-check or modify: Langfuse deployed globally, per-tenant projects live, chat traces arriving — confirmed in Langfuse UI, project `praxya`." |
| MUST | both gaps addressed (Pareto) | ✓ | DoD items 1–2 (Intel/Design feedback UI) cover gap 1; DoD item 3 (per-step spans) covers gap 2 |
| MUST | verification targets in langfuse/UI terms | ✓ | "Verification target: Langfuse UI, project `praxya`, trace for the new run." / "Verification target: Intel page, staging/dev." |
| MUST | fence protecting the verified part | ✓ | "Langfuse deployment and per-tenant project config — already verified working." (Out of scope) |
| MUST-NOT | tiering note | ✓ (absent) | none present |
| MUST-NOT | re-deploy instructions for what already passed | ✓ (absent) | fence says "do not touch," no redeploy instructions given |

No FAILs — no diagnosis rows required.

---

## S08 — Mode 2, route: iterate (trace-naming gaps as a class)

**Verdict: FAIL**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✗ | Total non-block/🎯/💡 lines = 3: "That was an errant tool call on my part — ignore it." + "I couldn't validate the brain-apps/pulse file paths..." (both before the block) + a third line after 💡: "Setup: run this from the repo containing brain-apps/pulse (not prompt-it). If you have a `/read-chat` alias for the original review-it session, attach it — I had no ledger access to find one." — exceeds the ≤2 setup-line budget |
| G2 | ≤10 discrete directives | ✓ | exactly at the boundary (~10: goal, no-regress, gap1 locate+wire, gap2 locate+apply, pattern-to-imitate, DoD1-3, out-of-scope x2) |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | both FAILs (pulse call sites, automations) carried |
| G5 | no tiering/teams content in block | ✓ | none inside the fenced block |
| G6 | runner produced a prompt, didn't do the task | ✓ | output is an `iterate` prompt, no fix applied |
| MUST | class framing (taxonomy/wrapper, not 3 edits) | ✓ | "Both FAILs are the same class: the trace-naming fix only covers the chat entry point — nothing enforces it anywhere else an LLM call originates." |
| MUST | all enumerated sites covered | ✓ | "3 call sites in that module were never given an origin name" (pulse) + "Automation-triggered calls also arrive unnamed" (automations) both present in Gaps + DoD |
| MUST | langfuse verification target | ✓ | "Verification target throughout: Langfuse project \"praxya\" — trigger each call site and read the trace name off the dashboard." |
| MUST-NOT | dropping the automations gap | ✓ (absent) | automations gap is DoD item 2, not dropped |

**Diagnosis (FAIL row — G1):** HARNESS-ARTIFACT. The line "That was an errant tool call on my part — ignore it." is leaked meta-commentary about a failed tool invocation (most plausibly an attempted ledger/`.agents/history` lookup for a `/read-chat` alias per SKILL.md Mode 2 Step 6, "Package using /next-session-prompt conventions... /read-chat back-reference") that the one-shot headless eval context could not complete cleanly — the same headless constraint the run itself names ("this session is sandboxed to the prompt-it repo"). This produced stray narration that pushed the output past the G1 setup-line budget; the sample-specific content (class framing, site coverage, verification target) is otherwise fully compliant.

---

## S09 — Mode 2, route: fable-it (rationale required in 🎯)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✓ | 0 setup lines, 1 fenced block, `🎯 Target: **fable-it** — ...` line, `💡` line — all present |
| G2 | ≤10 discrete directives | ✓ | ~6 directives (goal, failed-attempt-do-not-repeat, DoD1, DoD2, out-of-scope x2) |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | both FAILs (CDP false-green, unverified Airtable landing) carried |
| G5 | no tiering/teams content in block | ✓ | none present |
| G6 | runner produced a prompt, didn't do the task | ✓ | output is a `/fable-it` prompt, no fix applied |
| MUST | failed-attempts section with the longer-waits attempt | ✓ | "Failed attempt (do not repeat): re-running the same CDP suite with longer waits produced the identical false green. The suite's blindness to the dropdown error is structural, not a timing flake." |
| MUST | system-of-record verification target | ✓ | "verification target: the record as read back from Airtable itself (its API or UI), not the app's own success/toast state" |
| MUST | no fake acknowledgment of unverified wins | ✓ | 💡: "It also acknowledges nothing as 'working': both review findings were FAILs with no passing evidence given, so crediting anything here would itself be a false green" |
| MUST-NOT | re-proposing the failed approach | ✓ (absent) | "do not 'fix' this by re-running the existing CDP suite with longer timeouts/waits — already tried, same false green" |
| MUST-NOT | trusting CDP-only green as the target | ✓ (absent) | DoD item 1 requires "a human-observed (or human-equivalent, non-CDP-suite) run," explicitly rejecting CDP-only |
| Route+rationale | review-it or fable-it, rationale in 🎯 | ✓ | routed fable-it, "🎯 Target: **fable-it** — two related but distinct false-green gaps... need a DoD run with real, honest verification targets, not a single fix-test cycle" |

No FAILs — no diagnosis rows required.

---

## S10 — clarity gate: minimal tighten (typo fix)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | 1 fenced block + 🎯 + 💡, ≤2 setup lines | ✓ | 1 setup line ("Pointer confirmed: `eval/fixtures/notes.md` exists..."), 1 fenced block, `🎯 Target:` + `💡` lines present |
| G2 | ≤10 discrete directives | ✓ | 2 directives ("Fix the typo..." / "Single-word correction only — no other edits") |
| G3 | no credentials | ✓ | none present |
| G4 | intent preserved | ✓ | matches sample exactly: same file, same typo pair |
| G5 | no tiering/teams content | ✓ | none present |
| G6 | runner produced a prompt, didn't do the task | ✓ | confirmed on disk: `eval/fixtures/notes.md` line 2 still reads "we recieve the payload" — the typo was not applied, only prompted |
| MUST | NO full 6-slot scaffold | ✓ | block is a single sentence, no GROUNDING/CP/SF headers |
| MUST | ≤4 directives | ✓ | 2 (see G2 row) |
| MUST | still G1 output shape | ✓ | see G1 row |
| MUST-NOT | questions | ✓ (absent) | none present |
| MUST-NOT | research | ✓ (absent) | only a single cheap pointer check, disclosed as "Pointer confirmed" — not a research pass |
| MUST-NOT | DoD sketch section | ✓ (absent) | none present |
| Fact-check | pointer claim accurate | ✓ | verified directly: `grep -n "recieve" eval/fixtures/notes.md` → line 2, single occurrence, matches the claim "single occurrence... at line 2" |

No FAILs — no diagnosis rows required.

---

## Summary J2

- S06: **FAIL** (MUST violated: only 2 of the oracle's 3 "cliente" senses named — ORACLE-DEFECT, third sense is unreachable domain knowledge not present in the sample or this repo)
- S07: **PASS**
- S08: **FAIL** (G1 violated: leaked "errant tool call" meta-commentary pushed setup lines past the ≤2 budget — HARNESS-ARTIFACT, tied to a failed lookup in the one-shot headless context)
- S09: **PASS**
- S10: **PASS**
