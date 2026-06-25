# Reference: an end-to-end Claude developer workflow

This directory shows how to build on the skills in this repo and wire them into a single, automated developer workflow that runs from **ideation → development → code management → CI/CD**.

The skills under [`../skills/`](../skills/) are the *building blocks*. This directory holds the *assembly instructions*: copyable templates (GitHub Actions, hooks, settings, scripts) plus short docs that show how the blocks fit together for each phase. Each bundle is self-contained — copy it into your own repo and run that phase end-to-end. The source material is the SDLC playbook research distilled into a per-phase recipe.

## The lifecycle at a glance

| Phase | What happens | Skills that drive it | Bundle |
| ----- | ------------ | -------------------- | ------ |
| **1. Ideation** | Turn a vague idea into an aligned spec and a set of grabbable issues | `grill-me` / `grill-with-docs` → `to-prd` → `to-issues` | [`ideation/`](./ideation/) |
| **2. Development** | Build the issues test-first, in a controlled local loop | `implement`, `tdd`, `prototype`, `diagnosing-bugs` | [`development/`](./development/) |
| **3. Code management** | Review, triage, and hand off the resulting changes | `code-review` (built-in), `triage`, `handoff` | [`code-management/`](./code-management/) |
| **4. CI/CD** | Automate release notes, triage, and maintenance headlessly | `claude -p` recipes + GitHub Actions | [`ci-cd/`](./ci-cd/) |
| **Cross-cutting** | Ship the harness to a team and keep it current | plugin packaging, `writing-great-skills` | [`governance/`](./governance/) |

## How the phases connect

```
idea ──grill──> aligned spec ──to-prd──> PRD ──to-issues──> issues
                                                              │
                                                  implement / tdd
                                                              │
                                                           changes
                                                              │
                                              code-review / triage / handoff
                                                              │
                                                  CI/CD: review, changelog,
                                                  triage, scheduled audits
```

Each arrow is a skill or an automated job. The whole chain is the same engine (Claude Code) invoked five different ways: interactively, as a slash command, as a subagent, as a GitHub Action, and headless in a pipeline.

## Using these bundles

Each subdirectory has its own README explaining what's inside, how to copy it into your repo, and which skills it leans on. Start with the phase you want to automate first — the bundles don't depend on each other, though they're most powerful in sequence.

> The issue-tracker and triage-label conventions these bundles assume are recorded in [`../docs/agents/`](../docs/agents/).

## Bundles

- **[ideation/](./ideation/)** — a worked example taking one feature from idea to issues.
- **[development/](./development/)** — copyable `CLAUDE.md`, settings, and hooks for the local build loop.
- **[code-management/](./code-management/)** — GitHub Actions for review and security, plus triage/handoff guidance.
- **[ci-cd/](./ci-cd/)** — headless `claude -p` recipes and scheduled-task examples.
- **[governance/](./governance/)** — packaging the harness as a team plugin and keeping it healthy.
