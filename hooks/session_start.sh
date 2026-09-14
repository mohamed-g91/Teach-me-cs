#!/bin/bash
# teach-me-cs SessionStart hook.
#
# Injects the teaching contract into the session, pitched at $TEACH_LEVEL.
# Deliberately does NOT inline the curriculum: per-session cost stays near zero,
# and the reference files are read only when a note is actually due.
#
# This hook must never block a session. Every failure path exits 0 quietly.

set -uo pipefail

ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
CONTRACT="$ROOT/hooks/contract.md"

# No contract file means nothing to inject. Start the session normally.
[ -r "$CONTRACT" ] || exit 0

# Normalize the level. Anything unrecognized falls back to beginner.
LEVEL="$(printf '%s' "${TEACH_LEVEL:-beginner}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
case "$LEVEL" in
  beginner|intermediate|advanced) ;;
  beg)  LEVEL="beginner" ;;
  int)  LEVEL="intermediate" ;;
  adv|expert) LEVEL="advanced" ;;
  off|none|disabled) exit 0 ;;
  *) LEVEL="beginner" ;;
esac

case "$LEVEL" in
  beginner)
    CAP="3"
    read -r -d '' RULES <<'EOF'
Assume no prior knowledge at all, not even what a file or a folder is. Lead with an
analogy from ordinary life, then name the real term. Never explain one piece of jargon
using another piece of jargon.

Everyday operations are all worth a note here: cloning a repo, installing packages,
starting a server, a file appearing on disk.
EOF
    ;;
  intermediate)
    CAP="2"
    read -r -d '' RULES <<'EOF'
Assume the vocabulary is already known: repo, commit, push, package, port, server,
environment. Do not re-define those terms.

Teach the model underneath instead: what the machine actually did, where state lives,
why the abstraction leaks. Routine commands earn a note only when something about this
particular run is instructive.
EOF
    ;;
  advanced)
    CAP="1"
    read -r -d '' RULES <<'EOF'
Assume daily fluency with the tools. Routine operations earn nothing at all: `git clone`
and `npm install` are invisible at this level.

Write only when this session hit something genuinely non-obvious: a tradeoff with a
hidden cost, a failure mode with a surprising cause, or an internal detail that explains
behavior the user just observed.

Most sessions at this level should produce no note. That is the expected outcome, not a
failure to do the job.
EOF
    ;;
esac

# Substitute placeholders, then JSON-escape.
# sed/awk only, so this works anywhere bash does (no python/jq dependency).
CONTEXT="$(
  awk -v lvl="$LEVEL" -v cap="$CAP" -v root="$ROOT" -v rules="$RULES" '
    { gsub(/\{\{LEVEL_RULES\}\}/, rules)
      gsub(/\{\{LEVEL\}\}/, lvl)
      gsub(/\{\{CAP\}\}/, cap)
      gsub(/\{\{ROOT\}\}/, root)
      print }
  ' "$CONTRACT" \
  | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\t/\\t/g' -e 's/\r//g' \
  | awk '{ printf "%s\\n", $0 }'
)" || exit 0

# An empty substitution means something went wrong upstream. Stay quiet.
[ -n "$CONTEXT" ] || exit 0

printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$CONTEXT"
exit 0
