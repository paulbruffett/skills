# Team plugin & governance bundle

The four phase bundles — [`../ideation/`](../ideation/), [`../development/`](../development/),
[`../code-management/`](../code-management/), and [`../ci-cd/`](../ci-cd/) — each automate one slice
of the lifecycle. This bundle is the cross-cutting concern: **how you take that workflow from one
engineer's laptop to a whole team and keep it healthy over time.**

The research is blunt about why this matters: expertise around the harness, not raw model access,
drives results. Anthropic's June 2026 study of ~400,000 sessions found intermediate-and-up users
reach verified success 28–33% of the time versus 15% for novices. Centralizing the config is how a
team manufactures that expertise instead of waiting for each person to rediscover it.

This doc covers four things:

1. [Bundling the harness as a team plugin](#1-bundle-the-harness-as-a-team-plugin) — using *this repo* as the worked example.
2. [The DRI / "agent manager" role](#2-the-dri--agent-manager-role) — who owns the config and why centralization matters.
3. [Permission layering](#3-permission-layering) — allow/ask/deny in `.claude/settings.json`, and why hooks beat instructions.
4. [The config-review cadence](#4-the-config-review-cadence) — why compensating instructions go stale as models improve.

A short, copyable [`config-review-checklist.md`](./config-review-checklist.md) accompanies section 4.

---

## 1. Bundle the harness as a team plugin

A team workflow isn't just skills. It's skills **plus** the hooks that enforce conventions, the
`settings.json` that sets permissions, the MCP servers that connect your stack, and the subagents
that keep the main thread lean. The whole point of a Claude Code **plugin** is that one
`/plugin install` ships all of those together, so every engineer gets the same context instead of
each person maintaining a bespoke pile of dotfiles.

### This repo is the worked example

You don't have to imagine the structure — **this repository already is a plugin marketplace.** Two
small manifests under [`../../.claude-plugin/`](../../.claude-plugin/) do the wiring:

**`marketplace.json`** declares the marketplace and the plugins it offers:

```json
{
  "name": "paul-skills",
  "owner": { "name": "Paul Bruffett" },
  "plugins": [
    {
      "name": "skills",
      "source": "./",
      "description": "Personal agent skills for real engineering"
    }
  ]
}
```

A marketplace can host several plugins; this one hosts a single plugin named `skills`, sourced from
the repo root.

**`plugin.json`** declares what that one plugin actually ships — here, a curated list of skills:

```json
{
  "name": "skills",
  "description": "Personal agent skills for real engineering",
  "skills": [
    "./skills/engineering/diagnosing-bugs",
    "./skills/productivity/grill-me",
    "./skills/productivity/writing-great-skills"
  ]
}
```

(Abbreviated — the real file lists every shipped skill.) A plugin manifest can declare more than
skills: the same shape carries `hooks`, `mcpServers`, subagents, and a statusline. That is the
mechanism that lets a single install ship the entire harness. This repo happens to ship only skills
today, but the manifest is the place you'd add the hooks from [`../development/`](../development/) and
the MCP servers your team depends on.

### Installing it

From the top-level [README](../../README.md), the install is two commands inside Claude Code:

```
/plugin marketplace add paulbruffett/skills
/plugin install skills@paul-skills
```

The first command registers the marketplace (by GitHub `owner/repo`, or by local path while
developing). The second installs the `skills` plugin *from* the `paul-skills` marketplace — note the
`plugin@marketplace` syntax. After a reload, model-invoked skills are available automatically and
user-invoked ones show up as slash commands.

For a team, you'd point the marketplace at your org's repo and have everyone run those two lines (or
push the install into onboarding). Everyone is now on the same skills, the same hooks, the same
permission rules — by construction.

### Curate, don't dump

A plugin is only as good as what's in it. This repo models a **curated** library by sorting skills
into buckets — see [`../../skills/`](../../skills/):

- `engineering/` — daily code work
- `productivity/` — daily non-code workflow tools
- `misc/` — kept around but rarely used
- `in-progress/` — drafts not yet shipped (deliberately **excluded** from the plugin manifest)

The buckets are a governance signal as much as an organization one: `in-progress/` skills never reach
users, and the manifest is the gate. When you add a team skill, hold it to a real quality bar — the
in-repo reference for that is [`writing-great-skills`](../../skills/productivity/writing-great-skills/SKILL.md),
which captures the vocabulary and principles that make a skill predictable. A bloated, inconsistent
library erodes trust faster than no library at all.

---

## 2. The DRI / "agent manager" role

Bottoms-up adoption fragments and plateaus. If every engineer tunes their own `CLAUDE.md`, writes
their own hooks, and picks their own MCP servers, the team never converges and the good patterns
never propagate. The fix is a single owner.

**Appoint a DRI — an "agent manager."** Practically this is a hybrid PM/engineer, usually sitting in
developer-experience or productivity, with explicit authority over:

- the plugin marketplace and what ships in it,
- the permission policy (the allow/ask/deny rules below),
- the `CLAUDE.md` hierarchy and conventions, and
- which MCP servers and subagents are blessed for the team.

In a regulated org, widen this to a **cross-functional working group** — engineering plus infosec
plus governance — and start narrow: a defined set of approved skills, required code review on
AI-authored changes, and limited tool access, then expand as confidence grows. The DRI owns the
plugin; the working group owns the policy the plugin encodes.

Centralization is what turns the four phase bundles into a *shared* workflow rather than four things
each person reassembles differently.

---

## 3. Permission layering

Permissions live in `.claude/settings.json` as three lists, layered from most to least trusted:

- **allow** — runs without asking. Reserve for safe, read-only, high-frequency operations
  (e.g. `git status`, `git diff`, the project's test command). Removes friction where there's no risk.
- **ask** — pauses for human confirmation. Use for actions that are usually fine but occasionally
  consequential (e.g. `git push`, package installs).
- **deny** — never runs. Use for things that should never happen unattended (e.g. reading `.env` or
  other secrets, destructive git commands).

Settings layer across scopes — user, project, and local — so the DRI can ship a project-level baseline
that everyone inherits while individuals tighten (never loosen) it locally.

### Why hooks, not just CLAUDE.md

Here is the load-bearing distinction for governance:

> **`CLAUDE.md` instructions are followed ~70% of the time. Hooks fire ~100% of the time.**

`CLAUDE.md` is guidance the model *chooses* to follow; a hook is code the harness *runs* regardless of
what the model decides. So the rule is:

**If something is a preference, put it in `CLAUDE.md`. If it must hold every single time, make it a
hook.** Formatting and linting on every edit, blocking dangerous git commands, denying secret reads —
anything where a 70% compliance rate is a real incident — belongs in a hook (or a `deny` rule), not a
paragraph of prose. The repo's [`git-guardrails-claude-code`](../../skills/misc/git-guardrails-claude-code/SKILL.md)
skill is exactly this pattern: it installs hooks that block destructive git commands before they
execute, rather than asking the model to please be careful.

The phase bundles supply the raw material — [`../development/`](../development/) has the formatter/linter
hooks and the settings baseline. Governance's job is to decide which of those rules are *enforced* and
ship them to everyone through the plugin.

---

## 4. The config-review cadence

**Schedule a config review every 3–6 months.** This is not housekeeping — it is the single mechanism
that keeps the harness from quietly degrading as models improve.

The mechanism is counterintuitive: **as the model gets better, your old config gets worse.** Much of a
mature `CLAUDE.md` and many hooks are *compensating instructions* — rules written to work around a past
model's weakness. When the model improves, those rules don't just become redundant; they can actively
**block good behavior.** The canonical example: a "refactor only one file at a time" rule, written when
the model made sloppy cross-file edits, now prevents a more capable model from making correct,
necessary multi-file changes.

The capability ceiling is rising fast enough that this is a recurring problem, not a one-off — Anthropic
reports success on the most open-ended tasks reached 76% in May 2026, up 50 percentage points in six
months. Config written against last quarter's model is reasoning about a model that no longer exists.

So every cycle, the DRI walks the config and asks of each rule: *is this still earning its place, or is
it compensating for a weakness the model no longer has?* Prune aggressively. Two related triggers from
the research, worth watching between reviews:

- **Instruction-following degrading?** Your `CLAUDE.md` is probably bloated (prune it) or stale after a
  model upgrade (do the review early).
- **A rule that must always hold living in prose?** Move it from `CLAUDE.md` to a hook.

Use the [`config-review-checklist.md`](./config-review-checklist.md) in this directory to run the review.

---

## Where this fits

| Bundle | Role in the team workflow |
| ------ | ------------------------- |
| [`../ideation/`](../ideation/) | The skills the plugin ships for turning ideas into issues. |
| [`../development/`](../development/) | The `CLAUDE.md`, settings baseline, and hooks this bundle decides to enforce and distribute. |
| [`../code-management/`](../code-management/) | Review/triage automation, gated by the permission policy the DRI owns. |
| [`../ci-cd/`](../ci-cd/) | Headless jobs that must respect the same allow/ask/deny rules and turn caps. |
| **governance (here)** | Packages all of the above as one plugin, names an owner, sets the permission policy, and keeps it current. |

Governance isn't a fifth phase — it's the thread that makes the other four a team capability instead of
four personal habits.
