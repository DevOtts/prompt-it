# Judgment J1 — prompt-it eval v0.1.0, samples S01–S05

Judge: QA (review-it honesty rules). Oracle: `eval/expected-prompts.md` (G1–G6 + per-sample MUST/MUST-NOT). Judged for PROPERTY CONFORMANCE against the checklist, not byte-similarity to the exemplar.

---

## S01 — route: plan-it

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | one fenced prompt block + 🎯 Target + 💡 | ✓ | Single block (lines 3–23); `🎯 Target: **plan-it**` (line 25); `💡 I couldn't validate any pointers this turn…` (line 27) |
| G2 | ≤10 discrete directives in block | ✓ | /goal (1) + 4 context bullets (info, not directives) + 4 DoD items + 2 scope-fence clauses ≈ 7 actionable items |
| G3 | no credentials | ✓ | No literal secrets; only mechanism references ("existing backfill/webhooks secret-handling mechanism") |
| G4 | intent preserved | ✓ | Sample's "MCP section like backfill/webhooks" + "brain-agent plus brain-apps visibility" both carried without added/dropped scope |
| G5 | no tiering/teams content in block | ✓ | Absent |
| G6 | runner did not DO the task | ✓ | Only a prompt was produced; no MCP work performed |
| MUST: route plan-it | ✓ | `/plan-it` (line 4); `🎯 Target: **plan-it**` |
| MUST: GROUNDING | ✓ | "We support MCP in principle but have no tenant-facing way to install third-party MCP servers…" (line 6) |
| MUST: /goal one sentence | ✓ | Line 8, single (compound) sentence |
| MUST: CP names both consumer surfaces | ✓ | "brain-agent (needs to enumerate + invoke…) and brain-apps (needs its own visibility into what's installed…)" (line 12) |
| MUST: SCOPE FENCES present | ✓ | "Out of scope / do not touch: building custom/bespoke MCP servers per vendor…" (line 22) |
| MUST-NOT: sizing/shape pre-decision | ✓ (absent) | No "N squads"/"size L" language anywhere |
| MUST-NOT: uncertainty clause | ✓ (absent) | No formal UC slot; the one hedge ("requester did not specify for what purpose; confirm during discovery", line 12) is a CP caveat, not a UC directive |
| MUST-NOT: output contract | ✓ (absent) | No OC slot present (correct — plan-it owns artifact shape) |
| MUST-NOT: discovery performed by prompt-it | ✓ (absent) | Explicitly declines: "no pointers could be validated here — that grounding is plan-it's own job" (line 1) |

No FAILs to diagnose.

---

## S02 — route: fable-it

**Verdict: FAIL**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | one fenced prompt block + 🎯 + 💡 | ✓ | Single block (lines 6–45); `🎯 Target: fable-it` (line 47); `💡 I could not validate…` (line 49); 1 setup line after (line 51, within ≤2) |
| G2 | ≤10 discrete directives | ✓ | /goal (1) + DoD 1–5 (5) + 3 scope-fence clauses ≈ 9 |
| G3 | no credentials | ✓ | Only env-var names (`OPENROUTER_API_KEY`, `OPENAI_API_KEY`), no values |
| G4 | intent preserved | ✓ | Precedence order, "build and ship it" → fable-it, all carried faithfully |
| G5 | no tiering/teams content in block | ✓ | Absent |
| G6 | runner did not DO the task | ✓ | Only a prompt was produced |
| MUST: route fable-it | ✓ | `/fable-it` (line 7); "build and ship it" cited as fable-it trigger language (line 3) |
| MUST: pattern-to-imitate named | ✓ | "Reference implementation: trigger-draft.service.ts already implements this exact precedence chain… mirror its resolution logic/order exactly" (lines 17–19) |
| MUST: DoD sketch numbered, each item names a verification TARGET | ✓ | Items 1–5 numbered, each with a "verify by/with…" clause |
| MUST: SCOPE FENCES | ✓ | "do not modify trigger-draft.service.ts itself… do not extend this fix to other OpenRouter clients… no broader refactor…" (lines 40–44) |
| MUST-NOT: tiering note | ✓ (absent) | No teams/lower-models language |
| MUST-NOT: persistence/autonomy clauses | ✓ (absent) | No run-state/stop-condition language |
| MUST-NOT: verification protocol prescriptions (how to run QA) | ✗ | Item 2: "verify with a Space that has the connection configured and a deliberately different/invalid pod-level env var, confirming the outbound request uses the Space key" (lines 29–32); item 1: "verify by diffing the two resolution code paths" (line 27) — these prescribe the test setup/method, not a verification target (endpoint/page/table/command) |

