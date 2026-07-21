# Cross-run lessons — prompt-it project

## From run 2026-07-21 (research phase)

- **yt-dlp path is reliable**: all 8 YouTube transcripts fetched first-try via the baoyu script's yt-dlp fallback; no `--refresh` retries were needed. Keep single-quoting URLs.
- **Disjoint-file research fan-out works without worktrees**: 5 parallel agents each writing its own `research/` file, coordinator-only git — zero conflicts. Reserve worktree isolation for lanes that edit shared files.
- **Sonnet handled every research lane first-dispatch; haiku handled the structure scan** — zero escalations. For research-shaped packets this tiering is safe to repeat.
- **Cross-source contradiction checking pays**: having two video lanes let one agent catch that another lane's source recommended a technique (emotional-manipulation prompting) that Anthropic practitioners dispute. When lanes cover overlapping topics, tell agents the other lanes exist… (they discovered it via shared transcript dir and self-corrected scope — a happy accident worth making deliberate next time by stating lane boundaries in each prompt).
- **prompt-examples analysis is cheapest inline** when the coordinator already read the sources — don't re-delegate what's already in context.
- Build-phase pointer: the spec-ready brief lives in `research-SYNTHESIS.md` §3; Fernando's 7 open decisions in §3.6 gate the build.
