---
name: teach-me-cs
description: Explain a computer science concept that just came up in this session — what a repo, package, container, port, server, environment or dependency actually is, why something works locally but not in the cloud, or why a command did what it did. Use when writing a teaching note for work that just happened, when the user asks "what is X" or "why did that happen" about their own session, or when /teach, /teach-level or /teach-off is invoked.
---

# teach-me-cs

Teach computer science as a side effect of real work. The user learns by watching
their own sessions, so every explanation attaches to something that actually
happened in front of them.

The hard rules (note caps, when to stay silent, the format) are injected into every
session by the SessionStart hook. This file is the craft: how to choose what to
teach and how to write it well.

## Reference files

| File | Read it when |
|---|---|
| `references/triggers.md` | A note may be due and you need to know what the event maps to, whether it clears the current level, and which angle to use. |
| `references/curriculum.md` | You have the concept and need the accurate explanation for the current level. |
| `references/writing-notes.md` | Before writing your first note in a session. Voice, analogies, and the failure modes to avoid. |

Do not read these preemptively. Most sessions need none of them.

## Choosing what to teach

**1. List what actually happened.** Commands that ran, files that appeared or
changed, errors that surfaced, differences the user could see. Only these are
eligible. A concept the session did not touch is not eligible, no matter how
foundational it is.

**2. Map events to concepts** via `references/triggers.md`. One event usually maps
to several concepts in prerequisite order. `npm install` is not "packages" — it is
package → registry → dependency → lockfile.

**3. Drop everything below the current level's bar.** The triggers table marks which
levels still care about each row. At `advanced`, most rows are silent.

**4. Take the shallowest remaining concept, not the most interesting one.** Teach
what a package is before what a lockfile is. Name the deeper term without explaining
it — unexplained terms accumulate as familiar noise until the user asks, which is
exactly how vocabulary is supposed to arrive.

**5. Check the failure exception.** If a concept caused a failure this session, it
clears the bar at every level and you go one notch deeper. Prioritize it over
anything incidental.

**6. Stop at the cap.** Then stay silent for the rest of the session.

## Choosing the angle

The same concept will come up in hundreds of sessions and there is no memory of what
was taught before. That is fine — repetition is how learning works — but the *same
words* twice are wasted. `references/triggers.md` carries two or three angles per
concept. Pick by what is actually true this time:

- Clone took 40 seconds → the size-and-history angle.
- Clone happened in a cloud container → the this-copy-disappears angle.
- Clone is the first thing in a fresh session → the plain what-is-a-repo angle.

Same concept, different door. If none of the stored angles fits what happened, write
to what happened rather than forcing a stored one.

## Depth by level

**`beginner`** — Assume nothing, including what a file or folder is. Analogy first,
real term second. Never explain jargon with jargon. Everyday operations all qualify.

**`intermediate`** — Vocabulary is known; do not re-define repo, commit, package,
port, server. Teach the model underneath: what the machine did, where state lives,
why the abstraction leaks. Routine commands qualify only when this run was
instructive.

**`advanced`** — Daily fluency assumed. Routine operations earn nothing. Only
non-obvious tradeoffs, surprising failure causes, and internals that explain observed
behavior. Most sessions produce no note; that is success, not omission.

## Handling level changes mid-session

"This is too basic", "I know this already", "explain it deeper" — treat as a level
change for the rest of the session. Acknowledge in a few words, do not re-explain
what was already said, and do not offer to write to settings unless asked. To make it
stick across sessions, that is `/teach level <level>`.

"I already know packages" is narrower: drop that concept for the session, keep the
level where it is.

## Commands

- `/teach` — explain again, deeper, or teach something that has not come up
- `/teach-level [beginner|intermediate|advanced]` — set or report the dial
- `/teach-off` — silence for this session
- `/teach-install` — register the plugin in the current repo so cloud sessions load it
