# Tabs

> Dependencies: `colors.md`, `radius.md`, `shadows.md`

## Core Specs

- Typography: 14px (text-xs), medium weight (480), foreground at 50%
- Transitions: all properties, 200ms

## Variants

### 1. Underline (Default)

**Wrapper:** bottom border, border token

**Tab Item:**
- Padding: 16px horizontal, 16px vertical
- Bottom border: 2px, transparent
- Transition: color, border-color — 150ms

| State | Appearance |
|---|---|
| Active | foreground text, blue bottom border (2px) |
| Inactive | foreground at 50% text; hover → foreground text, border-dark bottom border |
| Disabled | fg-disabled text, not-allowed cursor |

### 2. Pills

**Tab Item:**
- Padding: 16px horizontal, 10px vertical
- Radius: 6px (base)
- Font weight: medium (480)
- Transition: all, 200ms

| State | Appearance |
|---|---|
| Active | off-black background, paper text (light) / white at 10% background, cream text (dark) |
| Inactive | foreground at 50% text; hover → foreground at 4% background, foreground text |
| Disabled | fg-disabled text, not-allowed cursor |

### 3. Full Width

Children overlap with -1px left margin on all except first.

**Tab Item:**
- Full width, centered text
- Padding: 16px horizontal, 16px vertical
- Background: surface
- Border: 1px, border token
- Transition: background-color, 150ms
- Hover: foreground at 4% background, foreground text

| State | Appearance |
|---|---|
| Active | cream background, blue text |
| First item | rounded start (6px) |
| Last item | rounded end (6px) |

## Tabs with Icons

- Icon size: 16x16px or 20x20px
- Spacing: 8px right margin
- Layout: inline-flex, centered
- Icons inherit the text color of the tab state
