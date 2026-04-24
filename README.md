# ICP Builder

A structured, seven-phase workflow for turning a flat list of accounts into a graded, sized, territory-ready book of business. Packaged as a Claude skill.

Use when designing (or refreshing) an Ideal Customer Profile and coverage model from the ground up. Industry-agnostic — the user defines their own segments, scoring dimensions, and grade thresholds.

## The seven phases

1. **Build the account universe** — one clean row per firm, with firmographic fields
2. **Segment the universe** — cluster accounts that share buying behaviour
3. **Define scoring dimensions** (per segment) — the 3–5 signals that separate fit from non-fit
4. **Build the scoring profile** — map every combination of dimension values to a grade (A / B / C)
5. **Grade and size each account** — apply the profile, attach estimated potential ARR
6. **Build territories** — split the graded universe into balanced, geographically coherent patches
7. **Produce the deliverables** — a workbook and a 1-page memo

Read `SKILL.md` for the full walkthrough, then the relevant file under `references/` before starting each phase.

## Repo layout

```
SKILL.md                           # the skill entrypoint — seven phases, orientation
references/
  scoring-framework.md             # choosing segments and scoring dimensions
  grading-model.md                 # A/B/C thresholds, calibration, sizing potential
  territory-build.md               # balancing, geography locks, hybrid rules
  worked-example.md                # end-to-end walkthrough for a fictional vendor
assets/
  scoring_profile_template.csv     # ready-to-edit scoring profile
  workbook_layout.md               # tab structure and column headers for the output xlsx
  memo_template.md                 # 1-page memo skeleton
scripts/
  grade_accounts.py                # apply a scoring profile to a universe
  build_territories.py             # balance accounts across N territories
```

## Using the scripts

Both scripts are pure Python 3, pandas-based. From the repo root:

```
pip install pandas
python scripts/grade_accounts.py --universe accounts.csv --profile assets/scoring_profile_template.csv --out graded.csv
python scripts/build_territories.py --graded graded.csv --territories 6 --out territories.csv
```

For universes under ~100 accounts it is often faster to grade directly in the workbook. Use the scripts when manual grading gets error-prone.

## Principles

- The user owns segment definitions, dimensions, thresholds, and the sizing method. Confirm these before running anything.
- Keep the grading profile small — 4 binary dimensions is 16 rows, 5 is 32. If you are debating a sixth, cut a weaker one.
- Calibrate against real customers: your best current customers should grade A. If they do not, the dimensions are wrong.
- Save the scoring profile alongside the graded list — the logic needs to be auditable.
