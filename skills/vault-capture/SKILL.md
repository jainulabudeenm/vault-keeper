---
name: vault-capture
description: Turns a raw braindump, a pasted source, or a half-formed thought into one properly filed and linked note in a markdown vault. Interviews for the context that would otherwise be lost, then files it with correct frontmatter. Use when the user says capture this, braindump, add this to my notes, ingest this, or remember this.
---

# Vault Capture

The thought is not the hard part. Filing it so you can find it in eight months is the hard part, and
that is where capture usually dies.

This takes a messy dump and turns it into one note with the surrounding context attached: why it
mattered, what it connects to, and where it belongs.

## Read first

`~/.claude/vault-keeper/profile.md`. If it does not exist, run onboarding below, then continue with
whatever they were trying to capture.

## Onboarding, on first use

Six questions, one or two at a time. Look at the vault yourself first so you can propose answers
rather than interrogate.

1. **Where is the vault?** The root folder path. Then list it, so the next questions are informed.
2. **What is the shape?** Name what you see. PARA (projects, areas, resources, archive), a date
   based journal, folders by subject, or flat. Propose what you observe and let them correct it.
3. **Where do new captures land by default?** Most vaults want a staging folder rather than filing
   straight into a permanent home. Propose the inbox folder if there is one.
4. **What must never be auto-edited?** This is the important one, so do not rush it. Journals,
   anything personal, frozen source material, private folders. Get exact paths. Everything listed
   here becomes gated for all three skills, permanently.
5. **Where does confidential material go?** A folder excluded from git, for anything that must not
   reach a remote. If they do not have one, suggest making one and adding it to `.gitignore`.
6. **Is the vault in git?** If it is, whether anything commits automatically, and confirm out loud
   that these skills never commit and never push.

Write `~/.claude/vault-keeper/profile.md`, in the home directory rather than the vault itself, so it
never gets committed by accident. Show them the file. See `profile.example.md` for the shape.

## The interview

Ask only what the dump has not already answered. One or two questions at a time. Keep it light,
because a capture tool that costs ten questions stops getting used.

1. **The raw thing.** The thought, the paste, the file path. Accept mess, fragments, voice to text.
2. **Why it matters.** Why capture it now. This is the context that vanishes first and is worth the
   most later.
3. **What kind of thing it is.** A fact, an idea, a decision, a task, or a reflection.
4. **What it connects to.** Existing notes, projects, or subjects. These become the links.
5. **Where it lives.** Suggest a home, let them confirm.
6. **Action or reference.** Does this need a next step, or is it something to find later.

## Writing the note

Default destination is the staging folder from the profile. Filing straight into a permanent home is
how a vault fills with notes nobody chose to keep.

```yaml
---
source: ai-assisted
status: unreviewed
created: YYYY-MM-DD
suggested-home: <best guess path>
summary: <one line, so triage never needs the file opened>
---
```

If they confirmed a home during the interview, file it there instead and drop `status` and
`suggested-home`.

Then hand off to `vault-groom` so the note gets its index row and its links. Skip that if it landed
in staging, because staging is not a permanent home and indexing it there is work you throw away.

## Rules

- **Never write into a gated path autonomously.** Draft it, show it, ask. The profile lists them.
- **Voice to text mangles proper nouns.** If a name of a person, place, product, or film looks
  garbled, mark it and confirm during the interview. Never silently correct a guess into a filed
  note, because a confidently wrong name is worse than an obviously broken one.
- **One dump is one note** unless they ask to split it.
- **Preserve their voice.** Where the text is their own thinking, keep their words. Do not smooth
  the edges off and do not make it sound more finished than it is.
- Absolute dates, always. "Last Tuesday" is worthless in a year.
- Filenames in lowercase with hyphens, plain ASCII, no spaces.
