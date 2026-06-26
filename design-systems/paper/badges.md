# Badges

> Dependencies: `colors.md`, `radius.md`

## Core Specs

- **Border:** 1px or outline
- **Default radius:** 8px
- **Pill radius:** 9999px

## Sizes

| Size | Font size | Horizontal padding | Vertical padding |
|---|---|---|---|
| Default (small) | 12px | 6px | 2px |
| Large | 14px | 8px | 4px |

## Variants

### Blue (Brand)
- **Background:** blue-300 at 15%
- **Border:** blue-400 at 30%
- **Text:** blue-500 (light) / blue-300 (dark)

### Neutral
- **Background:** foreground at 4%
- **Border:** foreground at 8%
- **Text:** foreground

### Gray
- **Background:** gray-100 (light) / gray-800 (dark)
- **Border:** foreground at 8%
- **Text:** foreground

### Danger
- **Background:** danger-soft
- **Border:** border-danger at 30%
- **Text:** fg-danger

### Success
- **Background:** success-soft
- **Border:** border-success at 30%
- **Text:** fg-success

### Warning
- **Background:** warning-soft
- **Border:** border-warning at 30%
- **Text:** fg-warning

### Dark
- **Background:** off-black (light) / white at 10% (dark)
- **Border:** transparent
- **Text:** paper (light) / cream (dark)

## Pill Badges

Use 9999px radius instead of 8px on any variant.

## Badges with Icons

- Icon size (default): 12x12px
- Icon size (large): 14x14px
- Icon spacing: 4px margin next to label

## Icon-only Badge

Square shape — equalize dimensions to 24x24px, no horizontal text padding.

## Dismissible Badges

Badge content + a close button. Close button hover backgrounds per variant:

| Variant | Close button hover background |
|---|---|
| Blue | blue-400 at 20% |
| Neutral | foreground at 8% |
| Gray | foreground at 12% |
| Danger | danger at 20% |
| Success | success at 20% |
| Warning | warning at 20% |

## Dot / Notification Badge

- Positioned absolutely: -4px top, -4px right
- Size: 12x12px, fully rounded
- 2px border in surface color (background buffer)
- Background: danger
