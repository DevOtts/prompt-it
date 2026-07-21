# Grounding — prompt-it research run (2026-07-21)

Run type: research-only. No product code is built; deliverables are research files + synthesis + spec-ready brief. "Data" here = evidence sources, each with a named on-disk output.

## Source-of-truth map
- Local evidence: `prompt-examples.txt` (9 hand-written prompts, READ in main thread), `analysis-example/image-{1,2,3-prompt}.png` (bosslife/"cliente" case, VIEWED in main thread).
- Sibling plugins (structure conventions): `/Users/macbook/Workspace/Devotts/{plan-it,fable-it,review-it,parallel-lifecycle}` — local disk, reachable.
- YouTube: 8 video URLs → transcripts via user skill `/youtube-transcriber` (fallback: yt-dlp auto-subs). Reachability = network; test at first fetch.
- Web: prompt-engineering standards + existing optimizer tools via WebSearch/WebFetch. Reachable (tools available to agents).

## File conventions (mirrors review-it: `research/` dir + root synthesis)
- `research/research-findings-A-local-evidence.md` (DoD 1)
- `research/research-findings-B-sibling-plugins.md` (DoD 2)
- `research/research-findings-C1..C2-youtube.md` + `research/transcripts/` (DoD 3)
- `research/research-findings-D1-existing-tools.md`, `research/research-findings-D2-best-practices.md` (DoD 4)
- `research-SYNTHESIS.md` at repo root (DoD 5)
- `.fable-it-reports/report.md` (DoD 6)

## Per-DoD verification path
| DoD | Verified against | Reachable this session? |
|---|---|---|
| 1 | findings-A file on disk, content covers anatomy + bosslife case | YES (sources already in context) |
| 2 | findings-B file on disk, covers all 4 sibling repos' conventions | YES (local disk) |
| 3 | 8 transcripts on disk + findings-C files; per-video technique extraction | LIKELY (network-dependent; verify per URL, report per-video honestly) |
| 4 | findings-D files with cited URLs incl. Anthropic prompt-improver, DSPy, meta-prompting + critical assessment of Fernando's patterns | LIKELY (WebSearch) |
| 5 | research-SYNTHESIS.md on disk w/ output template, 2 modes, family integration, open decisions | YES |
| 6 | report.md + fresh-eyes verifier verdicts | YES |
