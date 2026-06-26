# Sidebars

> Dependencies: `colors.md`, `radius.md`, `typography.md`, `badges.md`, `alerts.md`

## Core Specs

- Background: surface (white light / gray-900 dark)
- Right border: 1px, border token (for left-sidebar); left border for right-sidebar
- Width: 256px

## Anatomy

### Outer Container
Hidden on mobile, visible at laptop breakpoint (≥900px). Needs a toggle/trigger for mobile.

### Inner Wrapper
- Full height, vertical scroll overflow
- Padding: 12px horizontal, 16px vertical

### Navigation List
- Vertical spacing: 8px between items
- Font weight: medium (480)

### Navigation Item
- Layout: flex, vertically centered
- Padding: 8px horizontal, 8px vertical
- Text: foreground at 70%
- Radius: 6px (base)
- Hover: foreground at 4% background, foreground text
- Transition: background-color, color — 150ms
- Icon: 20x20px, foreground at 50%, hover → foreground, 75ms transition
- Label: 12px left margin from icon

### Active Item
- Background: foreground at 8%
- Text: foreground

### Separator
- 16px top padding, 16px top margin
- Top border: border token
- 8px vertical spacing below

### Bottom CTA / Card
- Padding: 16px
- Top margin: 24px
- Radius: 6px (base)
- Background: blue-300 at 15%
- Can also use any alert variant from `alerts.md`

## Rules

- Responsive: hidden on mobile with a trigger mechanism
- Icons: 20x20px, foreground at 50% (hover: foreground)
- Multi-level menus: indent with 44px left padding
- Spacing follows 4–8px grid
- Only use design tokens — no arbitrary colors
