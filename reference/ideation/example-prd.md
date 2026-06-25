# PRD: `lint --watch` mode

> **Illustrative example.** This is the shape `/to-prd` would publish to the project issue
> tracker (with the `ready-for-agent` triage label) after a `/grill-me` session about the
> sample feature. It follows the `to-prd` template. The decisions below stand in for what a real
> grilling session would settle — treat them as a plausible example, not prescriptions.

## Problem Statement

When I'm fixing lint errors, I run the `lint` CLI, read the output, edit a file, and run it
again — over and over. Re-running by hand breaks my flow and wastes time, especially on large
repos where a full run is slow and I'm only iterating on one or two files.

## Solution

A `--watch` flag on the `lint` command. With it, the CLI runs once, then stays alive and
re-lints automatically whenever a tracked source file changes, printing fresh results each time.
I leave it running in a terminal pane and just keep editing; I stop it with Ctrl-C.

## User Stories

1. As a developer, I want `lint --watch` to run the linter once on startup, so that I see the
   current state immediately without an extra command.
2. As a developer, I want the linter to re-run automatically when I save a tracked source file,
   so that I don't have to re-invoke it by hand.
3. As a developer, I want rapid successive saves to be debounced into a single re-run, so that a
   "save all" doesn't trigger a storm of redundant runs.
4. As a developer, I want only tracked source files to trigger re-runs, so that build output,
   logs, and `.git` churn don't cause spurious runs.
5. As a developer, I want each re-run to clearly delimit its output from the previous run, so
   that I can tell old results from new at a glance.
6. As a developer, I want a one-line summary (error/warning counts, elapsed time) after each run,
   so that I can see progress without re-reading the whole output.
7. As a developer, I want a change that lands while a run is in flight to queue exactly one
   follow-up run, so that I always end on results that reflect the latest files.
8. As a developer, I want to stop watch mode with Ctrl-C and get a clean exit, so that I don't
   leave orphaned watchers behind.
9. As a developer, I want `--watch` to compose with the existing path/config flags, so that I can
   watch a subset of the repo the same way I'd lint it once.
10. As a CI maintainer, I want `--watch` to be rejected (clear error, non-zero exit) in
    non-interactive contexts, so that nobody accidentally hangs a pipeline on a long-lived watch.
11. As a developer, I want the exit code in watch mode to reflect the last run's pass/fail when I
    quit, so that scripts wrapping a single watched session still behave sensibly.

## Implementation Decisions

- **One new seam, at the lint-run boundary.** The existing CLI already has a single function that
  takes a resolved config + file set and returns a structured lint result. Watch mode is a loop
  *around* that seam: it does not change how a single lint runs, only how often and in response to
  what. Tests target this existing seam plus one new, small file-event seam (below). Confirmed
  with the developer that no per-rule code needs to change.
- **File-event seam.** Introduce a thin watcher abstraction that emits debounced "files changed"
  events for a given root + ignore set. The watcher is the only new seam; it is injectable so
  tests can drive synthetic events without touching a real filesystem watcher.
- **Debounce.** Coalesce events within a short fixed window (illustratively ~200ms) into one
  re-run. Window is a constant, not yet a user-facing flag (see Out of Scope).
- **In-flight changes.** At most one re-run is queued while a run is in progress; additional
  events during that run collapse into that single pending run ("trailing run" semantics).
- **Tracked files only.** Reuse the linter's existing ignore/include resolution so the watched set
  exactly matches the linted set — no second source of truth for which files matter.
- **Output.** Each run prints a delimiter header (run number + timestamp) and a trailing summary
  line. The default is append (scrollback preserved); screen-clearing is out of scope for v1.
- **Interactivity guard.** `--watch` requires an interactive TTY; in a non-TTY context it errors
  and exits non-zero rather than blocking.
- **Composition.** `--watch` is purely additive to the existing flag set; path and config flags
  resolve exactly as they do for a one-shot run, then feed the loop.

## Testing Decisions

- **Test external behavior, not internals.** Drive the CLI through its public entry point and the
  injectable watcher seam; assert on observable output (run count, summary lines, exit code) and
  on how many times the lint-run seam is invoked — never on private loop state.
- **Modules under test:** the watch loop (via the CLI entry point) and the debounce/trailing-run
  logic (via synthetic events on the injected watcher).
- **Key cases:** initial run fires once; a single change triggers exactly one re-run; a burst
  within the debounce window collapses to one re-run; a change during an in-flight run yields
  exactly one trailing run; non-TTY invocation errors with non-zero exit; Ctrl-C exits cleanly
  with the last run's status.
- **Prior art:** mirror the existing one-shot CLI tests that invoke the entry point and assert on
  captured stdout/exit code; extend that harness with the injectable watcher rather than inventing
  a new test style.

## Out of Scope

- A configurable debounce window flag (fixed constant for v1).
- Screen-clearing / alternate-screen TUI rendering (append-only for v1).
- Watching files outside the linter's existing include/ignore resolution.
- Incremental linting of only the changed files (each run lints the full resolved set for v1).
- Editor/LSP integration or any daemon/background-server mode.

## Further Notes

The watcher seam is the one durable architectural addition; the rest is a loop around behavior
that already exists. Keeping incremental linting out of scope keeps v1 a thin tracer through the
real plumbing, which is exactly what the issue breakdown leans on.
