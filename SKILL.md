---
name: icp-builder
description: >-
  Turn a client's raw account list into a full ICP plan — segmentation, per-segment scoring
  dimensions, A/B/C grading, estimated potential and balanced territory splits — with every
  segment, dimension, threshold and grade rule defined by the client in a client profile rather
  than assumed. Use whenever someone mentions ICP or ideal customer profile, account grading,
  account scoring, a coverage model, territory planning or design, carving up the book, or rep
  assignment. Trigger without the acronym too: help me decide which accounts my reps should own,
  score our prospect list and split it across the team, build an account plan database for our
  market. Reads client-profile.md at run time and asks rather than inventing when a threshold is
  missing. Do NOT use for designing the meetings where the book gets reviewed, which is
  gtm-cadence-builder, or for pipeline and forecast reporting, which is gtm-dashboard-builder.
---

# ICP Builder

**Build:** `icp-builder · 2026-08-05 · client-configured`

A seven-phase workflow that turns a flat list of accounts into a graded, sized, territory-ready
book of business.

## The client owns the values. This skill owns the method.

**Never hard-code a segment, a scoring dimension, a threshold, a grade rule, a sizing rate or a
territory constraint into this file or its references.** They are read at run time from the
engagement's **`client-profile.md`**.

This matters more here than in most skills, because **an ICP is the client's commercial judgement
about their own market.** A borrowed threshold produces a graded universe that looks authoritative
and is wrong in a way nobody can see from the output — and reps then work it for a year.

`client-profile.example.md` ships with this skill. It carries the proposed working ranges and the
calibration heuristics so a workshop starts from something. **It is an input to a conversation,
never an answer.**

**Load order:** `client-profile.md` in the engagement folder → `client-profile.example.md` as the
proposal to work through → ask the client. Stop at the first that exists.

**Failure mode — stop, don't improvise.** If no profile exists and the client cannot be asked,
**stop and say so. Never invent a segment, a threshold or a grade boundary to keep the workflow
moving.** A half-guessed ICP is worse than none: it gets loaded into the CRM, and the guess becomes
the company's definition of a good customer. No profile, no grading.

**The skill is industry-agnostic by design.** Nothing in the method assumes a sector — the client
defines their own segments, dimensions and thresholds, and the workflow is the same either way.

## The seven phases

1. **Build the account universe** — one clean row per firm, with the fields the profile names.
2. **Segment it** — cluster accounts that share buying behaviour.
3. **Define scoring dimensions** per segment — the signals that separate fit from non-fit.
4. **Build the scoring profile** — map every combination of dimension values to a grade.
5. **Grade and size** — apply the profile, attach estimated potential.
6. **Build territories** — split the graded universe into balanced, coherent patches.
7. **Produce the deliverables.**

Run them in order — earlier decisions constrain later ones. Skipping back is fine, but redo every
downstream phase when you do. Read the reference for a phase before running it; the summaries here
are orientation, not instructions.

---

## Phase 1 — Build the universe

One row per firm at the level the profile specifies, with the fields it lists. Clean before
grading: deduplicate on the firm ID, and **flag rows with missing geography rather than dropping
them** — they cannot be territorised, and the client should see how many there are.

## Phase 2 — Segment

A segment is a cluster that buys the same way and responds to the same signals. **It is not an
industry taxonomy**, and the most common failure is letting the client default to one. Ask which
buyer types buy *differently from each other*, and collapse the ones that don't.

Tag every account with its segment, plus any sub-cut the profile names — sub-cuts matter when the
coverage model later splits reps along that axis.

Working range and the over-segmentation smell test: the profile. Method:
`references/scoring-framework.md` → *Choosing segments*.

## Phase 3 — Define scoring dimensions

Per segment, pick the dimensions the profile records. Every one must clear two bars stated there:
**observable** — populatable across the universe from data the client has or can buy — and
**discriminating** — it actually splits the segment.

**Document each threshold beside its dimension name**, never the bare dimension. A threshold that
lives only in someone's head is re-derived differently next quarter.

Method: `references/scoring-framework.md`.

## Phase 4 — Build the scoring profile

Map every combination of dimension values to a grade, per segment, into
`assets/scoring_profile_template.csv`. Watch the row count against the ceiling in the profile —
past it, cut a dimension rather than reasoning about combinations nobody can hold.

**Then calibrate against the client's own history**, using the sample the profile specifies: their
best customers should land at the top grade and their churned or mis-sold ones at the bottom. **If
they don't, the dimensions are wrong — go back to phase 3.** Do not fix it by hand-editing grades:
that hides the error and it will resurface on every new account.

Method: `references/grading-model.md`.

## Phase 5 — Grade and size

Apply the profile across the universe, then attach estimated potential by the sizing method the
client chose. Compute whitespace for existing customers as the profile defines it.

**Run the distribution sanity check** the profile specifies, per segment. A grade that swallows the
segment, or one that almost nobody gets, means the dimensions are not discriminating — **report
that rather than shipping a distribution that flatters the model.**

Method: `references/grading-model.md` → *Sizing potential*.

## Phase 6 — Build territories

Split the graded universe into balanced, coherent patches against the balance target, coherence
rules and constraints in the profile. Named-rep pins and anything that must not be split are the
client's, not a solver's.

Method: `references/territory-build.md`.

## Phase 7 — Deliverables

1. **Workbook (.xlsx)** — the graded, sized universe plus rollups. Tab structure in
   `assets/workbook_layout.md`.
2. **1-page memo (.md)** — method, grade distribution, headline numbers, territory
   recommendations. Template in `assets/memo_template.md`.

A summary deck is not in the default bundle; build one only if asked, and keep it short.

**State provenance on the face of the deliverable:** which values came from the client's profile,
which were inferred, and which checks failed. A graded universe with invisible provenance gets
treated as fact.

---

## Standing rules

**Propose, never impose.** The client owns the segments, the dimensions and the thresholds. The
skill's job is to structure the conversation, run the arithmetic, and **show the client where their
own data disagrees with them** — that last part is most of the value.

**Iterate on real data, not theory.** Draft the profile, run it against the calibration sample, and
adjust until both the good and the bad customers land where they should.

**Helper scripts are optional.** `scripts/grade_accounts.py` and `scripts/build_territories.py` do
the deterministic work — applying a profile, balancing a split. **They read the client's scoring
profile as input and contain no thresholds of their own.** For a small universe it is often faster
to grade in the workbook directly.

## Reference files

- `references/scoring-framework.md` — choosing segments and dimensions; how to set a threshold.
- `references/grading-model.md` — building the profile, calibrating it, sizing potential.
- `references/territory-build.md` — balancing, coherence, constraints.
- `references/worked-example.md` — a full walk-through. **An illustration, not a set of defaults**
  — every number in it belongs to that example.
- `assets/` — scoring-profile template, workbook layout, memo template.
- `client-profile.example.md` — the proposed working ranges and calibration heuristics.

---
*Rebuilt 5 Aug 2026 to `NEW-SKILL-STANDARD.md`, client-configured. The client-specific values were
already externalised — segments, dimensions and thresholds have always been the client's — so what
moved were the **method heuristics**: segment and dimension counts, the observability and
discrimination bars, the profile-size ceiling, the calibration sample, the distribution check and
the minimum cell size. They now sit in `client-profile.example.md` as proposals an engagement can
argue with, rather than in the skill as rules it cannot. Surviving digits here are phase numbers and
the date.*
