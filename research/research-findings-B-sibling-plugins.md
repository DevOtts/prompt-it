# research-findings-B-sibling-plugins

Document structure and conventions from four sibling Claude Code plugins (plan-it, fable-it, review-it, parallel-lifecycle) to establish a family template for the new prompt-it plugin.

---

## Part A: Per-Repository Structure Summary

### 1. plan-it

**Root-level structure** (`/Users/macbook/Workspace/Devotts/plan-it/`):
- `.claude-plugin/` → `marketplace.json` (top-level marketplace metadata)
- `.claude/` → project-level Claude config
- `plugins/plan-it/` → the actual plugin source directory
  - `.claude-plugin/plugin.json` → plugin manifest
  - `skills/plan-it/` → bundled SKILL.md, machine.json, references/, scripts/
  - `hooks/hooks.json` + `scripts/hooks/` → enforcement hooks
- `docs/` → documentation (01-*, 02-*, etc. design docs)
- `delivery/` → delivery artifacts (CONTRACT.md, STATUS.md, etc.)
- `research/` → research findings (research-BRIEF.md, research-findings-{LETTER}-{slug}.md, research-SYNTHESIS.md)
- `references/` → shared reference docs (formats.md, machine.md, templates.md, playbooks.md)
- `assets/` → visual assets (SVGs)
- `tests/` → test suite (if present)
- `SKILL.md` → root SKILL.md (duplicates `plugins/plan-it/skills/plan-it/SKILL.md`)
- `machine.json` → duplicated root copy for accessibility
- `README.md` → ~600 lines; installation + feature overview + usage guide
- `CHANGELOG.md` → semantic versioning changelog (~200+ lines)
- `CLAUDE.md` → project-specific config/instructions

**Marketplace schema** (`marketplace.json`):
```json
{
  "name": "devotts",  // shared namespace
  "owner": { "name": "DevOtts", "url": "https://github.com/DevOtts" },
  "plugins": [{
    "name": "plan-it",
    "source": "./plugins/plan-it",  // relative to repo root
    "version": "3.0.1",  // semver
    "description": "...",  // long form
    "author": { "name": "DevOtts", "url": "..." },
    "homepage": "https://github.com/DevOtts/plan-it",
    "license": "MIT",
    "keywords": [...]
  }]
}
```

