# Config review checklist

Run every **3–6 months**, and immediately after any major model upgrade. Owned by the DRI / agent
manager. Copy this into an issue and check items off.

The guiding question for the whole review: **does each rule still earn its place, or is it
compensating for a model weakness that no longer exists?** As the model improves, compensating
instructions don't just go redundant — they can block good behavior (e.g. an old "one file at a time"
refactor rule now preventing correct multi-file edits). Prune aggressively.

## CLAUDE.md

- [ ] Under ~150 lines? If it has grown, prune.
- [ ] Every rule still earns its place — remove anything that compensates for a weakness the current model no longer has.
- [ ] Build / test / lint commands still accurate.
- [ ] Architecture notes, conventions, and "traps" still true.
- [ ] Any rule that *must* hold every time moved out of prose and into a hook (instructions ~70%, hooks ~100%).
- [ ] Hierarchy (user / project / local CLAUDE.md) still makes sense; no contradictions between layers.

## Hooks

- [ ] Each hook still serves a real purpose — retire ones that worked around a now-fixed model behavior.
- [ ] Formatter / linter hooks point at the current toolchain.
- [ ] Guardrail hooks (e.g. dangerous-git blocks) still cover the right commands.
- [ ] No hook is silently failing or blocking legitimate work.

## Permissions (`.claude/settings.json`)

- [ ] `allow` list is only safe, read-only, high-frequency operations.
- [ ] `ask` list covers the "usually fine, occasionally consequential" actions.
- [ ] `deny` list still blocks secrets (`.env`) and destructive operations.
- [ ] Project baseline still correct; no individual local override has loosened it unsafely.

## Plugin contents

- [ ] Skills inventory reviewed — remove stale or unused skills; `in-progress/` drafts excluded from the manifest.
- [ ] New team skills meet the quality bar in `writing-great-skills`.
- [ ] MCP servers still needed, still trusted, still authenticated; tool search enabled to manage token cost.
- [ ] Subagents still pulling their weight; main-thread work pushed into them where it balloons context.

## Headless / CI jobs

- [ ] `claude -p` jobs still capped (`--max-turns`, `timeout`-wrapped) and routed to appropriate models.
- [ ] All AI-initiated changes still pass the same human review as human-authored code.
- [ ] Review/security actions remain read-only and trusted-PR-only (no `pull_request_target`).

## Sign-off

- [ ] Changes committed to the team plugin and the new version rolled out (`/plugin install`).
- [ ] Next review scheduled (3–6 months out, or sooner if a major model upgrade lands first).
