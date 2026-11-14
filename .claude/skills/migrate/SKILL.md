---
name: migrate
description: Load this when the human asks to migrate, import or install CodeFactory into a repo, or to start a new project from CodeFactory, and when TICKET-0000 "Migrating Code Factory" is not Done. It is the one-time procedure that copies the CodeFactory workflow and coding setup into a new repo, tunes it in an interview with the human, and ships it as one pull request. Tech lead only.
---

# Migrating CodeFactory into a new repo (main session only)

This procedure runs once per project. Its ticket is `TICKET-0000:
Migrating Code Factory`. Its output is one pull request. After the human
merges it, the project starts with `TICKET-0001`.

Two rules shape it:

1. **Import as is, then tune.** The first commit is CodeFactory,
   unchanged. Every later commit adapts it. The human can read the
   tuning as a diff.
2. **Ask before you tune.** You propose; the human decides. Nothing in
   "Tune" happens before the human has agreed to the decisions.

Names used below: the **target** is the new repo. The **source** is a
checkout of CodeFactory.

## Step 1 — Check where you are

1. Run `pwd` and `git remote -v`. The working directory must be the
   target, never the source.
2. Find the source. It is this skill's own repo. If you have no checkout
   of it, ask the human to attach CodeFactory to the session, or clone
   it next to the target.
3. Look at the target with `git status` and `ls -A`.
   1. Empty, or only a README, a licence or a `.gitignore`: carry on.
   2. It holds code or its own setup: list every path that the import
      would overwrite. Ask the human, file by file, to keep theirs, take
      CodeFactory's, or merge. Never overwrite silently.
4. If the target already has a `TICKET-0000` that is `Done`, stop. It is
   migrated.

## Step 2 — Open the branch

1. The target needs a `main` branch to open a pull request against. If
   the repo has no commit, create `main` with one empty commit and push
   it:

   ```bash
   git checkout --orphan main && git commit --allow-empty -m "Initial empty commit" && git push -u origin main
   ```

2. Create `ticket/0000-migrating-code-factory` from `main`'s tip.
3. If the session was told to work on another branch, use that branch
   and say so in the pull request.

## Step 3 — Import as is

1. Copy every tracked file of the source into the target, except the
   paths the human chose to keep in step 1:

   ```bash
   git -C <source> archive HEAD | tar -x -C <target>
   ```

2. Commit it alone, with the message
   `TICKET-0000: import CodeFactory as is`. Change nothing in this
   commit.
3. Run `just env` and `just ci`. Both must pass before you tune. If one
   fails, the fault is in the environment or the import; fix that first.

## Step 4 — The interview

Do this before the pull request, in the conversation. Use the question
tool when you have one; it lets the human pick from options. Ask in
rounds, a few questions per round. Explain each option in one line. Give
your recommendation first.

Skip a question the human already answered. Do not ask what you can read
in the target.

### Round 1 — The project (always ask)

1. What is the project, in one or two sentences? Who uses it?
2. What are its main parts, if known?

Every repo made from CodeFactory is built to production grade. Do not
offer a lighter mode.

### Round 2 — The team (always ask)

Propose the full team: `dev`, `code-reviewer`, `qa` at light and deep,
`docs-sync` and `researcher`. Drop a role only when the human asks for
it or the project gives it no work.

1. Do we keep every role? Say which one you would drop, if any, and
   why.
2. For `qa`: light and deep, or light only? Deep means repeated runs,
   breaking the code on purpose to test the tests, and killing
   processes mid-work. It suits concurrency, saving and recovery.
3. Do we need a role that is not in the box? Offer the ones that fit
   the project, for example:
   1. a security reviewer, for a system that holds user data or keys;
   2. a UI reviewer that drives the pages in a browser;
   3. a data or evaluation role, for a project that grades model output;
   4. a release role, for a project that deploys.
