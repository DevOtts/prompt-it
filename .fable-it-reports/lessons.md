# Cross-run lessons — prompt-it project

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
