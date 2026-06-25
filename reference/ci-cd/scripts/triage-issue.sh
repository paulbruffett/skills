#!/usr/bin/env bash
#
# triage-issue.sh — triage a single GitHub issue with Claude Code headless.
#
# Reads an issue, suggests labels, a priority, and (optionally) applies
# labels via `gh`. Routine classification work, so it is routed to Sonnet
# with a low turn cap and a wall-clock timeout — the cost/determinism
# guardrails from section 5 of the SDLC playbook.
#
# Usage:
#   ./triage-issue.sh <issue-number>            # dry run: print suggestion
#   APPLY=1 ./triage-issue.sh <issue-number>    # also apply labels with gh
#
# Requirements: `claude` CLI (authenticated), `gh` (authenticated), and GNU
# `timeout`/`gtimeout`. Run inside the target repo.
#
# For the Actions-native equivalent, use anthropics/claude-code-action with
# `--max-turns 6 --model sonnet` on `issues: [opened]` — see
# ../workflows/scheduled-maintenance.yml header and ../README.md.

set -euo pipefail

ISSUE="${1:-}"
if [ -z "$ISSUE" ]; then
  echo "usage: $0 <issue-number>   (set APPLY=1 to write labels)" >&2
  exit 2
fi

# --- config (override via env) ----------------------------------------------
TIMEOUT="${TRIAGE_TIMEOUT:-120}"     # seconds of wall clock
MAX_TURNS="${TRIAGE_MAX_TURNS:-6}"   # cap from the playbook's triage recipe
MODEL="${TRIAGE_MODEL:-sonnet}"      # cheap model for labeling/triage
APPLY="${APPLY:-0}"                  # 1 = let Claude run `gh` to write labels

# Pick a `timeout` binary.
if command -v timeout >/dev/null 2>&1; then
  TIMEOUT_BIN="timeout"
elif command -v gtimeout >/dev/null 2>&1; then
  TIMEOUT_BIN="gtimeout"
else
  echo "error: need GNU 'timeout' (brew install coreutils for 'gtimeout')" >&2
  exit 1
fi

# --- gather context ---------------------------------------------------------
# Pull issue + existing label vocabulary so Claude only chooses from real
# labels instead of inventing new ones.
ISSUE_JSON=$(gh issue view "$ISSUE" --json number,title,body,labels)
LABELS=$(gh label list --limit 100 --json name --jq '[.[].name] | join(", ")')

# --- tool scoping -----------------------------------------------------------
# Dry run (default): read-only, no write access — Claude only proposes.
# APPLY=1: additionally allow exactly the one gh write command we need,
# scoped with a glob so it can edit labels but not, e.g., close issues.
if [ "$APPLY" = "1" ]; then
  ALLOWED_TOOLS="Read,Grep,Glob,Bash(gh issue edit:*),Bash(gh issue view:*),Bash(gh label list:*)"
  ACTION="After deciding, APPLY the labels by running: \
gh issue edit ${ISSUE} --add-label \"<comma,separated,labels>\". Use only \
existing labels. Then print the final label set and one-line rationale."
else
  ALLOWED_TOOLS="Read,Grep,Glob"
  ACTION="Do NOT modify anything. Print: suggested labels (from the existing \
set only), a priority (P0-P3), and a one-line rationale."
fi

# --- run --------------------------------------------------------------------
printf 'ISSUE:\n%s\n\nEXISTING LABELS: %s\n' "$ISSUE_JSON" "$LABELS" | \
  "$TIMEOUT_BIN" "$TIMEOUT" \
    claude -p \
      --model "$MODEL" \
      --max-turns "$MAX_TURNS" \
      --allowedTools "$ALLOWED_TOOLS" \
      "You are triaging a GitHub issue. The issue JSON and the list of \
labels that already exist in this repo are on stdin. Classify the issue \
(type: bug/feature/docs/question, area, and priority). ${ACTION}"

# NOTE: verify flag names against your installed `claude -p` version
# (`claude -p --help`) and the `gh` label scheme in your repo.
