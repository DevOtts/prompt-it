# prompt-it — Skill-Marketplace Publish Report (2026-07-23)

Repo: `DevOtts/prompt-it` (public, MIT, v0.2.1 released). Adaptation merged to `main` via PR #1: root `SKILL.md` union manifest (license/homepage/repository/metadata/keywords frontmatter + Install + Security sections), topics added (`openclaw-skill`, `agent-skill`, `skill`, `skills`, `mcp`, `claude`, `claude-code`), tagged release `v0.2.1` with zip artifact.

| # | Marketplace | Status | Evidence / probe |
|---|---|---|---|
| 0 | **skills.sh** | **VERIFIED — installable** | `npx skills@latest add DevOtts/prompt-it --list` prints the prompt-it skill name + full description. The public directory page populates from install telemetry and lags — not yet claimed as "listed". (Deliberately did NOT seed a local install: this machine already runs prompt-it as the installed Claude Code plugin, and a global skills-dir copy would shadow/duplicate it.) |
| 1 | **SkillsLLM** | **SUBMITTED — pending review** | Driven via real-Chrome CDP while signed in: form at skillsllm.com/submit filled with `https://github.com/DevOtts/prompt-it`, green toast confirmed on screen: *"Skill submitted successfully! It will be reviewed shortly."* (screenshot: `.fable-it-reports/skillsllm-submit-toast.png`, local). The on-page "100 stars" line is advisory; listing follows their async review + security scan (~24h). |
| 2 | **SkillsMP** | **QUALIFIED — awaiting crawl** | Repo now meets indexing requirements (root SKILL.md on default branch, topics, license). Negative probe at submit time (honest): `skillsmp.com/api/v1/skills/search?q=prompt-it` → `"skills":[], total 0`. Re-probe in 6–24h. |
| 3 | **SkillHub** | **QUALIFIED — awaiting crawl** | No submit surface exists (`/submit` is 404 by design); auto-index reads qualifying public repos. Check skillhub.club search for "prompt-it" in a day. |
| 4 | **TrustedSkills** | **QUALIFIED — awaiting scrape (≤6h)** | `openclaw-skill` topic + tagged `v0.2.1` release with zip artifact are live (`gh repo view` confirms both). Scraper picks these up within ~6h; first appears at "Unverified" tier, then "Community" after its 6 security scans. |

## Recommended next actions
- Re-run the probes in 6–24h: `npx skills add DevOtts/prompt-it --list` (directory page), the SkillsMP search URL, skillhub.club search, trustedskills.dev search.
- SkillsLLM listing lands after their review (~24h); "Featured" tier wants ~100 GitHub stars — the LinkedIn post should help.
