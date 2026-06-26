# Accordion

> Dependencies: `colors.md`, `radius.md`

## Core Specs

- **Wrapper:** full width, outline 1px (foreground at 6%), 6px radius — clips first/last item corners
- **Item separator:** 1px bottom border (border token) on every item except last

## Trigger (Button)

- **Layout:** flex, space-between, full width
- **Padding:** 20px horizontal, 16px vertical
- **Font:** 14px (text-xs), medium weight (480)
- **Text color:** foreground
- **Background:** cream (light) / gray-900 (dark)
- **Hover:** gray-100 (light) / gray-800 (dark) background
- **Focus:** outline none, 2px ring in focus (blue-400)
- **Transition:** background-color, 150ms
- **Open state:** gray-100 (light) / gray-800 (dark) background

## Panel (Content)

- **Padding:** 20px horizontal, 16px vertical
- **Background:** surface (white light / gray-900 dark)
- **Top border:** 1px, border token
- **Font:** 14px (text-xs), foreground at 90%, 1.5 line-height

## Chevron Icon

- Size: 16x16px
- Color: foreground at 50%
- Closed: 0deg rotation
- Open: 180deg rotation
- Transition: transform, 150ms

## Variants

### Default (Collapse)
One panel open at a time. Items stacked inside a single shared outlined/rounded wrapper.

### Separated Cards
Each item is independent — has its own outline 1px (foreground at 6%), 6px radius. 8px bottom margin between items. No shared outer outline.

### Always Open
Multiple panels can expand simultaneously. Same styling as Default.

### Flush
No outer outline. Trigger and panel have transparent backgrounds. Only bottom border dividers between items. Use inside containers that already provide a background.

## States

| State | Trigger appearance |
|---|---|
| Closed | foreground text, cream background |
| Open | foreground text, gray-100 background |
| Hover | gray-100 background |
| Focus | 2px focus (blue-400) ring, no outline |
| Disabled | fg-disabled text, not-allowed cursor, no hover/focus |
