---
updated: 2026-08-25
---

# Vault profile

A worked example with invented paths. The point is the level of detail, especially in the gated
section, because that is the part that decides what an agent is allowed to touch.

## Root

`~/notes`

In git. Committed by hand. Remote is a private repo.

## Shape

PARA, with one addition.

```
inbox/        staging, everything lands here first
projects/     has an end date
areas/        ongoing
resources/    reference
archive/      done
journal/      daily entries, written by hand
```

Areas each have a `state.md` and a `rules.md`. Projects each have a `plan.md`.

## Default landing spot

`inbox/`, with `status: unreviewed`.

Nothing gets filed into a permanent home without me saying so, including notes that obviously belong
somewhere. Obvious is how the inbox stops being used.

## Gated, never auto-edited

Draft and show. Do not write.

- `journal/` at any depth. Every word in there is mine.
- `areas/health/`
- `areas/relationships/`
- Any file whose frontmatter says `source: human`
- `resources/exports/`, which is frozen source material. Distil out of it, never edit it.
- `_private/` at any depth

## Confidential

`_private/`, git ignored at any depth. Anything that must not reach the remote.

Also fine to nest: `areas/health/_private/` keeps a private file next to its context rather than in
a distant quarantine folder.

## Indexes

Only `resources/` and `areas/reading/` have enough notes to need one. Do not create indexes anywhere
else yet.

## Session log

`log.md` at the root. Newest entries at the top.

## Standing notes

- Never commit, never push. I review the diff myself, and that is the only real gate.
- Local rules beat these. If a folder has its own rules file, read it first and let it win.
- One area explicitly refuses new structure until its plan is agreed. Skip it, and say that you
  skipped it.
