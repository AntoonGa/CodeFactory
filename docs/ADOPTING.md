# Starting a new project from CodeFactory

CodeFactory is a template for working with Claude as a small software
team. You talk to the tech lead (the main Claude session). The tech lead
writes tickets and dispatches role agents: `dev`, `qa`, `code-reviewer`,
`docs-sync` and `researcher`. They share the backlog in `tickets/` and the
docs in `docs/`, and every change arrives as a pull request you merge.

## Set up a new project

1. Create the new repo from this one. On GitHub, mark CodeFactory as a
   template repository (Settings → General) and use "Use this template".
2. Fill the "Project" section of `CLAUDE.md`, and the "Where things
   live" paths. Fill `docs/design/roadmap.md` when you have a design.
3. Replace the stub recipes in `justfile` with your stack's commands.
   `just ci` must run the real checks. `just check` is the same with
   autofix. Examples are below.
4. Add your stack's setup to `.github/workflows/ci.yml`. Keep the job
   name `check`. Add the ecosystem to `.github/dependabot.yml`. Extend
   `.gitignore`.
5. Change the owner in `.github/CODEOWNERS` if the human is not
   `@AntoonGa`.
6. Apply the branch ruleset once (`.github/rulesets/README.md`).
   Rulesets on a private repo need a paid GitHub plan.
7. Optional: `pre-commit install` to run `just ci` before each commit.
8. Open a Claude session in the repo. The `SessionStart` hook in
   `.claude/settings.json` makes the tech lead load its procedure. The
   tech lead checks steps 2, 3 and 6 before it starts any ticket.

## What stays generic, and what you tune

Generic, do not edit per project: the role files in `.claude/agents/`,
`.claude/skills/orchestrate/SKILL.md`, the ticket, ADR and PR templates,
`.github/rulesets/`.

Tune per project: `CLAUDE.md`, `justfile`, CI setup, `.gitignore`,
`.env.example`, and the design docs.

If a role file needs a project-specific rule, put the rule in
`CLAUDE.md` instead. All roles read it. Never name the `orchestrate`
skill in `CLAUDE.md` or in a role file; only the tech lead may load it.

## Example: Python with uv

`justfile`:

```just
# format + lint with autofix
[group("lint")]
lint:
	uv run ruff format .
	uv run ruff check . --fix

# static type check
[group("lint")]
typecheck:
	uv run pyright

# run all tests
[group("test")]
test:
	uv run pytest

# the same checks CI runs, without autofix
[group("lint")]
ci:
	uv run ruff format --check .
	uv run ruff check .
	uv run pyright
	uv run pytest

# run one ticket's QA suite (not part of CI), for example: just qa TICKET-0003
[group("test")]
qa ticket:
	uv run pytest qa/{{ticket}} -p no:cacheprovider
```

`ci.yml` setup step: `astral-sh/setup-uv`, then `uv sync --locked`.

`CLAUDE.md` stack details:

- Package command: `uv add <pkg>` (or `uv add --dev <pkg>`). Commit
  `pyproject.toml` and `uv.lock` together.
- Caches to clear: every `__pycache__`. Set `PYTHONDONTWRITEBYTECODE=1`
  in the subprocess. A stale `.pyc` can make the old code run.
- Live test marker: `@pytest.mark.live`.
- Exclude `qa/` from ruff (`extend-exclude = ["qa"]`).

## Example: Node

`justfile`: `lint` runs `npm run lint`, `typecheck` runs `npx tsc
--noEmit`, `test` runs `npm test`, `ci` runs the three without autofix.
`qa` runs the test runner on `qa/{{ticket}}`. Package command:
`npm install <pkg>`. Caches to clear: the test runner cache and the build
folder.

## Project-specific standards worth reusing

These rules came from the project this template was extracted from.
Copy one into the "Project-specific standards" section of `CLAUDE.md`
when it fits.

- **No `__init__.py` files** (Python). Folders without one are namespace
  packages. Run tests with `--import-mode=importlib`. Tell `code-reviewer`
  to flag a new one by adding it to this section.
- **Every fact has a source.** Any output that states a fact about the
  world carries its citation and retrieval date. Use it when the product
  reports facts.
- **Every model call is observable.** Trace it and record its tokens and
  cost. Use it when the product calls an LLM.
- **Keep dev notes out of runtime content.** If the product reads files
  as its memory or prompts, never put ticket numbers or code paths in
  them.
