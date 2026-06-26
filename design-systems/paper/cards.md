# Cards

> Dependencies: `colors.md`, `radius.md`, `shadows.md`, `typography.md`

## Core Specs

- **Background:** surface (white light / gray-900 dark)
- **Outline:** 1px, foreground at 6% (light) / white at 10% (dark)
- **Radius:** 6px (base)
- **Shadow:** none (outline-first approach)
- **Overflow:** hidden
- **Padding:** 30px (mobile), 40px (laptop), 60px (desktop) — use `--card-padding` variable

## Card Heading

- Desktop: 18–24px, medium weight (480), foreground color
- Mobile: 16px, medium weight (480), foreground color
- Never skip heading levels — the page hierarchy must logically arrive at the card heading level.

## States

### Static Card (no interactivity)
- Background: surface
- Outline: 1px, foreground at 6% (light) / white at 10% (dark)
- Radius: 6px
- No hover styles. Non-interactive cards must NOT have hover background changes.

### Interactive Card (clickable)
- Same base styles as static card
- Hover: outline shifts to foreground at 12–20% (light) / white at 15–20% (dark)
- Transition: outline-color, 150ms
- Cursor: pointer

## Rules

- Background: surface token (white / gray-900)
- Outline: 1px, foreground at 6% (not box-shadow)
- Radius: 6px
- Interactive hover: outline strengthens, no background change
- Non-interactive: no hover styles
- In dark mode: outline 1px solid white at 10%
