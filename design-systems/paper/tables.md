# Tables

> Dependencies: `colors.md`, `radius.md`, `shadows.md`

## Wrapper

- Horizontal scroll overflow
- Background: surface (white light / gray-900 dark)
- Radius: 6px (base)
- Outline: 1px, foreground at 6% (light) / white at 10% (dark)
- No box-shadow

## Table Element

- Full width, left-aligned text (right-aligned for RTL)
- Font: 14px (text-xs), foreground at 80%
- Border collapse

## Table Head

- Font: 14px (text-xs), foreground at 50%, medium weight (480)
- Background: cream (light) / gray-950 (dark)
- Bottom border: border token
- Cell padding: 24px horizontal, 12px vertical

## Table Body

- Row background: surface
- Row bottom border: border token (omit on last row to avoid doubling with wrapper outline)
- Row hover: foreground at 2% background (optional)
- Row header: medium weight (480), foreground color, no-wrap
- Cell padding: 24px horizontal, 16px vertical

## Rules

- Wrapper must have horizontal scroll overflow for responsive scrolling
- Last row: omit bottom border to avoid doubling with wrapper outline
- Row headers: always `scope="row"` for semantic structure
- Hover on rows is optional
- No arbitrary hex codes — use token colors only
