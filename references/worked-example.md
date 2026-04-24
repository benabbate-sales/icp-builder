# Worked example — a fictional B2B data-services vendor

A full walk-through of the seven phases for a made-up vendor, *DataRail*. DataRail sells a compliance data platform to mid-market and enterprise B2B companies. Numbers are illustrative.

Use this as a reference for shape, not for content — DataRail's dimensions will not be yours.

---

## Phase 1 — Universe

DataRail starts with a list of 1,200 firms from their CRM + a purchased data file. After deduplication on firm ID and dropping firms below $50M revenue (unaddressable), they have **487 accounts**: 48 existing customers, 439 prospects.

Fields populated per account: firm name, website, firm ID, HQ country, HQ state (if US), revenue band, employee count, industry, compliance team flag, existing vendor count in category, last funding event date.

**Tiering:**

- Tier 1 (strategic / reference): top 50 firms by revenue + 10 logos their CMO asked for → 60 accounts
- Tier 2 (core): everyone else that passed the $50M cut → 420 accounts
- Tier 3 (opportunistic): 7 edge-case accounts flagged by the CSM team
- Unaddressable: 713 removed at the $50M cut

## Phase 2 — Segments

After interviewing three sellers and pulling deal-cycle data from the CRM, four segments emerge:

| Segment | Rough definition | Why it is its own segment |
| --- | --- | --- |
| Regulated Financial Services | Banks, insurers, asset managers | Highly regulated — buying process dominated by compliance/risk; buyer is CISO + Compliance |
| Tech & SaaS | Software vendors, cloud-native companies | Self-serve-friendly; buyer is VP Eng or Head of Data |
| Healthcare & Life Sciences | Pharma, medical devices, healthtech | HIPAA/GDPR-heavy; buyer is Head of Data Privacy |
| Industrial & Other Enterprise | Manufacturing, retail, logistics | Slow cycle, champion-led; buyer is CIO |

One sub-cut: **Customer vs. Prospect**. No Buy/Sell analogue.

## Phase 3 — Scoring dimensions per segment

### Regulated Financial Services

| Dimension | Type | Threshold | Notes |
| --- | --- | --- | --- |
| Compliance team exists | Y/N | — | From purchased data |
| Multiple regulated subsidiaries | Y/N | — | If parent has ≥3 entities |
| Revenue band | H/L | $2B | H = ≥$2B |
| # of existing compliance vendors | H/L | 3 | H = ≥3 |
| Recent regulatory enforcement event | Y/N | — | Last 24 months |

### Tech & SaaS

| Dimension | Type | Threshold | Notes |
| --- | --- | --- | --- |
| Headcount | H/L | 500 | H = ≥500 employees |
| Handles PII (self-declared) | Y/N | — | From website / privacy policy |
| Multi-product company | Y/N | — | ≥2 distinct product lines |
| Recent funding (Series C+) | Y/N | — | Last 18 months |

### Healthcare & Life Sciences

| Dimension | Type | Threshold | Notes |
| --- | --- | --- | --- |
| Patient-data volume | H/L | 1M records | H = ≥1M |
| FDA/EMA-regulated product | Y/N | — | — |
| Global operations | Y/N | — | ≥3 countries |
| Existing data-governance platform | Y/N | — | Category incumbent check |

### Industrial & Other Enterprise

| Dimension | Type | Threshold | Notes |
| --- | --- | --- | --- |
| Revenue band | H/L | $1B | H = ≥$1B |
| Multi-country operations | Y/N | — | ≥5 countries |
| Recent data breach or audit finding | Y/N | — | Last 36 months |
| Existing governance maturity | H/L | — | From sales discovery notes |

## Phase 4 — Scoring profile

Calibrated against 30 existing customers. A typical row from the Regulated FS profile (5 binary dimensions = 32 rows):

| Team | Subsidiaries | Revenue | Vendors | Trigger | Grade |
| --- | --- | --- | --- | --- | --- |
| Y | Y | H | H | Y | A |
| Y | Y | H | H | N | A |
| Y | N | H | H | Y | A |
| Y | N | H | L | N | B |
| N | N | L | L | N | C |
| ... | ... | ... | ... | ... | ... |

After applying to the full universe:

| Segment | A | B | C | Total |
| --- | --- | --- | --- | --- |
| Regulated FS | 42 | 71 | 68 | 181 |
| Tech & SaaS | 31 | 48 | 39 | 118 |
| Healthcare | 22 | 39 | 41 | 102 |
| Industrial | 15 | 37 | 34 | 86 |
| **Total** | **110** | **195** | **182** | **487** |

Sanity check: 23% A, 40% B, 37% C. No segment has a grade at >60% or <10%. Dimensions are discriminating. Ship it.

## Phase 5 — Sizing potential

DataRail uses **Method 1: analogue benchmark**. Their 48 existing customers give median annual spend by segment × revenue band:

| Segment | H-band median | L-band median |
| --- | --- | --- |
| Regulated FS | $420k | $180k |
| Tech & SaaS | $310k | $140k |
| Healthcare | $280k | $150k |
| Industrial | $260k | $110k |

Applied across the universe. Total estimated potential: **$134M**, split roughly 50% Regulated FS, 25% Tech, 15% Healthcare, 10% Industrial.

Whitespace for 48 customers: $23M (customers paying 67% of potential on average).

## Phase 6 — Territories

DataRail has 5 new-logo AEs and 2 hybrid reps (retention + some new-logo). Target:

| Region | Coverage |
| --- | --- |
| North America | 3 new-logo AEs |
| EMEA | 1 new-logo AE + 1 hybrid |
| APAC | 1 hybrid |
| LATAM (too small) | covered by EMEA hybrid as edge case |

Geography lookup:

- NA states → East / Central / West
- EMEA countries → UKI, DACH, Rest-of-EMEA
- APAC countries → all one bucket

After balancing:

| Territory | # A/B accounts | Total potential |
| --- | --- | --- |
| NA East | 41 | $21.8M |
| NA Central | 39 | $20.4M |
| NA West | 43 | $22.1M |
| EMEA UKI | 28 | $15.2M |
| EMEA DACH + RoE (hybrid) | 22 | $11.8M |
| APAC (hybrid) | 18 | $9.6M |

Within ±10% on count, ±15% on potential within the peer group (the three NA territories). EMEA hybrid takes less because the rep's time is split with retention.

Uncovered: 7 accounts in LATAM. Flagged for the APAC hybrid rep or left for inbound.

## Phase 7 — Deliverables

Workbook tabs:
- `Data` — all 487 accounts with grade, potential, territory
- `Scoring Profiles` — one tab per segment
- `Grade Distribution` — pivot by segment × grade
- `Territory Summary` — counts and potential per territory
- `Geography Map` — state/country → territory lookup
- `Uncovered` — the LATAM 7
- `Customers Whitespace` — customers ranked by whitespace × grade

1-page memo covers method, the 23/40/37 A/B/C split, the $134M total potential, the 7-territory recommendation, and the two open questions (LATAM coverage, and whether to split NA Central into two territories in FY+1 if pipeline warrants it).

---

That is the full shape. Your dimensions, segments, and numbers will differ — but the arc is the same every time.
