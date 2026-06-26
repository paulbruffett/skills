---
name: paper
description: Paper — a specific design system: a warm, editorial, minimal visual language using paper/cream backgrounds, Montserrat type, 6px radius, and outline-first elevation with automatic dark mode. One of several design-system skills in this plugin, each defining a distinct visual language. Use when generating or styling any UI — pages, components, layouts — under the Paper design system.
---

# Design System — Agent Instructions

This skill describes the Paper Design visual language for all UI output. Every component, layout, and page should follow the design specs in the module files below. These describe *what the design looks like* — you choose how to implement the styles.

Paper's aesthetic is warm, editorial, and minimal. Backgrounds use paper/cream tones, typography uses [Montserrat](https://fonts.google.com/specimen/Montserrat) as the primary and unique typeface with variable weights, radius is 6px, and shadows are replaced by thin outlines. The overall feel is clean, spatial, and intentional.

## Before Writing Any Code

1. **Read every module that applies.** For a landing page, read at minimum: `layout.md`, `typography.md`, `colors.md`, `buttons.md`, `cards.md`, `shadows.md`, `radius.md`, `borders.md`. Do NOT write JSX until you have loaded all relevant modules.

## Critical Rules

- **Tokens are AGNOSTIC, NOT Tailwind classes:** The tokens defined in the `.md` files (like `neutral-primary-soft`, `heading`, `border-default`) are agnostic design system tokens, NOT literal Tailwind classes. Do not blindly use classes like `bg-neutral-primary-soft` unless you have explicitly mapped them in the CSS/Tailwind configuration. You must implement the mapping yourself.

- **Cross-reference modules.** A card containing buttons must satisfy both `cards.md` AND `buttons.md`.
- **Dark mode is automatic.** The CSS custom properties resolve differently in light/dark via `@media (prefers-color-scheme: dark)`. Never manually swap colors.
- **Every interactive element needs hover, focus, and disabled states** — defined in the relevant module.
- **Use semantic HTML:** proper heading hierarchy (`h1`→`h6`), `<button>` for actions, `<a>` for navigation, ARIA attributes where needed.
- **Prefer outlines over shadows** for card/surface boundaries.

## Module Index

### Foundation (read first for any UI work)
- [colors.md](colors.md) — all background, text, border, and accent tokens
- [typography.md](typography.md) — Montserrat font, type scale, heading hierarchy, weights
- [layout.md](layout.md) — spacing rhythm, containers, animation, visual depth
- [radius.md](radius.md) — border-radius scale (6px base)
- [shadows.md](shadows.md) — outline-first elevation approach
- [borders.md](borders.md) — border widths, colors, and styles

### Components
- [buttons.md](buttons.md) — button variants, sizes, states, gradient CTA
- [button-group.md](button-group.md) — grouped button structure
- [cards.md](cards.md) — card structure, outline borders, interactivity
- [inputs.md](inputs.md) — form controls, labels, states
- [alerts.md](alerts.md) — alert variants
- [badges.md](badges.md) — badge variants, sizes, dismissible chips
- [lists.md](lists.md) — list components
- [avatars.md](avatars.md) — avatar variants, sizes, indicators
- [icon-shapes.md](icon-shapes.md) — icon containers

### Complex Components
- [accordion.md](accordion.md) — accordion variants
- [dropdown.md](dropdown.md) — dropdown menus
- [modals.md](modals.md) — modal dialogs
- [tabs.md](tabs.md) — tab navigation
- [tables.md](tables.md) — table structure
- [pagination.md](pagination.md) — pagination components
- [sidebars.md](sidebars.md) — sidebar navigation
- [radios-checkboxes-toggle.md](radios-checkboxes-toggle.md) — selection controls
- [tooltips-popovers.md](tooltips-popovers.md) — tooltips and popovers
- [content.md](content.md) — grid system, responsiveness
