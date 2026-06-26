# Inputs

> Dependencies: `colors.md`, `radius.md`

## Core Specs

- **Display:** block, full width
- **Radius:** 6px (base)
- **Border:** 1px, border token
- **Background:** transparent or surface
- **Shadow:** none
- **Font:** 16px (text-sm), foreground color
- **Padding:** 12px horizontal, 10px vertical
- **Placeholder:** foreground at 50% (via color-mix)
- **Transition:** border-color, outline-color — 150ms

## Label

- Display: block
- Font: 14px, medium weight (480), foreground color
- Margin bottom: 8px
- Label `htmlFor` must match the input `id`

## States

### Default
- Border: 1px, border token
- Background: transparent

### Hover
- Border: border-dark token

### Focus
- No outline default
- Border: 2px solid focus (blue-400)
- Outline: 2px solid focus with 2px offset (or ring approach)

### Success
- Border: border-success
- Focus ring: 2px solid success

### Error / Danger
- Border: border-danger
- Focus ring: 2px solid danger

### Disabled
- Background: foreground at 4%
- Text: fg-disabled
- Opacity: 0.7
- Cursor: not-allowed

## Input with Icons

- Icon size: 16x16px
- Icon color: foreground at 50%
- Container: relative positioned wrapper
- Start icon: absolutely positioned left, 12px left padding — input gets 36px left padding
- End icon: absolutely positioned right, 12px right padding — input gets 36px right padding
- Icons vertically centered within the wrapper

## Rules

- Every input must have a unique `id`
- Every label must have a matching `htmlFor`
- Padding: 12px horizontal, 10px vertical unless overridden for icon variants
- No arbitrary hex or hardcoded colors
