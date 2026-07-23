# Retry judgment — v0.2.0-final stochastic-flip samples (S11, S13, S14, S18)

Judged against `/Users/macbook/Workspace/Devotts/prompt-it/eval/expected-prompts.md` (GLOBALS G1–G6 + per-sample MUST/MUST-NOT) and the binding nuances supplied for this retry. Evidence-quoted; no vibes. No git was run.

---

## S11 — clarity gate: minimal tighten (already well-formed) → **FAIL**

Input (`sample-prompts.md` S11): `plan-it. /goal add a CONTRIBUTING.md to this repo covering how to add a new target profile to references/targets.md. DoD: 1. file exists with profile-addition steps 2. linked from README. Out of scope: no CI changes.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | G1 output shape (fence → 🎯 → 💡) | ✓ | Fence opens the response, `🎯 Target:` and `💡` lines present. |
| 2 | Route stays plan-it (locked) | ✓ | `/plan-it` kept verbatim as first line. |
| 3 | Dead pointer fixed in place (legit defect fix, not a new section) | ✓ | `/goal` line itself is expanded to name the real path `plugins/prompt-it/skills/prompt-it/references/targets.md` — a fix inline in the existing `/goal` slot, not a new slot. |
| 4 | DoD verification targets = allowed light tightening | ✓ | Oracle exemplar explicitly permits "verification target added to DoD item 1"; both DoD items here got one. |
| 5 | **NO new sections added (binding nuance: a new `Context:`/`Grounding:` block = FAIL)** | ✗ | A standalone `Grounding:` line appears that does not exist anywhere in the user's original text: `Grounding: contributors need a documented path for extending prompt-it's per-target responsibility map (the owns/parses/cautions ledger) without reverse-engineering the existing profile structure.` This is precisely the failure mode SKILL.md itself calls out: *"a new `Context:`/`Grounding:` block appearing in a minimal tighten means you've violated this rule."* (SKILL.md L69) |
| 6 | Out-of-scope fence: light tighten vs. added scope | ⚠ (not the deciding factor) | Original: `Out of scope: no CI changes.` Output: `Out of scope / do not touch: no CI changes; no edits to targets.md's actual profiles or to SKILL.md.` — new restriction added beyond the user's line; borderline defensible as tightening but stacks on top of the Grounding violation. |

**Verdict: FAIL.** The output re-pours part of the already-well-formed input into template structure (a `Grounding:` slot) that the user never wrote and that the clarity-gate rule explicitly forbids adding.

**Diagnosis:** SKILL-DEFECT (execution/adherence failure) — SKILL.md L69 states this exact rule in nearly these exact words ("a new `Context:`/`Grounding:` block appearing in a minimal tighten means you've violated this rule"), yet this run added one anyway. Not an oracle issue (the oracle's MUST-NOT is explicit and matches SKILL.md's own stated rule) and not a harness/tooling artifact.

---

## S13 — legitimate ambiguity → **FAIL**

