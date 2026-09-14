---
description: Set or report the teaching depth — beginner, intermediate, or advanced
argument-hint: "[beginner|intermediate|advanced]"
allowed-tools: Read, Edit, Write, Bash(git rev-parse:*)
---

Set the teaching depth dial.

**With no argument** — Report the current level (from `$TEACH_LEVEL`, defaulting to
`beginner`) and describe what it means in one line each:

| Level | Notes/session | What you get |
|---|---|---|
| `beginner` | 3 | What things are. Analogy first, no assumed vocabulary. |
| `intermediate` | 2 | How they work underneath. Vocabulary assumed. |
| `advanced` | 1 | Only the non-obvious: tradeoffs, surprising failure causes, internals. |

Then stop. Do not change anything.

**With a level argument** — Accept `beginner`/`beg`, `intermediate`/`int`,
`advanced`/`adv`/`expert`. Anything else: say what the valid values are and change
nothing.

1. Apply it for the rest of this session immediately.
2. Persist it if there is a repo to persist it in. Find the repo root
   (`git rev-parse --show-toplevel`); if there is one, set `env.TEACH_LEVEL` in
   `<root>/.claude/settings.json`.
   - **Merge into the existing file. Never overwrite it.** Read it first, preserve every
     other key, and if it is not valid JSON, change nothing and say so.
   - Create the file only if it does not exist.
3. Confirm in one line: the new level, and whether it persisted or is session-only.

If there is no repo, apply it for the session and say plainly that it will not carry
over — to make it stick, they need `/teach-install` in a repo, or `TEACH_LEVEL` set in
their own environment.

Do not write a teaching note about settings files unless a note is genuinely due.
