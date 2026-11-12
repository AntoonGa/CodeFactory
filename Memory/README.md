# Memory

What the human asked for that is not part of the product's design: their
constraints, preferences and special requests. It is the repo's memory
of how the human wants the work done.

- A design choice about the product goes in `Notion/`.
- A piece of work goes in `Jira tickets/`.
- A standing request from the human goes here. Examples: "never add a
  dependency without asking", "screenshots in every pull request for a
  page", "I review on my phone, keep pull requests small".

## Files

- `requests.md` — the list. One entry per request.

## Who reads and who writes

1. Every role reads `requests.md` at the start of a task and follows it.
2. Only the tech lead writes it. Another role that learns of a lasting
   request, or sees one broken, tells the tech lead.

## Adding an entry

1. Search `requests.md` first. Use the key words of the request.
2. **Not there:** add it, in the format below.
3. **Already there:** do not add it again. Add today's date to its
   `Seen` line. The human had to repeat it, so the list alone did not
   work.
4. **Seen two times or more**, or the entry has grown into a procedure
   with steps: suggest to the human to turn it into a skill. A skill is
   loaded when it applies and can hold steps; a line in a list cannot.

Add an entry only for a request that should outlive the current task.
A one-time instruction stays in the conversation or the ticket.

## Entry format

```markdown
### <short title>

- Request: <what the human wants, in one or two plain sentences>
- Applies to: <everyone | a role | a kind of task>
- Why: <the reason, if the human gave one>
- Seen: <YYYY-MM-DD>, <YYYY-MM-DD>
```

## Maintaining the list

1. Change an entry when the human changes their mind. Do not keep the
   old version.
2. Remove an entry when it no longer applies, or when it became a rule
   in `CLAUDE.md`, a role file or a skill. One home per rule.
3. Keep the list short. If it passes about twenty entries, group them
   and propose which to promote or drop.

## Turning an entry into a skill

Only after the human agrees.

1. Write `.claude/skills/<name>/SKILL.md`: a `name`, a `description`
   that says when to load it, then the rule as numbered steps.
2. Remove the entry from `requests.md`.
3. If every role must follow it at all times, it is not a skill: put it
   in `CLAUDE.md` instead.
