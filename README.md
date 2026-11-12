# CodeFactory

A reusable base for building personal software projects with Claude as a
small team. Import it into a new repo, answer a few questions, merge one
pull request, and start.

You talk to one Claude session, the **tech lead**. It runs design
sessions with you, writes tickets, and dispatches role agents that build,
check and document each ticket on its own branch. You review and merge
the pull requests.

## What is in the box

| Part | Where | What it does |
|---|---|---|
| Tech-lead procedure | `.claude/skills/orchestrate/` | Design sessions, tickets, branches, worktrees, dispatch, fix loop, pull request, notification |
| Migration procedure | `.claude/skills/migrate/` | Imports CodeFactory into a new repo and tunes it. Runs once |
| Status command | `.claude/skills/wawa/` | Type `/wawa` (where are we at) for one short table: every ticket, its status, what it needs from you, the merge order |
| Role agents | `.claude/agents/` | `dev`, `qa`, `code-reviewer`, `docs-sync`, `researcher` |
| Session hook | `.claude/settings.json` | Makes the main session load the tech-lead procedure at start |
| Backlog | `Jira tickets/` | One markdown file per ticket. `TICKET-0000` is the migration |
| Docs | `Notion/` | Design docs, decision records (ADRs), changelog |
| QA suites | `qa/` | One folder per ticket, written by the `qa` agent, not run in CI |
| Python setup | `pyproject.toml`, `ruff.toml`, `src/python/`, `tests/` | `uv`, `ruff`, `pyright`, `pytest`, with one placeholder module and its test |
| GitHub setup | `.github/` | CI, pull request template, CODEOWNERS, Dependabot, `main` ruleset |
| Commands | `justfile` | `just check`, `just ci`, `just qa`, `just commit` and more |

## Migration guide

The idea: create your new repo, then migrate CodeFactory into it. Claude
does the work. The whole migration is one ticket, `TICKET-0000:
Migrating Code Factory`, and one pull request.

### What you do

1. Create the new repo on GitHub. It can be empty.
2. Open a Claude Code session in the new repo.
3. Give Claude access to CodeFactory: attach it to the session, or clone
   it next to the new repo.
4. Say:

   > Migrate CodeFactory into this repo. Follow
   > `.claude/skills/migrate/SKILL.md` in CodeFactory.

5. Answer the interview (below).
6. Review and merge the pull request `TICKET-0000 — Migrating Code
   Factory`.
7. After the merge: set `main` as the default branch if it is new, and
   apply the branch ruleset if you kept it
   (`.github/rulesets/README.md`).

### What Claude does

1. **Imports CodeFactory as is.** The first commit of the branch is an
   unchanged copy, so the tuning that follows is easy to review.
2. **Interviews you**, before any pull request:
   1. *Purpose.* What is the project? Is it a throwaway, a proof of
      concept, a personal tool or a production system?
   2. *Team.* Which roles to keep. Whether `qa` runs light only, or
      light and deep. Whether you need a role or a workstream that is
      not in the box.
   3. *Process weight.* Design docs, decision records, changelog, ticket
      format, branch protection, notifications.
   4. *Stack and standards.* Python or another stack, the package name,
      and rules that fit the product.

   Claude proposes an answer to each question from the purpose. You
   decide.
3. **Tunes the copy.** It fills `CLAUDE.md`, removes or adds roles,
   updates the tech-lead procedure, renames the package, and writes the
   first `README.md` and roadmap from what you said.
4. **Verifies and ships.** `just ci` passes, the ticket is `Done`, and
   one pull request holds everything.

### What you get from the purpose

| Purpose | Proposed team | Proposed process |
|---|---|---|
| Throwaway | `dev` | Short tickets, no docs |
| Proof of concept | `dev`, `code-reviewer`, light `qa` if wanted | Roadmap only |
| Personal tool | All roles, `qa` light by default | Design docs and ADRs |
| Production system | All roles, `qa` light and deep | Everything, ruleset applied |

These are starting proposals. The interview settles the real answer.

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

The tech lead stays quiet while the team works. It speaks when a pull
request is ready, when it is blocked, when the design must change, or
when something looks risky. Type `/wawa` at any time to see where things
stand.

## Commands

All tasks run through `just`. The environment is managed by `uv`.

- `just env` — create `.venv` and install dev dependencies.
- `just check` — format, lint, type-check and test, with autofix.
- `just ci` — the checks CI runs, without autofix.
- `just qa TICKET-XXXX` — run one ticket's QA suite.
- `just commit` — stage everything and commit with an empty message.
- `just --list` — every recipe.

## Changing the template itself

Work in this repo on a branch and open a pull request. Keep the role
files and the procedures free of any one project's details: a rule that
fits only some projects belongs in the migration interview, not in the
box.
