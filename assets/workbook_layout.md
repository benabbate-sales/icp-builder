# Workbook layout

The output xlsx has a fixed tab structure. Build tabs in this order — later tabs depend on earlier ones.

| Tab | Purpose | Depends on |
| --- | --- | --- |
| `Data` | One row per account with all fields, grade, potential, territory | — |
| `Scoring Profiles` | One sub-section per segment showing the dimension → grade lookup | — |
| `Grade Distribution` | Pivot: segment × region × grade, counts and potential | `Data` |
| `Territory Summary` | Per-territory: # accounts, % accounts, total potential, % potential | `Data` |
| `Geography Map` | State → territory (and/or country → sub-region) lookup | — |
| `Customers Whitespace` | Customers ranked by whitespace × grade, for expansion targeting | `Data` (customer rows only) |
| `Uncovered` | Accounts that could not be assigned a territory — edge cases to review | `Data` |

## `Data` tab columns

Required (in this order):

```
FIRM_ID, FIRM_NAME, WEBSITE, COUNTRY, STATE, CITY,
ACCOUNT_TYPE, TIER, GRADING_SEGMENT, [sub-cut e.g. BUY_SELL],
[dimension columns, one per scoring dimension],
GRADE, ESTIMATED_POTENTIAL, CURRENT_SPEND, WHITESPACE,
TERRITORY
```

Sort by `GRADING_SEGMENT`, then `GRADE`, then `ESTIMATED_POTENTIAL` descending.

## `Scoring Profiles` tab

One block per segment, separated by blank rows. Each block:

1. Segment name (bold header row)
2. Column headers: the dimension names + `GRADE` + `# ACCOUNTS` + `% ACCOUNTS` + `TOTAL POTENTIAL` + `% POTENTIAL`
3. One row per combination, grade filled in
4. Grand total row at the bottom of the block

This doubles as documentation — anyone reading the workbook can see exactly why a given combination gets a given grade.

## `Grade Distribution` tab

A single pivot with:

- Rows: `GRADING_SEGMENT`, then `GRADE` (A/B/C)
- Columns: `REGION` (or sub-cut that matters most — buy/sell, SMB/Mid/Ent, etc.)
- Values: `# of accounts` and `total potential`

Add a grand total row and column.

## `Territory Summary` tab

One row per territory:

```
REGION, SUB_REGION, TERRITORY, COVERAGE_TYPE (new-logo/retention/hybrid),
# ACCOUNTS, % ACCOUNTS, TOTAL POTENTIAL, % POTENTIAL
```

Sort by region, then coverage type, then territory name. Include regional subtotals and a grand total.

## `Geography Map` tab

Simple two- or three-column lookup. The exact shape depends on the carve-up:

- NA-style: `State, Buy_Side_Territory, Sell_Side_Territory`
- EMEA-style: `Country, Sub_Region`

Keep it in one tab even if you have multiple regional carve-ups — put them side by side rather than splitting across tabs.

## `Customers Whitespace` tab

Customer-only view. Columns:

```
FIRM_NAME, FIRM_ID, GRADING_SEGMENT, GRADE,
CURRENT_ARR, ESTIMATED_POTENTIAL, WHITESPACE, % OF POTENTIAL CAPTURED,
COVERAGE_RECOMMENDATION (stay with retention / move to new-logo / hybrid)
```

Sort by `WHITESPACE` descending within grade. A-grade + high-whitespace at the top is the priority list for new-logo or growth reps.

## `Uncovered` tab

Anything that did not cleanly fit. Columns:

```
FIRM_NAME, FIRM_ID, COUNTRY, GRADING_SEGMENT, GRADE, ESTIMATED_POTENTIAL,
REASON_UNCOVERED, PROPOSED_TREATMENT (assign manually / leave for inbound / defer)
```
