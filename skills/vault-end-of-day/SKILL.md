---
name: vault-end-of-day
description: The end-of-day router for a markdown vault. The user dumps everything that happened today once (messy voice to text is fine, meeting transcripts and files too), and this splits the dump into pieces and files each one where it belongs, using the vault's own live map, with raw transcripts frozen first and summaries written out from them. Use when the user says "log my day", "journal my day", "end of day", "eod", "here is what happened today", "process my day", "I missed a few days, catch me up", or drops a whole day's account or a transcript. Not for a single thought (that is vault-capture).
---

# Vault End of Day

One dump, many homes. People will tell an agent about their whole day once. They will not file twelve
notes by hand. This skill is a dispatcher over the vault's live map, not an interviewer: it splits the
dump, decides where each piece goes, writes it there, and asks only about what it cannot place.

## Read first

`~/.claude/vault-keeper/profile.md`. It holds the vault root, its shape, the default landing spot and
the **gated paths**. If it does not exist, run the onboarding in the `vault-capture` skill first.

Then look for an `## End of day` section in that profile. If it is missing, ask these three questions
once, one at a time, and add the section:

1. **Where do daily entries go?** A path pattern such as `journal/YYYY-MM-DD.md`. If that folder is
   gated, ask whether this skill may write the day's entry there directly, as long as their own words
   go in a verbatim section. Record the answer as `journal-write: allowed` or `journal-write: draft`.
2. **Is any part of the vault shared or seen by others?** A work repo nested inside, a team folder, a
   synced folder a partner can read. Get the paths and what is allowed in them (for example "work
   facts only, nothing about me, my pay or my health").
3. **Where are raw transcripts frozen?** A `raw/` folder per project, one central folder, or none.

```markdown
## End of day
journal: journal/YYYY-MM-DD.md
journal-write: allowed | draft
shared:
- <path>: <what may go there>
raw-transcripts: <pattern, for example <project>/raw/transcripts/YYYY-MM-DD-<topic>.md>
```

## Step 0. Load the live map. Never skip this.

The vault changes. Never route from memory.

1. If the vault, or a shared repo nested in it, is in git with a remote, pull first
   (`git pull --rebase --autostash`) so you route into what is really there. **Never push.**
2. Read the vault's own map: the root rules file (`AGENTS.md`, `CLAUDE.md` or `README.md`), any index
   or router file that lists projects and areas, and the rules file of each folder you are about to
   write into. **Local rules win.**
3. Check whether today's entry already exists. Append or merge, never overwrite.

## Step 1. Split the dump

Break it into fragments: one event, decision, feeling, learning, link or task each. Keep the user's
words with each fragment.

## Step 2. The sensitivity gate

Skip this step if the profile lists no shared paths.

**Classify by content, not by where it happened.** A work meeting can hold a personal fragment: "the
project review went well" is work, but "my manager says I am not ready for the next level" is about
the person, and it stays private even though it was said at work. One meeting can split across both.

**Unsure means private.** A wrong call into a private note costs nothing. A wrong call into a shared
folder cannot be taken back once someone reads it.

## Step 3. Route each fragment

Use the vault's real folders, from Step 0. A typical spread:

| Fragment | Home |
|---|---|
| Feelings, health, family, friends, moments from the day | the day's journal entry |
| Project work: decisions, progress, blockers | that project's folder: its state file, or a dated note |
| Work that belongs in a shared area | the shared path, neutral facts only, never anything about the person |
| Something learned: a video, a course, a book chapter | the learning log, if the vault has one |
| A tool, a link or a resource | the resources area |
| An idea for a new project | that project's folder, or the landing spot if it is raw |
| A film, a show, a book finished | hand to a log skill if the user has one, otherwise the journal |
| Anything that fits nowhere | the default landing spot from the profile |

If the user has another installed skill that owns a kind of item (a watch log, a tool library, a
reading list), hand that fragment to it instead of writing it yourself.

## Step 4. Store raw, then write the summaries

When the dump includes a transcript or a file:

1. **Freeze the raw first** at the profile's `raw-transcripts` path. Raw is frozen: write it once,
   never edit it afterwards. Create a `raw/` folder only the first time something goes in it.
2. **Then write the summary outward:** decisions, next steps and anything worth finding later go to
   the project or area note. Each summary links back to its raw file.
3. **The raw copy goes where its most sensitive fragment goes.** If one transcript holds both shared
   work and something personal, the raw copy stays private, and only the neutral summary goes to the
   shared path.

## The journal entry

Write it if `journal-write: allowed`. Otherwise draft it in the chat and wait.

```markdown
---
source: ai-assisted
date: YYYY-MM-DD
---

# YYYY-MM-DD: <one-line read of the day>

## In their words (verbatim, do not edit)
<their dictation. Remove transcription noise only. Never reword.>

## Summary
<what happened, in plain words, with links to every note this run wrote>

## Open threads
- <carry-forward items, named tasks, questions for tomorrow>
```

Keep their words and yours apart. Never touch any other file in a gated folder.

## Several days at once

If the dump covers missed days (a trip, a busy week), ask once: one entry per day, or one entry for
the whole span. Use absolute dates, always.

## After

- Hand off to `vault-groom`, so new notes get their index rows and links.
- List what you wrote and where, in one short table, plus any fragment you parked in the landing spot
  and why.
- If a shared repo is nested in the vault, remind the user it has its own commits and its own push.

## Rules

- **Step 0 every run.** Routing follows the vault as it is today.
- **The sensitivity gate fails one way: unsure means private.**
- **Their words are sacred.** Dictation and transcripts are theirs. Clean transcription noise, never
  reword.
- **Voice to text mangles proper nouns.** A name of a person, film, product or place that looks
  wrong gets marked `(?)` and asked about at the end. Never silently guess-correct it into a note.
- **Create folders on first real use only.** An empty folder is structure for a problem nobody has.
- **Never commit. Never push.** The user reviews the diff.
- **Light by default.** Ask only about fragments you genuinely cannot place.
