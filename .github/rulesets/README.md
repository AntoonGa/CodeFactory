# rulesets

`main.json` is the branch ruleset for `main`. GitHub does not read this
file by itself. Apply it once by hand, and again after every change to
it.

## What it enforces

1. No direct push to `main`. Every change arrives through a pull
   request.
2. The `check` CI job must pass, on a branch that is up to date with
   `main`.
3. Every review conversation must be resolved before merge.
4. Squash merge only, so `main` stays linear: one commit per ticket.
5. `main` cannot be deleted or force-pushed.

Required approvals is `0` on purpose. GitHub does not let an author
approve their own pull request, and in a one-human repo that would
block every merge. The human still reviews; merging is the approval.
Raise it to `1` when a second reviewer joins.

## Apply it

Web: Settings → Rules → Rulesets → New ruleset → Import a ruleset →
pick `main.json`.

CLI (from a machine where `gh` is logged in as a repo admin):

```bash
gh api -X POST repos/$(gh repo view --json nameWithOwner -q .nameWithOwner)/rulesets --input .github/rulesets/main.json
```

To update an existing ruleset, list it to get its id, then `PUT` to it:

```bash
gh api repos/$(gh repo view --json nameWithOwner -q .nameWithOwner)/rulesets
```

```bash
gh api -X PUT repos/$(gh repo view --json nameWithOwner -q .nameWithOwner)/rulesets/<id> --input .github/rulesets/main.json
```

Rulesets on a private repo need a paid GitHub plan. On a free plan,
make the repo public or use classic branch protection (Settings →
Branches) with the same five rules.

## Recommended repo settings (Settings → General)

1. Pull Requests: allow squash merging only; turn on "Automatically
   delete head branches".
2. Pull Requests: turn on "Always suggest updating pull request
   branches".