**Diagnosis (FAIL — verification protocol prescriptions):** SKILL-DEFECT. SKILL.md's DoD-sketch rule ("each item naming its verification TARGET… not the protocol") and targets.md's fable-it profile give only one abstract line of guidance with no worked example distinguishing an acceptable target phrasing ("a per-Space key proven honored on a real Space," per the oracle exemplar) from protocol-level instructions ("unset the connection, use an invalid pod key, confirm the outbound request"). The rule doesn't stop the model from over-specifying test setup steps that read as a QA protocol, which fable-it's own claim gate is supposed to own.

---

## S03 — route: review-it

**Verdict: FAIL**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | one fenced prompt block + 🎯 + 💡 | ✗ | The only fenced block (lines 10–21) is explicitly a non-deliverable: "here's the **shape** the compiled prompt will take" (line 8); block contains literal placeholders `[review-it invocation]`, `<test env>`, `<session/report pointer>`, `<component name/location>` — not copyable/paste-ready. No `🎯 Target:` line and no `💡` line anywhere in the output (route is only named in prose: "route: **review-it**", line 8) |
| G2 | ≤10 directives | ✓ | N/A — no real directive content, only placeholders |
| G3 | no credentials | ✓ | None present |
| G4 | intent preserved | ✓ | Verification-ask framing (review-it) matches the sample's "check it's actually done" |
| G5 | no tiering content | ✓ | Absent |
| G6 | runner did not DO the task | ✓ | No review was actually performed |
| MUST: route review-it | ✗ | Named only in prose ("route: **review-it**", line 8); the block itself has `[review-it invocation]` as an unresolved placeholder, not an actual routed prompt |
| MUST: CP identifies claim-under-test + where claim lives | ✗ | "Claim under test: `<component name/location>`" / "Claim source: `<report pointer — file:line or session ledger card>`" (lines 16–17) — templated placeholders, not resolved pointers |
| MUST: SCOPE FENCES | ✓ | "this is a verification pass only — do not fix, patch, or redeploy anything found broken; report findings for a follow-up" (line 20) |
| MUST-NOT: DoD sketch authored fresh | ✓ (absent) | No DoD sketch present |
| MUST-NOT: instructions on HOW to verify | ✓ (absent) | No verification-method content present |
| MUST-NOT: credentials content | ✓ (absent) | None present |

**Diagnosis (FAIL — G1, clarifying question instead of a copyable prompt):** SKILL-DEFECT. Per the task's judgment rule, asking a clarifying question instead of emitting a prompt block violates G1 regardless of how reasonable the question is. SKILL.md Mode 1 step 3 offers "≤3 grounded questions" as a legitimate path when lookups can't resolve something, and separately says "if the user is unavailable, state the assumption inline… mark it `(assumed — flag if wrong)`" — but this fallback is only a conditional aside, not a hard rule that a best-effort, assumption-flagged prompt must still be emitted so G1 always holds in a one-shot/headless run. The sample's "last session's report" pointer is genuinely unreachable from this cwd (contributing HARNESS factor), but the skill had the assume-and-flag mechanism available and didn't force its use — a gap in the skill, not an unresolvable harness condition (contrast S01/S02, where the model used exactly this mechanism successfully under the same kind of unreachable-repo constraint).

---

## S04 — route: iterate

