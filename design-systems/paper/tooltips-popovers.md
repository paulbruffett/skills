# Tooltips & Popovers

> Dependencies: `colors.md`, `radius.md`, `shadows.md`

## Tooltips

### Core Specs
- Padding: 12px horizontal, 8px vertical
- Font: 14px (text-xs), medium weight (480)
- Radius: 8px (default)
- Shadow: shadow-sm
- Transition: opacity, 300ms

### Dark (Default)
- Background: off-black (light) / gray-800 (dark)
- Text: paper (light) / cream (dark)
- Border: none

### Light
- Background: surface (white light / gray-900 dark)
- Text: foreground
- Outline: 1px, foreground at 6% (light) / white at 10% (dark)

## Popovers

### Core Specs
- Background: surface (white light / gray-900 dark)
- Radius: 6px (base)
- Shadow: shadow-sm
- Outline: 1px, foreground at 6% (light) / white at 10% (dark)
- Transition: opacity, 300ms

### Header / Title
- Padding: 12px horizontal, 8px vertical
- Background: cream (light) / gray-950 (dark)
- Bottom border: border token
- Font: 14px (text-xs), medium weight (480), foreground color

### Body / Content
- Standard: 12px horizontal, 8px vertical padding; 14px, foreground at 80%
- Rich: 16px padding; 14px, foreground at 80%

## Arrows

- Size: 8x8px rotated 45deg
- Color must match the background of the tooltip/popover variant

## Rules

- Tooltips: 8px radius
- Popovers: 6px radius
- Dark tooltips: off-black background, paper/cream text
- Light tooltips/popovers: surface background + outline tokens
- Arrows match parent background color
