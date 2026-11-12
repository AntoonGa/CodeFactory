# decisions

Architecture Decision Records. One file per decision, named
`ADR-XXXX-short-slug.md`, numbered like tickets: sequential,
zero-padded, never reused.

Write an ADR when a choice is expensive to reverse or will surprise a
new reader: a framework, a data store, a model provider, a component
boundary, a security trade-off. Do not write one for a choice a single
pull request can undo.

## Rules

1. Copy `TEMPLATE.md` to start one.
2. An ADR is never edited after it is `Accepted`, except to change its
   status. To change a decision, write a new ADR that supersedes it, and
   set the old one to `Superseded by ADR-XXXX`.
3. A ticket that implements or depends on a decision cites the ADR in
   its "Design docs this depends on" section.

## Status values

`Proposed` → `Accepted` → (`Superseded by ADR-XXXX` | `Deprecated`)
