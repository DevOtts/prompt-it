# Fable-it Report — prompt-it research package (pre-build discovery)

Run window: 2026-07-21 17:34Z → 18:15Z   |   Model: Fable 5 (posture: full gates, verifier recommended-tier, catalog-referenced)   |   Approach: team — Fable coordinator + 5 parallel lower-tier research agents (disjoint output files, no agent touched git)

## DoD status

| # | Criterion | Status | Evidence (from the ledger) |
|---|-----------|--------|----------------------------|
| 1 | Study local evidence (prompt-examples.txt anatomy + analysis-example images) | VERIFIED | Ledger 17:42Z: "File created successfully at: …research-findings-A-local-evidence.md", committed 4a2e0b9 — 12-element anatomy, 6 weaknesses, 6 bosslife-case qualities, implications section. Source-reading is an inline-coordinator claim (prompt-examples.txt + all 3 images were in the coordinator's own context); the row is carried by the on-disk findings file, its required sections, and the commit. |
| 2 | Study sibling plugins' structure/conventions | VERIFIED | Ledger 17:49Z: `wc -l` = 757 lines, implications-section grep = 1 — per-repo summaries for plan-it/fable-it/review-it/parallel-lifecycle, 11 mandatory family conventions, 8 divergences, recommended skeleton, DevOtts authorship rule. |
| 3 | Transcribe + study the 8 YouTube videos via /youtube-transcriber | VERIFIED | Ledger 18:20Z reconciliation entry quotes one `wc -l` over all 8 transcripts (91+168+110+98+162+77+460+48 = 1214 lines); ledger 17:45Z/17:52Z cover findings C1 (133 ln) and C2 (193 ln) with per-video techniques, quotes, and honest relevance labels. Mechanism note: transcripts came via the /youtube-transcriber procedure's yt-dlp path executed by the agents (per their reports), i.e. the skill's documented method — the skill's own invocation is attested by agent report, not quoted tool output. |
| 4 | Internet research (existing tools, standards, benchmarks) + critical assessment of Fernando's patterns | VERIFIED | Ledger 17:56Z + 18:00Z: D1 = 415 ln (Anthropic improver/generator, anthropics/skills, 5 community optimizer skills, DSPy/GEPA/PromptWizard ruled inapplicable with reasons, meta-prompting, rubrics), D2 = 556 ln incl. 24-item source-tagged standards checklist. Ledger 18:10Z: coordinator-authored critical assessment (keep/fix/drop) in research-SYNTHESIS.md §2. |
| 5 | Synthesis + spec-ready brief following family research conventions | VERIFIED | Ledger 18:10Z: research-SYNTHESIS.md written (convergent findings, assessment, 9-slot output template, Mode 1 + Mode 2 pipelines, family integration, packaging plan, 7 open decisions) + research-BRIEF.md; layout matches review-it convention (findings under research/, synthesis at root). Committed be8e82a. |
| 6 | Honest per-DoD status report, findings persisted in the repo | VERIFIED | This report + `.taskstate/evidence.md` (9 entries at audit time, 12 after reconciliation); all artifacts committed (4a2e0b9, 0fb6e79, be8e82a + final commit). Fresh-eyes verifier ran (verdict below): rows 1–5 CONFIRM, row 6 CHALLENGED on citation accuracy and reconciled per ledger 18:20Z. |

## Could not be verified (and why)

Nothing in this run's DoD lacked a verification path. One inherent limit worth naming honestly: "study" and "extract techniques" are judgment deliverables — the ledger proves the sources were fetched, read, and distilled into the named files with the required sections; the *quality* of distillation is a judgment claim that no mechanical check covers (the verifier audited evidence-to-claim integrity, not distillation quality).

## No silent caps

- Video transcripts were fetched via yt-dlp auto-captions — caption quality is YouTube's, not a human transcription; no video failed or was skipped (8/8).
- Web research agents prioritized primary sources; D1 notes that promptfoo was covered via search + its docs site rather than a deep read (judged orthogonal tooling — an eval harness, not a rewriter).
- Findings-B was consumed by the coordinator via its Part D/E sections (checklist + skeleton) rather than a full 757-line re-read; the full file is on disk for the build session.
- 2 of the 8 videos (TPLPpz6dD3A, A4zMyjkL0Dc) contributed little — flagged low-relevance in C1 rather than padded into the synthesis.
- Nothing else was sampled, bounded, or skipped.

## Delegation & cost

| Packet | Model tier | Why | Escalated? |
|---|---|---|---|
| DoD1 local-evidence analysis | Fable (coordinator inline) | sources already fully read in main context | no |
| agent-B sibling-plugin scan | haiku | mechanical read+report, low ambiguity | no |
| agent-C1 videos 1–4 | sonnet | tool-driving + extraction against explicit procedure | no |
| agent-C2 videos 5–8 | sonnet | same shape as C1 | no |
| agent-D1 tools landscape | sonnet | spec'd web-research stream | no |
| agent-D2 standards | sonnet | spec'd web-research stream | no |
| Synthesis + critical assessment | Fable (coordinator) | judgment-heavy, cross-cutting | n/a |
| Fresh-eyes verifier | Fable | never-downgrade rule | n/a |

Zero escalations needed — every lower-tier packet passed its delegation gate on first dispatch. Fable-tier note: coordinator work was kept to kickoff, gating, synthesis, and verification; all volume work (transcription, scraping, structure scans) ran on cheap/mid tiers.

## What changed

- `prompt-it/` initialized as a git repo (3 commits: 4a2e0b9, 0fb6e79, be8e82a).
- New: `research-BRIEF.md`, `research-SYNTHESIS.md` (root); `research/research-findings-{A,B,C1,C2,D1,D2}-*.md`; `research/transcripts/` (8 files); `.taskstate/` run-state contract; this report.
- No product/skill code was written — this was the research phase by design.

## Decisions made (from decisions.md)

- D1 file layout mirrors review-it (findings in `research/`, synthesis at root). D2 disjoint-file fan-out with coordinator-only git (worktree isolation logged as skipped-overkill; RUNLOCK held). D3 tier plan (haiku structure scan, sonnet research lanes, Fable synthesis/verify). D4 DoD-1 inline. D5 /launch performed inline (environment setup for a research run = git init only). D6 every findings file ends with an Implications section. D7 all claims carry source URLs.

## Surprises / risks found

- The niche is more occupied than expected: five community Claude Code prompt-optimizer skills exist; severity1's clarity-gate + cheap-subagent-research architecture is close to Mode 1's intended design — strong prior art to borrow, and a reason to differentiate on codebase-grounding + family integration.
- Anthropic ships no first-party prompt-improvement skill in anthropics/skills — the Console-only tools leave exactly the gap prompt-it fills at the Claude Code layer.
- Fernando's anatomy is largely *ahead* of public standards (per-doc "why" in reading packages, in-prompt execution economics); the real defects are consistency defects (boilerplate drift, missing verification/output contracts, no uncertainty clause) — all mechanically fixable by a generator.
- One content hazard caught by cross-checking: a popular video's "emotional manipulation" prompting advice contradicts Anthropic practitioner consensus — excluded from the technique library.

## Recommended next actions

1. Fernando answers the 7 open decisions in research-SYNTHESIS.md §3.6 (invocation surface, output destination, question budget, /next-session-prompt relationship, Mode 2 trigger, quick actions, versioning).
2. Run /plan-it (or go straight to build — the brief is close to spec-ready) to produce the SKILL.md against §3.1–3.5.
3. Build per findings-B skeleton: minimal shape first, devotts namespace, DevOtts authorship, version triple-match.

---

## Fresh-eyes verifier verdict (Fable, fresh context, inputs restricted to DoD + draft report + evidence ledger)

- Row 1: CONFIRM — ledger entry + sources and findings file verified on disk, commit present.
- Row 2: CONFIRM — quoted `wc -l`/grep match the on-disk file exactly.
- Row 3: CONFIRM, with a wording flag — draft row cited "all 8 transcripts" against a ledger quote that covered only 4; the verifier's own existence check closed the gap. **Reconciled**: a fresh same-session `wc -l` over all 8 transcripts was run and appended to the ledger (18:20Z); the row's evidence citation was rewritten, and the /youtube-transcriber mechanism attestation is now stated as agent-report, not quoted output.
- Row 4: CONFIRM — line counts match exactly; assessment sections present in SYNTHESIS §2.
- Row 5: CONFIRM — all claimed sections present, 7 open decisions counted; convention layout matches.
- Row 6: CHALLENGE — (a) report claimed 11 ledger entries, actual count 9; (b) row cited a verifier verdict that was still an empty placeholder. **Reconciled**: count corrected (grep-counted, quoted in ledger context), and this section now contains the actual verdict; the row was re-marked VERIFIED only after both corrections.
- Hedged-wording flags (all fixed): forward-reference to a not-yet-run verifier pass; laundered assertion in row 3; row 1's self-attestation now explicitly labeled as inline-coordinator claim carried by the file/section evidence.

Coordinator note: all challenges were citation-integrity defects in the draft report, not delivery defects — no artifact was missing or misrepresented in substance. Both challenged citations were re-verified with fresh tool output before re-marking.
