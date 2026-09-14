---
description: Register teach-me-cs in the current repo so cloud and remote sessions load it too
argument-hint: "[beginner|intermediate|advanced]"
allowed-tools: Read, Edit, Write, Bash(git rev-parse:*)
---

Cloud and remote sessions start from a clean container and cannot see the user's local
plugin installation. This writes the registration into the repo so those sessions load
it from the clone.

**Steps:**

1. Find the repo root with `git rev-parse --show-toplevel`. If there is no repo, say so
   and stop — there is nothing to write into.

2. Read `<root>/.claude/settings.json` if it exists. **Merge; never overwrite.** Preserve
   every existing key. If the file exists but is not valid JSON, change nothing and say so.

3. Ensure these keys, leaving everything else untouched:

```json
{
  "extraKnownMarketplaces": {
    "teach-me-cs": {
      "source": {
        "source": "github",
        "repo": "mohamed-g91/teach-me-cs"
      }
    }
  },
  "enabledPlugins": {
    "teach-me-cs@teach-me-cs": true
  },
  "env": {
    "TEACH_LEVEL": "beginner"
  }
}
```

   Use the level from `$ARGUMENTS` if given. If not given and `TEACH_LEVEL` is already
   set in the file, leave it alone. Otherwise default to `beginner`.

4. Tell the user, in three lines:
   - which file was written or updated, and whether it was created or merged
   - the level it is set to
   - that it takes effect for cloud sessions **once committed and pushed**, since a cloud
     session reads the repo as cloned

Do not commit or push. That is the user's call.

If `.claude/settings.json` is gitignored in this repo, say so — the registration will not
reach cloud sessions until that is resolved.