4. Do we need a workstream that is not in the box? The box has three:
   design session, development, and a change that alters no behavior.
   Offer the ones that fit, for example:
   1. a quick-fix path for small bugs;
   2. a release path: version, changelog, deploy.

### Round 3 — Process

1. **Branch protection.** Apply the `main` ruleset? It needs a public
   repo or a paid plan. Pull requests that the human merges stay in
   every case.
2. **Ready-for-review alerts.** How does the human learn that a pull
   request is ready? Recommend the first option for a human who is often
   away from the screen.
   1. Phone and `/wawa`: a push notification reaches the phone for each
      pull request. It carries the same row that `/wawa` shows for that
      ticket. `/wawa` stays available.
   2. `/wawa` only: nothing is pushed. The human types `/wawa` to see
      what is ready.

   The phone option needs a push-notification tool in the session. Check
   for one. If there is none, say so and offer `/wawa` only.

### Round 4 — Stack and standards

1. **Stack.** The box is Python: `uv`, `ruff`, `pyright`, `pytest`.
   Keep it? If not, name the stack.
2. **Package name.** Propose one from the project name.
3. **Standards that fit some projects.** Offer the ones that apply:
   1. the product calls a model: every model call is traced, with its
      tokens and cost; tests never call the real model;
   2. the product reports facts: every fact carries its source and
      retrieval date;
   3. the product reads files as its memory or its prompts: no ticket
      numbers or code paths in those files.
4. Anything else the team must always or never do in this repo?

### Close the interview

1. Write the decisions as a short list, one line each.
2. Show the list to the human. Ask for a clear yes.
3. Copy the agreed list into the "Decisions" section of the ticket.
4. Put each standing request the human made (how they want the work
   done, not what the product is) in `Memory/requests.md`.

## Step 5 — Tune

Apply the decisions. Commit in small steps, each message starting with
`TICKET-0000`.

### The project

1. Fill the "Project" section of `CLAUDE.md`: name, paragraph, parts. Remove the template comment.
2. Rename the `app` package: the folder under `src/python/`, the
   `[project]` name, the wheel path in `pyproject.toml`,
   `known-first-party` in `ruff.toml`, the import in the tests, and the
   path in `CLAUDE.md`. Run `uv lock`.
3. Keep `hello.py` and its test until the first real module exists.
   They prove the toolchain works.
4. Set the owner in `.github/CODEOWNERS` to the human's GitHub login.
5. Add agreed standards to "Engineering standards" in `CLAUDE.md`.

### The team

To remove a role:

1. Delete its file in `.claude/agents/`.
2. Remove it from the team table and from every step that dispatches it
   in `.claude/skills/orchestrate/SKILL.md`. Rewrite the step so it
   still reads as a full instruction.
3. Hand its duties to another role where one must remain:
   1. no `docs-sync`: the tech lead sets a ticket to `Done`;
   2. no `qa`: remove `qa/`, the `qa` recipe and the QA text in
      `CLAUDE.md`; `code-reviewer` is the only check;
   3. no `code-reviewer`: `qa` is the only check;
   4. no `researcher`: remove the research step of the design session.
4. `grep -rn "<role>"` across the repo. Fix every match: the other role
   files, `CLAUDE.md`, `Jira_tickets/README.md`, the templates.

To keep `qa` at light only: remove the deep level from
`.claude/agents/qa.md` and from the tech-lead procedure.

To add a role:

1. Copy the closest role file. Keep its shape: frontmatter with `name`,
   `description`, `tools` and `background: true`; the writing-style
   block; "Your job"; "Workflow"; "Live coordination"; "Boundaries".
2. Give it only tools from the list of allowed background tools in the
   tech-lead procedure.
3. Say what it may write and what it must never touch.
4. Add it to the team table, to the step where it runs, and to the role
   list in `CLAUDE.md`.

To add a workstream: write it in the tech-lead procedure as
`Workflow N — <name>`, as numbered steps, with the test for when it
applies.

Never name a skill in a role file or in `CLAUDE.md`.

