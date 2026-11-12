---
name: wawa
description: "Where are we at?" The human invokes it with /wawa to get one short status table of every ticket in flight - its status, the action needed from them, and the merge order. Load it when the human types /wawa or asks where things stand. Tech lead only.
---

# /wawa — where are we at

The human wants the state of the work at a glance. Reply with one table
and at most two lines of text. No narration, no history, no agent
reports.

## Gather the facts first

Do not answer from memory alone.

1. Read the `Status:` line of every ticket in `Jira_tickets/` that is
   not `Done`, plus any that became `Done` since the last table.
2. List the open pull requests and their check results.
3. Note which agents are running now, and on which ticket.
4. Note anything that waits on the human: a review, a decision, a
   blocker.

## Reply with this table

| Ticket | Status | Needs from you | Merge order |
|---|---|---|---|
| TICKET-0012 — short title ([PR](url)) | To review | Review and merge | 1 |
| TICKET-0013 — short title ([PR](url)) | To review | Merge after TICKET-0012 | 2 |
| TICKET-0014 — short title | In QA | Nothing | — |
| TICKET-0015 — short title | Blocked | Choose the data store | — |

1. One row per ticket. Name the row by its ticket ID and title, never by
   a branch name or a pull request number. Link the pull request when it
   exists.
2. Status is one of: `Backlog`, `Design`, `Building`, `In QA`,
   `In review`, `Fixing`, `Docs`, `To review` (pull request open, all
   gates passed), `Blocked`, `Merged`.
3. "Needs from you" is one short action, or `Nothing`.
4. "Merge order" is a number when pull requests are stacked or must
   merge in sequence. Otherwise `—`.
5. Order the rows: what needs the human first, in merge order; then
   work in progress; then `Backlog`.
6. Show at most five `Backlog` rows. Write "+ N more in backlog" under
   the table for the rest.

## Around the table

1. If something needs the human, put one line above the table: the most
   urgent action.
2. If nothing is in flight, say so in one line and skip the table.
3. Add nothing else. The human asks if they want detail.
