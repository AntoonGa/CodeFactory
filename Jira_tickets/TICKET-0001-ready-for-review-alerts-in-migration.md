# TICKET-0001: Ready-for-review alerts in the migration interview

Status: Done
Branch: `claude/dreamy-einstein-58ca2b`

## What?

When CodeFactory is set up in a new project, the interview now asks how
you want to learn that a pull request is ready. You can choose a phone
alert plus the `/wawa` status table, or the `/wawa` table only. The
setup then adjusts the tech lead's instructions and the `/wawa` skill to
match your choice.

## Why?

Some people are away from the screen while the team works. They want a
tap on their phone to take them to the pull request. Others want no
pushes. Before this change the setup asked a vague question and only
handled the "no pushes" case.

## How?

This is a change to the setup procedure only. The phone alert carries
the same ticket, title and "what I need from you" as the `/wawa` row. Its
title is the ticket exactly as written in the ticket file. It always
links to the pull request, so a tap opens it on GitHub. Choosing the
table only removes the alert step from the tech lead's instructions.

## Context

Requested by the human during a template maintenance session. The
template's own tech-lead procedure is unchanged: it still sends the
phone alert in its original form. Only the migration applies the choice.

## Design docs this depends on

- None. This ticket changes the migration procedure and `README.md`.

## Acceptance criteria

- [x] The interview asks the question with both options and a
      recommendation.
- [x] The interview checks that a push tool exists before it offers the
      phone option.
- [x] Phone choice: the alert title is the ticket, copied exactly, and
      the alert always links to the pull request.
- [x] Phone choice: the Wawa skill gets a "Phone alerts" section.
- [x] `/wawa` only choice: the alert step is removed from the tech-lead
      procedure, including its description.
- [x] `README.md` matches both choices.
- [x] `just ci` passes

## Out of scope

- Changing the tech-lead procedure in the template itself.
- Other alert channels, such as email or chat.

## Notes

No code changed, so Workflow 3 applied: no `qa` or `code-reviewer` run.
The tech lead read the whole diff, grepped for leftover "chat only"
text and ran `just ci`.