**Plugin schema** (`plugins/plan-it/.claude-plugin/plugin.json`):
- Mirrors name, version, author, homepage, license, keywords
- No source field (that's marketplace-level)

**SKILL.md** (lines 1–565, `/Users/macbook/Workspace/Devotts/plan-it/SKILL.md`):
- Frontmatter (lines 1–37): name, description (long), version, author, author_url, homepage, repository, metadata (platforms, category), keywords
- DevOtts footer: `_Authored by [DevOtts](https://github.com/DevOtts)._` (line 564)
- Section structure: H1 for main title, H2 for subsections, prose + code blocks + tables
- Extensive cross-references to `machine.json`, `references/*.md` files

**Files mentioned by relative path**:
- `machine.json` — XState v5-compatible statechart (lines 102–127 of SKILL.md)
- `references/machine.md` — machine.json protocol + .plan-it/state.json schema
- `references/templates.md` — doc/delivery skeletons + 5 packaging shapes
- `references/formats.md` — atomic formats (decisions, test-cases, governance, DoD ladder)
- `references/playbooks.md` — advanced discovery modes, brownfield templates, scale-out PRD generation
- `scripts/gate-check.mjs` — executable guards (verify, freeze, handoff, state, adversary)

**Research file naming convention**:
- Root-level: `research-BRIEF.md`, `research-findings-A-{slug}.md` through `research-findings-H-{slug}.md`, `research-SYNTHESIS.md`
- Total files in plan-it: 8 findings files (A–H), plus BRIEF and SYNTHESIS

---

### 2. fable-it

**Root-level structure** (`/Users/macbook/Workspace/Devotts/fable-it/`):
- `.claude-plugin/` → `marketplace.json` (can also be at repo root or inside plugins/)
- `plugins/fable-it/` → plugin source
  - `.claude-plugin/plugin.json` → plugin manifest
  - `skills/` → **multiple bundled skills** (not a single one):
    - `fable-it/SKILL.md` — main orchestrator skill
    - `launch/SKILL.md` — mission control (Phase 1 Analyze, etc.)
    - `iterate/SKILL.md` — refinement loop
    - `full-qa/SKILL.md` — test execution
    - `chrome-cdp-control/SKILL.md` — browser automation
    - `references/` → shared reference files (cdp-core.md, model-tiers.md, parallel-safety.md)
  - `hooks/` → Python hooks (turn-end-gate.py, evidence-lint.py, README.md, tests/)
- `docs/` → documentation
- `delivery/` → delivery artifacts
- `tests/` → test suite
- `assets/` → visual assets
- `SKILL.md` → root SKILL.md (duplicates plugins/fable-it/skills/fable-it/SKILL.md)
- `README.md` → ~600 lines; hero + installation + usage
- `CHANGELOG.md` → semantic versioning changelog
- `.fable-it-reports/` → run-state directory (created at runtime)
- `fable-it-field-guide.pdf` — comprehensive guide document

**Key difference from plan-it**: Bundles **5 related skills** under one plugin, with shared references.

**SKILL.md structure** (lines 1–94, root `/Users/macbook/Workspace/Devotts/fable-it/SKILL.md`):
- Frontmatter (lines 1–14): name, description (long single paragraph), version, author, author_url, homepage, repository, metadata, keywords
- DevOtts footer: `_Authored by [DevOtts](https://github.com/DevOtts)._` (line 93)
- Section structure: H1 main title, H2 subsections, prose + bullet tables + code blocks

**Files referenced by relative path**:
- `.taskstate/` — run-state directory (grounding.md, decisions.md, evidence.md, run-memory.md)
- `.fable-it-reports/lessons.md` — cross-run memory persistence
- `references/parallel-safety.md` — worktree, interlock, integration gate protocols

**Bundled skills** (each with own frontmatter):
- `/launch` (lines 1–6): description (single line, shorter), author, author_url, no version field in skill-level frontmatter
- Naming convention: skills are lower-cased with hyphens (launch, iterate, full-qa, chrome-cdp-control)

---

### 3. review-it

**Root-level structure** (`/Users/macbook/Workspace/Devotts/review-it/`):
- `.claude-plugin/` → `marketplace.json`
- `plugins/review-it/` → plugin source (structure mirrors plan-it/fable-it)
- `research/` → **subdirectory** containing findings files (NOT root-level)
  - `research-findings-A-qa-system-docs.md`
  - `research-findings-B-skills-inventory.md`
  - `research-findings-C-e2e-unit-tests-session.md`
  - `research-findings-D-airtable-postmortem.md`
  - `research-findings-E-session-histories.md`
- `research-BRIEF.md` → at root level
- `research-SYNTHESIS.md` → at root level
- `qa/` → **QA-specific directory** (tests, test results)
- `docs/` → documentation
- `delivery/` → delivery artifacts
- `PRD.md` → product requirements document (not in docs/ subdirectory)
- `KICKOFF.md` → handoff/launch prompt
- `NEXT-SESSION-PROMPT.md` → session continuation prompt
- `.review-it/` → plugin state directory (runtime artifacts)
- `.fable-it-reports/` → run-state directory (shared with fable-it)
- `SKILL.md` → root SKILL.md
- `README.md` → ~250 lines
- `CHANGELOG.md` → semantic versioning changelog

**Key difference**: research findings moved into `research/` subdirectory, plus explicit `qa/` directory for quality assurance artifacts.

**SKILL.md structure** (lines 1–13, root):
- Frontmatter: name, description (very long single paragraph with em-dashes), version, author, author_url, homepage, repository, metadata, keywords
- DevOtts footer expected but not shown in excerpt

**Unique aspects**:
- PRD.md at root (not in docs/)
- KICKOFF.md at root (handoff-specific)
- qa/ directory for test results and case tracking

---

### 4. parallel-lifecycle

**Root-level structure** (`/Users/macbook/Workspace/Devotts/parallel-lifecycle/`):
- `.claude-plugin/` → `marketplace.json`
- `plugins/parallel-lifecycle/` → plugin source
  - `.claude-plugin/plugin.json`
  - `skills/parallel-lifecycle/` → single bundled skill (SKILL.md, scripts/connect.py)
  - `hooks/` → bash scripts (worktree-bootstrap.sh, worktree-teardown.sh, hooks.json)
- `docs/` → documentation (simpler, fewer files)
- `references/` → shared reference docs (at root, not in plugins/)
- `assets/` → visual assets
- `.fable-it-reports/` → run-state directory
- `SKILL.md` → root SKILL.md
- `README.md` → ~300 lines
- **No CHANGELOG.md** (smallest plugin; versioning in README instead)
- **No delivery/ or research/ directories**

**Key difference**: Minimal viable plugin shape. No complex delivery artifacts, no research phase, no CHANGELOG.

**SKILL.md structure** (lines 1–87):
- Frontmatter (lines 1–13): name, description (long, structured), version (0.1.0), author, author_url, homepage, repository, metadata, keywords
- DevOtts footer: line 86
- Sections: preflight, browser model, run the app, drive Chrome, cleanup, hard rules
- Emphasis on contract file (`.env.worktree`) over complex state files

**Marketplace** (`marketplace.json`, lines 1–31):
- Distinct marketplace name: `parallel-lifecycle` (not shared with devotts family)
- Description states: "also published in the wider DevOtts marketplace"
- Suggests this can be both standalone and federated

---

## Part B: Common Family Conventions (The Checklist for prompt-it)

Every sibling plugin must satisfy these invariants:

### B1: SKILL.md Frontmatter (Required Fields)

Every SKILL.md **must** have these fields in the YAML frontmatter (lines 1–):

```yaml
---
name: {plugin-name}                    # kebab-case (plan-it, fable-it, parallel-lifecycle)
description: >-                         # Multi-line string (uses `>-` YAML folding)
  {Long description of what the skill does, ~200–300 words.
  Include trigger phrases: "Use when the user says X", "Use whenever Y"...}
version: {semver}                       # Must match marketplace.json + plugin.json
license: MIT                            # Consistent across family
author: DevOtts                          # Required
author_url: https://github.com/DevOtts  # Required
homepage: https://github.com/DevOtts/{plugin-name}
repository: https://github.com/DevOtts/{plugin-name}
metadata:
  platforms: [...]                      # At minimum [claude-code, cursor, ...]
  category: "{Category}"                # E.g., "Planning & Specs", "Agents & Orchestration"
keywords: [...]                         # List of tags
---
```

**Examples of description trigger phrases** (from plan-it lines 3–12):
> Use when the user says "/plan-it", "plan this", "plan-it this", "spec this out", "turn this into a delivery package", "create the PRDs/epics", "do discovery and planning", "scope this project/feature", "act like a PM and break this down", or pastes a vision/transcription…

(review-it uses em-dashes for complex multi-feature description; see line 3 of review-it/SKILL.md)

### B2: DevOtts Authorship Attribution

**All SKILL.md files authored by DevOtts must include**:

1. **Frontmatter fields** (YAML, lines ~1–13):
   ```yaml
   author: DevOtts
   author_url: https://github.com/DevOtts
   ```

2. **Footer line** (last line of the document):
   ```markdown
   ---
   _Authored by [DevOtts](https://github.com/DevOtts)._
   ```

**Verified in**:
- `/Users/macbook/Workspace/Devotts/plan-it/SKILL.md` line 564
- `/Users/macbook/Workspace/Devotts/fable-it/SKILL.md` line 93
- `/Users/macbook/Workspace/Devotts/parallel-lifecycle/SKILL.md` line 86

### B3: Marketplace Schema

**Top-level** `.claude-plugin/marketplace.json`:
- `$schema`: `https://json.schemastore.org/claude-code-marketplace.json`
- `name`: `devotts` (shared namespace for plan-it, fable-it, review-it) OR standalone name (parallel-lifecycle)
- `owner`: `{ "name": "DevOtts", "url": "https://github.com/DevOtts" }`
- `description`: Short summary (1–2 sentences)
- `plugins`: Array with one or more plugin objects, each containing:
  - `name`: kebab-case plugin name
  - `source`: relative path (e.g., `./plugins/plan-it`)
  - `version`: semver, **must match all copies** (plugin.json, SKILL.md, marketplace.json)
  - `description`: short version for marketplace listings
  - `author`: `{ "name": "DevOtts", "url": "..." }`
  - `homepage`: GitHub repo URL
  - `license`: MIT
  - `keywords`: array

**Inside plugins/** `plugin.json` (e.g., `plugins/plan-it/.claude-plugin/plugin.json`):
- Mirrors: `name`, `version`, `author`, `homepage`, `repository`, `license`, `keywords`, `description`
- Omits: `source` (that's marketplace-level)
- Schema: `https://json.schemastore.org/claude-code-plugin-manifest.json`

**Verified in**:
- plan-it: `/Users/macbook/Workspace/Devotts/plan-it/.claude-plugin/marketplace.json` + `/Users/macbook/Workspace/Devotts/plan-it/plugins/plan-it/.claude-plugin/plugin.json`
- fable-it: `/Users/macbook/Workspace/Devotts/fable-it/.claude-plugin/marketplace.json` + `/Users/macbook/Workspace/Devotts/fable-it/plugins/fable-it/.claude-plugin/plugin.json`
- review-it: `/Users/macbook/Workspace/Devotts/review-it/.claude-plugin/marketplace.json`
- parallel-lifecycle: standalone marketplace name + bundled plugin.json

### B4: Directory Structure (Mandatory)

Every plugin must follow this **mandatory hierarchy**:

```
{repo}/
├── .claude-plugin/
│   └── marketplace.json              # Top-level marketplace metadata
├── plugins/{name}/                    # One or more plugin subdirs
│   ├── .claude-plugin/
│   │   └── plugin.json                # Plugin-level manifest
│   ├── skills/
│   │   ├── {skill-name}/
│   │   │   ├── SKILL.md               # The skill definition
│   │   │   ├── [scripts/]             # Optional: scripts dir (e.g., gate-check.mjs)
│   │   │   ├── [references/]          # Optional: shared reference files
│   │   │   └── [machine.json]         # Optional: statechart (if stateful)
│   │   └── [references/]              # Optional: shared refs across all skills in plugin
│   ├── hooks/                          # Optional: enforcement hooks
│   │   ├── hooks.json
│   │   ├── [scripts/]                 # Hook implementation files
│   │   └── [tests/]                   # Hook tests
│   └── [README.md]                    # Optional: plugin-specific readme
├── docs/                               # Design documentation
├── delivery/                           # Delivery artifacts (for plan-phase plugins)
├── research/                           # Research findings (for plan-phase plugins)
│   ├── research-BRIEF.md
│   ├── research-findings-{LETTER}-{slug}.md
│   └── research-SYNTHESIS.md
├── qa/                                 # QA/test results (for review/test plugins)
├── references/                         # Top-level shared references (optional)
├── assets/                             # Visual assets (SVGs, images)
├── SKILL.md                            # Root copy of main skill (duplicated from plugins/*/skills/*/SKILL.md)
├── [machine.json]                      # Root copy (for statechart-based plugins)
├── README.md                           # ~300–600 lines; hero, install, usage, platforms
├── CHANGELOG.md                        # Semantic versioning changelog
└── [CLAUDE.md]                         # Project-level instructions (optional)
```

**Size guidance**:
- `plan-it`, `fable-it`: Large plugins → full docs/ + delivery/ + research/ + hooks/ + multiple skills
- `review-it`: Medium plugin → docs/ + qa/ + multiple modes (review-it has bundled sub-skills in plugins/review-it/skills/)
- `parallel-lifecycle`: Small plugin → minimal structure, single skill, bash-based

### B5: README.md Structure and Scope

**Target: 300–600 lines** (verified: plan-it ~600, fable-it ~600, review-it ~250, parallel-lifecycle ~300)

**Required sections** (in order):

1. **Hero section** (lines ~1–30): centered HTML div with logo/SVG, h1 title, h3 tagline, badges (Quick Start, License, Native Claude Code, SKILL.md portable, Author), nav links
2. **Motivation/Problem** (lines ~40–60): what pain point does this solve?
3. **How it works** (lines ~60–120): diagram + high-level overview (2–3 paragraphs)
4. **Installation** (lines ~120–200): Claude Code + SKILL.md + other agents
   - Use universal installer fallback: `npx skills add DevOtts/{name} -a {agent}`
   - Provide explicit Claude Code plugin command
5. **Key features / The X that makes it unique** (lines ~200–300): 3–5 bullet points or subsections
6. **Platform compatibility** (lines ~300–400): which platforms supported
7. **What's inside / Architecture** (lines ~400–500): file tree, key concepts
8. **Contributing / Development** (lines ~500–550): if applicable
9. **License** (line ~550–560): MIT, copyright DevOtts
10. **Links** (line ~560+): GitHub, docs, related plugins

**Examples**:
- plan-it README (line 18): `<a href="#how-it-works"><img src="assets/plan-it-hero.svg" alt="..." width="100%"></a>`
- fable-it README: similar structure
- parallel-lifecycle README: more minimal (smaller scope)

### B6: Research File Naming Convention

**Only for plugins that have a research/planning/discovery phase** (plan-it, review-it, some large features):

```
{repo}/research-BRIEF.md              # Executive summary of research scope
{repo}/research-findings-A-{slug}.md  # First findings document (A for area/aspect 1)
{repo}/research-findings-B-{slug}.md  # Second findings document
…
{repo}/research-findings-H-{slug}.md  # Up to 8 findings documents per scope
{repo}/research-SYNTHESIS.md          # Summary synthesis of all findings
```

**Verified in**:
- plan-it: 8 findings files (A–H) + BRIEF + SYNTHESIS (`/Users/macbook/Workspace/Devotts/plan-it/research-*.md` at root)
- review-it: 5 findings files (A–E) + BRIEF + SYNTHESIS in `/research/` subdirectory

**Slug naming**: lowercase with hyphens (e.g., `research-findings-A-airtable-anm.md`, `research-findings-B-braindocs-brandbible.md`)

### B7: CHANGELOG.md Format

**Mandatory for all plugins**; use **Semantic Versioning** (semver):

```markdown
# Changelog

All notable changes to {plugin-name} are documented here. This project adheres to
[Semantic Versioning](https://semver.org/).

## X.Y.Z — YYYY-MM-DD

{One-line summary of release}

- **M1 — {category}.** {Detailed change}
- **M2 — {category}.** {Detailed change}

### Founder mandates (optional section, for major releases)
### Write-time invariants (optional, for internal discipline tracking)
### Breaking changes (if any)
```

**Example** (plan-it CHANGELOG lines 1–32):
- Version `3.0.1` released 2026-07-09
- Each change tagged with letter + category (M1, M2, FD-1, FD-2, W1…)
- Release sections in reverse chronological order (newest first)

**Verified in**: `/Users/macbook/Workspace/Devotts/plan-it/CHANGELOG.md`, `/Users/macbook/Workspace/Devotts/fable-it/CHANGELOG.md`

### B8: Bundled Skills / Multiple Skills per Plugin

**When a plugin bundles multiple related skills** (e.g., fable-it):
- Each skill gets its own `skills/{skill-name}/SKILL.md`
- Shared references live in `skills/references/`
- Skills reference each other by name (e.g., `/full-qa`, `/iterate`)
- Each skill's SKILL.md includes frontmatter: name, description, author, author_url (no version at skill level; version is at plugin level)

**Example** (fable-it):
- `plugins/fable-it/skills/fable-it/SKILL.md` — main orchestrator
- `plugins/fable-it/skills/launch/SKILL.md` — Phase 1 mission control
- `plugins/fable-it/skills/iterate/SKILL.md` — refinement loops
- `plugins/fable-it/skills/full-qa/SKILL.md` — test execution
- `plugins/fable-it/skills/chrome-cdp-control/SKILL.md` — browser automation
- `plugins/fable-it/skills/references/` — cdp-core.md, model-tiers.md, parallel-safety.md (shared)

**Verified in**: `/Users/macbook/Workspace/Devotts/fable-it/plugins/fable-it/skills/`

### B9: Relative Path References in SKILL.md

When SKILL.md references bundled files, use **relative paths** from the SKILL.md location:

- `references/machine.md` — sibling dir (plan-it, line 98)
- `../references/model-tiers.md` — parent dir (fable-it bundled skills reference shared references)
- `scripts/gate-check.mjs` — sibling dir (plan-it, line 119)
- `.taskstate/` — absolute from repo root, not relative (fable-it, line 37)

**Verified in**:
- plan-it SKILL.md lines 98, 119 (references/machine.md, scripts/gate-check.mjs)
- fable-it launch SKILL.md line 23 (.taskstate/ — absolute pattern)

### B10: Version Triple-Match Invariant

Every release must maintain **exact version parity** across:

1. `plugin.json` → `version` field
2. `marketplace.json` → plugin object `version` field
3. Root `SKILL.md` → `version` field
4. Root `machine.json` (if present) → `version` field
5. `CHANGELOG.md` → release header line

**Failure mode**: Mismatched versions silently break plugin discovery.

**Verified in**:
- plan-it: all five locations carry `3.0.1` (lines checked in SKILL.md line 29, marketplace line 13, etc.)
- fable-it: all carry `3.0.1`
- review-it: all carry `1.0.0`
- parallel-lifecycle: all carry `0.1.0`

**Release gates mentioned in plan-it CHANGELOG** (line 24):
- `version-triple-match` — all 5 locations verified
- `changelog-shape` — CHANGELOG follows the format

### B11: Optional State and Hooks Infrastructure

**For stateful/enforcing plugins** (plan-it, fable-it, review-it):

- `.{plugin-name}/state.json` or `.taskstate/` directory → run-state persistence
- `plugins/{name}/hooks/hooks.json` → hook registration
- `plugins/{name}/scripts/hooks/` → hook implementations (Node.js `.mjs` or Python `.py`)
- Gate-check scripts as executable verifiers (entry/exit codes determine flow)

**For simpler plugins** (parallel-lifecycle):
- No state directory needed
- Hooks are bash scripts in `plugins/{name}/hooks/` (worktree-bootstrap.sh, worktree-teardown.sh)
- Contract file (`.env.worktree`) carries runtime config

**Verified in**:
- plan-it: `.plan-it/state.json`, `scripts/gate-check.mjs` (lines 102–134 of machine.json)
- fable-it: `.taskstate/` (fable-it SKILL.md line 37), hooks in Python (evidence-lint.py, turn-end-gate.py)
- parallel-lifecycle: `worktree-bootstrap.sh`, `worktree-teardown.sh` (no state persistence)

---

## Part C: Notable Divergences (What Varies)

### C1: Research Directory Placement

- **plan-it, parallel-lifecycle**: Research files at repo root (`research-BRIEF.md`, etc.)
- **review-it**: Research files in `research/` subdirectory (`research/research-findings-*.md`) + BRIEF/SYNTHESIS at root
- **Decision for prompt-it**: Recommend root-level placement (matches 2 of 4; simpler); adopt subdirectory only if research is voluminous (>10 files)

### C2: Marketplace Namespace

- **plan-it, fable-it, review-it**: Shared `devotts` namespace → install via `@devotts` (e.g., `/plugin install plan-it@devotts`)
- **parallel-lifecycle**: Standalone `parallel-lifecycle` namespace, but federated in the wider DevOtts marketplace
- **Decision for prompt-it**: Use `devotts` namespace (joins the family). Install: `/plugin install prompt-it@devotts`

### C3: CHANGELOG vs No CHANGELOG

- **plan-it, fable-it, review-it**: Full CHANGELOG.md with semantic versioning
- **parallel-lifecycle**: No CHANGELOG; version info embedded in README
- **Decision for prompt-it**: Required CHANGELOG.md (aligns with 3 of 4; formality scales with complexity)

### C4: Bundled Skills Count

- **plan-it**: 1 skill (plan-it)
- **fable-it**: 5 skills (fable-it + launch + iterate + full-qa + chrome-cdp-control)
- **review-it**: Inferred ~3–4 bundled skills (contract-qa, side-effects, deploy-verify, pr-review modes)
- **parallel-lifecycle**: 1 skill (parallel-lifecycle)
- **Decision for prompt-it**: Start with 1 primary skill (prompt-it), add bundled skills only if sub-workflows are substantial (>200 lines each)

### C5: Research Phase Necessity

- **plan-it, review-it**: Have research/ + research-BRIEF/SYNTHESIS (discovery-driven)
- **parallel-lifecycle**: No research phase (utility/infrastructure plugin)
- **Decision for prompt-it**: Depends on plugin purpose. If prompt-it is discovery/planning-adjacent, include research/. If utility-focused, omit.

### C6: Documentation Scope

- **plan-it, fable-it**: Extensive docs/ with numbered design docs (01-*, 02-*, etc.)
- **review-it**: docs/ with QA-centric content
- **parallel-lifecycle**: Minimal docs (mostly in README + SKILL.md)
- **Decision for prompt-it**: docs/ required if >5 major sections in SKILL.md; otherwise inline.

### C7: Test Organization

- **parallel-lifecycle**: `plugins/parallel-lifecycle/hooks/tests/` (hook tests)
- **fable-it**: `tests/` at root (e2e/integration tests)
- **plan-it**: No explicit tests/ (logic enforcement via gate-check.mjs exit codes)
- **Decision for prompt-it**: Add `tests/` only if prompt-it has testable logic; otherwise inline in SKILL.md examples

### C8: Assets (Diagrams/SVGs)

- **plan-it**: `assets/` with plan-it-hero.svg, plan-it-pipeline.svg (referenced in README)
- **fable-it, review-it, parallel-lifecycle**: `assets/` present but minimal
- **Decision for prompt-it**: Include `assets/` only if README needs diagrams; otherwise omit

---

## Part D: Common Family Conventions (Summary Checklist)

Use this **as a merge checklist** before publishing prompt-it:

- [ ] SKILL.md frontmatter includes: name, description (long, with triggers), version (semver), author, author_url, homepage, repository, metadata (platforms, category), keywords
- [ ] SKILL.md footer: `_Authored by [DevOtts](https://github.com/DevOtts)._` (last line)
- [ ] `.claude-plugin/marketplace.json` exists with name=devotts, owner=DevOtts, plugins array with name/source/version/description/author/homepage/license/keywords
- [ ] `plugins/prompt-it/.claude-plugin/plugin.json` mirrors plugin.json schema
- [ ] Version field **identical** across: marketplace.json, plugin.json, root SKILL.md, root machine.json (if present), CHANGELOG.md first release
- [ ] Directory structure follows: `.claude-plugin/` + `plugins/prompt-it/` (skills/, hooks/, scripts/) + docs/ + delivery/ (if applicable) + research/ (if applicable) + assets/ + SKILL.md + README.md + CHANGELOG.md
- [ ] README.md: 300–600 lines, hero section + motivation + how-it-works + installation (Claude Code + SKILL.md fallback) + features + platforms + architecture + license/links
- [ ] CHANGELOG.md: semantic versioning, release sections with M1/M2/etc. tags, newest first
- [ ] If bundled multiple skills: each skill/{name}/SKILL.md has frontmatter (name, description, author, author_url); shared references in skills/references/
- [ ] Relative paths in SKILL.md reference bundled files correctly (references/, scripts/, etc.)
- [ ] If stateful: `.prompt-it/state.json` and/or hooks/ directory with gate-check-style scripts
- [ ] If research phase: research-BRIEF.md, research-findings-A-{slug}.md…research-findings-N-{slug}.md, research-SYNTHESIS.md

---

## Part E: Implications for prompt-it

### E1: Recommended Repository Skeleton

```
prompt-it/
├── .claude-plugin/
│   └── marketplace.json                  # Namespace: devotts (join the family)
├── .claude/
│   ├── settings.json                     # Project settings
│   └── [hooks/]                          # Optional: project-level hooks
├── .gitignore
├── plugins/prompt-it/
│   ├── .claude-plugin/
│   │   └── plugin.json                   # Mirror of root version/author/etc.
│   ├── skills/
│   │   ├── prompt-it/
│   │   │   ├── SKILL.md                  # Main skill (~150–300 lines)
│   │   │   ├── [machine.json]            # If stateful (e.g., prompt refinement loop)
│   │   │   ├── [references/]             # If complex (reference docs, examples)
│   │   │   └── [scripts/]                # If executable (e.g., validators, gate-checks)
│   │   └── [references/]                 # Shared references across bundled skills (if >1 skill)
│   ├── hooks/
│   │   ├── hooks.json                    # Hook registration (if enforcing)
│   │   └── [scripts/]                    # Hook implementations
│   └── [README.md]                       # Plugin-specific readme (optional)
├── docs/                                 # Design documentation (if >5 sections in SKILL.md)
│   ├── 01-concept.md
│   ├── 02-architecture.md
│   └── [...]
├── delivery/                             # Delivery artifacts (if planning/spec phase)
│   ├── CONTRACT.md
│   └── [STATUS.md]
├── research/                             # Research findings (if discovery phase)
│   ├── research-BRIEF.md
│   ├── research-findings-A-{slug}.md
│   ├── research-findings-B-{slug}.md
│   └── research-SYNTHESIS.md
├── qa/                                   # QA/test results (if test/verification plugin)
│   └── [test-plan.md]
├── references/                           # Shared reference docs (if needed)
│   ├── formats.md
│   ├── examples.md
│   └── [...]
├── assets/                               # Visual assets (if README has diagrams)
│   ├── prompt-it-hero.svg
│   └── [...]
├── tests/                                # Test suite (if testable logic)
│   ├── [unit/]
│   └── [integration/]
├── SKILL.md                              # Root copy (duplicated from plugins/prompt-it/skills/prompt-it/SKILL.md)
├── [machine.json]                        # Root copy (if stateful)
├── README.md                             # 300–600 lines; hero, install, usage, platforms
├── CHANGELOG.md                          # Semantic versioning changelog; start with 0.1.0 or 1.0.0
├── [CLAUDE.md]                           # Project-level instructions (optional)
├── LICENSE                               # MIT
└── .git/
```

**Minimal viable skeleton** (for a small utility plugin like parallel-lifecycle):

```
prompt-it/
├── .claude-plugin/
│   └── marketplace.json
├── plugins/prompt-it/
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── skills/
│   │   └── prompt-it/
│   │       └── SKILL.md
│   └── [hooks/]
├── SKILL.md
├── README.md
├── CHANGELOG.md
└── LICENSE
```

### E2: Version Initialization

**For a new plugin**, choose the starting version:
- **v0.1.0** if alpha/exploring (parallel-lifecycle uses 0.1.0)
- **v1.0.0** if feature-complete and field-hardened (plan-it v3 is field-hardened; review-it v1 is production-ready)

**Update CHANGELOG.md first release block** to match:

```markdown
## 0.1.0 — 2026-07-21

Initial release. prompt-it provides [feature summary].

- **M1 — [category].** [Change description]
```

**Ensure version field appears identically in**:
1. `.claude-plugin/marketplace.json` → plugins[0].version
2. `plugins/prompt-it/.claude-plugin/plugin.json` → version
3. Root `SKILL.md` (line ~4)
4. Root `machine.json` if present (line ~4)
5. `CHANGELOG.md` first release header

### E3: Marketplace Registration

When ready to publish, update the **shared devotts marketplace** (managed in plan-it or central registry):

```json
{
  "name": "devotts",
  "plugins": [
    { "name": "plan-it", ... },
    { "name": "fable-it", ... },
    { "name": "review-it", ... },
    { "name": "prompt-it", ... }    // NEW
  ]
}
```

**Installation command** will be:
```bash
/plugin install prompt-it@devotts
```

**Note**: If prompt-it starts in a separate marketplace (like parallel-lifecycle), it can migrate to devotts later.

### E4: Authorship Crediting

Every SKILL.md authored by DevOtts must credit the author:

1. **Frontmatter** (required):
   ```yaml
   author: DevOtts
   author_url: https://github.com/DevOtts
   ```

2. **Footer** (required):
   ```markdown
   ---
   _Authored by [DevOtts](https://github.com/DevOtts)._
   ```

**Per CLAUDE.md global instructions** (user's ~/.claude/CLAUDE.md): DevOtts-authored skills must include these exact fields and footer. Edits to existing DevOtts skills must preserve both.

### E5: README.md First Draft Sections

Structure your README.md for prompt-it to match family conventions:

```
1. [Hero section — centered, badge links, nav] — ~30 lines
2. [Problem/motivation] — ~20 lines
3. [How it works / diagram] — ~40 lines
4. [Installation] — ~60 lines (Claude Code + SKILL.md fallback)
5. [Key features] — ~40 lines
6. [Platform compatibility] — ~30 lines
7. [Architecture / what's inside] — ~50 lines
8. [Contributing] — ~20 lines (optional)
9. [License + links] — ~20 lines

Total: ~310 lines (minimum to ~600 max)
```

### E6: SKILL.md Description Field (Trigger Phrases)

The `description` field in SKILL.md frontmatter is crucial for discoverability. It should:

1. **State the core capability** (first sentence)
2. **Include trigger phrases** ("Use when the user says X", "Invoked with Y")
3. **Hint at composition** (what it delegates to, what plugins it works with)
4. **Be multi-line** (use YAML `>-` folding for readability)

**Example template** (inspired by plan-it, fable-it, review-it):

```yaml
description: >-
  {Short capability statement — 1 sentence}.
  {What it does — 2–3 sentences with architectural intent}.
  {Delegation and composition — what it calls or how it fits with siblings}.
  Use when the user says "{trigger1}", "{trigger2}", "{trigger3}",
  or [situation description].
  {Optional: Version info / notable constraints}.
```

### E7: Relative Path Convention for Bundled References

If prompt-it bundles reference files (e.g., prompt-it/references/formats.md, prompt-it/scripts/validator.mjs):

**In SKILL.md, reference them as**:
- `references/formats.md` (sibling dir from SKILL.md)
- `scripts/validator.mjs` (sibling dir)
- `../references/shared-ref.md` (if referencing from a bundled sub-skill)

**Do NOT** use absolute paths or symlinks; relative paths ensure portability when the plugin is installed to any agent's skill directory.

### E8: Enforcement and State Persistence (Optional)

**If prompt-it enforces gates or maintains run state**:

1. **Create `.prompt-it/state.json`** in the target repo (analogous to plan-it's `.plan-it/state.json`, fable-it's `.taskstate/`)
2. **Add gate-check-style scripts** in `plugins/prompt-it/scripts/` (or hooks/)
3. **Document state schema** in a reference file (e.g., `references/state.md`)
4. **Use machine.json if stateful** (XState v5-compatible statechart)

**If no enforcement**, omit state infrastructure and rely on narrative discipline (as parallel-lifecycle does with its .env.worktree contract).

---

## Summary

**prompt-it must be a sibling of plan-it, fable-it, review-it, and parallel-lifecycle.** The family standards are:

1. **SKILL.md frontmatter** + DevOtts footer (non-negotiable)
2. **marketplace.json + plugin.json** with version triple-match
3. **README.md** (300–600 lines, hero + install + features)
4. **CHANGELOG.md** (semantic versioning)
5. **Directory structure** with plugins/{name}/ + bundled skills
6. **Relative paths** for bundled file references
7. **Shared `devotts` namespace** for marketplace

**Size-appropriate skeleton**:
- Minimal (like parallel-lifecycle): plugins/prompt-it/skills/prompt-it/ + SKILL.md + README + CHANGELOG
- Full (like plan-it/fable-it): + docs/ + delivery/research/ + hooks/ + machine.json + references/

**Authorship**: Every SKILL.md credits DevOtts in frontmatter (author, author_url) and footer (one line).

The exact repo skeleton, initial version (0.1.0 vs 1.0.0), and feature scope are determined by what prompt-it does. Use Part E recommendations as a starting template.

---

_This research documents the structure and conventions of four sibling Claude Code plugins as of 2026-07-21, extracted from the live repositories at /Users/macbook/Workspace/Devotts/. It is a snapshot for the purpose of establishing prompt-it's repository template._
