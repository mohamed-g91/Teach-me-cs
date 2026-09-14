# teach-me-cs

Learn computer science from the sessions you're already running.

While Claude Code does the actual work — cloning a repo, installing packages, starting a
server — this drops a short plain-language note explaining what just happened and why it
matters. Not a course. Not homework. A side effect.

```
> 🧠 What just happened: git clone
>
> A repo is a project folder that quietly records every change ever made to it.
>
> Cloning downloaded GitHub's copy onto this machine — the files and the entire history.
>
> That copy is now independent. Your edits live only here until you push them back.
```

## Pick a depth

One setting, three values. It works like an effort dial: it changes not just how things
are worded, but **what's worth mentioning at all**.

| Level | Notes per session | What you get |
|---|---|---|
| `beginner` | 3 | What things *are*. Analogy first, no assumed vocabulary. |
| `intermediate` | 2 | How they work underneath. Vocabulary assumed. |
| `advanced` | 1 | Only the non-obvious: hidden tradeoffs, surprising failures, internals. |

At `beginner`, `git clone` earns an explanation. At `advanced` it's invisible — only a
rebase conflict or a surprising CI failure clears the bar. The note count goes *down* as
depth goes up, because the threshold for "worth your time" goes up.

Default is `beginner`. Change it any time:

```
/teach-level intermediate
```

## Install

### On your own computer

Once per machine. Covers every local session, in every folder, from then on.

```
claude plugin marketplace add mohamed-g91/teach-me-cs
/plugin install teach-me-cs@teach-me-cs
```

### Cloud sessions (claude.ai/code)

Cloud sessions run in a fresh container that can't see your computer, so the install
above doesn't reach them. Inside the repo you want it for:

```
/teach-install
```

That writes `.claude/settings.json`. **Commit and push it** — cloud sessions read the
repo as cloned, so an uncommitted file doesn't exist as far as they're concerned. One
command per repo, then it's permanent for that repo.

### Other machines

Same as "on your own computer", once per machine.

## Commands

| Command | Does |
|---|---|
| `/teach` | Explain something now — again, deeper, or a topic you name |
| `/teach-level [level]` | Set or check the depth dial |
| `/teach-off` | Silence for the rest of this session |
| `/teach-install` | Register in the current repo, for cloud sessions |

## When it stays quiet

Deliberately, a lot of the time. It says nothing when you're frustrated, when you're
rushing, when you're deep in a debugging loop, when something is broken and you just need
it fixed, or when nothing genuinely new happened. There's a hard cap per session and no
padding to reach it — at `advanced`, most sessions produce no note at all, and that's
correct behavior rather than a bug.

`/teach-off` kills it for a session. Saying "quiet" or "not now" does the same thing.

## The one thing it always explains

Failures. If a concept *caused* something to break in your session — a missing package, an
import error, "it works locally but not here", a port already in use — it clears the bar at
every level and goes one notch deeper than your dial.

A failure you just watched happen is the best teaching moment there is.

## How it works

- A **SessionStart hook** injects a small contract (~800 tokens) into every session. This
  is what makes it always-on: a skill alone would never activate, because "teach me CS"
  matches no task you'd actually ask for.
- A **skill** holds the pedagogy and two reference files: a trigger table mapping session
  events to concepts, and a curriculum of ~100 concepts across 11 tracks.
- The references are read **only when a note is actually due**, so a session where nothing
  teachable happens costs almost nothing.

There's no database, no progress tracking, and nothing stored about you anywhere. The
level is a single word in a settings file. You're the memory — and seeing a concept
explained more than once across weeks is spaced repetition, which is how learning
actually works.

## License

MIT
