# changelog

One file per period, named `CHANGELOG_<start>_<end>.md` (ISO dates,
`YYYY-MM-DD`, inclusive). Record changes only — no process narrative, no
design debate. That history lives in `Jira_tickets/`, in the tickets and
in `proposals/`, and in `Notion/decisions/`.

Group entries by area (for example: Features, Fixes, Infrastructure,
Process; pick names that fit the project). Each entry is one line and
names its ticket: `- Added X. (TICKET-0012)`.

Cadence: written as a follow-up pull request after a batch of tickets
merges, covering that batch's date range.
