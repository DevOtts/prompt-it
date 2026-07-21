# Decisions contract — prompt-it research run

- D1: File layout follows review-it convention: `research/` dir for findings, `research-SYNTHESIS.md` at root. Transcripts under `research/transcripts/<video-id>.md`.
- D2: Parallel safety — this is a read-only research fan-out writing DISJOINT files. No subagent runs any git command; coordinator alone commits, sequentially. Worktree isolation skipped as overkill for disjoint-file writes (logged per interlock/worktree gate; RUNLOCK held by fable-it-research-run-1).
- D3: Tiering — coordinator Fable 5. Sibling-structure scan: haiku (mechanical read+report). YouTube transcription+extraction: sonnet ×2 (4 videos each; tool-driving + summarization). Web research: sonnet ×2 (research streams). Synthesis + critical assessment of Fernando's patterns vs standards: Fable (judgment-heavy, stays with coordinator). Verifier: Fable (never downgrade).
- D4: DoD-1 (local evidence) done INLINE by coordinator — sources already fully read in main-thread context; delegating would re-pay reading cost for worse fidelity.
- D5: /launch invoked in degraded-inline form: environment setup for a research run is git-init only (done); approach decision recorded here + breakdown. Noted for report.
- D6: Findings files must end with a `## Implications for prompt-it` section so synthesis is a merge, not a re-read.
- D7: Every web/video claim in findings must carry its source URL — synthesis cites, never launders.
