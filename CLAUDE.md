# CLAUDE.md (AGENTS.md) — GREMLIN

> For LLM coding agents. GREMLIN is a GR4 project, and GR4's rules apply unchanged.
> This file adds only what differs here.

## 1 · Rules

GR4's [`CLAUDE.md`](https://github.com/fair-acc/gnuradio4/blob/main/CLAUDE.md) is authoritative: the working agreement, design, naming, layout, documentation, C++23, GR4 conventions, testing, commits and the pre-submit checklist.
Read it first.

The local copies below are taken verbatim from GR4 `f0f48976` (2026-10-29) and are re-synced with each GR4 bump:

| File                            | Purpose                                                 |
| ------------------------------- | ------------------------------------------------------- |
| `CORE_DEVELOPMENT_GUIDELINE.md` | rationale                                               |
| `CORE_NAMING_GUIDELINE.md`      | naming                                                  |
| `CORE_AGENT_WORKFLOW.md`        | orchestration                                           |
| `CORE_REVIEW_GUIDELINE.md`      | review                                                  |
| `.claude/commands/`             | review commands and the refactor and fix-style commands |

This file and the copies MUST NOT be changed without the author's express approval, which expires with each approved change.

## 2 · What differs here

- **Phase.** GREMLIN is in its documentation phase: the project site, the talks and their archiving on Zenodo; there is no C++ yet.
  Code, when it lands, follows GR4 unchanged and gets its own build and check sections here.
- **A public, EU-funded record.** Everything in this repository is public and may end up archived with a DOI.
  Results are stated as measured or as projected, never inflated; a DOI, deliverable number or figure that is not known yet is a `TODO`, never invented;
  no confidential GSI/FAIR operational data and no RF/EMI measurement detail beyond what is already published.
- **Language.** British English in prose (`colour`, `behaviour`, `organisation`); identifiers follow GR4.
- **Licences.** Code: `SPDX-License-Identifier: LGPL-3.0-or-later WITH LGPL-3.0-linking-exception`; the linking exception is mandatory.
  Documentation and figures: CC-BY-SA-4.0. Talk slides: CC-BY-4.0, third-party pictures under their own terms (each talk's `media/CREDITS.md`).
  `LICENSE` is the verbatim LGPL text that GitHub's licence detection recognises: no header, no SPDX line, no exception text.
- **Zenodo.** A publish is permanent and happens only on the author's go; reserving and uploading to a draft are not publishing.
  Tokens are read with `read -rsp` or come from repository secrets, never from a command line, a file or a chat.
  A sandbox DOI is never cited.
- **Talks** are [gr4-present](https://github.com/RalphSteinhagen/gr4-present) decks in their own Markdown dialect; formatters leave `talks/` as it is.
  Their PDFs live on Zenodo only. The workflow (DOI, PDFs, viewer, publish) is in [`talks/README.md`](talks/README.md).
- **Working notes** (`claude_wip.md`, papers kept beside a deck for reference) stay untracked: never committed, and never added to `.gitignore`.

## 3 · Repository

- **Layout.**
  `docs/`, `mkdocs.yml` and `overrides/` (the MkDocs Material site), `assets/` (figures in their source formats), `talks/` (one deck per talk, and the vendored gr4-present viewers in `talks/viewer/<commit>/`), `scripts/` (Zenodo and PDF tooling for the talks);
  `.zenodo.json`, `CITATION.cff` and `.all-contributorsrc` carry the citation metadata.
- **CI.** `pages.yml` builds the site with the decks and deploys it to <https://fair-acc.github.io/gremlin/>; `zenodo-talks.yml` archives the talks (plan, check, reserve, publish).

## 4 · Building and checks

```bash
pip install -r requirements.txt
mkdocs serve                      # live preview of the site
mkdocs build --site-dir site      # as pages.yml builds it
pre-commit run --all-files        # whitespace, Prettier (YAML, Markdown), shellcheck, black
scripts/zenodo_talks.py plan      # the talks' Zenodo state, offline
```

`pre-commit` MUST run before each commit; it leaves `talks/` and the GR4 copies as they are.
