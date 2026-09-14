# Curriculum

A lookup table, **not a syllabus**. Nothing marches through this in order. Find the
concept the trigger table pointed at, take the body for the current level, adapt it to
what actually happened in the session.

Concepts are **tiered**: many have no `A` body (too basic to ever be worth an advanced
note) and some have no `B` body (meaningless without foundations). A missing body means
that concept is not taught at that level.

---

## 1. Machines and places

### file
- **B** — A file is a named lump of information on a disk. The name is how you find it
  again; everything else about it (that it is a photo, a program, a list of packages) is
  a convention about what is inside, not a property of the file itself.
- **I** — A path plus bytes plus metadata. The extension is a hint to humans and tooling,
  not enforcement.
- **Misconception:** that the extension makes it that kind of file. Renaming `.png` to
  `.txt` changes nothing about the bytes.
- **Connects to:** filesystem, path.

### filesystem / directory / path
- **B** — Folders inside folders, all the way down to one starting point. A *path* is
  the list of turns you take to reach a file: `/home/user/project/README.md` means start
  at the very top, then `home`, then `user`, then `project`.
- **I** — Absolute paths start at root and mean the same thing from anywhere. Relative
  paths start wherever the program happens to be, which is why the same command works in
  one directory and fails in another.
- **Misconception:** that "the Desktop" is a place in the computer rather than just
  another folder with a picture drawn around it.
- **Connects to:** working directory, PATH.

### local vs remote machine
- **B** — Your laptop is one computer. A cloud session is a *different* computer, in a
  data center somewhere, that you are sending instructions to. They share nothing: not
  files, not installed programs, not settings. Everything the remote one knows, it had
  to be given.
- **I** — The boundary is the source of most "but it works on my machine" confusion.
  Anything not committed, declared in a manifest, or set as an environment variable does
  not cross it.
- **Connects to:** container, ephemeral, environment parity.

### container
- **B** — A container is a fresh, empty computer created on demand to do one job, then
  thrown away. Think of a rented workshop: it comes with standard tools, you bring your
  materials, and when you leave it is wiped for the next person.
- **I** — An isolated process tree with its own filesystem view, built from a layered
  image. Reproducibility is the point: it starts identical every time.
- **A** — Layer caching decides your build time. An instruction that changes invalidates
  every layer after it, so ordering a Dockerfile badly (copying source before installing
  dependencies) turns a 5-second build into a 5-minute one.
- **Connects to:** ephemeral, image, environment parity.

### ephemeral vs persistent
- **B** — Ephemeral means it disappears. A cloud session's disk exists while the session
  runs and is gone afterwards. If something should outlive the session, it has to be
  pushed somewhere that persists — a git remote, a database, cloud storage.
- **I** — The practical rule: *committed and pushed* is the only durable state in an
  ephemeral environment. Everything else is scratch.
- **Connects to:** container, git remote, why-packages-do-not-travel.

---

## 2. The terminal

### shell / command / arguments / flags
- **B** — The terminal is typing instructions instead of clicking them. A command is the
  program's name, followed by things you hand it. `git clone <url>` is: run `git`, do the
  `clone` job, on that address. Words starting with `-` or `--` are *flags* — switches
  that change how it behaves.
- **I** — The shell expands, splits and quotes before the program ever sees its
  arguments, which is why unquoted paths with spaces break.
- **Connects to:** process, exit code.

### stdout / stderr / pipes
- **B** — Programs have two output channels: normal results, and errors. Keeping them
  separate means you can save the results to a file while still seeing the errors on
  screen. The `|` symbol pipes one program's output straight into the next one's input.
- **I** — This separation is what makes small tools composable; it is the core Unix idea.
- **Connects to:** exit code, composition.

### exit code
- **B** — Every command finishes with a number. Zero means it worked; anything else means
  it failed. That number is how other programs — and CI — know whether to continue.
- **I** — Why `set -e`, `&&` and CI gates work at all. A script that ignores exit codes
  reports success while doing nothing.
- **Connects to:** CI, error output.

### process
- **B** — A program that is currently running. Starting one gives it memory and a slice of
  the processor; Ctrl-C asks it to stop. A program on disk is inert until it becomes a
  process.
