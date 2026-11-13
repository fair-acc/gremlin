# Contributing

## Before you start

`CLAUDE.md` (also read as `AGENTS.md`) is the working agreement; it defers to GR4's [`CLAUDE.md`](https://github.com/fair-acc/gnuradio4/blob/main/CLAUDE.md) and adds only what differs here.
`CORE_DEVELOPMENT_GUIDELINE.md` and `CORE_NAMING_GUIDELINE.md` carry the rationale,
`CORE_AGENT_WORKFLOW.md` the orchestration of agents, and `CORE_REVIEW_GUIDELINE.md` what a reviewer checks.
Talks and their Zenodo records: [`talks/README.md`](talks/README.md).

## Sign-off

Every commit must be signed off under the [Developer Certificate of Origin](DCO.txt):

```bash
git commit -s
```

The sign-off is an assertion by the human author, who holds the copyright and remains answerable for the quality of the contribution.
Commits carry no other trailer: no bot co-author, no assistant attribution.
That an assistant drafted a change does not alter who is answerable for it.

## Before submitting

```bash
pre-commit run --all-files                                   # whitespace, Prettier, shellcheck, black
pip install -r requirements.txt && mkdocs build --site-dir site
```

## Licences

Contributions are accepted under the repository's licences: code under `LGPL-3.0-or-later WITH LGPL-3.0-linking-exception`,
documentation and figures under CC-BY-SA-4.0, talk slides under CC-BY-4.0 (see [`README.md`](README.md)).

## Conduct

By participating you agree to the [Code of Conduct](CODE_OF_CONDUCT.md).