### The process

1. Apply the human's choice for ready-for-review alerts.
   1. `/wawa` only: in `.claude/skills/orchestrate/SKILL.md`, remove the
      "Notify the human" section, step 8 of Workflow 2 (renumber the
      steps after it), and the line "One PR and one notification per
      ticket" in "Run tickets in parallel" (keep "One PR per ticket").
      Also change "notify the human" to "report to the human" in the
      skill's `description`. Leave `.claude/skills/wawa/SKILL.md` as it is.
   2. Phone and `/wawa`: keep the notification and make it carry the
      `/wawa` row.
      1. In "Notify the human", replace the exact message. The
         notification title is the ticket, exactly as the `/wawa` row
         names it: `TICKET-XXXX — <ticket title>`, copied from the
         ticket file, never reworded. The body is
         `PR for review: <needs from you>`. If the tool has no separate
         title field, put the title first and the body after it on one
         line. The status is always `To review`, so leave it out.
      2. In `.claude/skills/wawa/SKILL.md`, add a last section
         "Phone alerts": "A ready pull request also reaches the human's
         phone. The alert carries the same ticket, title and 'Needs
         from you' as its row here. If the two differ, this table is
         right."
      3. Keep the `README.md` text that says the human gets a phone
         alert. Under `/wawa` only, change it to say the human types
         `/wawa` to see what is ready.
2. If the ruleset is not applied, change rule 5 in `CLAUDE.md` and the
   matching text in the tech-lead procedure to say so.

### The stack, if it is not Python

1. Replace `pyproject.toml`, `ruff.toml`, `uv.lock`, `.python-version`,
   `src/python/` and `tests/` with the new stack's minimal setup and
   one module with one test.
2. Keep the recipe names in `justfile`: `env`, `lint`, `typecheck`,
   `test`, `check`, `ci`, `qa`. Change their bodies.
3. Change the setup steps in `.github/workflows/ci.yml`. Keep the job
   name `check`. Change `.github/dependabot.yml`,
   `.pre-commit-config.yaml` and `.gitignore`.
4. Rewrite "Commands", "Stack details" and the Python standards in
   `CLAUDE.md`.

### The first docs

Use what the interview told you.

1. `README.md`: replace it. Project name, the one-paragraph
   description, a quick start (`just env`, `just check`), the command
   list, and a short "How we work" section that names the roles kept.
2. `Notion/design_docs/roadmap.md`: the product in one sentence, its parts,
   and what comes first.
3. Offer to write the first tickets as `Backlog` from what the human
   said. Write them only on a yes.

### Remove the template-only files

1. Delete `.claude/skills/migrate/`.
2. In the tech-lead procedure, shorten "Check the project is migrated"
   to its first case.
3. `grep -rni "codefactory\|code factory"`. The only matches left are
   `TICKET-0000` and one credit line in `README.md`.

## Step 6 — Verify

1. `just ci` passes.
2. `grep -rn "<[a-z][^>]*>" CLAUDE.md README.md Notion/design_docs/roadmap.md`
   finds no placeholder.
3. Every role named anywhere has a file, and every role file is named
   in the team table.
4. Read the whole diff from the import commit to the tip. Look for a
   sentence cut off mid-thought and a step that names a removed role.

## Step 7 — Ship

1. Tick the acceptance criteria in the ticket. Set `Status:` to `Done`.
2. Push. Open one pull request titled
   `TICKET-0000 — Migrating Code Factory`. In the body, list the
   decisions and say that the first commit is the unchanged import.
3. Tell the human the pull request is ready, the way they chose: a
   phone alert plus the `/wawa` row, or the `/wawa` row only.
4. Tell the human what only they can do after the merge:
   1. set `main` as the default branch, if it was just created;
   2. apply the ruleset (`.github/rulesets/README.md`), if kept;
   3. allow squash merge only, and turn on automatic deletion of head
      branches.

Do not start `TICKET-0001` before the human has merged.
