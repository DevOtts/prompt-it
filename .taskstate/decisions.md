# Decisions contract — prompt-it research run

- D1: File layout follows review-it convention: `research/` dir for findings, `research-SYNTHESIS.md` at root. Transcripts under `research/transcripts/<video-id>.md`.
- D2: Parallel safety — this is a read-only research fan-out writing DISJOINT files. No subagent runs any git command; coordinator alone commits, sequentially. Worktree isolation skipped as overkill for disjoint-file writes (logged per interlock/worktree gate; RUNLOCK held by fable-it-research-run-1).
- D3: Tiering — coordinator Fable 5. Sibling-structure scan: haiku (mechanical read+report). YouTube transcription+extraction: sonnet ×2 (4 videos each; tool-driving + summarization). Web research: sonnet ×2 (research streams). Synthesis + critical assessment of Fernando's patterns vs standards: Fable (judgment-heavy, stays with coordinator). Verifier: Fable (never downgrade).
- D4: DoD-1 (local evidence) done INLINE by coordinator — sources already fully read in main-thread context; delegating would re-pay reading cost for worse fidelity.
- D5: /launch invoked in degraded-inline form: environment setup for a research run is git-init only (done); approach decision recorded here + breakdown. Noted for report.
- D6: Findings files must end with a `## Implications for prompt-it` section so synthesis is a merge, not a re-read.
- D7: Every web/video claim in findings must carry its source URL — synthesis cites, never launders.

## Eval run (2026-07-23, run 3)
- D8: review-it plugin NOT installed under this profile → DoD-4 conducted in degraded-inline mode per fable-it contract: judge agents follow the real /Users/macbook/Workspace/Devotts/review-it/SKILL.md (honesty layer, closed status vocabulary, evidence rows) with eval/expected-prompts.md as the binding contract, feeding this run's ledger. Disclosed in report.
- D9: sample runs use EXPLICIT "/prompt-it <sample>" invocation (locked decision #1: skill-only surface — explicit invocation IS the real usage). Trigger test = does the installed plugin skill load and get followed in a fresh agent.
- D10: oracle judges property conformance (checklists in expected-prompts.md + globals G1–G6), never byte equality with exemplars.
- D11: eval outputs are disjoint files eval/runs/v0.1.0/S*.md; no agent touches git; coordinator commits.
- D12: S10 sample referenced a typo that doesn't exist in README (skill correctly caught the false premise in smoke test — honest behavior, defective sample). Fixed the EVAL CONTRACT, not the skill: seeded eval/fixtures/notes.md with the typo and repointed S10. Oracle unchanged.
- D13: ORACLE fix — S06 checklist demanded ≥3 "cliente" senses but the sample evidences only 2; skill correctly refused to fabricate. Relaxed to "senses in evidence (≥2)".
- D14: v0.1.1 fix set (from J1–J4): question gate (one-shot = user unavailable → assume-and-flag, output unconditional); cross-tree unvalidated-pointer rule; DoD sketch = targets never methods; clarity-gate preserve-structure; output hygiene (no tool narration). Root SKILL.md re-synced.
- D15: cycle-2 fixes (rejudge-1): question gate rewritten context-free (emit-first unconditional; questions only APPEND after output); output hygiene mechanical (first char = opening fence); user-named route LOCKED; plan-it routing heuristic (pointers don't resolve scope); validation-is-not-discovery cap (≤7 pointers, no dossiers).
- D16: cycle-3 (rejudge-2): root cause = load-bearing rules buried mid-file/in reference file don't survive one-shot sonnet runs (primacy effect, per our own D2/C2 research). Fix: HARD OUTPUT RULES box at TOP of SKILL.md with inline per-route omission mini-table; clarity-gate return-user's-text rule; ≤7-pointer cap made mechanical.
