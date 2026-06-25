# CI/CD bundle — headless `claude -p` recipes & scheduled jobs

Phase 4 of the [reference workflow](../README.md). This bundle automates the
work that happens *after* a change lands: release notes, issue triage, and
recurring maintenance — all driven by Claude Code running **headless**
(`claude -p`) so it composes into Unix pipelines, CI jobs, and cron.

Copy any file here into your own repo and adjust the config at the top.

## What's inside

| File | What it does |
| ---- | ------------ |
| [`scripts/generate-changelog.sh`](./scripts/generate-changelog.sh) | Diffs commits since the last tag and emits a [Keep a Changelog](https://keepachangelog.com) entry. Read-only, Sonnet, turn-capped, `timeout`-wrapped. |
| [`scripts/triage-issue.sh`](./scripts/triage-issue.sh) | Triages one GitHub issue (type/area/priority), optionally applying labels via `gh`. Sonnet, `--max-turns 6`, `timeout`-wrapped. |
| [`workflows/scheduled-maintenance.yml`](./workflows/scheduled-maintenance.yml) | GitHub Actions cron job: weekly CVE/dependency audit that opens an issue. Also documents the Anthropic Scheduled Tasks (`/schedule`) equivalent. |

```bash
# changelog on a tag push
./scripts/generate-changelog.sh > CHANGELOG.new.md

# triage issue 42 (dry run, then apply)
./scripts/triage-issue.sh 42
APPLY=1 ./scripts/triage-issue.sh 42
```

## Hooks vs. agentic: keep deterministic work out of the agent

The professional split, in one rule:

- **Deterministic work → hooks.** Anything with a single correct answer —
  formatting, linting, blocking writes to protected files, running the test
  suite — belongs in a hook (or a plain CI step). Hooks fire ~100% of the
  time; a CLAUDE.md instruction is followed ~70% of the time. It's also
  cheaper: no tokens, no agent latency.
- **Judgment work → agentic steps.** Anything that needs reading,
  summarizing, classifying, or weighing trade-offs — "write a changelog from
  these commits," "what labels does this issue need," "is this CVE relevant"
  — is where `claude -p` earns its keep.

A good headless pipeline does the deterministic part first (lint/format/test
as normal CI steps or hooks) and only invokes Claude for the judgment slice.
If a check has a right answer, don't pay an agent to guess it.

## Approval gates: a human before merge / deploy / secret changes

None of the recipes here take an irreversible action on their own:

- The **changelog** script only writes to **stdout** — you review and commit.
- The **triage** script defaults to a **dry run**; writing labels requires
  `APPLY=1`, and even then it's scoped to `gh issue edit` only.
- The **scheduled audit** **opens an issue** — it never edits code, bumps a
  version, opens a PR, or merges.

Put a human in the loop before anything that merges, deploys, rotates a
secret, or writes to production. Have the agent *propose* (a PR, an issue, a
diff); a person *disposes*. Never put write/merge/deploy work on an unattended
cron, and never grant unbounded production write access to an agent.

## Cost & determinism guardrails

Every recipe here applies the four guardrails from the SDLC playbook so a
headless fleet can't quietly run up cost or hang a pipeline:

1. **Wall-clock `timeout`.** Every script wraps `claude` in `timeout`
   (`gtimeout` on macOS); the Actions job sets `timeout-minutes`. A stuck run
   dies instead of hanging CI.
2. **`--max-turns`.** Caps the agent loop. Summarizing a diff needs ~3 turns;
   triage ~6. Pick the smallest number that still finishes the job.
3. **Model routing.** Routine work (triage, labeling, changelog) goes to
   **Sonnet**. Reserve Opus for planning and hard reasoning, not for
   classifying issues.
4. **Scope tools, default to read-only.** `--allowedTools "Read,Grep,Glob"`
   for anything that only needs to *look*. Grant write tools narrowly and
   explicitly (e.g. `Bash(gh issue edit:*)`), never blanket `Bash` or
   `Edit`/`Write`.

Two more pipeline-level guardrails worth adding in CI:

- **Gate on `if: failure()`** so review/diagnosis jobs only spend tokens when
  a pipeline is actually broken — don't run the agent on green builds.
- **Bound concurrency** (a job `concurrency:` group or a runner cap) so a
  burst of pushes can't fan out into a swarm of paid agent runs.

## A note on flags

The headless flag surface (`claude -p --help`) and the
`anthropics/claude-code-action` inputs move fast. The flags used here —
`--allowedTools`, `--max-turns`, `--model`, `--output-format` — are the
stable ones from the playbook, but verify against your installed version
before relying on a script in production. Treat any PR/issue content the
agent reads as **untrusted** (prompt-injection risk), and never use
`pull_request_target` for autonomous runs.
