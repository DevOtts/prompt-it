# Run memory — prompt-it (run 2: build appended)

## Build run tier log (2026-07-23)
- T1/T2 core SKILL.md + targets.md · Fable inline · interface-locking. T3 packaging · sonnet · spec'd drafting, passed gate first dispatch. T5a checks · INLINE (deviation from haiku plan: 4 commands < agent overhead). T5b dry-runs + T6 verify · Fable. Zero escalations.

# Run memory — prompt-it research run

## Delegation tier log (dispatched 2026-07-21 ~17:40Z)
- agent-B · haiku · mechanical structure read+report over 4 local repos, low ambiguity.
- agent-C1 · sonnet · videos 1–4: tool-driving (yt-dlp/bun script) + summarization against explicit procedure.
- agent-C2 · sonnet · videos 5–8: same shape as C1.
- agent-D1 · sonnet · web research stream (existing optimizer tools), spec'd deliverable.
- agent-D2 · sonnet · web research stream (standards/best practices), spec'd deliverable.
- DoD-1 local-evidence analysis · Fable inline (coordinator) · sources already in main-thread context; delegation would re-pay reading for worse fidelity.
- Synthesis + critical assessment + verifier reserved for Fable (judgment-heavy / never-downgrade).

## Failed approaches
- (none yet)

## Env quirks
- Folder was not a git repo at start; `git init -b main` run at 17:34Z.
- No .fable-it-reports/lessons.md existed (first run on this project).

## Eval run failed approach (2026-07-23)
- FAILED: running eval samples via Agent-tool subagents — subagents inherit the parent session's skill roster, snapshotted BEFORE prompt-it was installed → 20/20 TRIGGER-FAIL, all artifacts of the environment. Diagnostic proof: fresh `claude -p --model haiku` lists `prompt-it:prompt-it`. NEW APPROACH: fresh headless `claude -p --model sonnet` per sample (real plugin loading, real trigger path). Never eval a freshly-installed plugin from inside the installing session's subagents.
- NEAR-MISS (state-change gate win): cycle-2 deploy looked absent because verification greps were case-sensitive ("first character" vs the file's "FIRST character") — almost triggered an unnecessary cache purge + reinstall loop. Rule: verification greps use -i or exact quoted text copied from the file.
