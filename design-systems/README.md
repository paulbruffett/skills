# Design systems

Reusable visual languages packaged as Claude skills. Each skill defines **one design system** — a complete set of design tokens and component specs that shape how Claude generates UI. This is a separate plugin from the engineering [`skills/`](../skills/), so you can install it on its own:

```
/plugin marketplace add paulbruffett/skills
/plugin install design-systems@paul-skills
```

Each design system lives in its own folder as a [`SKILL.md`](./paper/SKILL.md) (the index + critical rules) plus one `.md` module per component or token group. The skill's instructions tell Claude to load only the modules relevant to the UI it's building, so adding modules doesn't inflate every request.

## Skills

**Model-invoked**

- **[paper](./paper/SKILL.md)** — Warm, editorial, minimal design system: paper/cream backgrounds, Montserrat type, 6px radius, outline-first elevation, automatic dark mode.

## Adding another design system

1. Create a sibling folder (e.g. `design-systems/<name>/`) with a `SKILL.md` carrying `name`/`description` frontmatter that names the system and says when to use it.
2. Add one `.md` module per component/token group, linked from the `SKILL.md` index.
3. Register `./<name>` in [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json) and add a bullet under **Model-invoked** above.
