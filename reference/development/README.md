# Development: the local Claude Code loop

This bundle is the **development** phase of the [reference workflow](../README.md): take the issues produced in [ideation](../ideation/) and build them, test-first, in a controlled local loop.

It gives you three copy-paste artifacts plus a map of which skills drive which part of the loop. Drop the artifacts into your repo and you have a working local Claude Code setup: lean project memory, layered permissions, and a formatter that runs after every edit.

## The loop: explore → plan → code → verify

Anthropic's core agentic pattern is **explore → plan → code → verify**, and the single most important habit is *context management plus verification* — keep memory lean, plan before coding, and always give Claude a check it can run. The skills in this repo each own a stage of that loop:

| Stage | What you do | Skill | Why it fits here |
| ----- | ----------- | ----- | ---------------- |
| **Explore** | Understand the code and the question before committing to an approach. For an open design question, build throwaway code to get an answer. | [`prototype`](../../skills/engineering/prototype/SKILL.md) | A prototype is *throwaway code that answers a question* — a runnable terminal app for a state/logic question, or several toggleable UI variations. You explore the design, capture the answer, then delete the prototype. |
| **Plan** | Turn the issue into a sequence of behaviors and seams before writing real code. | [`tdd`](../../skills/engineering/tdd/SKILL.md) (Planning step) + [`implement`](../../skills/engineering/implement/SKILL.md) | `implement` reads the PRD/issues and plans the work, deferring to `tdd` at pre-agreed seams. `tdd`'s planning step pins down the public interface and the prioritized list of behaviors *before* any code. |
| **Code** | Build it one vertical slice at a time, test-first. | [`tdd`](../../skills/engineering/tdd/SKILL.md) | Red → green → refactor, **one vertical slice at a time** (one test → one implementation → repeat). Tests are an external oracle that stays accurate as context fills — the strongest agentic pattern there is. |
| **Verify** | Confirm it works; when something is broken or slow, diagnose it rigorously. | [`tdd`](../../skills/engineering/tdd/SKILL.md) (suite + refactor) + [`diagnosing-bugs`](../../skills/engineering/diagnosing-bugs/SKILL.md) | The passing suite is the first verification gate. When a hard or slow bug shows up, `diagnosing-bugs` builds a tight, red-capable feedback loop *first* and refuses to hypothesize without one. |

The `implement` skill is the orchestrator for a known piece of work: it reads the issues, uses `tdd` at the seams, typechecks and runs single test files as it goes, runs the full suite once at the end, then reviews and commits. `prototype` and `diagnosing-bugs` are the two off-ramps — reach for `prototype` when the *design* is uncertain, and `diagnosing-bugs` when something is *broken or slow*.

```
issue ──► explore ──────► plan ──────► code ──────► verify ──► commit
            │               │            │            │
        prototype      tdd (plan) +    tdd         tdd (suite)
        (if design     implement    (red-green-    + diagnosing-bugs
         unclear)                    refactor)      (if broken/slow)
```

## What's in this bundle

| File | What it is |
| ---- | ---------- |
| [`CLAUDE.md.template`](./CLAUDE.md.template) | A lean project-memory template — placeholders for build/test/lint commands, layout, conventions Claude can't infer (commit format, branch naming), and known traps. |
| [`settings.json.example`](./settings.json.example) | A `.claude/settings.json` example with layered permissions (allow / ask / deny) plus the PostToolUse hook wiring. |
| [`hooks/format-on-edit.sh`](./hooks/format-on-edit.sh) | A PostToolUse hook that formats (and optionally lints) the file Claude just edited. |

## Install

From the root of your own repo:

1. **Project memory.** Copy the template to your repo root and fill it in:
   ```bash
   cp path/to/reference/development/CLAUDE.md.template ./CLAUDE.md
   ```
   Then trim it. The rule for every line is: *"If removing this line wouldn't cause a mistake, remove it."* Aim for well under ~150 lines. You can generate a starter with Claude Code's `/init` and merge it in. (For cross-tool portability you can symlink `AGENTS.md` → `CLAUDE.md`.)

2. **Settings + permissions.** Copy the example into `.claude/`:
   ```bash
   mkdir -p .claude
   cp path/to/reference/development/settings.json.example .claude/settings.json
   ```
   Edit the `allow` / `ask` / `deny` lists for your stack. The shape: auto-allow read-only commands like `git status`, **ask** before `git push` / `git commit`, and **deny** reading `.env` and `secrets/`. `deny` always wins over `allow`. The `//`-prefixed keys are explanatory comments — delete them if your tooling validates JSON strictly.

3. **Format-on-edit hook.** Copy the script and make it executable:
   ```bash
   mkdir -p .claude/hooks
   cp path/to/reference/development/hooks/format-on-edit.sh .claude/hooks/
   chmod +x .claude/hooks/format-on-edit.sh
   ```
   The hook is already wired in `settings.json.example` under `hooks.PostToolUse` with `matcher: "Edit|Write|MultiEdit"`. Edit the formatter branches in the script for your language. It reads the edited file path from the tool payload on **stdin** (`.tool_input.file_path`, via `jq`), so install `jq` too. Running formatting/linting as a hook means it happens **every** time (deterministic), instead of relying on Claude to remember — and lint errors get fixed inside the loop instead of failing in CI.

4. **Install the skills.** This bundle leans on `prototype`, `implement`, `tdd`, and `diagnosing-bugs` from this repo's `engineering/` bucket. Install the marketplace plugin (see the repo [README](../../README.md)), then in a session just describe the work — `tdd` and `diagnosing-bugs` activate on their own, and `implement` / `prototype` are user-invoked (`/implement`, `/prototype`).

## Using it

A typical slice, end to end:

1. Pick up an issue. If the *design* is unclear, run `/prototype` to answer the open question, capture the answer, and throw the prototype away.
2. Run `/implement` against the issue. It plans, then drops into `tdd` at the seams — one failing test, minimal code to pass, repeat.
3. The format-on-edit hook tidies each file as Claude writes it; your `deny` rules keep it out of `.env` and secrets the whole time.
4. The full suite runs at the end. If something is broken or slow, switch to `diagnosing-bugs` — build a tight red-capable repro before theorizing.
5. `/clear` between unrelated tasks to keep the context window clean.

> A note on accuracy: the `settings.json` and hook field names here follow the current Claude Code schema (`permissions.allow/ask/deny`, `hooks.PostToolUse[].matcher`, `type: "command"`, stdin payload with `.tool_input.file_path`). Claude Code ships often — if a field doesn't behave as documented here, verify against [the settings docs](https://code.claude.com/docs/en/settings) and [the hooks docs](https://code.claude.com/docs/en/hooks).
