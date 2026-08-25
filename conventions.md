# Vault conventions

The defaults these three skills assume. None of it is mandatory. Your profile overrides any of it,
and the skills read your profile first.

It is written down because a convention that only lives in one person's head is not a convention, it
is a habit that the agent cannot follow.

## Frontmatter

Three fields carry most of the weight.

```yaml
---
source: ai-assisted
type: note
created: 2026-08-25
---
```

**`source:`** is who actually wrote this, and it is the field that decides whether an agent may edit
the file.

| Value | Meaning |
|---|---|
| `human` | You wrote it. **An agent never edits this.** Draft a change and ask. |
| `ai-assisted` | An agent drafted it, you directed and reviewed it. Most of a working vault. |
| `ai-generated` | An agent produced it with nobody checking. **Unverified.** Belongs in staging until a human reads it, and should never be cited as fact before then. |

The distinction between the last two is the whole safety model. An `ai-generated` note that gets
filed into a permanent home is how a guess quietly becomes a fact you rely on next year.

**`type:`** tags what a file is for, so it can be found by role rather than by remembering its name:
`router`, `state`, `plan`, `spec`, `index`, `conventions`, `log`, `note`, `raw`.

**`created:`** in `YYYY-MM-DD`. Absolute dates only, everywhere. "Last Tuesday" is worthless in a
year and actively misleading in three.

## The two file kinds that do the work

**A state file says what is true right now.** It changes constantly and it is the first thing to
read when picking up cold. Keep it short enough that it stays honest.

**A rules file says what was decided and why.** It changes rarely.

Keep them apart. The moment a decision gets copied into the state file, one of the two copies starts
being wrong and there is no way to tell which.

## Naming

Lowercase, hyphens, plain ASCII. No spaces, no brackets, no ampersands, no apostrophes. The one
exception is frozen source material, which keeps whatever name it arrived with, because renaming it
breaks the link back to where it came from.

## Structure

PARA is the default the skills assume, because it is the most common and it maps cleanly onto
whether something has an end date.

```
inbox/       staging, everything lands here first
projects/    has an end
areas/       ongoing, no end
resources/   reference material
archive/     done
```

Any structure works. Tell the profile what yours is.

## Staging exists so filing can be a decision

Everything captured lands in the staging folder first, marked `status: unreviewed`. Promoting it to
a permanent home is a separate act that a human performs.

Without that split, every passing thought gets a permanent address, and the vault fills with notes
nobody chose to keep. Staging is where a capture proves it was worth keeping.

## Gated paths

Any path you nominate as gated is never auto-edited by any of these skills. Journals, personal
material, frozen source, private folders.

An agent may draft a change to a gated file and show it to you. It may not write it.

This is not a soft preference. A vault stops being worth keeping the moment you cannot trust that
your own words are still your own words.

## Confidential material

Keep one folder that git ignores, for anything that must not reach a remote. `vault-save-chat`
routes to it automatically.

Encrypting sensitive files in place, so they sit in their natural home but reach the remote as
ciphertext, is better than a single quarantine folder, because it keeps local search and links
working. It is also more setup. Start with the ignored folder.

## Git

**These skills never commit and never push.** They only change files.

That is deliberate. Reviewing the diff is the gate that makes agent-run bookkeeping safe, and a gate
the agent can walk past is not a gate.
