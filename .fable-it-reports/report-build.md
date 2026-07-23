# Fable-it Report — prompt-it v0.1.0 build (harness-aware intent compiler)

Run window: 2026-07-23 (~50 min)   |   Model: Fable 5 (posture: full gates, verifier recommended-tier)   |   Approach: coordinator-authored core + 1 sonnet packaging agent (disjoint files, coordinator-only git)

## DoD status

| # | Criterion | Status | Evidence (from the ledger) |
|---|-----------|--------|----------------------------|
| 1 | Core SKILL.md with all specified mechanisms | VERIFIED | Ledger ~1 + ~6: committed c2abd67; grep-audit confirms every DoD-1 mechanism present — clarity gate, 5-target routing, ≤3 questions, pointer validation against `.agents/history/INDEX.md`, 6-slot template + bare-target extras, full Mode 2 pipeline, 3 self-check passes, 🎯/💡 output contract, credential rule, nsp-distinction in description, DevOtts frontmatter + footer. |
| 2 | references/targets.md with 6 target profiles | VERIFIED | Ledger ~1: committed c2abd67 — profiles for plan-it, fable-it, review-it, iterate, bare session, product-LLM, each with PARSES→include / OWNS→omit / cautions + the quick omission table; no-CoT-on-reasoning-native and bare-agentic STOP rules present. |
| 3 | Family packaging, version 0.1.0 quad-matched | VERIFIED | Ledger ~5: "JSON_OK · COPY_IDENTICAL · 0.1.0 grep: marketplace 1, plugin 1, SKILL 1, CHANGELOG 4 · README 300 ln (300–600 range) · LICENSE 21 ln (MIT)". Committed 03f57e1. |
| 4 | Cross-routing note in /next-session-prompt | VERIFIED | Ledger ~2: edit applied; the harness's live skill listing re-rendered nsp's description WITH the new "Sibling routing:" text same-session; author/author_url + footer untouched. |
| 5 | Real verification: JSON parse, version match, Mode 1 + Mode 2 dry-runs under qa/ | VERIFIED | Ledger ~3/~4/~5: qa/dryrun-mode1.md (LANGFUSE rough core → plan-it route; 8-point conformance: no tiering note, 🎯/💡 present, 8 directives, real pointer validation incl. honest unresolved-file disclosure) + qa/dryrun-mode2.md (bosslife findings → 9-point conformance: acknowledge-then-catch, evidence cites, class-over-instance, failed-attempts, no fable-it-owned content). Honest label: dry-runs are coordinator-simulated applications of the skill's instructions, not end-user sessions. |
| 6 | Honest per-DoD report, all committed to main | VERIFIED | Build artifacts on main at c2abd67 + 03f57e1 (verifier-confirmed); this report + lessons + ledger committed in the reconciliation commit whose hash is recorded in the ledger's final build entry. Verifier ran: rows 1–5 CONFIRM on independent artifact spot-checks; row 6's original wording CHALLENGED (uncommitted report + premature verdict citation) and reconciled — verdict below is the verifier's actual output. |

## Could not be verified (and why)

The dry-runs prove the skill's instructions produce conforming output when followed by this coordinator; they cannot prove a *fresh* session will trigger and follow the skill identically (that's inherent to skill authoring — first real-world uses are the true test). Everything else had a same-session verification path.

## No silent caps

- The planned haiku verification agent was replaced by 4 inline bash checks (cheaper than agent spawn; identical coverage) — logged in run-memory.
- Dry-runs cover one route each (plan-it via Mode 1, plan-it via Mode 2); fable-it/review-it/iterate/bare routes are specified in targets.md but not dry-run — first real uses will exercise them.
- README landed at exactly 300 lines (the range floor).
- Nothing else was skipped, sampled, or bounded.

## Delegation & cost

| Packet | Model tier | Why | Escalated? |
|---|---|---|---|
| Core SKILL.md + targets.md | Fable (coordinator) | interface-locking, single coherent voice | n/a |
| Packaging (README/CHANGELOG/JSONs/LICENSE/copy) | sonnet | spec'd doc drafting vs locked interface | no |
| JSON/version checks | inline (was haiku) | 4 commands < agent overhead | no |
| Dry-runs + judging | Fable (coordinator) | judgment-shaped | n/a |
| Fresh-eyes verifier | Fable | never-downgrade | n/a |

Zero escalations needed.

## What changed
- New: plugins/prompt-it/skills/prompt-it/SKILL.md (+ byte-identical root copy), references/targets.md, .claude-plugin/marketplace.json (devotts), plugins/prompt-it/.claude-plugin/plugin.json, README.md, CHANGELOG.md (0.1.0 — 2026-07-23), LICENSE (MIT), qa/dryrun-mode{1,2}.md.
- Edited outside repo: ~/.claude/skills/next-session-prompt/SKILL.md (routing note only, attribution preserved).

## Decisions made
All 5 product decisions were pre-locked by Fernando (synthesis §3.6) — none re-opened. Build-time: inline-checks-over-haiku (above); README tiering mentions allowed only in boundary-explanation context (verified by grep).

## Surprises / risks found
- None structural. Risk to watch: prompt-it's description must not over-trigger on ordinary task requests — the "user must be asking for a prompt, not the work" clause guards this, but real-session behavior should be watched in early use.

## Recommended next actions
1. Install and field-test: `/plugin install prompt-it@devotts`, then run Mode 1 on the next real rough ask.
2. After first review-it cycle, exercise Mode 2 for real and compare against qa/dryrun-mode2.md.
3. After ~a week of use, revisit the two deferred decisions (hook mode, file-output flag) with field evidence.

---

## Fresh-eyes verifier verdict (Fable, fresh context; inputs: DoD + draft report + ledger + artifact spot-checks)

- Row 1: CONFIRM — re-read the core SKILL.md in full; independently found every claimed mechanism (clarity gate, 5-way routing, ≤3 questions, pointer validation, 6-slot template, full Mode 2 pipeline, 3-pass self-check, 🎯/💡 contract, credential rule, nsp distinction, DevOtts attribution).
- Row 2: CONFIRM — all 6 target profiles with PARSES/OWNS/cautions; no-CoT caution in product-LLM profile; stop conditions restricted to bare agentic targets.
- Row 3: CONFIRM — ledger ~5's quoted output reproduced exactly on disk (JSONs parse, byte-identical copy, 0.1.0 quad-match, README 300 ln, MIT).
- Row 4: CONFIRM — "Sibling routing:" note present in nsp; frontmatter attribution + footer intact.
- Row 5: CONFIRM — both dry-run files' conformance checkboxes hold against file content; tiering language appears only as meta-commentary about omissions, never inside emitted prompt blocks; coordinator-simulation caveat properly labeled.
- Row 6: CHALLENGE — (a) report + lessons uncommitted at audit time while the row claimed "all committed"; (b) row cited a verdict that was an empty placeholder (same defect class the research-run verifier flagged). **Reconciled**: row rewritten to separate what was on main (c2abd67/03f57e1, verifier-confirmed) from the reconciliation commit; this section now contains the actual verdict; commit hash recorded in the ledger's final entry.

Coordinator note: the recurring row-6 defect (self-referential "report is committed/verdict below" claims written before they are true) is now a logged lesson — the report's own row must be the LAST thing evidenced, after the verdict exists and the commit hash is known.
