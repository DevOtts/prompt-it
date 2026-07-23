# Grounding — prompt-it BUILD run (2026-07-23, run 2)

Run type: skill-authoring build (no runtime code). Source of truth: research-SYNTHESIS.md §3 (decisions LOCKED), findings-B (packaging conventions), findings-D3 (adopted mechanisms). All three read in full this session (synthesis + D3 authored by this session's coordinator; B's Part D/E read).

## Per-DoD verification path
| DoD | Verified against | Reachable? |
|---|---|---|
| 1 | plugins/prompt-it/skills/prompt-it/SKILL.md on disk; section checklist vs DoD-1 spec (grep for each required mechanism) | YES |
| 2 | plugins/prompt-it/skills/prompt-it/references/targets.md; 6 target profiles present | YES |
| 3 | JSON parse (python json.load) on marketplace.json + plugin.json; `diff` root SKILL.md vs bundled; README wc -l in 300–600; version grep = 0.1.0 in 4 files | YES |
| 4 | grep the routing note + attribution in ~/.claude/skills/next-session-prompt/SKILL.md after edit | YES |
| 5 | qa/dryrun-mode1.md + qa/dryrun-mode2.md on disk; conformance judged against SKILL.md rules (slot presence/omission, 🎯/💡, ≤10 directives, no tiering note, acknowledge-then-catch, failed-attempts) | YES (dry-run = applying the skill's own instructions; honest label: authored-by-coordinator simulation, not an end-user session) |
| 6 | report + ledger + git log | YES |

## Interfaces locked
- SKILL.md is the interface every other artifact copies/describes → authored FIRST, by coordinator (never-downgrade: locks interface others consume).
- Version string "0.1.0" appears in: .claude-plugin/marketplace.json, plugins/prompt-it/.claude-plugin/plugin.json, SKILL.md frontmatter (both copies), CHANGELOG.md first header.

---
# Grounding — v0.2.1 eval-fix + ship run (2026-07-23, fable-it resume)
Source of truth: docs/v0.2.1-eval-fixes-KICKOFF.md + eval/expected-prompts.md (oracle) + judgment-retry-final.md (defect evidence). All read this session.

## Per-DoD verification path
| DoD | Verified against | Reachable? |
|---|---|---|
| 1 (S13) | fresh run-eval.sh output vs oracle S13 checklist (concrete-option questions, cheap-lookup-first), judged evidence-quoted | YES |
| 2 (S14) | fresh run-eval.sh output vs oracle S14 checklist (plan-it route, Beacon path carried, no false facts), judged evidence-quoted | YES |
| 3 (20/20) | full 20-sample run on session-default tier (EVAL_MODEL=fable), judged vs oracle; D19 retry policy for singles, D20 for repro | YES |
| 4 (ship) | version grep = 0.2.1 in quad (marketplace.json, plugin.json, both SKILL.md) + CHANGELOG; 3 registry repos' marketplace.json; installed-cache version dir = 0.2.1 | YES (registry repos exist locally — verify before edit) |
