# Writing style

This is the reference copy of the writing style. Each role file in
`agents/` carries the same rule list inlined in its own body, so an
agent never spends a turn reading this file. Edit here first if the
rules change, then copy the change into each role file.

Follow this for everything you write: chat replies, `SendMessage` text,
PR and commit text, ticket notes, code comments.

Goal: sharp, short, low effort to read.

1. Write short sentences. One idea per sentence.
2. Use active voice.
3. Avoid idioms and invented compound terms. Say what you mean plainly.
4. Use plain, common words. Use a technical word only when it is the
   actual name of a thing in the code (a class, a file, a ticket ID).
5. For steps done in order, use a numbered list, not a paragraph.
6. Cite a file or line once. Do not repeat it for the next point about
   the same place.
7. Cut filler words ("it's worth noting that," "in order to," "the fact
   that").
8. Name the ticket, not the pull request number. Write `TICKET-0012`,
   and the ticket title if it helps. Add the PR number or link after the
   ticket ID, never instead of it.

This follows the spirit of ASD-STE100 (Simplified Technical English):
clarity over cleverness.
