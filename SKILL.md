---
name: icp-builder
description: Turn a raw account list into a full ICP plan — segmentation, per-segment scoring dimensions, A/B/C grading, estimated potential, and balanced territory splits. Use whenever the user mentions ICP (Ideal Customer Profile), account grading, account scoring, coverage model, territory planning, territory design, book carve-up, rep assignment, or anything that sounds like "turning our target account list into a graded, sized, and split book of business." Trigger even if the user does not say "ICP" — requests like "help me decide which accounts my reps should own", "score our prospect list and split it across the team", or "build a CAP DB for our market" should all invoke this skill.
---

# ICP Builder

A structured, seven-phase workflow for turning a flat list of accounts into a graded, sized, territory-ready book of business. Use this skill when the user wants to design (or refresh) an Ideal Customer Profile and coverage model from the ground up.

The skill is industry-agnostic. The user defines their own segments, scoring dimensions, and grade thresholds. Nothing in the workflow assumes a specific industry.

## The seven phases

1. **Build the account universe** — one clean row per firm, with firmographic fields
2. **Segment the universe** — cluster accounts that share buying behaviour
3. **Define scoring dimensions** (per segment) — the 3–5 signals that separate good-fit from bad-fit within that segment
4. **Build the scoring profile** — map every combination of scoring values to a grade (A / B / C)
5. **Grade and size each account** — apply the profile, attach estimated potential ARR
6. **Build territories** — split the graded universe into balanced, geographically coherent patches
7. **Produce the deliverables** — a workbook and a 1-page memo

Each phase is covered in detail in `references/`. Read the relevant reference before doing the work for that phase — the summaries below are orientation, not instructions.

Run the phases in order. Earlier decisions (segments, dimensions) constrain later ones (grading logic, territory shape). Skipping back is fine, but redo every downstream phase if you do.

---

## Phase 1 — Build the account universe

One row per firm. Ultimate parent only (roll up child accounts). Required fields:

- Firm name, website, a stable firm ID
- Region, country, state/county, city, postcode
- At least one size signal (revenue, headcount, AUM, assets, customers — whatever matters in this industry)
- `ACCOUNT TYPE` — `Customer` or `Prospect`
- `TIER` — Tier 1 / Tier 2 / Tier 3 / Unaddressable (strategic importance; see `references/scoring-framework.md` for how to draw the line)

Optional but useful: parent/child count, known product/tech signals, analogue spend benchmarks.

If the user hands you a messy list, clean it first. Deduplicate on firm ID. Flag rows with missing geography (they cannot be territorised).

---

## Phase 2 — Segment the universe

A segment is a cluster of accounts that share buying behaviour and respond to similar scoring signals. Segments are not the same as industries — two industries can collapse into one segment if they behave identically, and one industry can split into two segments if it does not.

Ask the user: *"What are the 3–5 buyer types that buy differently from each other?"* Do not let them default to their industry taxonomy.

Tag every account with a `GRADING SEGMENT`. If relevant, also tag a sub-cut (e.g., Buy-side / Sell-side, SMB / Mid-market / Enterprise, Direct / Channel). Sub-cuts matter when the coverage model splits reps along that axis later.

Full methodology: `references/scoring-framework.md` → "Choosing segments".

---

## Phase 3 — Define scoring dimensions

For each segment, pick 3–5 dimensions that separate fit from non-fit. Each dimension should be:

- **Observable** — you can actually populate it for most accounts
- **Discriminating** — it splits the segment into meaningfully different groups
- **Binary or low-cardinality** — `Y/N`, or `H/L` against a clear threshold. Avoid continuous scores

Common dimension types: *team exists* (Y/N), *uses a competing/adjacent product* (Y/N), *has meaningful subsidiaries* (Y/N), *size band* (H/L vs. a threshold), *vendor count* (H/L), *recent trigger event* (Y/N).

Dimensions can overlap between segments (e.g., *size band* will often appear in all segments), but each segment should have at least one dimension that is segment-specific.

Full methodology and worked examples: `references/scoring-framework.md` → "Choosing dimensions".

---

## Phase 4 — Build the scoring profile

A scoring profile is a lookup table: for each combination of dimension values in a segment, it assigns a grade (A / B / C).

With 4 binary dimensions that is 16 rows per segment. With 5, it is 32. Keep it tight — if you find yourself debating a sixth dimension, cut a weaker one instead.

Rules of thumb:

