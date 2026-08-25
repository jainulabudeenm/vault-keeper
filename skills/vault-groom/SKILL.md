---
name: vault-groom
description: Keeps a markdown notes vault tidy without being asked twice. Updates index files, adds links between related notes, refreshes the current-state file for anything that changed, and appends a session log entry. Use when the user says groom, tidy the vault, update my index, or at the end of a working session in their notes.
---

# Vault Groom

Bookkeeping is the work that keeps a notes vault usable and the work nobody does. Indexes go stale,
links never get added, and the file that is supposed to say what is going on says what was going on
in March.

This is the maintenance layer. Let the agent do the bookkeeping.

## Read first

`~/.claude/vault-keeper/profile.md`. It holds the vault root, the folder shape, where new notes
land, and the **gated paths that must never be auto-edited**. If it does not exist, run the
onboarding in the `vault-capture` skill first, then come back.

## When to run

- The user asks: "groom", "tidy the vault", "update the index".
- **At the end of a substantive session in the vault**, before stopping. Scoped to what changed.
- Straight after a capture, so the new note gets indexed and linked while the context is fresh.

## Scope

**Session scope is the default.** Work out what changed from `git status` and `git diff --name-only`,
or from file modification times if the vault is not in git.

For each changed file, walk up to **both** its immediate folder **and** its nearest area or project
root. Reconcile both. A change deep in a subfolder often makes a parent level index or state file
stale, and only checking the immediate folder is how that gets silently missed for months.

**Full scope** sweeps everything. Use it when asked, or as an occasional health pass.

## The auto-write layer

Do these without asking. They are mechanical, and they show up in `git diff` if anything goes wrong.

1. **Index files.** Make sure every note in the folder has a row: title, one line summary, type, and
   its key links. Regenerate from the directory listing plus frontmatter. Never hand maintain a
   count.

   **Only create an index once a folder has roughly fifteen notes.** Below that the folder listing is
   the index, and an index file is scaffolding for a problem nobody has yet.

2. **Links between notes.** Add `[[wikilinks]]` between related notes, including across folders. A
   link to a note that does not exist yet is fine, it marks something worth writing. Do not
   over link. Every link has to help someone find something.

3. **The current-state file.** Refresh it for each touched area and stamp the date. Reflect what
   changed. **Do not rewrite the user's framing or their voice.**

4. **Plans and specs, split by kind.**
   - **Auto:** tick a checklist item from open to done **only when the thing it describes
     demonstrably exists in the repo**. Two hard rules. Evidence must be a file you can point at,
     never something inferred from the conversation, because "we discussed it" is not done. And
     **cite the evidence** for every tick, so it is auditable in the diff and easy to revert.
   - **Propose:** flipping a whole milestone to done, re-sequencing, adding or removing tasks,
     rewriting a goal, or any change of direction. That is authoring, not bookkeeping. Show it and
     write only on a yes.

5. **Session log.** Append one block:

   ```
   ## [YYYY-MM-DD HH:MM] <title>
   - **Worked on:** ...
   - **Files touched:** ...
   - **Decisions:** ... (or none)
   - **Next:** ...
   ```

6. **Counts are always recomputed, never carried forward.** Any number an index or a map states has
   to come from a listing you ran this sweep. Copying a stale count forward is how a vault map drifts
   until it describes a vault that no longer exists.

## The gated layer, do not auto-write

**Draft and show, never silently rewrite.** Anything under a path the profile marks as gated:
personal journals, private folders, frozen source material, and any note whose frontmatter says a
human wrote it. You may draft a suggested entry and show it. The human keeps it or bins it.

**Propose then confirm.** Changes to rules or conventions files, entries in a decision log, and any
plan or spec change that is authoring rather than status. Collect these and surface them at the end
as a short list.

## Respect local rules

Read a folder's own instructions file before touching it, if it has one. **Local rules win.** If a
folder says do not create structure here, skip it and say you skipped it. Do not helpfully scaffold
what a folder has explicitly refused.

## Never

Never `git commit`. Never `git push`. Never edit frozen source material. Never invent structure a
folder's own rules forbid. The human gate is reviewing the diff, and that gate only works if the
agent never reaches past it.

## Finish with a coverage report

This is the part that makes groom trustworthy, so it is not optional.

For every folder you touched, list **every structural file present in it**: index, state, rules,
plan, spec, readme. Give each one a disposition. Use a directory listing, never memory.

| Folder | File | What happened |
|---|---|---|
| ... | ... | Updated / Skipped, with a one line reason / Needs you |

**No structural file in a touched folder may be missing from this table.** If groom did not touch
it, the table has to say why. A silent omission and a deliberate skip look identical to the user
otherwise, and only one of them is fine.

Then summarise in three lines: what you wrote, what you drafted for review, and what you are
proposing. Remind them the changes are local and nothing was committed.