- **I** — Processes own their resources, including open ports — which is the real reason
  a port stays occupied after a crash.
- **Connects to:** port, signals.

---

## 3. Git

### repo
- **B** — A repository is a project folder that quietly records every change ever made to
  it. Not just the current version of each file, but every version, with who changed it
  and when. That recording is the entire difference between a repo and an ordinary folder.
- **I** — A working tree plus a `.git` directory containing an object database and refs.
  The history is content-addressed: identical content is stored once.
- **Connects to:** commit, history, clone.

### commit
- **B** — A save point you chose to make, with a note explaining why. Unlike autosave, you
  decide when one happens and what goes in it — which is what makes the history readable
  later.
- **I** — An immutable snapshot of the whole tree, plus parent pointers. Not a diff; the
  diff is computed for display.
- **A** — Immutability is why rebase and amend create *new* objects rather than editing
  old ones, and why the old ones survive in the reflog.
- **Misconception:** that a commit stores changes. It stores a complete snapshot.
- **Connects to:** history, branch, reflog.

### clone
- **B** — Cloning downloads a copy of a repo onto this machine — the files *and* the
  entire history. That copy is independent: your edits live only here until you push
  them back.
- **I** — Also creates remote-tracking refs (`origin/main`) and a default upstream.
- **A** — `--depth=1` omits ancestry, which breaks `git describe`, `git log` beyond the
  cut, and bisect. `--filter=blob:none` gets similar speed with full history: commits and
  trees arrive, file contents load lazily.
- **Connects to:** remote, remote-tracking branch.

### remote / remote-tracking branch
- **B** — A remote is another copy of the repo somewhere else, usually on GitHub. `push`
  sends your commits there; `pull` brings theirs here. Until you push, your work exists on
  exactly one computer.
- **I** — `origin/main` is a *local bookmark* of where the remote's `main` was the last
  time you talked to it. It does not update on its own. That is why `git status` can say
  "up to date" when it is not: it compares you against a stale bookmark, not against
  GitHub. `git fetch` refreshes the bookmark; `git pull` is fetch plus merge.
- **Connects to:** push/pull, sync.

### branch / HEAD
- **B** — A branch lets two versions of the project exist at once, so you can try
  something without disturbing the working version. Switching branches swaps the files in
  your folder.
- **I** — A branch is a movable pointer to a commit; HEAD is a pointer to the branch you
  are on. Detached HEAD just means HEAD points at a commit directly. Nothing is lost —
  the reflog keeps unreferenced commits for about 90 days.
- **Connects to:** merge, reflog.

### merge / conflict
- **B** — Merging combines two lines of work. When both changed the same lines, git stops
  and asks rather than guessing — that is a conflict. The markers in the file show both
  versions; you pick the right result and commit.
- **I** — Three-way merge against the common ancestor. Conflicts are a refusal to
  silently lose one side.
- **Connects to:** branch, rebase.

### rewriting history
- **I** — Amend, rebase and force-push replace commits with new objects. On a shared
  branch this invalidates everyone else's checkout, which is why merging is the polite
  default on branches other people have.
- **A** — `--force-with-lease` at minimum: it refuses when the remote moved since you
  last looked.
- **Connects to:** immutability, reflog.

---

## 4. GitHub and collaboration

### hosting / pull request / review
- **B** — GitHub stores a copy of the repo that everyone can reach. A pull request is a
  proposal: "here are my commits, please look before they join the main version." It is
  how changes get discussed instead of imposed.
- **I** — A PR is a branch comparison plus a review and gating surface. The merge is the
  cheap part; the review and CI are the point.
- **Connects to:** CI, branch, review.

---

## 5. Packages and dependencies

### package / library / registry
- **B** — A package is code someone else wrote and published so you do not have to write
  it. A registry (npm, PyPI) is the shared warehouse they publish to. `npm install`
  fetches from that warehouse into your project.
- **I** — Publishing is a social contract: versioned, named, and resolvable. The registry
  is also a supply-chain surface.
- **Connects to:** dependency, lockfile, install location.

