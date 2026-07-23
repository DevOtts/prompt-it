# prompt-it eval — 20 rough sample prompts (v1)

Each sample is the EXACT text a runner agent hands to the installed /prompt-it skill. Working directory for every run: /Users/macbook/Workspace/Devotts/prompt-it unless the sample says otherwise. Paired oracle: `eval/expected-prompts.md` (same IDs).

## Coverage matrix
| Dimension | Samples |
|---|---|
| Route: plan-it | S01, S14 |
| Route: fable-it | S02, S15, S19 |
| Route: review-it | S03 |
| Route: iterate | S04, S16 |
| Route: bare session | S05, S17 (agentic) |
| Target: product-LLM / external | S06, S18 (reasoning-native) |
| Mode 2 (post-review, ≥3) | S07, S08, S09, S20 |
| Clarity-gate trivial (≥2) | S10, S11 |
| Dead pointer | S12 |
| Legitimate ambiguity | S13 |
| Tiering-note-in-input (must be stripped) | S19 |
| Failed-attempts material | S09, S20 |

---

## S01 (plan-it — fuzzy platform feature)
> Our brain system is robust but we're missing MCPs. Third parties like HubSpot and Airtable ship MCP servers and we have no plug-and-play way for tenants to install them. I imagine an MCP section in integrations settings like we have for backfill and webhooks, and brain-agent plus brain-apps need visibility of installed MCPs. Figure out how we'd do this.

## S02 (fable-it — scoped fix with clear done-ness)
> The ontology OpenRouter client in brain-api-core reads the global pod env var for the API key. It should resolve the per-Space "Direct (OpenRouter)" backbone connection key first, then fall back to OPENROUTER_API_KEY then OPENAI_API_KEY, same as trigger-draft.service.ts already does. Build and ship it.

## S03 (review-it — verify a done-claim)
> The team says the feedback thumbs up/down component is finished and deployed to the test env. Before I tell the client, check it's actually done — the claim is in the last session's report.

## S04 (iterate — failing build with error)
> pnpm build is failing with: `src/eval/runner.ts(42,18): error TS2345: Argument of type 'string | undefined' is not assignable to parameter of type 'string'.` Make the build green.

## S05 (bare — scratch repo, no harness)
> I'm in a scratch repo with no plugins installed. I have data/customers.csv with duplicate rows (same email, different casing). Write me a script that dedupes it and reports how many rows were removed.

## S06 (product-LLM — term ambiguity in tenant chat)
> Our tenant chat agent keeps answering "no clients found" when the praxya owner asks "quantos clientes recorrentes tivemos este mês?" — in that question "clientes" means Shopify repeat buyers, not orgs of type=client. Improve the agent's system prompt so it handles "cliente" correctly.

## S07 (Mode 2 — post-review continuation)
> Here are the review findings on the observability epic — write me the continuation prompt:
> - PASS: langfuse deployed globally, per-tenant projects live, chat traces arriving (verified in langfuse UI, project praxya).
> - FAIL: the feedback thumbs component only renders on the chat page; Intel and Design pages have LLM interactions with no feedback UI.
> - FAIL: multi-step intel generation shows as one flat llm.generate trace; steps are not separated so we can't see where cost goes.

## S08 (Mode 2 — trace naming gaps)
> Review results for the trace-naming work, generate the next prompt:
> - PASS: traces from chat arrive named "chat" (langfuse project praxya, verified).
> - FAIL: calls from brain-apps arrive as bare "llm.generate" — 3 call sites in brain-apps/pulse were never given origin names.
> - FAIL: automation-triggered calls also unnamed.

## S09 (Mode 2 — postmortem with failed attempts)
> The airtable write feature had a rough review. Findings:
> - FAIL: e2e via CDP claimed green but the tasks dropdown throws UI errors when a human runs it.
> - FAIL: saving to tasks required enabling the integration first; nobody verified the record actually landed in Airtable.
> - Note: we already tried just re-running the CDP suite with longer waits — same false green, don't suggest that again.
> Write the continuation prompt for the next session.

## S10 (clarity-trivial — must NOT get the full pipeline)
> Fix the typo "recieve" → "receive" in eval/fixtures/notes.md in this repo.

## S11 (clarity-trivial — already well-formed)
> plan-it. /goal add a CONTRIBUTING.md to this repo covering how to add a new target profile to references/targets.md. DoD: 1. file exists with profile-addition steps 2. linked from README. Out of scope: no CI changes.

## S12 (dead pointer — must be caught, not propagated)
> Update @docs/architecture/overview.md in this repo to document the new eval suite under eval/.

## S13 (legitimate ambiguity — needs a question or flagged assumption)
> There's a bug in auth — sessions die way too early. Fix the auth bug in our Engine workspace.

## S14 (plan-it — multi-surface product enhancement)
> Extend the Beacon feedback thumbs to every page where users chat with the LLM (Intel, Design, all the regenerations), pop a review modal after each generation, and add a small "what went wrong" form on thumbs-down. The Beacon repo is at /Users/macbook/Workspace/ANM/Beacon.

## S15 (fable-it — small autonomous delivery)
> I'm heading out. Add a version-check script to this repo that exits non-zero when the 0.x.y version differs across marketplace.json, plugin.json, SKILL.md and CHANGELOG.md, wire it as scripts/check-version.sh, and prove it catches a mismatch. Run it to done.

## S16 (iterate — flaky UI e2e)
> The tasks-page dropdown throws "ResizeObserver loop limit exceeded" and detaches mid-click in our CDP e2e, so the suite is red. Get the e2e passing against the real page, not by skipping the test.

## S17 (bare agentic — needs stop conditions)
> Have an agent go through ~/Downloads and move files into subfolders by type (images, pdfs, archives, installers), deleting nothing. I want a prompt I can paste into a plain Claude Code session with no plugins.

## S18 (product-LLM, reasoning-native — must stay short, no CoT)
> Write the system prompt for our log-triage analyzer that runs on o3-mini. It gets a batch of error logs and must output severity 0-4 plus a one-line cause hypothesis per log.

## S19 (fable-it — input carries a stale tiering note that must be stripped)
> Ship the LLM key-source fix to done: brain-api-core ontology client must use the per-Space backbone key with env fallback, mirroring trigger-draft.service.ts. IMPORTANT: split the work using claude teams and use lower models for the subagents to save tokens, keep the coordinator on the big model.

## S20 (Mode 2 — three point-bugs hiding one class)
> Review found these in brain-admin-ui, write the next prompt:
> - FAIL: header title hardcoded "Painel" — English tenants see Portuguese.
> - FAIL: date formats hardcoded DD/MM/YYYY in the tasks table.
> - FAIL: currency symbol hardcoded "R$" in billing widget.
> All three were "fixed" once before by inline ternaries on tenant.language — that got reverted for being unmaintainable.
