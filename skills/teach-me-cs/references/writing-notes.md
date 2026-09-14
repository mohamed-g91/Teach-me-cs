# Writing notes

Read before the first note in a session. This is voice and craft; the hard rules are in
the session contract.

## The three beats

```
> 🧠 **What just happened: `git clone`**
>
> A *repo* is a project folder that quietly records every change ever made to it.
>
> Cloning downloaded GitHub's copy onto this machine — the files *and* the entire history.
>
> That copy is now independent. Your edits live only here until you `push` them back.
```

1. **What it is** — one sentence, no dependencies on other jargon.
2. **What happened here** — name the real command, file, path or error from this session.
3. **Why it matters** — the consequence, the gotcha, or the thing it connects to.

Under 70 words total, at every level. If it will not fit, the concept is too big — teach
its prerequisite instead.

## The test that matters

**Would this note read identically in someone else's session?** If yes, it has failed.
Rewrite it around what actually happened: the 40 seconds it took, the exact error text,
the 312 folders that appeared, the name of the file that changed.

Generic:
> Packages are reusable code that developers share through registries.

Grounded:
> `npm install` just put 312 folders in `node_modules/` — that is other people's code,
> downloaded into this project. You asked for 4 packages; those 4 needed 308 more.

## Analogies

A good one is concrete, ordinary, and carries the *mechanism* — not just the vibe.

| Concept | Works | Why |
|---|---|---|
| repo | a folder with a time machine attached | keeps "folder", adds the one real difference |
| container | a rented workshop, wiped after you leave | carries both isolation and ephemerality |
| lockfile | a recipe that names brands, not just ingredients | explains *why* it exists |
| port | numbered doors on one building | explains exclusivity naturally |
| PATH | the order you check your pockets in | first match wins, which is the whole point |

Avoid analogies that need their own explanation, and never stack two in one note. When
an analogy would take more words than the plain fact, use the plain fact.

## Never

- **Never explain jargon with jargon.** "A repo is a version-controlled directory tree"
  teaches nothing to someone who does not know those words.
- **Never lecture.** No "it is important to understand that", no "as you may know", no
  "let us dive into". Start at the fact.
- **Never be cute about failure.** When something broke, explain it plainly. The user is
  already frustrated; whimsy lands badly.
- **Never condescend.** Not knowing what a repo is says nothing about intelligence. Write
  the way you would explain to a smart colleague from another field.
- **Never apologize for teaching** ("sorry for the tangent"). Either the note earned its
  place or it should not have been written.
- **Never let the note outweigh the work.** If the answer is three lines and the note is
  six, the note is wrong.
- **Never end with an offer** ("want me to explain more?"). It turns a note into a prompt
  and makes silence awkward. `/teach` already exists for that.

## Bold the searchable term

Exactly one per note, the real technical name, so it can be looked up later: **remote-tracking
branch**, **transitive dependency**, **exit code**. That is the note's lasting value —
tomorrow the user can search a term they now have a memory attached to.

## Level, in one line each

- **beginner** — they have never seen this before. Analogy, then the word.
- **intermediate** — they use it daily and do not know how it works. Skip the analogy,
  explain the mechanism.
- **advanced** — they know how it works. Only write if you can tell them something that
  would surprise them.

## Worked example: one moment, three levels

The session ran `pip install -r requirements.txt` in a cloud container, and the user
asked why their local packages were not already there.

**beginner**
> 🧠 **Why your packages were not already here**
>
> A **package** is code someone else wrote that your project borrows.
>
> Installing them on your laptop put the files in a folder on *that* computer's disk.
> This cloud session is a different computer with an empty disk.
>
> What travels between them is `requirements.txt` — the shopping list, not the shopping.

**intermediate**
> 🧠 **The manifest travels; the install does not**
>
> `requirements.txt` is a **declaration**, and the environment gets reconstructed from it
> rather than copied.
>
> That is deliberate: copying an install would drag along your Python version, your OS
> libraries and whatever you globally installed in 2023.
>
> It is also why anything you did *not* declare silently vanishes at this boundary — the
> usual root cause of "works on my machine".

**advanced**
> 🧠 **What the lockfile still does not pin**
>
> Version pinning is not platform pinning. Packages with native extensions resolve to
> per-architecture wheels, so an identical `requirements.txt` produces different binaries
> on arm64 and x86_64.
>
> When a build passes locally and segfaults in CI with matching versions, that gap is
> where to look first.
