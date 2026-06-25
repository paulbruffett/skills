# Code management: PR review, security, triage, and handoff

The **code-management** phase (phase 3 in the [reference lifecycle](../README.md))
covers everything that happens to a change *after* it's written: reviewing it,
flagging security issues, triaging incoming issues and PRs, and handing the
work off to the next session. This bundle gives you two copyable GitHub Actions
workflows for the automated part, and explains how the repo's `code-review`,
[`triage`](../../skills/engineering/triage/SKILL.md), and
[`handoff`](../../skills/productivity/handoff/SKILL.md) skills cover the rest.

## What's in here

| File | What it does |
| ---- | ------------ |
| [`workflows/claude-auto-review.yml`](./workflows/claude-auto-review.yml) | Read-only Claude Code review on every PR push (`opened`, `synchronize`). |
| [`workflows/claude-security-review.yml`](./workflows/claude-security-review.yml) | OWASP-aligned security review, scoped to critical paths, trusted PRs only. |

## Installing the workflows

1. **Copy the workflows into your repo.** GitHub only runs workflow files that
   live in `.github/workflows/`, so copy both files there:

   ```bash
   mkdir -p .github/workflows
   cp reference/code-management/workflows/claude-auto-review.yml .github/workflows/
   cp reference/code-management/workflows/claude-security-review.yml .github/workflows/
   ```

2. **Install the GitHub app.** From an interactive Claude Code session, run:

   ```
   /install-github-app
   ```

   This wires up the `anthropics/claude-code-action` integration and walks you
   through creating the API key secret.

3. **Set the `ANTHROPIC_API_KEY` secret.** Both workflows read
   `${{ secrets.ANTHROPIC_API_KEY }}`. Add it under
   *Settings → Secrets and variables → Actions → New repository secret* (or via
   `gh secret set ANTHROPIC_API_KEY`). `/install-github-app` can create this
   for you.

4. **Tune the path scope.** The security workflow only runs on the `paths:`
   globs in its trigger — edit those to match your repo's sensitive areas
   (auth, API surface, infra, workflows).

> The action surface moves fast. Verify the `with:` inputs in both workflows
> against the current
> [`anthropics/claude-code-action`](https://github.com/anthropics/claude-code-action)
> and
> [`anthropics/claude-code-security-review`](https://github.com/anthropics/claude-code-security-review)
> docs before relying on them.

## Fork-PR safety rules (read this)

PR-review automation is a prime target for credential theft, so both workflows
follow the same rules:

- **Use `on: pull_request`, never `pull_request_target` for autonomous review.**
  With `pull_request`, a PR from a fork runs *without* repository secrets, so
  fork PRs simply aren't auto-reviewed — the safe default. `pull_request_target`
  checks out the trusted base branch *with secrets exposed* while running
  against attacker-controlled PR code; it is the classic secret-exfiltration
  path and must never be used for untrusted PRs.
- **Keep permissions read-only for code.** Both workflows set `contents: read`
  and grant only `pull-requests: write` so the review can post comments. The
  allowed tools are read/comment-only — no `Edit`/`Write`, so a review can never
  mutate or push code.
- **Treat PR content as untrusted.** Neither action is hardened against prompt
  injection. The security workflow additionally gates on
  `head.repo.full_name == github.repository` so it runs only on same-repo
  (trusted) PRs.
- **Want fork PRs reviewed anyway?** Use a maintainer-triggered manual workflow
  (e.g. `workflow_dispatch`, or a `/review` comment gated on author
  association) — not `pull_request_target`.

## How the skills fit this phase

The workflows automate review on the GitHub side. The repo's skills cover the
interactive and process side of code management:

- **`code-review` (built-in Claude Code skill)** — reviews the *current diff*
  locally at a chosen effort (`/code-review high`), and `--comment` posts the
  findings as inline GitHub PR comments. This is the "writer/reviewer" pattern
  done by hand: run it before you push, or as a fresh-context second opinion on
  a teammate's branch. The `claude-auto-review.yml` workflow is the same review
  loop, just triggered automatically in CI instead of on demand.
- **[`triage`](../../skills/engineering/triage/SKILL.md)** — moves incoming
  issues *and external PRs* through a small state machine (categorise → verify →
  grill if needed → write an agent-ready brief). It treats a PR as "an issue
  with attached code," which is exactly the request surface the auto-review
  workflow feeds into: review comments land on the PR, triage decides what to do
  with it next. User-invoked.
- **[`handoff`](../../skills/productivity/handoff/SKILL.md)** — compacts the
  current session into a handoff document so a fresh agent can pick the change
  up — useful when a review surfaces work that won't finish in one session, or
  when passing a triaged PR to the engineer who'll address it. User-invoked.

Together: **auto-review** and **security-review** run in CI, **`code-review`**
is the local pre-push pass, **`triage`** routes the resulting issues/PRs, and
**`handoff`** carries unfinished work to the next session.
