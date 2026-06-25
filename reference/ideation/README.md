# Ideation → spec bundle

A worked example of the **ideation phase**: turning a vague feature idea into an aligned
spec and a set of independently-grabbable issues, using only the skills already in this repo.

The chain is three user-invoked slash commands run in sequence:

```
idea ──/grill-me──> aligned spec ──/to-prd──> PRD ──/to-issues──> issues
```

Everything below is **illustrative** — a single invented feature carried through the flow so
you can see the handoff between steps made concrete. The artifacts each step produces are
captured as sibling files:

- [`example-prd.md`](./example-prd.md) — what `/to-prd` would publish for the sample feature.
- [`example-issues.md`](./example-issues.md) — the vertical-slice issues `/to-issues` would
  decompose that PRD into.

## The sample feature

> **Idea (one line):** "Add a `--watch` flag to our `lint` CLI so it re-runs automatically
> when source files change, instead of the developer re-running it by hand."

Small, believable, and touchy enough in the details (debouncing, which files, how to render
repeated output) to be worth grilling before anyone writes code. We carry exactly this idea
through all three steps.

## Step 1 — Grill the idea into an aligned spec

Skill: [`/grill-me`](../../skills/productivity/grill-me/SKILL.md)
(or [`/grill-with-docs`](../../skills/engineering/grill-with-docs/SKILL.md) when you also want
ADRs and glossary entries written as you go).

**Invoke:**

```
/grill-me
```

then describe the idea. `grill-me` runs a [`/grilling`](../../skills/productivity/grilling/SKILL.md)
session: a relentless one-question-at-a-time interview that walks every branch of the design
tree, resolving decisions one by one and offering a recommended answer for each. Questions that
the codebase can answer are answered by exploring the codebase rather than asking you.

**What it contributes:** it closes the communication gap *before* any code exists — the single
biggest failure mode in AI-assisted coding is a vague prompt. For the `--watch` feature, grilling
forces decisions like:

- Which files trigger a re-run? (tracked source files only, or everything?)
- Debounce window for rapid saves?
- Clear the screen between runs, or append?
- What happens to an in-flight lint when a new change lands?
- How does the process exit — Ctrl-C only?

The output is not a document yet — it is a **shared understanding** living in the conversation.
Use `/grill-with-docs` instead when you want those decisions persisted as ADRs as you go.

## Step 2 — Synthesize the spec into a PRD

Skill: [`/to-prd`](../../skills/engineering/to-prd/SKILL.md)

**Invoke (in the same conversation, right after grilling):**

```
/to-prd
```

`to-prd` does **not** re-interview you — it synthesizes what the grilling already settled. It
explores the repo, sketches the **seams** at which the feature will be tested (preferring
existing seams, and the fewest possible — ideally one), checks those seams with you, then writes
the PRD and publishes it to the project issue tracker with the `ready-for-agent` triage label.

**What it contributes:** it turns the conversation into a durable, structured artifact — problem
statement, an extensive list of user stories, implementation decisions, testing decisions, and
explicit out-of-scope boundaries. The PRD, not the chat log, becomes the source of truth.

See [`example-prd.md`](./example-prd.md) for the shape `to-prd` produces.

## Step 3 — Decompose the PRD into issues

Skill: [`/to-issues`](../../skills/engineering/to-issues/SKILL.md)

**Invoke (still in the same conversation, or pass the PRD's issue reference as an argument):**

```
/to-issues
```

or

```
/to-issues <issue-number-or-url-or-path>
```

`to-issues` breaks the PRD into **tracer-bullet vertical slices**. Each slice is a thin but
*complete* path through every layer (CLI parsing, watcher, lint runner, output, tests) — never a
horizontal slice of one layer. A finished slice is demoable on its own. It looks for prefactoring
to do first, presents the proposed breakdown as a numbered list for you to approve (granularity,
dependency order, splits/merges), then publishes each approved slice to the issue tracker in
dependency order so real "Blocked by" identifiers can be referenced.

**What it contributes:** it converts one spec into independently-grabbable units of work that an
agent (or a teammate) can pick up one at a time, each verifiable on its own.

See [`example-issues.md`](./example-issues.md) for the slices this PRD decomposes into.

## Conventions these steps assume

Both `/to-prd` and `/to-issues` publish to a project issue tracker and apply a triage label
(`ready-for-agent` for the PRD; the project's ready-for-agent label for each issue). The
issue-tracker and triage-label vocabulary is recorded in [`../../docs/agents/`](../../docs/agents/)
— if that vocabulary has not been loaded into the session, run `/setup-matt-pocock-skills` first,
as both skills note.

> Note: `../../docs/agents/` is contributed by a separate PR and may not be present on this
> branch yet. The path is the canonical home for these conventions regardless.
