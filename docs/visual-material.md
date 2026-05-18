# GREMLIN — visual material catalogue

## Purpose

A working inventory of the figures, infographics, and diagrams that the project
either has, expects to produce, or wants to reuse from predecessor work. The
intent is twofold: avoid duplicating effort, and keep licensing / attribution
explicit from the start.

## Storage convention

| Location | Contents |
| --- | --- |
| `docs/img/` | Project identity and finalised diagrams in use by the documentation — logos, EU flag. Optimised for repository size. |
| `docs/photos/` | Measurement figures and facility photos used in the documentation. |
| `assets/` | Source material, work-in-progress drawings, raw exports, and supporting reference images grouped by topic. Not all of this lands in `docs/`. |

Anything published under the project's documentation licence (`CC-BY-SA-4.0`)
must carry attribution if reused externally.

## Catalogue

Status legend: **[ ]** = planned · **[~]** = work in progress ·
**[x]** = present in repo.

### Project identity

- [x] **GREMLIN logo** — light and dark variants
  (`docs/img/GREMLIN_logo_small.svg`, `docs/img/GREMLIN_logo_dark_small.svg`,
  with PNG renderings for fallback).
- [x] **EU flag** — used in the funding banner
  (`docs/img/Flag_of_Europe.svg`).
- [ ] **iRIS project graphic** — the project-level identity graphic; reuse
  subject to iRIS branding guidelines.

### Signal-domain illustrations

- [x] **EMI device-signature time-domain examples** — voltage / current traces
  per device and operating state
  (`docs/photos/EMI_example_01.png` … `EMI_example_06.png`).
- [x] **PulsedPowerDemo current-spectrum spectrogram** — frequency-domain view
  over time (`docs/photos/gremlin_pulsedpower_spectrogram.png`).
- [ ] **Power-disaggregation plots** — aggregate trace alongside its per-device
  decomposition; ideally from a bench capture rather than a public dataset.
- [ ] **GNU Radio 4.0 scheduler / topology diagrams** — block diagrams showing
  where GREMLIN sits inside a GR4 flow graph; useful for the GR4 community too.

### Facility context

- [x] **GSI/FAIR 200 kV mains-feed test point**
  (`docs/photos/gremlin_facility_200kV_feed.png`).
- [x] **SIS18 / ESR main dipole and quadrupole instrumentation**
  (`docs/photos/gremlin_facility_dipole_quadrupole.png`).

### Conceptual overviews

- [ ] **GREMLIN / NILM overview schematic** — single-page diagram showing the
  path from facility meter to per-device attribution and on to maintenance
  output.
- [ ] **Power meter + branched devices + maintenance graphic** — storytelling
  figure for non-specialist audiences (sustainability reports, EU
  dissemination).
- [ ] **End-to-end pipeline diagram** — an architecture flow chart (see
  [`how-it-works.md`](how-it-works.md)), rendered as an exportable SVG for
  slide decks.

### Machine-learning explainers

- [ ] **PCA / SVD intuition slide** — projection of fingerprint features into
  two dimensions, coloured by device class.
- [ ] **kNN explainer** — classification by nearest fingerprint neighbours.
- [ ] **LSTM / GRU explainer** — recurrent model walk-through for the
  power-disaggregation case.

### Integration context

- [ ] **ONNX / time-series-database / GR4 context diagram** — the external
  components GREMLIN depends on, and the interfaces it uses.

## Authoring guidelines

- Prefer **SVG / Mermaid / PlantUML** sources over flattened bitmaps. Bitmaps
  are acceptable as fallback renderings.
- For figures derived from third-party material, keep the source link and
  licence statement next to the file (e.g. as a sibling `<name>.LICENSE.md` or
  in this catalogue).
- All figures intended for external publication (Zenodo, EU portal, posters,
  papers) must be reviewable in source form so colour, font, and labelling can
  be adjusted without re-tracing.

## Attribution

Material reused from `fair-acc/pulsed-power-ml` must preserve original
attribution. iRIS-branded material must be used in accordance with iRIS
visual-identity guidelines.