### dependency / transitive dependency
- **B** — Your project depends on a package; that package depends on others; those depend
  on more. That is why installing four things can download four hundred. Each one is
  someone else's work that yours now leans on.
- **I** — The dependency graph is resolved, flattened where possible, and deduplicated.
  Its depth is your real attack and breakage surface.
- **Connects to:** semver, lockfile.

### install location (`node_modules`, `.venv`, `site-packages`)
- **B** — The code landed in a *folder inside your project*, not "in the computer". Open
  `node_modules` and it is all just files. That folder is why the project works — and why
  copying the project without it gives you something broken.
- **I** — Project-local installation is deliberate: two projects can use two versions of
  the same library without a fight. Global installs give that up.
- **Connects to:** environment, why-packages-do-not-travel.

### why packages do not travel between machines ★
*The highest-value concept in this curriculum for this user. Fires at every level.*
- **B** — Installing put hundreds of folders on *that* machine's disk. A cloud session is
  a different computer with an empty disk, so it has to install them again. Nothing about
  your laptop is visible to it. What travels is the *list* (`package.json`,
  `requirements.txt`) — the recipe, not the meal.
- **I** — This is why manifests and lockfiles exist: the environment is reconstructed from
  a declaration, not copied. Anything not declared does not survive the boundary, which is
  the root of most "works on my machine" failures.
- **A** — The residue is what bites: global installs, shell rc files, OS-level libraries,
  and platform-specific binaries that a lockfile pins by version but not by architecture.
- **Connects to:** container, ephemeral, environment parity, lockfile.

### lockfile
- **B** — The manifest says "any version 4.x of this library". The lockfile records
  exactly which one you actually got, so the next install is identical instead of merely
  similar.
- **I** — Reproducibility across machines and across time. It is why CI can install the
  same tree you did six months from now, and why it belongs in git.
- **A** — Lockfiles pin versions, not platforms. Native modules and optional
  platform-specific dependencies can still diverge across architectures.
- **Connects to:** semver, reproducibility.

### semver and version ranges
- **I** — `MAJOR.MINOR.PATCH`: major breaks, minor adds, patch fixes. `^4.2.0` means "any
  4.x at or above this" — a promise the publisher may not keep, which is the gap a
  lockfile closes.
- **Connects to:** lockfile, dependency resolution.

---

## 6. Environments and config

### environment variable
- **B** — A named value handed to a program when it starts, from outside the program. It
  is how the same code behaves differently in two places — pointing at a test database
  here and the real one in production — without editing the code.
- **I** — Process-scoped and inherited by children. Not secret by virtue of being an env
  var; just out of the source tree.
- **Connects to:** secrets, config, PATH.

### secrets
- **B·I·A** — API keys and passwords must never be committed. Git remembers everything, so
  a key pushed once is exposed even after deletion — the fix is always to rotate it, never
  just to delete the line. Keep them in environment variables or a secret manager.
- **Connects to:** environment variable, git immutability.

### PATH
- **I** — An ordered list of directories the shell searches for a command name. First
  match wins, which is why the wrong version of a tool can run silently after an install.
  `which <cmd>` shows what actually resolves.
- **Connects to:** install location, shell.

### environment parity ★
- **B** — "It works on my machine" happens because your machine accumulated things you
  forgot about: a tool installed last year, a variable set in a config file, a file never
  committed. The other machine has none of that.
- **I** — CI is deliberately a clean machine so this gets caught early. A green local run
  and a red CI run is CI being right.
- **A** — Remaining divergence sources once containers are in play: base image drift,
  build-time vs run-time env, cached layers, and architecture differences.
- **Connects to:** container, why-packages-do-not-travel, CI.

---

## 7. Networks and servers

### localhost / port
- **B** — Starting a server makes your computer serve web pages to *itself*. `localhost`
  means this machine; the port number (3000, 8080) is which doorway to knock on, since one
  machine can run many servers at once. Nobody else on the internet can reach it.
- **I** — A port is held exclusively by one process. `EADDRINUSE` means another process
  still owns it — often a previous run that did not exit.
- **Connects to:** process, client-server.

### client / server / request / response
- **B** — One program asks, another answers. The browser is a client; it sends a request
  ("give me this page") and the server sends a response. Everything on the web is that
  loop, repeated.
