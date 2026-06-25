#!/usr/bin/env bash
#
# generate-changelog.sh — generate a Keep a Changelog entry from commits
# since the last tag, using Claude Code headless (`claude -p`).
#
# Usage:
#   ./generate-changelog.sh            # print the entry to stdout
#   ./generate-changelog.sh > NEW.md   # capture it
#
# This is the changelog/release-notes recipe from the SDLC playbook
# (section 5, "CI/CD & Automated SDLC Tooling"). It is intentionally
# bounded and read-only so it is safe to run in CI on a tag push.
#
# Guardrails baked in:
#   - wall-clock `timeout` so a stuck run can't hang a pipeline
#   - read-only tools only (no Edit/Write/Bash) — Claude just summarizes
#     the diff we pipe in; it never touches the working tree
#   - `--max-turns` cap so it can't loop
#   - routed to Sonnet — summarizing a diff is routine work, not planning
#
# Requirements: `claude` CLI on PATH and authenticated (ANTHROPIC_API_KEY
# or a logged-in session), plus `git` and GNU `timeout` (`gtimeout` on
# macOS via coreutils).

set -euo pipefail

# --- config (override via env) ----------------------------------------------
TIMEOUT="${CHANGELOG_TIMEOUT:-180}"      # seconds of wall clock
MAX_TURNS="${CHANGELOG_MAX_TURNS:-3}"    # Claude turns; summarizing needs few
MODEL="${CHANGELOG_MODEL:-sonnet}"       # routine work -> cheaper model

# Pick a `timeout` binary (GNU coreutils ships `gtimeout` on macOS/Homebrew).
if command -v timeout >/dev/null 2>&1; then
  TIMEOUT_BIN="timeout"
elif command -v gtimeout >/dev/null 2>&1; then
  TIMEOUT_BIN="gtimeout"
else
  echo "error: need GNU 'timeout' (brew install coreutils for 'gtimeout')" >&2
  exit 1
fi

# --- gather input -----------------------------------------------------------
# Most recent tag; if the repo has no tags, fall back to the root commit so
# the script still works on a fresh project.
if LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null); then
  RANGE="${LAST_TAG}..HEAD"
  SINCE="$LAST_TAG"
else
  RANGE="$(git rev-list --max-parents=0 HEAD | tail -n1)..HEAD"
  SINCE="the beginning of the project"
fi

# Subject lines are usually enough signal for a changelog and keep the
# prompt small. Swap in `--pretty=format:"%s%n%b"` if you want bodies too.
COMMITS=$(git log "$RANGE" --pretty=format:"- %s")

if [ -z "$COMMITS" ]; then
  echo "No commits since ${SINCE}; nothing to changelog." >&2
  exit 0
fi

# --- run --------------------------------------------------------------------
# We pipe the commit list in on stdin and let Claude shape it into a single
# changelog section. `--allowedTools ""` would also work; we pass an empty
# read-only set explicitly so intent is obvious. No write tools are granted.
printf '%s\n' "$COMMITS" | "$TIMEOUT_BIN" "$TIMEOUT" \
  claude -p \
    --model "$MODEL" \
    --max-turns "$MAX_TURNS" \
    --allowedTools "Read,Grep,Glob" \
    "You are writing a release changelog. The commit subjects since ${SINCE} \
are on stdin. Produce ONE Keep a Changelog (keepachangelog.com) entry: a \
'## [Unreleased]' heading followed by only the relevant '### Added', \
'### Changed', '### Fixed', '### Removed' subsections (omit empty ones). \
Rewrite terse commit messages into clear, user-facing bullet points. Output \
Markdown only — no preamble, no code fences."

# NOTE: verify flag names against your installed `claude -p` version
# (`claude -p --help`). The headless flag surface moves fast; `--allowedTools`,
# `--max-turns`, and `--model` are the stable ones used here.
