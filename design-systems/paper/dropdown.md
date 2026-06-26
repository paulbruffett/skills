# Dropdown

> Dependencies: `colors.md`, `radius.md`, `shadows.md`, `inputs.md`

## Core Specs

### Chevron Icon
- Size: 16x16px
- Spacing: 6px left margin, -2px right margin
- Color: inherits from trigger button

### Menu Container
- Background: surface (white light / gray-900 dark)
- Outline: 1px, foreground at 6% (light) / white at 10% (dark)
- Radius: 6px (base)
- Shadow: shadow-sm
- Z-index: elevated above content

### Menu List
- Padding: 8px
- Font: 14px (text-xs), foreground at 80%, medium weight (480)

### Menu Item
- Layout: inline-flex, vertically centered, full width
- Padding: 8px horizontal, 8px vertical
- Radius: 8px (default)
- Hover: foreground at 8% background, foreground text
- Transition: background-color, 150ms

## Trigger Sizes

| Size | Font size | Horizontal padding | Vertical padding |
|---|---|---|---|
| Small | 14px | 12px | 7px |
| Base | 16px | 14px | 10px |
| Large | 16px | 18px | 12px |

## Icon-only Trigger

- Padding: 8px
- Min size: 44x44px
- Icon: 20x20px

## Variants

### Default
- Menu width: 176px, items have 8px radius

### With Divider
- Top border (border token) between child groups, skip first group

### With Header
- Header padding: 16px horizontal, 12px vertical
- Bottom border: border token
- Name: foreground, 14px, semibold weight (550)
- Email: foreground at 50%, 14px, truncated

### With Icons
- Icon before label: 16x16px, 8px right margin, foreground at 50%
- On hover, icon color changes to foreground

### With Checkbox / Radio
- Inputs: 16x16px, 4px radius, focus ring in focus (blue-400)
- Helper text: 12px, foreground at 50%, 2px top margin

### With Search
- Search input at top of menu following `inputs.md` specs
- Left icon: 12px left padding, input 36px left padding

### Scrollable
- Max height: 192px, vertical scroll overflow

## States

| State | Appearance |
|---|---|
| Focused trigger | 2px focus (blue-400) ring, outline-offset 2px |
| Hover item | foreground at 8% background, foreground text |
| Active/open item | foreground at 4% background, foreground text |
| Disabled item | fg-disabled text, not-allowed cursor, no pointer events |
