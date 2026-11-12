# CodeFactory

A reusable template for building personal software projects with Claude
as a small team.

You talk to one Claude session, the **tech lead**. It runs design
sessions with you, writes tickets, and dispatches role agents that build,
check and document each ticket on its own branch. You review and merge
the pull requests.

## What is in the box

| Part | Where | What it does |
|---|---|---|
| Orchestration procedure | `.claude/skills/orchestrate/` | The tech lead's operating procedure: design sessions, tickets, branches, worktrees, dispatch, fix loop, PR, notification |
| Role agents | `.claude/agents/` | `dev`, `qa`, `code-reviewer`, `docs-sync`, `researcher` |
| Session hook | `.claude/settings.json` | Makes the main session load the procedure at start |
| Backlog | `tickets/` | One markdown file per ticket, with a lifecycle and a template |
| Docs | `docs/` | Design docs, decision records (ADRs), changelog |
| QA suites | `qa/` | One folder per ticket, written by the `qa` agent, not run in CI |
| GitHub setup | `.github/` | CI (`just ci`), PR template, CODEOWNERS, Dependabot, `main` ruleset |
| Commands | `justfile` | One interface for every stack: `just check`, `just ci`, `just qa` |

## The workflow in short

1. You and the tech lead agree on what to build. A `researcher` helps
   only when no simple design is obvious.
2. The tech lead writes a ticket and opens `ticket/<id>-<slug>` in its own
   worktree.
3. `dev` builds it. `qa` and `code-reviewer` check it in parallel. A fix
   loop closes findings.
4. `docs-sync` updates the docs and marks the ticket `Done`.
5. The tech lead opens the pull request and notifies you. You merge.

Nothing reaches `main` except through a pull request you merge.

## Start a project

Read `docs/ADOPTING.md`. It has the setup checklist and stack examples.

## Commands

- `just check` — format, lint, type-check and test, with autofix.
- `just ci` — the checks CI runs, without autofix.
- `just qa TICKET-XXXX` — run one ticket's QA suite.
- `just --list` — every recipe. Features a person can run by hand go in
  the group `try it` and are listed here.
