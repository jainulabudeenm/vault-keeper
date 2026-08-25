# Vault Keeper

Three Claude skills that do the bookkeeping on a markdown notes vault, so it stays worth having.

Every notes system decays the same way. Indexes go stale. Nothing gets linked to anything. The file
that is supposed to say what you are working on says what you were working on in March. Nobody skips
this work because they are lazy, they skip it because it is boring and it never feels urgent.

That is exactly the shape of work to hand to an agent.

## Install

In Claude Code, as a plugin. This is the one to use, because it brings all three skills plus the
`/vault-keeper-init` and `/vault-groom` commands:

```
/plugin marketplace add jainulabudeenm/vault-keeper
/plugin install vault-keeper
```

From npm, which also covers Claude.ai and anywhere outside Claude Code:

```
npx @jainulabudeenm/vault-keeper
```

The npm name is scoped because plain `vault-keeper` is blocked as too close to an existing package.
The plugin route above uses the short name.

Add `--project` to install into the current repo instead of your home directory, so you can commit
it and share it with a team.

## The three skills

**`vault-capture`** turns a braindump into one filed note. It asks the few questions whose answers
you will want later and cannot reconstruct: why this mattered, what it connects to, where it
belongs. Then it files it with correct frontmatter, into staging by default.

**`vault-save-chat`** freezes a conversation before the window closes. The saving is the easy half.
The part that matters is that it decides where the conversation goes **before** it writes, so a
private one never lands in a folder that gets pushed.

**`vault-groom`** is the maintenance sweep. Index rows, links between related notes, the state file
for anything that changed, a session log entry. Run it at the end of a working session.

## Use

```
> capture this: the reason the migration stalled was nobody owned the schema
```

```
> save this chat
```

```
> groom the vault
```

First run asks where your vault is, what shape it has, and **what must never be auto-edited**. That
last answer is the important one and it takes about a minute.

## What it will not do

**It never commits and it never pushes.** Only file changes. Reviewing the diff yourself is the gate
that makes agent-run bookkeeping safe, and a gate the agent can walk past is not a gate.

**It never writes to a path you marked as gated.** Journals, anything personal, frozen source
material, private folders. It will draft a change and show it to you. It will not write it. A vault
stops being worth keeping the moment you cannot trust that your own words are still your own words.

**It never creates an index for a folder with nine notes in it.** Scaffolding for a problem you do
not have yet is not tidiness.

**It tells you what it skipped.** Groom finishes with a table of every structural file in every
folder it touched, including the ones it left alone and why. A silent omission and a deliberate skip
look identical from the outside otherwise, and only one of them is fine.

## Sensitivity routing

The one rule worth spelling out, because it is the reason `vault-save-chat` exists.

People save chats by hand into whatever folder they are standing in. Do that often enough and a
conversation about something genuinely private ends up in a tracked folder, gets pushed, and is in
the git history permanently.

So the routing decision happens before anything is written, not after. Anything personal, medical,
or employer-confidential goes to a git-ignored folder. **When in doubt it treats the conversation as
sensitive**, because the two mistakes are not equal. A harmless chat filed privately costs you one
move later. A private chat filed publicly cannot be taken back.

## Conventions

`conventions.md` in this repo is the default set: frontmatter fields, naming, structure, and what
the `source:` field means for whether an agent may edit a file. PARA is assumed but nothing depends
on it. Your profile overrides all of it, and the skills read your profile first.

`profile.example.md` shows a filled-in profile at useful depth, especially the gated section.

## Your data

The profile is at `~/.claude/vault-keeper/profile.md`, in your home directory rather than inside the
vault, so it cannot end up committed by accident. Plain markdown, yours to edit.

Nothing is uploaded anywhere. The skills only read and write files you pointed them at.

## License

MIT
