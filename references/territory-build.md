# Territory build

How to split a graded universe into balanced, geographically coherent patches. Read this before Phase 6.

## What a territory is

A territory is a named list of accounts assigned to one rep (or one hybrid rep's new-logo book). Good territories satisfy four constraints:

1. **Balanced.** Roughly equal account count *and* total potential across peer territories.
2. **Geographically coherent.** Accounts in a territory are geographically adjacent. A rep covering "Germany and Spain" has one culture and timezone; a rep covering "Germany and Brazil" has neither.
3. **Coverage-typed.** Each territory is one of: **New-Logo** (prospects only), **Retention** (existing customers only), **Hybrid** (mixed book). Do not mix silently.
4. **Right-sized for actual headcount.** Do not design 12 territories if you have 6 reps. Design for the team you have, not the team you want.

## Step-by-step

### Step 1: Decide the coverage model

Ask:

- How many new-logo reps, retention reps, and hybrids do you have *today*?
- Does the coverage model split along any axis (buy/sell, SMB/Mid/Ent, direct/channel)? If yes, territory design must respect that split.
- Is any region too small for a dedicated rep? Those become hybrid.

Document the target per region: "North America — 3 new-logo buy-side + 1 new-logo sell-side + 2 hybrids."

### Step 2: Build the geography lookup

A geography lookup maps fine-grained geography to territory buckets. Two common shapes:

**State/province-level (NA-style):**

| State | Buy-side territory | Sell-side territory |
| --- | --- | --- |
| NY | New York | US/CAN |
| CA | West | US/CAN |
| MA | East | US/CAN |
| ... | | |

**Country-level (EMEA-style):**

| Country | Sub-region |
| --- | --- |
| UK | UKI & Nordics |
| Ireland | UKI & Nordics |
| Germany | DACH |
| France | BENELUX & France |
| ... | |

Save the lookup as a tab in the workbook (`geography_map`). It is the single source of truth for which account belongs to which geographic bucket.

### Step 3: Balance within sub-regions

Once each account has a sub-region tag, check the count and potential per sub-region. Three outcomes:

**(a) Sub-region fits one territory (typical).** Done. Assign the whole sub-region to one rep.

**(b) Sub-region is too big for one rep.** Split it. Preferred splits, in order:

1. **By coverage type** (Buy-side vs. Sell-side, if that axis applies)
2. **By city cluster** (e.g., London vs. the rest of UK)
3. **Alphabetical** (A-I vs. J-Z) — crude but defensible

Balance the split on *both* account count and total potential. `scripts/build_territories.py` does this automatically given a constraint set.

**(c) Sub-region is too small for a dedicated rep.** Mark it **Hybrid** — covered part-time by a rep whose main book is retention or another sub-region. Never invent a dedicated territory for a sub-region that cannot fund it.

### Step 4: Sense-check the balance

Pull the per-territory summary:

| Territory | # accounts | % accounts | Total potential | % potential |
| --- | --- | --- | --- | --- |
| NY (buy-side) | 51 | 30.2% | $58.1M | 27.7% |
| West (buy-side) | 51 | 30.2% | $57.7M | 27.5% |
| East (buy-side) | 48 | 28.4% | $55.4M | 26.4% |
| US/CAN (sell-side) | 19 | 11.2% | $38.6M | 18.4% |

Rules of thumb:

- Within a peer group (e.g., the three buy-side territories above), account count should be within ±10% across territories, and total potential within ±15%.
- If a sell-side/specialty territory has much higher potential-per-account than the new-logo territories, that is fine — sell-side accounts are bigger. Do not force balance across non-peer groups.

### Step 5: Flag the edge cases

Some accounts do not fit the geography lookup cleanly. Flag them to the user for assignment:

- **Multi-region parents.** If a parent account's subsidiaries span regions, decide: assign to HQ region, or split across reps? HQ is simpler; split is fairer. Use HQ unless the user prefers the other rule explicitly.
- **Unaddressed geographies.** Countries with 1–2 accounts and no rep coverage (e.g., "Eastern Europe" in a NA/EMEA carve-up). Flag them in an "Uncovered" list rather than forcing them into the nearest territory.
- **New-logo retention conflicts.** An account that is a customer of one product and a prospect for another. Usually retention rep owns it; new-logo rep sells the second product via the retention rep's relationship.

## Rules of thumb

- **Under-penetrated A/B customers are assigned to a new-logo rep, not retention.** If a customer is paying <30% of their estimated potential, the retention rep is unlikely to close the whitespace. Move it to a new-logo rep or a dedicated growth rep.
- **A dedicated territory needs 8–10 A/B accounts minimum.** If a sub-region has fewer, make it hybrid.
- **Do not split within a country without a reason.** Splitting Germany across two reps adds handover friction. Do it only if the country is big enough to sustain two full books (rare outside the US and UK).
- **Keep the lookup stable.** State → territory mappings should move rarely. Reps rely on geographic memory, and shuffling states every cycle is a tax.

## Output of this phase

After Phase 6, you should have:

1. A `geography_map` tab (state/country → territory)
2. Every account in the universe has a `TERRITORY` column
3. A per-territory summary showing # accounts, % accounts, total potential, % potential
4. An "Uncovered" list for any edge-case accounts that could not be assigned
5. Documented rep count and coverage type (new-logo / retention / hybrid) per territory

This is the input to Phase 7 (the workbook and memo).
