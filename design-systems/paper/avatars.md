# Avatars

> Dependencies: `colors.md`, `radius.md`

## Core Specs

- **Circular shape:** fully rounded (9999px)
- **Rounded square shape:** 6px radius
- **Default size:** 48x48px (Paper uses `--size` variable, default 48px)
- **Image fit:** cover

## Sizes

| Size | Dimensions | Radius (rounded square) |
|---|---|---|
| Extra Small | 20x20px | 4px |
| Small | 28x28px | 6px |
| Base | 40x40px | 6px |
| Large | 48x48px | 6px |
| XL | 52x52px | 6px |
| 2XL | 72x72px | 6px |

## Bordered Avatar

- 4px padding, fully rounded, 2px outline in border color
- Alternative: outline approach with foreground at 6%

## Stacked Avatars

- Displayed in a row (flex)
- Each avatar: 48x48px, fully rounded, 3px border in surface color (background buffer)
- Overlap: -12px negative margin on all except first

### Stacked Counter
- Same size as avatars, fully rounded
- Background: off-black (light) / white at 10% (dark)
- Text: paper (light) / cream (dark), 12px font, medium weight (480)
- Same overlap margin as other avatars

## Avatar with Text

- Flex row, 10px gap between avatar and text
- Avatar: 48x48px, fully rounded, cover fit
- Name: foreground color, medium weight (480)
- Subtitle: 14px, foreground at 50%
