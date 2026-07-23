# Breakdown v2 — build run

| Task | Owner | Tier | Output | DoD |
|---|---|---|---|---|
| T1 core SKILL.md | coordinator | Fable (interface-locking, single voice) | plugins/prompt-it/skills/prompt-it/SKILL.md | 1 |
| T2 targets.md | coordinator | Fable (same voice, boundary-critical) | …/references/targets.md | 2 |
| T3 packaging | agent-P | sonnet | marketplace.json, plugin.json, root SKILL.md copy, README, CHANGELOG, LICENSE, .gitignore update | 3 |
| T4 nsp cross-note | coordinator | Fable (edits a DevOtts skill outside repo) | ~/.claude/skills/next-session-prompt/SKILL.md | 4 |
| T5a JSON/version checks | agent-V | haiku | check outputs → ledger | 5a,5b |
| T5b dry-runs Mode1+Mode2 | coordinator | Fable (judgment) | qa/dryrun-mode1.md, qa/dryrun-mode2.md | 5c,5d |
| T6 report + verifier | coordinator + verifier | Fable | .fable-it-reports/report-build.md | 6 |

Sequence: T1+T2 (coordinator) → commit → dispatch T3 (sonnet) ∥ T4+T5b (coordinator) → T5a checks → T6.
Parallel-safety: T3 writes disjoint files from T4/T5b; no agent runs git; coordinator commits sequentially (same logged pattern as research run D2).
