# Notion

Everything the team needs to share, living in git. (The folder name is a
joke; there is no Notion.) Three parts:

- **`design_docs/`** — the source of truth for the product: what it does,
  how the system is built, and why. If the code and a design doc
  disagree, that gap is a finding. Report it; do not silently pick a
  side.
- **`decisions/`** — Architecture Decision Records (ADRs). One file per
  decision that is expensive to reverse: a framework, a data store, a
  model provider, a boundary between components. See
  `decisions/README.md`.
- **`changelog/`** — the short "what shipped" record, one file per
  period. See `changelog/README.md`.

Start a project with `design_docs/roadmap.md`: it lists every design document.

Design docs change in the same branch and pull request as the code that
makes them true, after review has passed.
