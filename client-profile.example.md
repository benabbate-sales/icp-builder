# Client profile — EXAMPLE, `icp-builder`

**Copy this to `client-profile.md` and build it with the client. This file is a starting proposal,
not a standard.** The heuristics below are carried over from the skill's earlier builds so a
session starts from something rather than nothing. They are expected to be argued with. The skill
reads `client-profile.md` at run time and carries none of these values itself.

The segments, dimensions and thresholds in an ICP are the client's commercial judgement — **the
skill never invents one.** What it can do is propose a shape, run the arithmetic, and show the
client where their own data disagrees with them.

---

## 1. The universe

- **Source of the account list:** (CRM export, purchased list, hand-built)
- **Row definition:** one row per **ultimate parent**, children rolled up — confirm with the client
- **Required fields present?** firm name · website · stable firm ID · region / country /
  state-county / city / postcode · at least one size signal · account type (customer or prospect)
- **Which size signal does this market actually run on?** (revenue, headcount, AUM, assets under
  administration, customer count, transaction volume…)
- **Rows with missing geography:** flagged, not territorised. How many:

## 2. Tiering

Strategic importance, decided before scoring and independent of it.

| Tier | The client's definition |
|---|---|
| Tier 1 | Strategic — large, brand-name, reference-worthy. Direct pursuit. |
| Tier 2 | Core — sensible fit and size, worth sustained effort. |
| Tier 3 | Opportunistic — smaller or weaker fit; inbound and nurture, not dedicated outbound. |
| Unaddressable | Out of scope, and worth naming so it stays out. |

**Where the client draws each line:**

## 3. Segments

A segment is a group that **buys the same way and responds to the same signals** — not an industry
taxonomy. Two industries collapse into one segment when they buy identically; one industry splits
into two when it doesn't.

- **Proposed working range:** `3–5` segments. *(More than about five usually means tier and segment
  have been confused — collapse. This is a smell test, not a limit.)*
- **The client's segments:**
- **Sub-cuts that matter for coverage** (buy-side/sell-side, SMB/mid-market/enterprise,
  direct/channel):

## 4. Scoring dimensions, per segment

- **Proposed count:** `3–5` dimensions per segment.
- **Observability bar:** a dimension must be populatable for at least `80%` of the universe from
  data the client already has or can buy. Below that it is a wish, not a dimension.
- **Discrimination bar:** if roughly `95%` of a segment answers a dimension the same way, it is not
  earning its place. Drop it.
- **Threshold method:** pull the dimension for the client's current customers in that segment, take
  the median, and sanity-check that accounts above it are intuitively better fits. **Document the
  threshold next to the dimension name** — *relative size H/L (threshold: …)*, never bare *relative
  size H/L*.

| Segment | Dimension | H/L or Y/N | Threshold | Why it discriminates |
|---|---|---|---|---|
| | | | | |

## 5. Grading

- **Grades in use:** `A / B / C` — and what each one commits the client to doing about an account:
- **Profile size ceiling:** with binary dimensions the profile is `2^n` rows per segment; **above
  about `32` rows the logic stops being reasonable-about.** Cut a dimension instead.
- **Calibration set:** pull `20–30` existing customers per segment, mixed deliberately — happy and
  expanding, alongside churned and mis-sold. The best should land A and the worst should land C; if
  they don't, **the dimensions are wrong and phase 3 is where to fix it, not the grade table.**
- **Distribution sanity check:** if any one grade takes more than about `60%` or less than about
  `10%` of a segment, the dimensions are not discriminating. Say so rather than shipping it.

## 6. Sizing potential

- **Method chosen:** analogue spend benchmark / size-based formula / top-down market sizing
- **If analogue:** minimum customers per segment × size-band cell before the median is trusted —
  proposed `5`. The client's number:
- **If formula:** the rate, and the check that it doesn't collapse at the extremes — inspect the
  top and bottom accounts after sizing
- **Whitespace definition for existing customers:**

## 7. Territories

- **Balance target** — what is being balanced (count, potential, or both) and the tolerance:
- **Geographic coherence rules** — what must not be split:
- **Named reps and any accounts that must stay with a named rep:**
- **Constraints:** language, timezone, regulatory, existing relationships

## 8. Deliverables and where they land

- Workbook (.xlsx) · 1-page memo (.md) · anything else the client asked for
- **A summary deck is not in the default bundle.** Only if requested.
- Destination folder:

## 9. Open questions for the client

Judgements only the client can make. Record them here and surface them; never pick on their behalf.

-
