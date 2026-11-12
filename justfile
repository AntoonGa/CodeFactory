# Project tasks. Run `just` to list them.
# Small features a person can run by hand go in the group "try it".

set windows-shell := ["C:/Program Files/Git/usr/bin/bash.exe", "-uc"]

# list every recipe
list:
	@just --list

# sync the venv with the dev dependencies
[group("python")]
env:
	uv sync

# install the git pre-commit hooks
[group("python")]
hooks:
	uv run pre-commit install

# run all tests
[group("python")]
test:
	uv run pytest

# run one ticket's QA suite (not part of CI), for example: just qa TICKET-0003
[group("python")]
qa ticket:
	uv run pytest qa/{{ticket}} -p no:cacheprovider

# ruff format + lint with autofix
[group("lint")]
lint:
	uv run ruff format .
	uv run ruff check . --fix

# pyright type check
[group("lint")]
typecheck:
	uv run pyright

# lint + typecheck + tests — run before every push
[group("lint")]
check: lint typecheck test

# the same checks CI runs, without autofix
[group("lint")]
ci:
	uv run ruff format --check .
	uv run ruff check .
	uv run pyright
	uv run pytest

# create a new branch and check it out
[group("git actions")]
branch name:
	git checkout -b {{name}}

# checkout a branch, pull latest, show status
[group("git actions")]
goto branch:
	git checkout {{branch}}
	git pull
	git status

# stage everything and commit with an empty message
[group("git actions")]
commit:
	git add -A
	git commit --allow-empty-message -m ""

# push the current branch and open a PR titled after the branch name
[group("git actions")]
pr:
	git push -u origin $(git branch --show-current)
	gh pr create --title "$(git branch --show-current)" --fill
