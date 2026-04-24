# Grading model

How to turn a scoring profile into grades, and how to size potential. Read this before Phases 4 and 5.

## The scoring profile

A scoring profile is one lookup table per segment. Rows are every combination of dimension values; each row has a grade.

With 4 binary dimensions, that is 2⁴ = 16 rows per segment. With 5, it is 32. Keep it tight — more than 32 rows per segment and the logic gets too granular to reason about.

Template column order: `SEGMENT, [dimension columns], GRADE`. See `assets/scoring_profile_template.csv`.

**Example — 5-dimension segment:**

| SEGMENT | TEAM | SUBSIDIARIES | SIZE_BAND | VENDOR_COUNT | TRIGGER | GRADE |
| --- | --- | --- | --- | --- | --- | --- |
| Asset Managers | Y | Y | H | H | H | A |
| Asset Managers | Y | Y | H | H | L | A |
| Asset Managers | Y | N | H | H | H | A |
| ... | | | | | | |
| Asset Managers | N | N | L | L | H | C |
| Asset Managers | N | N | L | L | L | C |

## Grade definitions

| Grade | Meaning | Coverage implication |
| --- | --- | --- |
| A | High fit + high potential | Dedicated outbound. Worth a rep's weekly attention. |
| B | Mid fit, real potential, longer sell | Worth pursuing on cadence; do not over-index. |
| C | Low fit or small potential | Nurture / automated only. Do not build a territory around these. |

Some teams add a D (actively non-fit) — skip it. If an account is non-fit, it should have been cut at the Unaddressable step.

## Filling in the grades

Do not fill this in by intuition. Calibrate:

1. **Pull 20–30 existing customers** spread across segments. Mix good ones (happy, expanding, reference-worthy) with bad ones (churned, under-penetrated, mis-sold).
2. **Populate their dimensions** honestly.
3. **Look at the combinations:** the combinations your best customers match should end up graded A. If they are landing in B or C, your dimensions are wrong — go back to Phase 3.
4. **Look at the bad-fit combinations:** the combinations your churned or bad-fit customers match should end up graded C.
5. **Grade the middle honestly.** Most combinations will be ambiguous. Default to B unless there is a reason to push up or down.

Document the reasoning for any combination that feels counterintuitive — you will be asked to defend it.

**Sanity check before shipping:** apply the profile to the full universe and look at the grade distribution per segment. If any one grade is >60% or <10% of a segment, the dimensions probably are not discriminating well. Go back and check.

## Sizing potential

Every account needs an `ESTIMATED_POTENTIAL` — the ARR that account would contribute if fully sold. Use one of:

### Method 1: Analogue spend benchmark

Look at what similar customers pay today. Group your existing customer spend by segment + size band. Median spend per group = benchmark.

*When to use:* You have enough current customers to get a stable median in each segment × size band cell. Minimum ~5 customers per cell.

*Failure mode:* You extrapolate a benchmark from one segment onto another. Do not. Build per-segment benchmarks.

### Method 2: Size-based formula

Potential = (size metric) × (rate).

Examples: $X per employee; $Y per $B of AUM; $Z per million transactions processed.

*When to use:* Product value scales clearly with one size metric, and you can defend the rate with customer data.

*Failure mode:* The rate looks reasonable in aggregate but collapses at the extremes. Check the top 5 and bottom 5 accounts after sizing — if either feels obviously wrong, the formula is miscalibrated.

### Method 3: Top-down market sizing

Total addressable market / number of target accounts = per-account average. Adjust up for A-grades, down for C-grades.

*When to use:* Early-stage product, limited customer data, need a directional number.

*Failure mode:* Top-down numbers are notorious for being convincing and wrong. Flag the sizing assumption explicitly in the memo. Do not let the user forget it was top-down.

## Whitespace calculation

For **customer** accounts, add one more column: `WHITESPACE = ESTIMATED_POTENTIAL - CURRENT_SPEND`. This is the expansion number.

Customers with high whitespace and A/B grades are where upsell should concentrate. Customers with high whitespace and C grades are a red flag — either the grading is off, or the customer is paying for things they do not need.

For **prospect** accounts, whitespace = `ESTIMATED_POTENTIAL` (they are paying you nothing today).

## Output of this phase

After Phases 4 and 5, you should have:

1. A completed scoring profile per segment (saved as CSV alongside the workbook)
2. Every account in the universe has a `GRADE` (A / B / C) and an `ESTIMATED_POTENTIAL` (number)
3. Customer accounts have a `WHITESPACE` column
4. Grade distribution per segment × region is sense-checked (no one grade dominates a segment)

Only after this is the data ready for territory design.
