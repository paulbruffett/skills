#!/usr/bin/env bash
#
# PostToolUse hook: format (and optionally lint) the file Claude just edited.
#
# Wire it up in .claude/settings.json (see ../settings.json.example):
#
#   "hooks": {
#     "PostToolUse": [
#       {
#         "matcher": "Edit|Write|MultiEdit",
#         "hooks": [
#           {
#             "type": "command",
#             "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/format-on-edit.sh",
#             "timeout": 60
#           }
#         ]
#       }
#     ]
#   }
#
# How Claude Code talks to this hook:
#   - The tool-call payload arrives as JSON on STDIN (NOT as env vars).
#     The edited file path is at .tool_input.file_path.
#   - CLAUDE_PROJECT_DIR is exported into the hook's environment.
#   - Exit 0 = success. Exit 2 = blocking error: stderr is fed back to Claude
#     so it can fix the problem. Any other non-zero = non-blocking warning.
#
# Requires `jq` to parse stdin. Install it (brew install jq / apt install jq) or
# swap in your own JSON parser.
#
# Adapt the formatter/linter section to YOUR stack — the prettier/eslint calls
# below are an example for a JS/TS repo.

set -euo pipefail

# --- read the edited file path off stdin -------------------------------------
payload="$(cat)"

if ! command -v jq >/dev/null 2>&1; then
  echo "format-on-edit: jq not found; skipping (install jq to enable this hook)" >&2
  exit 0
fi

file="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')"

# Nothing to do if the tool didn't touch a concrete file.
[ -n "$file" ] || exit 0
[ -f "$file" ] || exit 0

# --- pick a formatter by extension -------------------------------------------
# Replace these branches with whatever your project uses.
case "$file" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css|*.md)
    if command -v prettier >/dev/null 2>&1; then
      prettier --write "$file" >/dev/null 2>&1 || true
    fi
    ;;
  *.py)
    if command -v ruff >/dev/null 2>&1; then
      ruff format "$file" >/dev/null 2>&1 || true
    elif command -v black >/dev/null 2>&1; then
      black --quiet "$file" >/dev/null 2>&1 || true
    fi
    ;;
  *.go)
    command -v gofmt >/dev/null 2>&1 && gofmt -w "$file" || true
    ;;
  *.rs)
    command -v rustfmt >/dev/null 2>&1 && rustfmt "$file" 2>/dev/null || true
    ;;
  *)
    # Not a file type we format — done.
    exit 0
    ;;
esac

# --- optional: lint and block on failure -------------------------------------
# If the linter finds problems, exit 2 with the output on stderr. Claude Code
# feeds stderr back to Claude, which then fixes the issue itself — so lint
# errors get fixed in the loop instead of failing in CI.
#
# Uncomment and adapt for your stack:
#
# case "$file" in
#   *.ts|*.tsx|*.js|*.jsx)
#     if command -v eslint >/dev/null 2>&1; then
#       if ! lint_out="$(eslint "$file" 2>&1)"; then
#         echo "Lint failed for $file:" >&2
#         echo "$lint_out" >&2
#         exit 2
#       fi
#     fi
#     ;;
# esac

exit 0