- **A** = high fit. High potential, short time-to-close, worth a dedicated seller's time.
- **B** = mid fit. Worth pursuing but not worth building a territory around. Often the bulk of the list.
- **C** = low fit. Do not ignore entirely — run nurture, not outbound.

Calibrate against your existing customers: the combinations your best current customers match should grade A. If they do not, your dimensions are wrong — iterate.

Full methodology: `references/grading-model.md`.

---

## Phase 5 — Grade and size

Run the scoring profile over the universe. Every account gets a grade.

Then attach an estimated potential ARR per account. The user will have one of:

- An analogue-spend benchmark (what similar customers pay today)
- A size-based formula (e.g., $X per employee, $Y per $B of AUM)
- A top-down market-sizing number to divide

Use the method they already trust. Do not invent one. Flag accounts where the sizing method clearly does not fit (e.g., a benchmark derived from buy-side applied to a sell-side name) and recommend a per-segment benchmark instead.

Output: the universe file, enriched with `GRADE` and `ESTIMATED_POTENTIAL` columns, plus a whitespace column (`ESTIMATED_POTENTIAL` − `CURRENT_SPEND`) for customers.

Full methodology: `references/grading-model.md` → "Sizing potential".

---

## Phase 6 — Build territories

Territories need to be:

1. **Balanced** — roughly equal account count *and* total potential
2. **Geographically coherent** — a rep should not be zig-zagging across the map
3. **Coverage-consistent** — a territory is either new-logo, retention/hybrid, or one of each; do not mix silently
4. **Right-sized for the headcount you actually have** — do not design 12 territories if you have 6 reps

Build a lookup table (state → territory for NA-style carve-ups, country → sub-region for EMEA-style). Let the lookup do the geographic work; then balance within the sub-region using alphabetical splits or A/B/C mix where needed.

If one sub-region is too small for a dedicated rep, mark it **Hybrid** (served part-time by a rep with another book) rather than invent a territory.

Full methodology: `references/territory-build.md`.

Helper script: `scripts/build_territories.py` — balances accounts across N territories minimising variance on count and potential, honouring a geography lock.

---

## Phase 7 — Deliverables

Default deliverables (user chose this explicitly):

1. **Workbook (.xlsx)** — the graded, sized universe plus rollups. Tab structure in `assets/workbook_layout.md`.
2. **1-page memo (.md)** — method, grade distribution, headline numbers, territory recommendations. Template in `assets/memo_template.md`.

A summary deck is **not** in the default bundle. Build one only if the user asks. When they do, keep it to 3–5 slides: territory summary by region, then one slide per region showing the split.

---

## Workflow notes

**Ask before inventing.** The user owns the segment definitions, the dimension list, the grading thresholds, and the potential-sizing method. Confirm these before running anything. Guessing destroys the skill's value — the whole point is that the output reflects *their* ICP, not a generic one.

**Show your working.** When you grade accounts, save the scoring profile alongside the graded list so the logic is auditable. A CFO buyer or a VP Sales reviewing the output will ask *"why is Company X an A and Company Y a B?"* — you need to be able to answer.

**Keep the grading profile small.** If the grading profile has more than ~32 rows (5 binary dimensions), you have probably overcomplicated it. Cut dimensions until it fits.

**Iterate on real data, not theory.** Draft the scoring profile, run it against 20–30 existing customers, then sanity-check: do your best current customers show up as A? Do your churned/bad-fit ones show up as C? Adjust the profile until the answer to both is yes.

**Helper scripts are optional.** `scripts/grade_accounts.py` and `scripts/build_territories.py` do the deterministic work (apply a profile; balance a split). Use them when the universe is big enough that doing it by hand is error-prone. For under ~100 accounts, it is often faster to grade in the workbook directly.

---

## Reference files

- `references/scoring-framework.md` — choosing segments and scoring dimensions, with worked examples
- `references/grading-model.md` — A/B/C thresholds, calibration against existing customers, sizing potential
- `references/territory-build.md` — balancing rules, geography locks, new-logo vs. hybrid, sub-region too-small handling
- `references/worked-example.md` — a full walk-through for a fictional B2B data-services vendor, end to end
- `assets/scoring_profile_template.csv` — a ready-to-edit scoring profile file
- `assets/workbook_layout.md` — the tab structure and column headers for the output xlsx
- `assets/memo_template.md` — the 1-page memo skeleton

Read the reference file for a phase *before* starting that phase. Do not try to hold the whole skill in working memory.
