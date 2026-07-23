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
- ESCALATION log: eval runners S03/S11/S14 sonnet→fable (session default) after 3 failed corrected re-dispatches; reason: instruction-following depth for layered conditional rules is tier-bound; real /prompt-it usage runs on the session default anyway.

## v0.2.1 Phase 1 — S11+S18 guards (2026-07-23, fresh session)
- Fix (55b45b1, deployed+verified in cache): HARD OUTPUT RULES rule 6 gained a mechanical pre-emit diff (every block line must trace to a user-written line; untraceable lines DELETED, salvage goes to 💡); new rule 7 = hard 200-word cap for reasoning-native targets (draft ~150, count fence-to-fence, cut rubrics to 2–3 anchors).
- GOTCHA caught mid-phase: first version of rule 7 made the runner NARRATE its word count before the fence ("192 words, safely under…") → G1 fence-first violation. Patch: "the count is a silent internal check — never state count or cap in the response." Lesson: any mechanical self-check added to SKILL.md must say the check is SILENT, or lower tiers narrate it.
- Rerun on patched version (eval/runs/v0.2.1-phase1b, EVAL_MODEL=sonnet): S11 PASS (passthrough, dead pointer fixed in place, no Grounding/Context section), S18 PASS (197 words fence-exclusive, fence-first, schema+uncertainty-out intact). Sonnet judge: judgment-phase1.md.
- STOPPED for Fernando's review before Phase 2 (S13+S14), per kickoff.

## v0.2.1 Phases 2–3 + ship (2026-07-23, fable-it run)
- Phase 2 (fcd4088): rule 2 gained lookup-first + options-or-assumption; new rule 8 (plan-it scope tie-break, earned-facts, verbatim paths). S13+S14 PASS on sonnet rerun; S14 fact-check 11/12 true, 1 non-material.
- Phase 3: full 20 on EVAL_MODEL=fable (4 concurrent via xargs), judged by 4 fable judge agents (A–D) → 20/20, ZERO D19 retries. First-ever clean certification.
- Ship: quad + CHANGELOG (0.2.0 entry corrected 20/20→16/20 — it predated D20), 3 registries bumped+pushed, reinstall verified 0.2.1.
- Tier log: coordinator Fable; eval runners sonnet (iteration) / fable (certification, per D22); judges sonnet (iteration) / fable ×4 (certification, never-downgrade). Zero escalations needed this run.
