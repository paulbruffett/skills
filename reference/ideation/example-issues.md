# Issues: `lint --watch` mode

> **Illustrative example.** This is the set of issues `/to-issues` would publish to the project
> issue tracker after decomposing [`example-prd.md`](./example-prd.md). Each issue is a
> **tracer-bullet vertical slice** — a thin but complete path through every layer (CLI flag →
> watcher → lint-run → output → tests), demoable on its own — not a horizontal slice of one
> layer. They follow the `to-issues` issue-body template and would be published with the
> project's ready-for-agent triage label, in dependency order so the "Blocked by" fields can
> reference real issue identifiers.
>
> In a real run, `/to-issues` first presents this list as a numbered breakdown for you to approve
> (granularity, dependency order, splits/merges) before publishing.

## Proposed breakdown (the approval list)

| # | Slice | Blocked by | User stories |
|---|-------|-----------|--------------|
| 0 | Prefactor: extract the lint-run seam | — | (enabling) |
| 1 | `--watch` runs once and stays alive | #0 | 1, 8, 9, 11 |
| 2 | Re-run on tracked file change (single watcher seam) | #1 | 2, 4 |
| 3 | Debounce + trailing-run semantics | #2 | 3, 7 |
| 4 | Per-run delimiter + summary output | #1 | 5, 6 |
| 5 | Non-TTY guard | #1 | 10 |

The slices below are written in the `to-issues` template.

---

## Issue #0 — Prefactor: extract the lint-run seam

### What to build

Before adding watch behavior, isolate a single function that takes a resolved config + file set
and returns a structured lint result, so watch mode can call it in a loop without duplicating
setup. This is pure prefactoring: one-shot lint behavior and output stay identical. "Make the
change easy, then make the easy change."

### Acceptance criteria

- [ ] A single seam runs one lint pass from a resolved config + file set and returns a structured
      result.
- [ ] The existing one-shot `lint` command routes through this seam with no change in behavior or
      output.
- [ ] Existing lint tests still pass unchanged.

### Blocked by

None - can start immediately.

---

## Issue #1 — `--watch` runs once and stays alive

### What to build

Add the `--watch` flag. On invocation it resolves paths/config exactly like a one-shot run, runs
the lint seam once, then stays alive instead of exiting. Ctrl-C exits cleanly with the last run's
pass/fail status. No file watching yet — this is the end-to-end skeleton: flag parsed → one run →
process stays up → clean exit. Demoable by running `lint --watch` and seeing it run once and wait.

### Acceptance criteria

- [ ] `--watch` is accepted and composes with existing path/config flags.
- [ ] On startup the linter runs exactly once and prints its normal output.
- [ ] The process stays alive after the initial run instead of exiting.
- [ ] Ctrl-C exits cleanly with an exit code reflecting the last run's pass/fail.
- [ ] A test drives the entry point with `--watch`, asserts one initial run, and asserts clean
      shutdown.

### Blocked by

- #0

---

## Issue #2 — Re-run on tracked file change

### What to build

Introduce the injectable watcher seam: a thin abstraction that emits "files changed" events for
the resolved root using the linter's existing include/ignore resolution, so the watched set
exactly matches the linted set. Wire it into the watch loop so a change to a tracked source file
triggers another lint run; changes to ignored files do not. Tests drive synthetic events through
the injected watcher — no real filesystem watcher required.

### Acceptance criteria

- [ ] A watcher seam emits change events and is injectable for tests.
- [ ] A change to a tracked source file triggers exactly one additional lint run.
- [ ] A change to an ignored/untracked file triggers no run.
- [ ] The watched set is derived from the linter's existing include/ignore resolution (single
      source of truth).
- [ ] Tests drive synthetic change events and assert the resulting run count.

### Blocked by

- #1

---

## Issue #3 — Debounce + trailing-run semantics

### What to build

Coalesce rapid successive change events within a short fixed window into a single re-run. While a
run is in flight, queue at most one trailing run; further events during that run collapse into the
same pending run. This guarantees the session always ends on results reflecting the latest files,
without a storm of redundant runs.

### Acceptance criteria

- [ ] A burst of events within the debounce window produces exactly one re-run.
- [ ] Events arriving during an in-flight run produce exactly one trailing run.
- [ ] After activity settles, the last run reflects the final file state.
- [ ] Tests drive bursts and overlapping events through the injected watcher and assert run
      counts.

### Blocked by

- #2

---

## Issue #4 — Per-run delimiter + summary output

### What to build

Make repeated output legible. Each run prints a delimiter header (run number + timestamp) before
its results and a trailing one-line summary (error/warning counts + elapsed time) after. Default
is append (scrollback preserved); no screen-clearing. Applies to the initial run and every re-run.

### Acceptance criteria

- [ ] Each run is preceded by a delimiter header identifying the run.
- [ ] Each run is followed by a one-line summary of counts and elapsed time.
- [ ] Output is appended; prior runs remain in scrollback.
- [ ] A test asserts the header and summary appear once per run.

### Blocked by

- #1

---

## Issue #5 — Non-TTY guard

### What to build

Reject `--watch` when stdout is not an interactive TTY: print a clear error and exit non-zero
rather than blocking. This keeps a watch invocation from hanging a CI pipeline.

### Acceptance criteria

- [ ] `--watch` in a non-TTY context prints a clear error and exits non-zero.
- [ ] `--watch` in an interactive TTY is unaffected.
- [ ] A test simulates a non-TTY context and asserts the error and non-zero exit.

### Blocked by

- #1
