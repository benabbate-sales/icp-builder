# Scoring framework

How to choose segments and scoring dimensions. Read this before Phases 2 and 3.

## Tiering the universe first

Before segmentation, tag every account with a **tier**. Tier is strategic importance, not fit — it answers "should we care about this account at all?"

| Tier | Meaning |
| --- | --- |
| Tier 1 | Strategic — large, brand-name, reference-worthy. Go after directly. |
| Tier 2 | Core — sensible fit and size, worth sustained effort. |
| Tier 3 | Opportunistic — smaller or weaker fit, worth inbound/nurture but not dedicated outbound. |
| Unaddressable | Too small, wrong geography, wrong vertical, regulated out. Cut from the universe. |

Tier is usually a combination of size + strategic value (reference account, brand name, relationship leverage). It is coarse on purpose. Save the nuance for grading.

Cut all Unaddressable accounts before scoring. Keep them in a separate tab so you can audit the cut later.

## Choosing segments

A segment is a cluster of accounts that share buying behaviour. Two tests:

1. **Same buyer type.** Who signs the contract? If the decision-maker profile differs, it is a different segment.
2. **Same scoring signals.** If two groups of accounts need different dimensions to distinguish good-fit from bad-fit, they are different segments.

If both tests pass, collapse them. If either fails, split them.

**Common mistakes:**
- Using industry codes as segments. NAICS and SIC were built for regulatory reporting, not ICP design. Two accounts in different NAICS codes can buy identically; two in the same code can buy totally differently.
- Over-segmenting. More than ~5 segments usually means you are confusing tier with segment. Collapse.
- Under-segmenting. If a single scoring profile is giving obviously wrong grades for one sub-group, that sub-group is its own segment.

**Worked examples:**

*Example — a B2B data-services vendor selling to financial services.* Segments that emerged from actual buying behaviour: Universal & Investment Banks, Asset Servicing & Administrators, Asset/Fund Managers & Insurance, Hedge Funds. Note: asset managers and insurance collapse into one segment because they buy identically in this case. Hedge funds split out because the signals that distinguish fit (recent launch, AUM threshold, prime broker relationship) are hedge-fund-specific.

*Example — a dev-tools vendor selling to tech companies.* Segments: Infra-heavy SaaS, App-layer SaaS, AI-native startups, Enterprise IT. Same industry (tech), but dimensions differ: AI-native startups are scored on GPU spend and model-training frequency, enterprise IT is scored on compliance posture and incumbent vendor.

## Choosing scoring dimensions

For each segment, pick 3–5 dimensions. Each should be:

- **Observable.** You can populate it for at least 80% of the universe from existing data (CRM, web research, purchased data). If you cannot observe it, it is not a dimension — it is a wish.
- **Discriminating.** It splits the segment into meaningfully different groups. A dimension where 95% of accounts answer the same way is not earning its place.
- **Low-cardinality.** Binary (Y/N) or ternary (H/L vs. a threshold) is ideal. Continuous scores are temptingly precise and practically useless — they make the scoring profile too big and hide the logic.

### Dimension archetypes

| Archetype | Example | Signal captured |
| --- | --- | --- |
| Team exists | "Has a dedicated function for this budget category Y/N" | There is someone on the other side who owns this budget |
| Adjacent product | "Uses a named incumbent vendor H/L" | Validated that the buyer spends in this category |
| Scale band | "Headcount H/L (threshold: 500)" | Big enough to need your product |
| Portfolio breadth | "Subsidiaries in target segment Y/N" | Multi-entity contract potential |
| Vendor count | "# of existing vendors in category H/L (threshold: 3)" | Complexity/pain proxy |
| Trigger event | "Recently completed funding round Y/N" | Active buying window |

Pick 3–5 per segment. Most will be archetype-derived; one or two should be segment-specific.

### Thresholds for H/L dimensions

Set thresholds against the distribution of your own data, not against theoretical benchmarks:

1. Pull the dimension value (e.g., headcount) for your current customers in that segment.
2. Take the median. That is your H/L threshold.
3. Sanity-check: accounts above the threshold should intuitively be better fits than accounts below. If not, the dimension is noise — drop it.

Document the threshold next to the dimension name. *"Relative size H/L (threshold: $10B AUM)"* not just *"Relative size H/L"*.

### When dimensions repeat across segments

It is fine. *Relative size* and *team exists* show up in most segments. The segment-specific dimensions are the ones that do the real work — they carry the segment's buying logic.

What to avoid: a dimension that appears across every segment but with different thresholds per segment. That works, but document the per-segment threshold clearly in the scoring profile or you will confuse yourself.

## Output of this phase

After Phases 2 and 3, you should have:

1. A tag per account: `GRADING_SEGMENT`, plus any sub-cut (e.g., `BUY_SELL`)
2. For each segment, a list of 3–5 dimensions with H/L or Y/N definitions and thresholds documented
3. A filled-in `scoring_profile_template.csv` (structure only — the grades are filled in Phase 4)

Do not move to Phase 4 until both 2 and 3 are signed off by the user. Once grading starts, dimension changes are expensive.