- **I** — Stateless by default: each request carries its own context, which is why
  sessions, cookies and tokens exist.
- **Connects to:** HTTP, API.

### HTTP / API / JSON
- **B** — An API is a way for programs to ask other programs for things, the way a browser
  asks for pages. The answer usually comes back as JSON: text arranged in labeled
  key-value pairs that programs can read reliably.
- **I** — Methods, status codes and headers form the contract. `401` vs `403` is "who are
  you" vs "I know who you are and no".
- **Connects to:** client-server, data format.

### DNS
- **B** — Computers find each other by number, but people use names. DNS is the phone book
  that turns `github.com` into an address.
- **Connects to:** networking, timeouts.

---

## 8. Code and runtimes

### source / interpreter / compiler / runtime
- **B** — Source code is text a human wrote. Something has to turn it into instructions the
  machine runs: an *interpreter* reads and runs it line by line (Python, JavaScript), a
  *compiler* translates the whole thing up front into a file you run later (Rust, Go).
- **I** — The tradeoff is when errors surface and what ships. Compiled languages catch
  whole classes of error before running; interpreted ones find them at the moment the line
  executes.
- **Connects to:** build, artifact.

### build / artifact
- **B** — A build turns the code you wrote into the thing that actually runs or ships —
  bundled, minified, compiled. The output is separate from the source, which is why build
  folders are not committed: they can always be regenerated.
- **Connects to:** compile, deploy.

---

## 9. Data and state

### files vs database
- **B** — Files are fine until many things need to read and write at once, or you need to
  ask questions like "everyone who signed up last week". A database is built for
  concurrent access and querying.
- **I** — Guarantees are the real difference: transactions, constraints, indexes.
- **Connects to:** persistence, query.

### persistence
- **B** — Data survives the program stopping. Memory does not: close the process and it is
  gone. Writing to a file or database is what makes it last — and in an ephemeral
  container, even files are not enough.
- **Connects to:** ephemeral, database.

---

## 10. Ship and verify

### test / assertion / regression
- **B** — A test is code that checks other code still does what it should. Its value is
  not proving it works today; it is catching the day a change quietly breaks something
  that used to work. That break is a *regression*.
- **Connects to:** CI, exit code.

### CI / CD
- **B** — Continuous integration is a robot that re-runs your tests on a clean machine
  every time you propose a change. It catches what your machine hides.
- **I** — The gate is exit codes. CD extends it to deploying automatically once the gate
  is green.
- **Connects to:** environment parity, exit code.

---

## 11. AI agents and tools

*The system the user is literally inside. Unusually motivating — these concepts explain
the thing on their screen right now.*

### skill / plugin
- **B** — A skill is a set of instructions Claude loads when a task matches it, so it does
  not have to be told the same thing every time. A plugin bundles skills, commands and
  hooks so they install together. This teaching feature is exactly that.
- **I** — Skills load on description match, which is why always-on behavior needs a hook
  instead.
- **Connects to:** hook, context window.

### MCP
- **B** — MCP is a standard way for Claude to reach other systems — GitHub, Notion, a
  database — by speaking a shared protocol instead of a custom integration per service.
- **I** — A server advertises tools; the client decides which to expose. Connection
  failures are the server or transport, not a missing capability.
- **Connects to:** tools, permissions.

### context window / tokens
- **I** — The model sees a bounded amount of text at once, measured in tokens. When a
  conversation exceeds it, earlier parts get summarized — which is why a long session
  "forgets" specifics from the beginning.
- **A** — Cache boundaries and summarization points determine both cost and what survives
  compaction.
- **Connects to:** compaction, cost.

### hook
- **I** — Code the harness runs at a lifecycle point (session start, before a tool call).
  Deterministic: it executes whether or not the model decides anything. That is precisely
  why always-on behavior lives in a hook rather than an instruction.
- **Connects to:** skill, automation.

### permissions / sandbox
- **B** — Claude asks before doing things that change your system or reach outside it. The
  prompt exists so that reading and writing are different decisions, and you stay the one
  making them.
- **Connects to:** secrets, least privilege.
