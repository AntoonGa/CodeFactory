# <project name>

<!-- Fill the "Project" section when you start a project from this template.
     The tech lead checks it before starting work. -->

## Project

<One paragraph: what this project is and who it is for.>

- **<Component or feature>** — <one line.>
- **<Component or feature>** — <one line.>

> <Optional: the one sentence that states the principle of the project.>

This file is the map of the repo. Read it at the start of every task.
The project uses no third-party planning tools — the backlog, the
design docs, the architecture decisions and the changelog all live in
git as markdown.

## Where things live

- **`<source dir>/`** — the code. <Name the package or app folder.>
- **`<tests dir>/`** — the test suite that CI runs. Mirrors the code
  layout.
- **`qa/`** — the QA suites, one folder per ticket (`qa/TICKET-XXXX/`).
  The `qa` agent writes them. CI does not run them. Run one with
  `just qa TICKET-XXXX`.
- **`tickets/`** — the backlog. One file per ticket
  (`TICKET-XXXX-slug.md`), plus `TEMPLATE.md` (copy it to start a
  ticket) and `proposals/` (ideas and research, not yet tickets).
  `tickets/README.md` holds the ticket lifecycle. Every ticket opens
  with `## What?`, `## Why?` and `## How?` — a plain-English summary for
  a reader who does not read code. Keep them true and keep them plain;
  the rest of the ticket stays as technical as the work needs.
- **`docs/`** — the design docs and the record of what shipped.
  - `docs/design/` is the source of truth for the product. Start with
    `roadmap.md`: it lists every design document.
  - `docs/decisions/` holds Architecture Decision Records (ADRs).
  - `docs/changelog/` records what shipped and when.
- **`.claude/agents/`** — the subagent role files: `dev` (builds a
  ticket), `qa` (checks behavior against the ticket), `code-reviewer`
  (checks structure and simplicity), `docs-sync` (makes the docs match
  what was built and closes the ticket) and `researcher` (design-session
  research). Each role file is that agent's full instructions.
  `.claude/WRITING-STYLE.md` is the reference copy of the writing rules.
- **`.github/`** — CI, the pull request template, CODEOWNERS, Dependabot
  and the `main` branch ruleset.

## Commands

All tasks run through `just`. The recipes call the stack's own tools, so
the agents never need to know which stack the project uses.

- `just check` — format, lint, type-check and test, with autofix. Run it
  before every push.
- `just ci` — the same checks CI runs, without autofix.
- `just qa TICKET-XXXX` — run one ticket's QA suite. Not part of CI.
- `just --list` — every recipe. Recipes in the group `try it` are small
  features a person can run by hand, such as a terminal chat or a page.
  Every such feature has one, with a one-line comment, so the human can
  keep track of them. A ticket that adds a feature a person can run adds
  its recipe in the same pull request. The `README.md` lists them.

Stack details the agents need — the package command, the cache folders
to clear before a mutation check, the marker for live tests — go here:

- Package command: `<for example: uv add <pkg>, npm install <pkg>>`
- Caches to clear: `<for example: every __pycache__, .pytest_cache>`
- Live test marker: `<for example: @pytest.mark.live>`

## What "correct" means here

The design docs and the ticket define correct, not the code. Read the
ticket first, then the design docs and ADRs it cites, before you change
anything. If the code and the docs disagree, that gap is a finding —
report it, do not silently pick a side.

## Engineering standards

1. **Tests prove behavior.** Every change in behavior has a test,
   including at least one failure path. Tests never call the network or
   a paid service; use fakes. A test that needs a live service is marked
   and skipped by default.
2. **Typed and linted.** Use the strongest static checks the stack
   offers. They must report zero errors. Prefer typed data structures
   over loose dicts or maps at component boundaries.
3. **Simple first.** No abstraction before the second real use. No deep
   inheritance. Small functions with one job.
4. **No secrets in git.** Keys come from environment variables, loaded
   from a local `.env` that is gitignored. Never print a key, log a key
   or put one in a test fixture.
5. **Record hard-to-reverse decisions.** A new framework, data store,
   external provider or component boundary gets an ADR in
   `docs/decisions/` in the same pull request.

### Project-specific standards

Add the rules that only this project needs here, each with a reason.
Delete this heading if there are none. See `docs/ADOPTING.md` for
examples.

## Rules for every session, human or agent

1. Never push to `main`. Every change goes on its own branch
   (`ticket/<id>-<slug>`). The human reviews and merges it. A branch
   ruleset enforces this on GitHub.
2. Before your first write of a task, and again before you commit, run
   `pwd` and `git branch --show-current`. Confirm both match your
   assigned worktree and branch.
3. A change to code, its ticket, and the design docs it affects land in
   the same pull request.
4. Title a ticket's pull request `TICKET-XXXX — <short summary>`. Fill
   its body from `.github/pull_request_template.md`: keep every heading,
   fill every section, and tick a checklist box only when it is true.
5. `main` is protected by the ruleset in `.github/rulesets/main.json`:
   pull request only, CI job `check` green on an up-to-date branch, all
   review threads resolved, squash merge. Do not try to work around it.
   If it blocks you, report that to the human.
