# Talks

One directory per talk, `YYYYMMDD_<Event>/`, listed in [`docs/talks.md`](../docs/talks.md). Slides CC-BY-4.0;
third-party material in the talk's `media/CREDITS.md`.

Each talk can get its own Zenodo DOI (type *presentation*), linked to the software's
[10.5281/zenodo.20520246](https://doi.org/10.5281/zenodo.20520246). Tools:
[`scripts/zenodo_talks.py`](../scripts/zenodo_talks.py), [`scripts/talk_pdfs.sh`](../scripts/talk_pdfs.sh), workflow
[`zenodo-talks.yml`](../.github/workflows/zenodo-talks.yml).

## Adding a talk with a DOI

1. **Create** `talks/YYYYMMDD_<Event>/`: `README.md`, the [gr4-present](https://github.com/RalphSteinhagen/gr4-present)
   deck (`index.yml` with `export: { dpi: 150 }`, `talk.md`), `media/CREDITS.md`. Add a row to `docs/talks.md`.
2. **Describe:** copy `zenodo.yml` from another talk; edit `title`, `description`, `publication_date`, `conference_*`;
   clear `record_id`, `doi`, `sandbox_*`; set `viewer:` (see *Viewer*). Check: `scripts/zenodo_talks.py plan`.
3. **Reserve the DOI** (token below), commit `zenodo.yml`:
   ```bash
   scripts/zenodo_talks.py reserve talks/<talk>
   ```
   Put the DOI on the slides, the talk's `README.md`, `docs/talks.md` and `.zenodo.json` → `related_identifiers`
   (`isSupplementedBy`, `presentation`).
4. **PDFs** (stored on Zenodo only, never in git), when the talk is final and committed:
   ```bash
   scripts/talk_pdfs.sh talks/<talk>            # to ~/.cache/gremlin-talks/<talk>/, check them
   scripts/zenodo_talks.py upload talks/<talk>  # into the reserved draft; commit zenodo.yml (pdfs_from)
   ```
   Needs a current gr4-present build (`GR4_PRESENT_BIN`). Names under `files:` in `zenodo.yml`. A later deck
   change makes them stale: export and upload again.
5. **Merge** to `main`. Live slides, in the viewer that `viewer:` in `zenodo.yml` names:
   `https://fair-acc.github.io/gremlin/talks/<talk>/` (the Zenodo record links the same deck as
   `https://fair-acc.github.io/gremlin/talks/viewer/<viewer>/?presentation=../../<talk>`)
6. **Publish** before the talk (a reserved DOI does not resolve yet): the next GitHub release, or Actions →
   *Archive talks on Zenodo* → mode `publish`, the talk, *sandbox* unticked.
7. **Verify** `https://doi.org/<doi>`: two PDFs, deck zip, live-slides link.

Optional dry run on sandbox.zenodo.org: add `--sandbox` to `reserve`/`upload`/`publish`. Never cite a sandbox DOI.
A publish is permanent; published talks are skipped on later runs.

## Viewer

The live slides open in a gr4-present web viewer kept in this repository, `talks/viewer/<commit>/`, so the site
refers to nothing outside itself and a later gr4-present cannot change how a published talk looks:

```bash
scripts/update_viewer.sh               # gr4-present's latest minimal viewer into talks/viewer/<commit>/
scripts/update_viewer.sh v0.2.0 full   # a tagged release; full adds live GNU Radio 4 and OpenDigitizer (~60 MB)
```

Minimal suffices for a deck without live charts. Name the folder as `viewer: "<commit>"` in the talk's `zenodo.yml`
once the deck looks right in it (export the PDFs with a native build of the same commit); remove a folder once no
talk names it.

On the site, the Pages workflow also puts that viewer into the talk's own folder, with the deck beside it as `default/`
(what the viewer opens without `?presentation=`, as gr4-present's demo site does), so `talks/<talk>/` opens the talk.
This happens at build time only: the talk's folder in git, and so the deck archived on Zenodo, stays as it is.

## Tokens

Zenodo → Applications → **Personal access token** (not *Developer application*), scopes `deposit:write` and
`deposit:actions`; one on [zenodo.org](https://zenodo.org/account/settings/applications/tokens/new/), one on
[sandbox.zenodo.org](https://sandbox.zenodo.org/account/settings/applications/tokens/new/).

- CI: `gh secret set ZENODO_TOKEN -R fair-acc/gremlin` (and `ZENODO_SANDBOX_TOKEN`).
- Locally, paste at the silent prompt, then Enter:
  ```bash
  read -rsp 'Zenodo token: ' ZENODO_TOKEN && export ZENODO_TOKEN
  scripts/zenodo_talks.py check
  ```
- Never put a token on a command line, in a file, an issue or a chat.
