# Jira_tickets

The backlog for this project, living entirely in git. (The
folder name is a joke; there is no Jira.)

## Files here

- `TEMPLATE.md` — copy this to start a new ticket.
- `TICKET-XXXX-short-slug.md` — one file per ticket.
- `proposals/` — speculative ideas and research write-ups. Not tickets
  yet. Promote a proposal to a ticket (copy `TEMPLATE.md`, link the
  proposal) once the tech lead commits to it.

## Every ticket opens with What / Why / How

The first three sections of every ticket are `## What?`, `## Why?` and
`## How?`, before `## Context` and everything else.

They are written for a reader who knows the product and does not read
code — a founder, a customer, an investor. Plain English, short
sentences, no file names, no class names, no framework vocabulary.

- **What?** — what changes for the person using the product.
- **Why?** — the problem it solves or the gap it fills.
- **How?** — how it gets built, in plain terms. New capability, re-use
  of something that exists, or a fix. Include the numbers a product
  person cares about.

The rest of the ticket stays as technical as the work needs.

Keep them true. If implementation changes what the ticket does, the
implementer updates them. The docs-sync step checks them against what
shipped before marking the ticket `Done`.

## Ticket lifecycle

`Backlog` → `Ready` → `In Progress` → `In Review` → `Done`

- **Backlog**: exists, not yet scoped tight enough to implement.
- **Ready**: scoped, cites the design docs it depends on, has testable
  acceptance criteria.
- **In Progress**: `dev` is implementing it on its own branch
  (`ticket/<id>-<slug>`).
- **In Review**: implementation done, `just check` passing, waiting on
  `qa` and `code-reviewer`.
- **Done**: `qa` passed, `code-reviewer` has no open findings, and
  `docs-sync` made the design docs match what was built — all in the
  same branch and pull request as the code.

Never skip a stage. Who moves a ticket:

1. The tech lead creates it (`Backlog`), marks it `Ready`, and sets
   `In Progress` when `dev` starts.
2. Only `dev` sets `In Review`.
3. Only `docs-sync` sets `Done`, except on a docs-only or process-only
   ticket that runs no `docs-sync`: there the tech lead sets it.

## Numbering

Sequential, zero-padded, never reused: `TICKET-0001`, `TICKET-0002`, ...
`TICKET-0000` is always the migration of CodeFactory into the repo.
Check existing files before assigning the next number.
