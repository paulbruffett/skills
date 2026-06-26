# Pagination

> Dependencies: `colors.md`, `radius.md`

## Container

Font: 14px (text-xs). Items displayed as flex with -1px overlap for seamless borders.

## Pagination Item

- Layout: flex, centered both axes
- Size: 36x36px (or 40x40px)
- Text: foreground at 60%, medium weight (480)
- Background: transparent
- Border: 1px, border token
- Hover: foreground at 4% background, foreground text
- Focus: 2px focus (blue-400) ring
- Overlap: -1px left margin

## Previous / Next Buttons

- Horizontal padding: 12px, height: 36px
- First item: 6px radius on inline-start side
- Last item: 6px radius on inline-end side

## Active Page Item

- Text: blue color
- Background: foreground at 4%
- Hover text: blue (stays same)

## Rules

- Display as flex with -1px child overlap for seamless borders
- Items: transparent background, border token, foreground at 60% text
- Active: blue text, foreground at 4% background
- First item: rounded start, Last item: rounded end
- All items need hover and focus states
