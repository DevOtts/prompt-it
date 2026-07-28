# v0.3.0 certification — 19/20

Oracle: `eval/expected-prompts.md` (globals G1–G7 + per-sample MUST/MUST-NOT).
Runner: `eval/scripts/run-eval.sh`, `EVAL_MODEL=fable`, `CLAUDE_CONFIG_DIR=~/.claude-8ftools`.
Judges: four Fable-tier passes — `judgment-A.md` (S01–05), `judgment-B.md` (S06–10),
`judgment-C.md` (S11–15), `judgment-D.md` (S16–20).
All 20 `.err` files are 0 bytes — no harness noise.

| Judge | Samples | Result |
|---|---|---|
| A | S01–S05 | 5/5 PASS |
| B | S06–S10 | 5/5 PASS |
| C | S11–S15 | 5/5 PASS |
| D | S16–S20 | 4/5 — **S18 FAIL** |

**19/20.**

## The new behavior held

- **G1 (new shape): 20/20 mechanically.** Every output carries exactly one
  line-initial `▶` delivery line. No sample emitted a bare setup line.
- **G7 (delivery call): 20/20.** 18 fresh-session calls; 2 reasoned `run here`
  (S10, S11) — both verified genuine by their judges (S10's cited typo really is
  at `notes.md:2` in the working tree; S11's target repo really is the cwd).
- **G7 (dangling evidence): clean.** S04 pasted the TS2345 error *text* into the
  block rather than pointing at it. The Mode 2 samples (S07/S08/S09) restated
  findings in-block or cited persisted paths — no "the findings above".
- **Product-LLM targets behaved per the `targets.md` cross-route note:** S06 and
  S18 named a destination surface instead of choosing between sessions.

## The one failure: S18

The block is compliant (154 words fence-to-fence, schema + uncertainty-out
present, no CoT scaffolding). The FAIL is the `💡` line narrating the word cap
— "Kept under the 200-word reasoning-model cap" — which the binding S18 ruling
(fix F2, 0.2.1) defines as a violation in itself: *"The count is a silent
internal check — never state the count or the cap in your response."*

**This is not a 0.3.0 regression.** Measured by re-running S18 on both skills:

| Skill | Runs | Narrated the cap |
|---|---|---|
| 0.3.0 | 4 (`v0.3.0-final` + `v0.3.0-s18retry/r1–r3`) | 2 |
| 0.2.1 | 3 (`v0.2.1-s18baseline/r1–r3`) | 1 |

The defect is present in **0.2.1 at a comparable rate**. The F2 guard suppresses
the narration most of the time but not reliably, and the single 0.2.1
certification run happened to draw a clean sample. The honest reading of the
0.2.1 "20/20" is that S18 passed partly on luck; the honest reading of 0.3.0's
19/20 is that the same coin came up the other way.

Correcting the record rather than the number: 0.2.1's certification stands as
run, but S18 should be treated as a **known flake at roughly a 1-in-3 rate in
both versions**, not as a settled pass. Hardening rule 7 so the cap is never
narrated is follow-up work, out of scope for the delivery-signal release.

## Confounds and notes

- **Baseline commit differs.** 0.2.1 was certified at `cc68c83`; this run is
  `main` (`e511471`, which renamed the `fable-it` route to `build-it`) plus the
  delivery-signal change. No sample failed on routing, and zero rename lag was
  observed — every output used `build-it`.
- **The oracle changed for this run** (disclosed, since it is binding): G1 was
  rewritten from "setup lines ≤2 only if needed" to require the `▶` line; G7 was
  added for the delivery call + dangling-evidence guard; and `fable-it` was
  renamed to `build-it` throughout `expected-prompts.md` / `sample-prompts.md`,
  which the v3.1.0 rename had never propagated. Sample *inputs* were untouched.
- **Non-scoring quality note raised by three judges:** on some fresh-session
  calls (S02, S08, S12, S14, S19) the `▶` reason collapses into the setup clause
  or is dropped entirely. The skill's own exemplar at `SKILL.md:143`
  (`▶ Paste into a fresh session. Run from …`) models exactly that, so the
  emitted behavior matches the skill — but the emit contract's template asks for
  a reason. Exemplar and template disagree; worth reconciling in 0.3.1.

## What the eval could not have caught

`run-eval.sh` exercises the **installed plugin**, and the file it actually loads
is the plugin's **root `SKILL.md`** (the marketplace union manifest) — not
`plugins/prompt-it/skills/prompt-it/SKILL.md`. Overlaying only the latter left
the harness silently running 0.2.1 through three full S01 runs that looked like
model non-compliance. Verify with a no-tools probe before trusting any result:

```bash
CLAUDE_CONFIG_DIR=~/.claude-8ftools \
  echo "Use the prompt-it skill. Do not use any tools. Print verbatim item 4 of its 'Emit (output contract — strict)' list." \
  | claude -p --model fable
```
