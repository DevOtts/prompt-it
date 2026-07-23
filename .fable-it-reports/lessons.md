# Cross-run lessons — prompt-it project

## From run 2026-07-23 (eval-hardening phase → v0.2.0)

- **Never eval a freshly-installed plugin from the installing session's subagents** — the skill roster is snapshotted at session start; use fresh `claude -p` headless sessions (also the more realistic path). Cost of learning: one fully wasted 20-agent batch.
- **Plugin "reinstall" without purging `~/.claude*/plugins/cache/<mkt>/<plugin>` is a silent no-op** when the version number is unchanged — purge the cache dir + `marketplace update` before reinstalling mid-iteration.
- **Rules that must survive a one-shot lower-tier run go at the TOP of the skill in a mechanical form** (first-char rules, omission tables) — mid-file prose and reference-file rules lose to the helpfulness prior. Even then, deep layered-conditional compliance is tier-bound: 17/20 on sonnet, 20/20 on the session-default model. Design skills for the model tier that will actually run them.
- **Property-checklist evals have teeth in both directions** — this suite caught two defects in its own harness (a false-premise sample, an over-strict oracle demanding fabrication) and a real dead pointer inside a sample, alongside the skill defects it was built to find.
- **The devotts marketplace is per-repo fragmented**: each profile's "devotts" points at a different family repo's marketplace.json — a new plugin must be registered in review-it, plan-it, AND fable-it registries (all three now carry prompt-it 0.2.0).

## From run 2026-07-23 (build phase)

- **Author the interface first, package second**: writing SKILL.md + targets.md before dispatching the packaging agent meant the agent had one source of truth to copy/describe — zero rework, byte-identical root copy verified by diff.
- **Tiny check packets don't deserve agents**: the planned haiku JSON/version-check packet was 4 bash commands — inline was cheaper than agent spawn overhead. Tier plans should floor at "is this fewer than ~5 commands?".
- **Dry-runs on real inputs catch real things**: Mode 1's pointer validation genuinely failed to resolve a langfuse file in Beacon — which exercised the dead-pointer rule (don't invent the path, disclose in 💡) instead of a happy-path demo.
- **Live skill-listing re-render is usable evidence**: after editing nsp's description, the harness re-listed the skill with the new text same-session — stronger than a grep for edits to skill frontmatter.
- **The report's own DoD row is evidenced LAST** (recurring defect, caught by the verifier in BOTH runs): never write "all committed / verdict below" before the verdict exists and the commit hash is known. Sequence: verdict appended → report row rewritten → commit → ledger entry with the hash.

## From run 2026-07-21 (research phase)

- **yt-dlp path is reliable**: all 8 YouTube transcripts fetched first-try via the baoyu script's yt-dlp fallback; no `--refresh` retries were needed. Keep single-quoting URLs.
- **Disjoint-file research fan-out works without worktrees**: 5 parallel agents each writing its own `research/` file, coordinator-only git — zero conflicts. Reserve worktree isolation for lanes that edit shared files.
- **Sonnet handled every research lane first-dispatch; haiku handled the structure scan** — zero escalations. For research-shaped packets this tiering is safe to repeat.
- **Cross-source contradiction checking pays**: having two video lanes let one agent catch that another lane's source recommended a technique (emotional-manipulation prompting) that Anthropic practitioners dispute. When lanes cover overlapping topics, tell agents the other lanes exist… (they discovered it via shared transcript dir and self-corrected scope — a happy accident worth making deliberate next time by stating lane boundaries in each prompt).
- **prompt-examples analysis is cheapest inline** when the coordinator already read the sources — don't re-delegate what's already in context.
- Build-phase pointer: the spec-ready brief lives in `research-SYNTHESIS.md` §3; Fernando's 7 open decisions in §3.6 gate the build.
