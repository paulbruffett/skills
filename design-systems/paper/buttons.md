# Buttons

> Dependencies: `colors.md`, `radius.md`, `shadows.md`

## Core Specs (every button)

- **Radius:** 6px (base) or 9999px for pills
- **Font weight:** medium (480)
- **Font:** Matter (inherits from `--default-font-family`)
- **Box sizing:** border-box
- **Transition:** background-color, color, transform — 150ms ease-out
- **Active state:** scale(0.97) on press
- **Disabled opacity:** 0.7, not-allowed cursor

## Sizes

| Size | Font size | Horizontal padding | Vertical padding |
|---|---|---|---|
| Extra small | 12px | 10px | 4px |
| Small | 14px | 12px | 7px |
| Base (default) | 16px (text-sm) | 14px | 10px |
| Large | 16px (text-sm) | 18px | 12px |
| Extra large | 18px (text-base) | 24px | 12px |

## Variants

### Blue (Primary CTA)
- **Background:** `linear-gradient(to bottom, var(--color-blue-400), var(--color-blue-500))`
- **Border:** none
- **Text:** white
- **Shadow:** `inset 0 1px #ffffff1f, inset 0 -1px #0000001f`
- **Transition:** `background .15s ease-out, transform .1s ease-out`
- **Hover:** linear-gradient(to bottom, blue-300, blue-500)
- **Focus ring:** 2px solid focus, 2px offset
- **Active:** scale(0.97)

### Secondary
- **Background:** foreground at 8%
- **Border:** none
- **Text:** foreground
- **Shadow:** none
- **Hover:** foreground at 12% background
- **Focus ring:** 2px solid focus, 2px offset

### Outline
- **Background:** transparent
- **Border:** 1px solid border token
- **Text:** foreground
- **Shadow:** none
- **Hover:** foreground at 4% background
- **Focus ring:** 2px solid focus, 2px offset

### Ghost (NO shadow, NO border)
- **Background:** transparent
- **Border:** none
- **Text:** foreground
- **Hover:** foreground at 4–8% background
- **Focus ring:** 2px solid focus, 2px offset
- **No shadow**

### Dark
- **Background:** off-black (light mode) / white (dark mode)
- **Border:** none
- **Text:** paper (light mode) / off-black (dark mode)
- **Hover:** black (light mode) / paper (dark mode)
- **Focus ring:** 2px solid focus, 2px offset

### Success
- **Background:** success token
- **Border:** none
- **Text:** white
- **Hover:** success-strong background
- **Focus ring:** 2px solid focus, 2px offset

### Danger
- **Background:** danger token
- **Border:** none
- **Text:** white
- **Hover:** danger-strong background
- **Focus ring:** 2px solid focus, 2px offset

### Warning
- **Background:** warning token
- **Border:** none
- **Text:** white
- **Hover:** warning-strong background
- **Focus ring:** 2px solid focus, 2px offset

### Disabled
- **Background:** foreground at 8%
- **Text:** fg-disabled
- **Opacity:** 0.7
- **Cursor:** not-allowed
- **No hover, no focus**

## Icons in Buttons

- Icon size: 16x16px (or 0.9em relative)
- Spacing: 8px gap between icon and label
- Layout: inline-flex, vertically centered