Input (`sample-prompts.md` S13): `There's a bug in auth — sessions die way too early. Fix the auth bug in our Engine workspace.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | Full output contract emitted first (not questions-only) | ✓ | Fence → `/iterate` → goal/context/DoD/fences → `🎯` → `💡` all present before any appended question. |
| 2 | Flagged assumptions inline in the block (option "b") | ✓ | `(assumed: "Engine workspace" is a separate repo — open it and confirm the auth/session module path before touching anything — flag if wrong)` and a second assumed marker on TTL-vs-bug framing. |
| 3 | ≤3 appended questions | ✓ | Exactly 3 questions appended. |
| 4 | **Every appended question carries concrete options (binding nuance: open-ended question = FAIL)** | ✗ | Q1: `What's the gap — intended session lifetime vs how fast they actually die (e.g. "should last 24h, dies in ~15min")?` — an example, not a choice between options. Q3: `Where's the Engine workspace on disk (path or repo name)?` — a bare fill-in-the-blank with zero candidate options, the textbook open-ended shape SKILL.md itself bans ("never open-ended ('confirm the path' → 'is it `A` or `B`?')"). Only Q2 (`Which auth mechanism: JWT access/refresh tokens, a server-side session cookie, or an OAuth-provider session?`) meets the concrete-options bar. |
| 5 | No silent picking of repo/module | ✓ (technically) | Flagged rather than silently assumed — but see diagnosis below on why the flag was even necessary. |

**Verdict: FAIL.** 2 of the 3 appended questions (Q1, Q3) are open-ended, violating the binding nuance and SKILL.md's own concrete-options requirement for appended questions.

**Diagnosis:** SKILL-DEFECT (cheap-lookup step skipped). Q3 asks the user to supply the Engine workspace's location on disk, but `ls ~/Workspace/` resolves it in one call: `/Users/macbook/Workspace/Engine` (containing `Engine-Core`) exists and is trivially discoverable — exactly the "cheap lookup" SKILL.md Step 3.2 mandates before falling back to a question ("`.agents/history/INDEX.md`... `ls`/`grep` for the file/pattern they half-named"). The run neither performed this lookup nor validated the pointer, instead asking an open question about something a one-line `ls` would have resolved (and then a normal cross-tree "(unvalidated — confirm this path)" marker, not a question, would have applied). This is a run-execution gap against a clearly specified skill step, not an oracle or harness issue.

---

## S14 — route: plan-it → **FAIL**

Input (`sample-prompts.md` S14): `Extend the Beacon feedback thumbs to every page where users chat with the LLM (Intel, Design, all the regenerations), pop a review modal after each generation, and add a small "what went wrong" form on thumbs-down. The Beacon repo is at /Users/macbook/Workspace/ANM/Beacon.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | **Route MUST be plan-it (oracle-bound)** | ✗ | Output routes `/fable-it`: `🎯 Target: **fable-it** — the pattern already exists and is wired on one flow; this is a bounded, autonomous mirror-onto-remaining-surfaces job...` The route is not user-locked in the input (no skill name mentioned), so the oracle's plan-it lock applies and is violated. |
| 2 | 3 sub-features present (Pareto at intent level) | ✓ | All three covered in DoD: (1) thumbs on every surface, (2) post-generation review modal, (3) thumbs-down "what went wrong" form. |
| 3 | Beacon path carried | ✗ | User gave the absolute path `/Users/macbook/Workspace/ANM/Beacon`. The output's CONTEXT PACKAGE only says `(all under beacon/frontend/src/)` — a bare relative sub-path with no repo-root anchor anywhere in the block; the absolute path the user supplied never appears. Verified on disk: the real root is `/Users/macbook/Workspace/ANM/Beacon/beacon/frontend/src/` — a session pasting this prompt from elsewhere has no way to locate the repo. |
| 4 | CP ≤~7 validated pointers, not a file:line dossier | ✓ (count) / ✗ (accuracy, see #5) | Exactly 7 pointers listed, mostly file-level (one `pages/Intel.tsx:476`) — within the numeric cap, but see below on factual accuracy of the content. |
| 5 | No tiering/economics content | ✓ | None present. |
| 6 | Scope fences present | ✓ | "Out of scope / do not touch" section present with 3 items. |
| 7 | Pointer-validation accuracy (feeds the routing rationale directly) | ✗ | Output states: `pages/DesignChat.tsx — chat surface that appears to LACK the widget (assumed: primary gap — confirm during discovery)`. Verified false by grep: `DesignChat.tsx` already imports and renders `FeedbackWidget` twice (lines ~1441 and ~2095), with an inline comment reading *"Mirrors the Intel pattern"* and a reference to prior work (`feedback-obs E3/W1`). The claimed "primary gap" driving the entire fable-it re-route does not exist. |

**Verdict: FAIL** — on the oracle-bound route alone (fable-it ≠ plan-it), compounded by a dropped Beacon root path and a factually wrong "DesignChat lacks the widget" claim that was the stated basis for abandoning plan-it.

**Diagnosis:** SKILL-DEFECT. The run performed enough of its own discovery (reading multiple Beacon source files, confidently declaring what exists vs. is missing) to re-route away from the oracle-locked plan-it — exactly the boundary SKILL.md forbids crossing ("NEVER run heavy research fan-out to spec the task — plan-it... own discovery. You do cheap pointer validation only"). That partial discovery was itself incomplete (missed that DesignChat.tsx already has the widget wired, discoverable by the same one-line grep it used elsewhere in the same repo), producing false confidence and the wrong route. Not an oracle or harness issue — the oracle's plan-it lock is reasonable precisely because the "is this already built?" question is unresolved scope, which is plan-it's job to discover properly, not prompt-it's to half-verify.

---

## S18 — product-LLM, reasoning-native → **FAIL**

Input (`sample-prompts.md` S18): `Write the system prompt for our log-triage analyzer that runs on o3-mini. It gets a batch of error logs and must output severity 0-4 plus a one-line cause hypothesis per log.`

| # | Check | ✓/✗ | Evidence |
|---|---|---|---|
| 1 | No CoT / "think step by step" / scaffolded reasoning | ✓ | None present; 💡 line even states this was deliberately avoided: `no "think step by step" scaffolding — o3-mini reasons internally and CoT prompts degrade it.` |
| 2 | Output schema explicit | ✓ | Pinned JSON array schema with field names and an example. |
| 3 | **Short (≲200 words in-block)** | ✗ | Measured via `wc -w` on the fenced content only (opening fence to closing fence, exclusive): **340 words** — 70% over the ≲200-word MUST threshold. |
| 4 | Uncertainty out present | ✓ | `If the log lacks enough signal to hypothesize, output "insufficient signal" and set severity to your best floor estimate` and a separate rule for empty/truncated/unparseable logs — a different concrete design than the exemplar's literal `severity: unknown`, but the required property (explicit uncertainty-out behavior) is present. |
| 5 | No XML-heavy multi-section template | ✓ (literal reading) | Sections are plain ALL-CAPS labels (`INPUT:`, `SEVERITY SCALE`, `CAUSE HYPOTHESIS`, `MISSING / MALFORMED DATA`, `OUTPUT`, `WORKED EXAMPLE`), not XML tags — but 6 labeled sections is exactly what pushed the word count past the cap (see #3). |
| 6 | ≤1 tight worked example | ✓ | One worked example, 2 log lines. |

**Verdict: FAIL** — on the explicit word-count MUST alone (340 vs. ≲200); everything else conforms.

**Diagnosis:** SKILL-DEFECT. targets.md's product-LLM/reasoning-native profile calls for a short system prompt; this run added a fully-specified severity rubric (5 tiers, each with examples) plus a separate missing-data section on top of role/input/schema/example — defensible content individually, but the skill's own "short (<200 words)" target for this profile was not enforced as a hard budget during drafting. Not an oracle-wording issue (the oracle number is explicit and the exemplar itself is described as "SHORT... target <200 words") and not a harness/rendering artifact — the words are all genuine prompt content that could have been compressed (e.g., the 5-tier severity rubric could cite 2-3 anchors instead of a full scale, or fold the missing-data rule into the cause-hypothesis rule) without losing the required properties.

---

## Summary retry-final

| Sample | Verdict | Primary FAIL driver |
|---|---|---|
| S11 | FAIL | Added a new `Grounding:` section to an already-well-formed, route-locked prompt — the exact violation SKILL.md's clarity-gate rule names verbatim. |
| S13 | FAIL | 2 of 3 appended refinement questions are open-ended (no concrete options), one of them for a workspace path (`~/Workspace/Engine`) discoverable by a single `ls` that was never run. |
| S14 | FAIL | Routed to fable-it against the oracle-locked plan-it route, on the strength of a discovery claim ("DesignChat lacks the feedback widget") that is factually false — DesignChat.tsx already has `FeedbackWidget` wired twice. |
| S18 | FAIL | Fenced system-prompt content measures 340 words against the oracle's ≲200-word MUST. |

All four diagnosed as SKILL-DEFECT (execution/adherence gaps against clearly-stated skill rules or missed cheap validations), not ORACLE-DEFECT or HARNESS-ARTIFACT.
