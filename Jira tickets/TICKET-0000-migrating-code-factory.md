# TICKET-0000: Migrating Code Factory

Status: Ready
Branch: `ticket/0000-migrating-code-factory`

## What?

This repo gets a ready-made way of working with Claude: a tech lead you
talk to, a team of helper agents, a backlog, design docs and a coding
setup. It is copied from the CodeFactory template and then tuned to this
project in a short interview with you.

## Why?

Every new project needs the same base before real work can start.
Copying it by hand is slow, and an untuned copy does not fit the
project: it may lack a role the work needs or carry one it does not.

## How?

Claude copies CodeFactory as it is. Then it asks you what the project is
and proposes which helpers and checks it needs. It applies what you
agree to, checks that everything runs, and opens one pull request. When
you merge it, the project can start.

## Context

This is always the first ticket of a project made from CodeFactory. The
procedure is the `migrate` skill in `.claude/skills/migrate/SKILL.md`.
The whole migration is one branch and one pull request.

## Design docs this depends on

- none

## Acceptance criteria

- [ ] CodeFactory is imported as is, as the first commit of the branch
- [ ] The human answered the tuning interview, and the decisions are
      recorded under "Decisions" below
- [ ] `CLAUDE.md` describes this project, with no
      placeholder left
- [ ] The team matches the decisions: unused roles removed, new roles
      added, the tech-lead procedure updated, no stale reference to a
      removed role
- [ ] The package, `pyproject.toml`, `README.md` and
      `Notion/design_docs/roadmap.md` carry this project's name and content
- [ ] `just ci` passes
- [ ] The template-only files are gone (see the procedure)
- [ ] One pull request holds the whole migration

## Out of scope

- Any product feature. The first feature is `TICKET-0001`.

## Notes

### Decisions

<Filled during the interview. One line per decision.>

- Project:
- Roles kept:
- QA levels:
- Roles added:
- Workstreams:
- Stack:
- Process rules changed:
