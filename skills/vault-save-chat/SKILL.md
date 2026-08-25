---
name: vault-save-chat
description: Saves the current conversation into a markdown vault so it is not lost when the window closes, and routes it by sensitivity so a private conversation never lands in a folder that gets pushed to a remote. Use when the user says save this chat, save this conversation, save verbatim, or capture this discussion.
---

# Vault Save Chat

A long conversation is often the best thinking you did that week, and it disappears when the window
closes.

This saves it. The saving is the easy half.

## Why the routing matters more than the saving

People save chats by hand, into whatever folder they happen to be in. Do that often enough and one
day a conversation about something genuinely private ends up in a folder that gets pushed to a
remote, and it is in the git history forever.

**So sensitivity routing is the non-negotiable part of this skill.** Assess before you write, not
after.

## Read first

`~/.claude/vault-keeper/profile.md`, for the vault root, the staging folder, and above all the
**private folder** that git ignores. If there is no profile, run onboarding in the `vault-capture`
skill first.

## Sensitivity routing, decided before anything is written

Judge what the conversation actually contains.

**Sensitive goes to the private, git-ignored folder.** Anything personal, medical, or intimate.
Grief. Anything about a relationship. Employer-confidential material: pay, internal strategy, named
colleagues, internal documents. Anything they would not want on a remote, whether or not they said
so.

**When in doubt, treat it as sensitive.** The two mistakes are not equal. A harmless chat filed
privately costs one move later. A private chat filed publicly cannot be taken back.

**Everything else goes to the staging folder** with `status: unreviewed`, for triage later.

Put the private copy near the relevant context if there is one, or at the top level if the
conversation spans everything.

## What to write

1. **The transcript.** Use the real session transcript file if you know its path. Otherwise write a
   faithful reconstruction from context, keeping the user's **exact words** on decisions, framings,
   and anything that mattered. Do not tidy their phrasing. A smoothed transcript is a summary
   wearing a transcript's frontmatter.

2. **Optionally a short summary note** linking back to the transcript. Offer it. Do not force it,
   because not every conversation earns two files.

```yaml
---
source: ai-assisted
type: raw
created: YYYY-MM-DD
summary: <one line, what this conversation was>
---
```

Filename in lowercase with hyphens, with the date in it.

## After filing

Hand non-private output to `vault-groom` for its index row and links.

**Do not index anything in staging or in the private folder.** Staging is not a permanent home, and
a private folder that shows up in a tracked index defeats the whole point of the routing.

Say plainly where you put it and why. If it went private, say that the folder is git ignored so they
can confirm it.

## Never

- Never commit. Never push.
- Never edit frozen source material.
- Never index the private folder.
- Never write into a gated path on your own. Draft it and ask.
- Never leave a sensitive conversation in the tracked tree. Route it, or stop and ask.

## How this differs from capture

`vault-capture` takes one thought or one source and interviews you to give it context.
`vault-save-chat` takes a whole conversation that already has all its context and freezes it. No
interview, because the content already exists.
