# <project name>

<!-- This is the CodeFactory template. The migration (TICKET-0000) fills the
     "Project" section and tunes the rest for the new project. -->

## Project

<One paragraph: what this project is and who it is for.>

- **<Component or feature>** — <one line.>

This file is the map of the repo. Read it at the start of every task.
The project uses no third-party planning tools — the backlog, the
design docs, the architecture decisions and the changelog all live in
git as markdown.

## Where things live

- **`src/python/`** — the Python code. The package is `src/python/app/`.
- **`tests/`** — the test suite that CI runs. Mirrors the package
  layout.
- **`qa/`** — the QA suites, one folder per ticket (`qa/TICKET-XXXX/`).
  The `qa` agent writes them. CI does not run them. Run one with
  `just qa TICKET-XXXX`.
- **`Jira tickets/`** — the backlog. The folder name is a joke; there is
  no Jira. One file per ticket
  (`TICKET-XXXX-slug.md`), plus `TEMPLATE.md` (copy it to start a
  ticket) and `proposals/` (ideas and research, not yet tickets).
  `Jira tickets/README.md` holds the ticket lifecycle. Every ticket opens
  with `## What?`, `## Why?` and `## How?` — a plain-English summary for
  a reader who does not read code. Keep them true and keep them plain;
  the rest of the ticket stays as technical as the work needs.
- **`Notion/`** — the design docs and the record of what shipped. The
  folder name is a joke; there is no Notion.
  - `Notion/design_docs/` is the source of truth for the product. Start with
    `roadmap.md`: it lists every design document.
  - `Notion/decisions/` holds Architecture Decision Records (ADRs).
  - `Notion/changelog/` records what shipped and when.
- **`Memory/`** — standing requests from the human that are not part of
  the product's design: constraints, preferences, special requests.
  `Memory/requests.md` is the list. `Memory/README.md` holds the rules.
- **`.claude/agents/`** — the subagent role files: `dev` (builds a
  ticket), `qa` (checks behavior against the ticket), `code-reviewer`
  (checks structure and simplicity), `docs-sync` (makes the docs match
  what was built and closes the ticket) and `researcher` (design-session
  research). Each role file is that agent's full instructions.
  `.claude/WRITING-STYLE.md` is the reference copy of the writing rules.
- **`.github/`** — CI, the pull request template, CODEOWNERS, Dependabot
  and the `main` branch ruleset.

## Commands

All tasks run through `just`. The environment is managed by `uv`.

- `just env` — create `.venv` and install dev dependencies.
- `just check` — format, lint, type-check and test. Run it before every
  push.
- `just ci` — the same checks CI runs, without autofix.
- `just qa TICKET-XXXX` — run one ticket's QA suite. Not part of CI.
- `just commit` — stage everything and commit with an empty message. A
  shortcut for the human. Agents write a real commit message.
- `just --list` — every recipe. Recipes in the group `try it` are small
  features a person can run by hand, such as a terminal chat or a page.
  Every such feature has one, with a one-line comment, so the human can
  keep track of them. A ticket that adds a feature a person can run adds
  its recipe in the same pull request. The `README.md` lists them.

When `just` is not installed, run a recipe with
`uvx --from rust-just just <recipe>`.

Stack details:

- Package command: `uv add <pkg>` (or `uv add --dev <pkg>`), never by
  editing `uv.lock` by hand. Commit `pyproject.toml` and `uv.lock`
  together.
- Caches to clear before you break code on purpose to test a test: every
  `__pycache__`. Also set `PYTHONDONTWRITEBYTECODE=1` in the subprocess.
  A stale `.pyc` can make Python run the old code.
- Test runner: `pytest`. Live test marker: `@pytest.mark.live`. `pytest`
  runs only `tests/`, and `ruff` skips `qa/`.
- Run command for recipes: `uv run ...`.

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
2. **Types everywhere.** Public functions have full type hints. Pyright
   runs in standard mode and must report zero errors. Prefer typed data
   structures (dataclasses, Pydantic models) over loose dicts at
   component boundaries.
3. **Simple first.** No abstraction before the second real use. No deep
   inheritance. Small functions with one job.
4. **No secrets in git.** Keys come from environment variables, loaded
   from a local `.env` that is gitignored. Never print a key, log a key
   or put one in a test fixture.
5. **Record hard-to-reverse decisions.** A new framework, data store,
   external provider or component boundary gets an ADR in
   `Notion/decisions/` in the same pull request.
6. **No `__init__.py` files.** Modern Python does not need them. Folders
   without one are namespace packages, and imports work the same. Do not
   add one to a package, a test folder or a `qa/` folder. Tests run with
   `--import-mode=importlib`, so two test files may share a name in
   different folders. A new one in a diff is a review finding.

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
5. Read `Memory/requests.md` at the start of every task and follow it.
   Only the tech lead writes it. If you learn of a lasting request from
   the human, or see one broken, tell the tech lead.
6. `main` is protected by the ruleset in `.github/rulesets/main.json`:
   pull request only, CI job `check` green on an up-to-date branch, all
   review threads resolved, squash merge. Do not try to work around it.
   If it blocks you, report that to the human.
