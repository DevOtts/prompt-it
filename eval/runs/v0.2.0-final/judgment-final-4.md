# prompt-it eval — FINAL CERTIFICATION judgment (v0.2.0-final, batch 4: S16–S20)

Method: property conformance against `eval/expected-prompts.md` GLOBALS (G1–G6) + per-sample MUST/MUST-NOT, plus the binding nuances named in the task (response starts at the opening fence; refinement questions only APPEND with concrete options; inline `(assumed: …)`/`(unvalidated — …)` markers correctly formed). Exemplars in the oracle are quality anchors, not byte targets. Quotes are pulled verbatim from `eval/runs/v0.2.0-final/S16.md`…`S20.md`.

---

## S16 — route: iterate (flaky UI e2e)

**Verdict: PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| Route iterate, locked first line | ✓ | `/iterate` is line 1 |
| Error symptom carried into CP | ✓ | `"ResizeObserver loop limit exceeded" and the dropdown element detaches mid-click` |
| No-test-deletion fence | ✓ | `no \`.skip\`/\`.only\`/quarantine on the failing test; no blanket swallowing of page errors` |
| DS names the suite-green target | ✓ | `The full e2e suite is green via the project's standard e2e command.` |
| MUST-NOT: longer-waits-as-fix | ✓ (absent) | No mention of re-running with longer waits anywhere in the block |
| G5 no tiering/teams content | ✓ | none present |
| G6 runner didn't do the task | ✓ | output is a prompt only |
| G1 starts at opening fence | ✓ | file's first character is the ` ``` ` fence |
| Refinement Qs carry concrete options | ✗ (partial) | Q1 `"Which repo/path owns the tasks page?"` is open-ended — no named A/B candidates, the exact anti-pattern SKILL.md itself warns against (`"confirm the path"` → should be `"is it A or B?"`). Q2 (`"per-worktree parallel-lifecycle ephemeral Chrome, or the real logged-in Chrome at :9222"`) is correctly concrete. |

Diagnosis (non-blocking note): Q1's open-endedness is a real, isolated defect against the binding refinement-question rule — but it doesn't undermine the delivered artifact: the same ambiguity is already resolved inline in the block itself (`(assumed: a sibling app repo, not prompt-it — cd there first; flag if wrong)`), so the emit-first contract is satisfied and the appended question is redundant rather than load-bearing. All sample-specific MUSTs/MUST-NOTs and G1–G6 hold. Directive count in-block (~10 by natural per-rule counting) is at the ceiling but not over it.

---

## S17 — bare agentic (Downloads sort, stop conditions mandatory)

