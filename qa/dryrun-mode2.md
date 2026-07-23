# Dry-run — Mode 2 (post-review continuation)

**Method:** coordinator applied SKILL.md Mode 2 to a synthetic review-it findings snippet built from the real bosslife/"cliente" case (research-findings-A §4). Honest label: authored-by-coordinator simulation.

## Input (synthetic review-it findings)

> Review of "ZeroClaw uses google-ads-optimizer for client stores":
> - PASS: villand returns real recommendations; seu-stillo returns honest-empty. Verified live on praxya, 3 PRs merged. Evidence: chat b1dda7d1-1d40-43eb-aad8-8bad4848c265.
> - FAIL: asked "list the clients configured for the bosslife org", agent answered "No clients configured" — wrong: bosslife IS an org of type=client; the campaign-creator "client" config is a different entity; "clientes recorrentes" (Shopify repeat buyers, e.g. interaction 6a3b09c205c254bcec811236) is a third meaning. Term ambiguity, not a data bug.
> - Failed attempt (from run notes): patching the agent prompt with "clients = orgs of type=client" — rejected, breaks the Shopify-buyer and Meta-ads senses.

## Pipeline trace

1. **Ingest:** one verified win; one gap; gap is not a point defect.
2. **Class over instance:** "cliente" collides across 3 entities → the class is *per-org term/entity disambiguation with no context-injection mechanism*. Candidate mechanism from existing assets: `@brain-docs/features/client-bible/` (SOUL.md/USER.md analog).
3. **Pareto:** one materially distinct gap → fully addressed. 4. **Failed attempts:** the prompt-patch, listed with its rejection reason. 5. **Route:** gap is architecture-shaped ("think first, research benchmarks") → **plan-it**, not a fix loop. 6. Package with /read-chat back-ref.

## Emitted output

```
plan-it

Context: the ZeroClaw google-ads-optimizer integration is done and verified live on
praxya — villand returns real recommendations, seu-stillo returns honest-empty, all
3 PRs merged (evidence: chat b1dda7d1-1d40-43eb-aad8-8bad4848c265). Keep that intact.

The review surfaced one gap, and it's a class, not a bug: asked "list the clients
configured for the bosslife org", the agent answered "No clients configured."
"Cliente" collides across three entities with no way to disambiguate per org:
1. an organization of type=client (bosslife is praxya's B2B client),
2. the campaign-creator "client" config (Meta-ads sense — what the question meant),
3. a Shopify repeat buyer ("clientes recorrentes", e.g. interaction
   6a3b09c205c254bcec811236).

Already tried and rejected: patching the agent prompt with "clients = orgs of
type=client" — it fixes sense 1 by breaking senses 2 and 3, and per-org
particularities would grow the prompt forever.

/goal design the per-organization context-injection mechanism that lets ZeroClaw
disambiguate tenant-specific terms — starting from the existing
@brain-docs/features/client-bible/ (our SOUL.md/USER.md analog), injected when LLM
reasoning needs org context.

DoD sketch (for the planning run to lock):
1. Benchmark scan: how other harnesses solve per-tenant vocabulary/context injection.
2. Design doc: when/what the client-bible injects, and the disambiguation behavior
   for ambiguous terms (ask-or-state-interpretation, not silent guess).
3. Regression fence: villand/seu-stillo current behavior stays green — verifiable
   against the same chat flows above.

Out of scope / do not touch:
- No implementation this session — design + benchmarks only.
- Do not modify the merged google-ads-optimizer PRs.

Pre-read: /read-chat "done-zeroclaw-ads-optimizer-review" (the review session).
```

🎯 Target: plan-it — the gap is a missing architecture mechanism, not a fix-test loop; iterate/fable-it would point-patch it.
💡 Reframed the review's FAIL from "bosslife query broken" to the term-disambiguation class, and carried the rejected prompt-patch forward so the next session doesn't re-propose it.

## Conformance check (vs SKILL.md rules)

- [x] Acknowledge-then-catch: opens with the verified win + its evidence, then the gap
- [x] Evidence citations: chat UUID, interaction ID, existing asset path
- [x] Class-over-instance: 3 colliding senses named; mechanism proposed from existing assets; implementation not prescribed
- [x] Pareto completeness: all materially distinct gaps addressed (1 of 1)
- [x] Failed-attempts section present with rejection reason
- [x] /read-chat back-reference (nsp convention) present
- [x] No fable-it-owned content: no tiering, no persistence, no autonomy/stop clauses
- [x] Route justified in 🎯; 💡 discloses the reframe (no silent rewrite)
- [x] 9 discrete directives (≤10); scope fences labeled; regression fence names its verification target
