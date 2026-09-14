# Triggers: what in a session maps to what concept

Read this when a note may be due. Find the row matching what actually happened, take
the **shallowest concept** that clears the current level, pick the angle that matches
the situation.

**Fires column:** `B` beginner · `I` intermediate · `A` advanced. A row that does not
list the current level produces no note — the operation is too routine to be worth
that user's attention.

**Every row is overridden by the failure exception:** if the event was an error or
caused one, it fires at all levels and goes one notch deeper.

---

## Git and history

| Signal | Concepts (shallowest first) | Fires | Angles |
|---|---|---|---|
| `git clone` | repo → history → remote → working-copy | B·I | **first-time**: a folder that remembers every version · **slow-clone**: why size is history, not files · **cloud-ephemeral**: this copy dies with the container |
| `git commit` | commit → snapshot → message → staging | B·I | **first-commit**: a save point you can name · **why-staging**: choosing what goes in |
| `git push` / `git pull` | remote → sync → local-vs-remote | B·I | **first-push**: until now it existed only here · **rejected-push**: someone else moved first |
| `git status` says up to date but isn't | remote-tracking-branch → fetch-vs-pull | I·A | **stale-bookmark**: `origin/main` is a memory, not a live view |
| `git branch` / `git checkout` | branch → parallel-work → HEAD | B·I | **first-branch**: two versions of the truth at once |
| merge conflict | merge → conflict → resolution | B·I | **first-conflict**: git refusing to guess |
| rebase conflict, detached HEAD, lost commits | object-model → refs → reflog | I·A | **recovery**: nothing is actually lost for 90 days · **why-it-happened**: HEAD is just a pointer |
| `--depth=1`, partial clone, slow CI checkout | packfiles → shallow-clone → blob-filtering | A | **hidden-cost**: what shallow breaks (`git describe`, `git log`, bisect) |
| force push, rewritten history | immutability → rewriting → shared-history | I·A | **why-it-is-rude**: everyone else's checkout is now wrong |

## GitHub and collaboration

| Signal | Concepts | Fires | Angles |
|---|---|---|---|
| a PR is opened | hosting → pull-request → review | B·I | **first-pr**: proposing rather than imposing |
| CI checks run on a PR | CI → automation → gate | B·I | **first-ci**: a robot that re-runs your tests on someone else's machine |
| CI passes locally but fails in CI | environment-parity → clean-machine | **all** | the single most instructive failure in this whole table — go deep |
| review comments arrive | code-review → collaboration | B | **why-review-exists** |

## Packages and dependencies

| Signal | Concepts | Fires | Angles |
|---|---|---|---|
| `npm install`, `pip install`, `cargo build` | package → registry → dependency → lockfile | B·I | **fresh-install**: borrowing code other people wrote · **transitive**: why 4 packages became 400 |
| `node_modules/`, `.venv/`, `site-packages/` appears | install-location → project-local-vs-global | B·I | **where-it-went**: the code landed in a folder, not "in the computer" |
| lockfile changes or conflicts | lockfile → version-pinning → reproducibility | I·A | **why-it-exists**: same install, two different results, six months apart |
| `ModuleNotFoundError`, `command not found` after install | package → install-location → environment → PATH | **all** | **the failure angle** — installed *somewhere*, just not where this program looked |
| packages work locally, not in cloud session | container → ephemeral → local-vs-remote → install-per-machine | **all** | **the single most valuable row for this user** — go deep at every level |
| version conflict, peer dependency warning | semver → ranges → resolution | I·A | **why-ranges-exist** and what they cost |

## Machines, places and environments

| Signal | Concepts | Fires | Angles |
|---|---|---|---|
| a cloud/remote session starts | local-vs-remote → container → ephemeral | B·I | **different-computer**: this is not your laptop · **fresh-every-time**: nothing survives |
| a file is created or written | file → filesystem → path → directory | B | **what-a-file-is**: the true foundation, worth spending a note on |
| `cd`, absolute vs relative paths | path → working-directory → relative-vs-absolute | B | **where-am-i** |
| env var read or set, `.env` file | environment-variable → config → secrets | B·I | **why-not-in-code**: the same program behaving differently in two places |
| a secret or API key is involved | secrets → why-not-committed | B·I·A | fires at all levels; the security consequence is worth restating |
| `$PATH` issue, wrong binary picked up | PATH → resolution-order → shims | I·A | **why-the-wrong-one-ran** |
| container cold start, cache miss, slow build | layer-caching → image → cold-start | A | **the-tradeoff-you-did-not-price** |

## The terminal

| Signal | Concepts | Fires | Angles |
|---|---|---|---|
| any first command in a session | shell → command → arguments → flags | B | **what-a-terminal-is**: typing instructions instead of clicking them |
| a command fails with non-zero exit | exit-code → success-vs-failure → error-output | B·I | **how-programs-report-failure** |
| output piped or redirected (`\|`, `>`) | stdout → stderr → composition | B·I | **lego-bricks**: small programs bolted together |
| a long-running process, Ctrl-C, background job | process → lifecycle → signals | B·I | **what-running-means** |

## Networks and servers

| Signal | Concepts | Fires | Angles |
|---|---|---|---|
| a dev server starts on a port | localhost → port → client-server → request | B·I | **first-server**: your computer talking to itself · **not-public**: why nobody else can see it |
| `EADDRINUSE`, port already in use | port → exclusivity → process-ownership | **all** | **the failure angle**: two programs, one doorway |
| an API is called, JSON comes back | HTTP → request-response → API → JSON | B·I | **first-api**: asking another computer a question |
| a URL, DNS, a domain | DNS → name-to-address | B | **phone-book** |
| CORS error, 401, 403 | origin → auth → browser-security | I·A | **why-the-browser-refused** |
| timeout, connection refused, proxy error | network-failure-modes → where-it-broke | I·A | **which-hop-failed** |

## Code, runtimes and data

| Signal | Concepts | Fires | Angles |
|---|---|---|---|
| a script is run (`python x.py`, `node x.js`) | source → interpreter → runtime | B·I | **what-running-code-means** |
| a build or compile step | compile → source-vs-artifact → build-output | B·I | **why-a-build-exists** |
| tests run | test → assertion → regression | B·I | **why-tests-exist**: proving it still works |
| a database or query appears | persistence → table → query → schema | B·I | **files-vs-database** |
| JSON/YAML/TOML config read | data-format → serialization → config | B | **structured-text** |

## AI agents and tools (the system the user is literally inside)

| Signal | Concepts | Fires | Angles |
|---|---|---|---|
| a skill or plugin loads | skill → plugin → capability-injection | B·I | **how-this-very-feature-works** — unusually motivating; use it |
| an MCP server connects or fails | MCP → tool-protocol → external-capability | B·I | **how-claude-reaches-other-systems** |
| a permission prompt appears | permissions → sandbox → least-privilege | B·I | **why-it-asked** |
| context gets long, compaction happens | context-window → tokens → summarization | I·A | **why-it-forgot** |
| a hook fires | hook → lifecycle-event → automation | I·A | **deterministic-vs-model-driven** |

---

## Rows deliberately absent

If the session did something not in this table, that does not mean stay silent — it
means write to what actually happened, using the same three-beat format and the
current level's depth. This table exists to get prerequisite ordering and level
thresholds right, not to limit what can be explained.