**Verdict: PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| No harness header | ✓ | block opens directly with the task text, no skill invocation |
| Forbidden actions | ✓ | `Move only — never delete a file, never overwrite one.` |
| File-scope lock | ✓ | `Touch only files at the top level of ~/Downloads` / `Write nothing outside ~/Downloads` |
| No-deletion carried from intent | ✓ | matches sample's `deleting nothing` |
| Stop conditions present | ✓ (thinner than exemplar) | `If ~/Downloads doesn't exist or is empty, stop and say so.` — present, but the exemplar's two richer mechanisms (ambiguous-type → ask; >N moves → checkpoint) are NOT implemented; ambiguity is instead resolved by silent defer-to-report (`note it instead of guessing`) rather than a live stop-and-ask |
| Output contract | ✓ | `print a summary table (category → files moved) plus the list of skipped/unmatched files, then verify by running \`ls\` on each created subfolder and showing the output` |
| MUST-NOT: unlimited filesystem scope | ✓ (absent) | scope is bounded to `~/Downloads` top level only |
| ≤10 discrete directives (counted) | ✓ (at ceiling) | counting one directive per numbered rule + categories + destructive-ops ban + output pair lands at exactly 10; a maximally split reading (splitting each rule's sub-clauses) reaches 12–13, so this has zero margin |
| G1 starts at opening fence | ✓ | first character is the fence |
| Refinement Qs carry concrete options | ✓ | both Qs are binary (`Other/ subfolder … or staying at the top level?`; `treated as Installers too, or left alone?`) |

Diagnosis (non-blocking note): the delivered stop-condition shape (defer ambiguous files to the final report rather than pausing mid-run to ask) is a legitimate design substitution for an interactive bare session, and the MUST's literal text ("stop conditions … present") is satisfied — but it is a real property gap against the oracle's specific exemplar mechanisms and is flagged here for visibility. Directive count is compliant but should not be allowed to grow on any future revision.

---

## S18 — product-LLM, reasoning-native (log-triage analyzer)

**Verdict: FAIL**

| Check | ✓/✗ | Evidence |
|---|---|---|
| No CoT / "think step by step" scaffolding | ✓ | no such phrasing anywhere in the block |
| Output schema explicit | ✓ | `[{"index": <0-based position in batch>, "severity": <0-4>, "hypothesis": "<one line>"}]` |
| ≲200 words in-block (counted) | ✗ | **335 words** measured (`awk`/`wc -w` between the fences) — 67% over the ≲200 target, not a rounding/tolerance case |
| Uncertainty out present | ✗ (present but wrong shape) | exemplar wants `severity: unknown` when truncated; delivered text instead forces a guess: `set severity to your best estimate from whatever fragments are legible (default 2 if nothing is)` — this is uncertainty papered over with a default value, not surfaced as an explicit unknown state a downstream consumer can detect |
| MUST-NOT: XML-heavy multi-section template | ✗ | 7 distinct ALL-CAPS section headers (`INPUT`, `TASK`, `SEVERITY SCALE`, `CAUSE HYPOTHESIS`, `UNPARSEABLE OR TRUNCATED LOGS`, `OUTPUT`, `EXAMPLE`) — not literal XML tags, but the same heavily-sectioned template shape the MUST-NOT targets |
| MUST-NOT: few-shot padding beyond ≤1 example | ✓ | exactly one worked example, tight |
| G1 starts at opening fence | ✓ | first character is the fence |
| Refinement Qs carry concrete options | ✓ | all three are binary (severity direction; input shape; JSON-vs-dashboard consumer) |

Diagnosis: this sample fails on its own headline binding nuance. The oracle calls for a SHORT reasoning-native system prompt (≲200 words: role, input shape, schema, uncertainty-out) — the delivered prompt instead reproduces the "full anatomy" shape (7 labeled sections, a rubric, a length cap on the hypothesis field, a "likely:" prefixing rule, a no-invention rule, an unparseable-handling clause) that belongs to the bare/agentic profile, not the compact product-LLM profile targets.md specifies. Net effect: correct schema and no CoT (two MUSTs hold), but the core "short, reasoning-native, no scaffolded template" property is violated on word count, template shape, and the semantics of the uncertainty-out slot. This is a route-appropriate-content miscalibration, not a routing error — the target line correctly says `product-LLM (o3-mini system prompt) … reasoning-native so no CoT scaffolding was added`, but the skill's own ≲200-word discipline was not applied to itself.

---

## S19 — route: fable-it, tiering note stripped

**Verdict: PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| No tiering/teams/model language in block | ✓ | scanned full block — none present |
| Strip disclosed (not silent) | ✓ | 💡: `Dropped your teams/lower-models directive from the prompt on purpose: fable-it owns model tiering canonically … so routing to fable-it delivers exactly that without restating it.` |
| MUST-NOT: carrying the note "to be safe" | ✓ (absent) | not carried anywhere |
| Route fable-it | ✓ | `/fable-it` is line 1 |
| Pattern-to-imitate named | ✓ | `trigger-draft.service.ts` named twice, framed as the pattern to mirror |
| DoD numbered, each with a verification target | ✓ | item 1 → `proven by a test exercising both sources`; item 2 → `proven by the ontology flow/endpoint that invokes the client`; item 3 → `Existing test suite stays green` |
| SCOPE FENCES present | ✓ | `Out of scope / do not touch: trigger-draft.service.ts itself (reference only), the backbone-key storage/encryption model, LLM clients other than the ontology client.` |
| MUST-NOT: persistence/autonomy clauses | ✓ (absent) | none present |
| MUST-NOT: verification protocol prescriptions | ✓ (absent) | DS states targets, never test commands/setup steps |
| Cross-tree pointers correctly marked | ✓ | `Context (unvalidated — compile ran outside brain-api-core; confirm these paths from its repo root first):` |
| G1 starts at opening fence | ✓ | first character is the fence |

No defects found. Clean pass across every MUST, MUST-NOT, and binding nuance.

---

## S20 — Mode 2, route fable-it (three point-bugs as one class)

**Verdict: PASS**

| Check | ✓/✗ | Evidence |
|---|---|---|
| Class-over-instance framing | ✓ | `All three are instances of ONE class — locale-dependent presentation hardcoded to pt-BR — not three independent bugs.` |
| All 3 instances covered as acceptance cases | ✓ | DoD 1/2/3 map 1:1 to header title / dates / currency symbol |
| Failed-attempts section present | ✓ | `Failed attempt — do NOT re-propose: inline \`tenant.language\` ternaries at each call site. Reverted once already as unmaintainable.` |
| Two-locale verification target | ✓ | e.g. `dashboard header shows English text under an English tenant, Portuguese under a Portuguese tenant` (repeated per DoD item) |
| MUST-NOT: three independent point-fix tasks | ✓ (absent) | fix is framed as one shared layer, not three patches |
| MUST-NOT: re-proposing inline ternaries | ✓ (absent) | explicitly forbidden instead |
| Acknowledge nothing falsely (all input rows were FAIL) | ✓ | no PASS/credit language anywhere — correct, since the input review had no passing rows |
| Route with rationale | ✓ | 🎯: `fable-it — fix + verify against confirmed review findings; three surfaces sharing one mechanism-level fix is a small autonomous delivery, not a plan-it-sized scope.` |
| SCOPE FENCES present | ✓ | `Out of scope / do not touch: backend APIs, tenant data model changes, translating admin UI surfaces beyond the three touched components, i18n of non-tenant-facing internals.` |
| G5 no tiering | ✓ | none present |
| G1 starts at opening fence | ✓ | first character is the fence |
| Refinement Qs carry concrete options | ✓ | all three binary (`language`, or a proper `locale`/`currency` field…; existing i18n dep or free to choose; three components or whole admin UI) |

No defects found. Clean pass across every MUST, MUST-NOT, and binding nuance.

---

## Summary final-4

- **S16 — PASS** (one non-blocking defect: refinement Q1 is open-ended, not concrete-optioned; block content and all sample MUSTs are clean).
- **S17 — PASS** (stop conditions present but thinner than the exemplar's ask/checkpoint mechanisms; directive count at the ceiling with no margin).
- **S18 — FAIL** (335 words vs. the ≲200-word cap, a 7-section ALL-CAPS template resembling the disallowed XML-heavy shape, and uncertainty-out delivered as a forced default-severity guess instead of an explicit unknown state).
- **S19 — PASS** (clean: tiering note fully stripped and disclosed, all S02-equivalent MUSTs hold).
- **S20 — PASS** (clean: class-over-instance framing, all 3 instances as acceptance cases, failed-attempts section, two-locale verification).
