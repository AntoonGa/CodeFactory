# Project tasks. Run `just` to list them.
# Small features a person can run by hand go in the group "try it".
#
# The recipes below are stubs. Replace each body with your stack's commands.
# See docs/ADOPTING.md for a Python (uv) and a Node example.

set windows-shell := ["C:/Program Files/Git/usr/bin/bash.exe", "-uc"]

# list every recipe
list:
	@just --list

# format + lint with autofix
[group("lint")]
lint:
	@echo "STUB: configure 'lint' in the justfile for your stack"

# static type check
[group("lint")]
typecheck:
	@echo "STUB: configure 'typecheck' in the justfile for your stack"

# run all tests
[group("test")]
test:
	@echo "STUB: configure 'test' in the justfile for your stack"

# lint + typecheck + tests — run before every push
[group("lint")]
check: lint typecheck test

# the same checks CI runs, without autofix
[group("lint")]
ci:
	@echo "STUB: configure 'ci' in the justfile for your stack (no autofix)"

# run one ticket's QA suite (not part of CI), for example: just qa TICKET-0003
[group("test")]
qa ticket:
	@echo "STUB: configure 'qa' in the justfile for your stack, run qa/{{ticket}}"

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

# push the current branch and open a PR titled after the branch name
[group("git actions")]
pr:
	git push -u origin $(git branch --show-current)
	gh pr create --title "$(git branch --show-current)" --fill