**Verdict: FAIL**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | one fenced prompt block + 🎯 + 💡 | ✗ | No fenced prompt block anywhere in the output; no `🎯 Target:` line; no `💡` line. Entire output is a clarifying question: "**Before I draft anything, which repo is this actually in?**" (line 5) with two options listed (lines 6–7) |
| G2 | ≤10 directives | ✓ | N/A — nothing emitted |
| G3 | no credentials | ✓ | None present |
| G4 | intent preserved | ✗ | The sample already supplies everything /iterate's CP needs verbatim (the TS2345 error text, the goal "make the build green") per targets.md's own guidance ("the conversation itself" is the cheapest source and iterate's CP just needs "the failing command/page… paste the actual error"); no repo access was actually required to compile this prompt, so intent was dropped rather than compiled |
| G5 | no tiering content | ✓ | Absent |
| G6 | runner did not DO the task | ✓ | No build/fix was attempted |
| MUST: route iterate | ✗ | No `/iterate` invocation or 🎯 line anywhere |
| MUST: error text carried into the prompt | ✗ | The TS2345 text is quoted back in the clarifying question (line 1) but not carried into any prompt — there is no prompt |
| MUST: "root cause, not suppression" framing | ✗ | Absent |
| MUST: DS names the verifying command | ✗ | Absent |
| MUST-NOT: multi-step epic structure | ✓ (absent) | Nothing emitted to violate this |
| MUST-NOT: cycle-structure instructions | ✓ (absent) | Nothing emitted to violate this |

**Diagnosis (FAIL — G1, no prompt emitted at all):** SKILL-DEFECT. The sample's `src/eval/runner.ts` pointer is indeed unreachable from cwd `prompt-it` (a markdown/skill repo with no TS/pnpm project) — a real HARNESS co-factor. But unlike S01/S02, which hit the identical "unreachable repo" circumstance and still produced a compliant prompt by drafting around the described intent and flagging the unvalidated pointer, this run fully declined and asked a question instead — even though the one piece of information /iterate's CP structurally needs (the pasted error text) was already given verbatim in the sample and required zero repo access to carry forward. This inconsistency (same category of missing grounding, opposite behavior) indicates the skill's pointer-validation caution isn't calibrated to distinguish "pointer needed to validate a claim" from "data already supplied in-conversation, no validation required" — a skill-guidance gap, not an unavoidable harness limitation.

---

## S05 — bare (non-agentic script task)

**Verdict: PASS**

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| G1 | one fenced prompt block + 🎯 + 💡 | ✓ | Single block (lines 3–21); `🎯 Target: bare session…` (line 23); `💡 Two silent ambiguities…` (line 24) |
| G2 | ≤10 discrete directives | ✓ | "Do" 1–4 (4) + closing verification line (1) ≈ 5; assumptions are flagged constraints, not directives |
| G3 | no credentials | ✓ | None present |
| G4 | intent preserved | ✓ | Dedupe + report-rows-removed ask preserved; added assumptions (dedup key, keep-first, output path) are explicitly disclosed as assumptions, not silently added scope |
| G5 | no tiering content | ✓ | Absent |
| G6 | runner did not DO the task | ✓ | Only the prompt was produced; script was not written or run by this session |
| MUST: no harness skill header | ✓ | Block opens directly with "Write a script that deduplicates…" — no `/plan-it` etc. header |
| MUST: UNCERTAINTY CLAUSE present | ✓ | "Assumptions (flag if wrong, otherwise proceed): …" (line 6) plus "if the column is missing or named differently, stop and report instead of guessing" (line 13) |
| MUST: OUTPUT CONTRACT incl. end-to-end verification | ✓ | "Do: 1…2…3. Write data/customers.deduped.csv. 4. Print a summary…" (lines 12–16) plus "Run it and show the printed summary as proof it works." (line 20) |
| MUST: case-insensitive email rule stated | ✓ | "deduplicates data/customers.csv by email address, case-insensitively (e.g. \"Foo@x.com\" and \"foo@x.com\" count as the same row)" (line 4) |
| MUST-NOT: @-refs to harness state files | ✓ (absent) | None present |
| MUST-NOT: /read-chat refs | ✓ (absent) | None present |

No FAILs to diagnose.

---

## Summary J1

- S01 → PASS
- S02 → FAIL (MUST-NOT violated: DoD items prescribe verification protocol, not just target — SKILL-DEFECT)
- S03 → FAIL (G1 violated: clarifying question instead of a copyable prompt — SKILL-DEFECT)
- S04 → FAIL (G1 violated: no prompt emitted at all — SKILL-DEFECT)
- S05 → PASS
