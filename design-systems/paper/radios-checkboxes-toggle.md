# Radios, Checkboxes & Toggles

> Dependencies: `colors.md`, `radius.md`

## Checkbox

- Size: 16x16px
- Radius: 4px
- Border: 1px, border token
- Background: transparent (unchecked) / blue-400 (checked)
- Focus ring: 2px, focus (blue-400)

### Disabled
- Border: foreground at 8%
- Text: fg-disabled
- Opacity: 0.7

## Radio

- Size: 16x16px
- Radius: fully rounded
- Border: 1px, border token
- Background: transparent (unchecked)
- Focus ring: 2px, focus (blue-400)
- Checked: blue-400 border, indicator: white dot

### Disabled
- Border: foreground at 8%
- Text: fg-disabled
- Opacity: 0.7

Group all radio items under the same `name` attribute.

## Toggle

### Track
- Fully rounded
- Background: gray-300 (light) / gray-700 (dark)
- Focus-within ring: 2px, focus (blue-400)
- Checked track: blue-400 background
- Disabled track: foreground at 8% background

### Thumb
- Fully rounded
- Background: white
- Border: 1px, foreground at 6%

### Disabled
- Track: foreground at 8% background
- Thumb: foreground at 20%
- Label: fg-disabled text
- Opacity: 0.7

## Rules

- All selection inputs must have `id` matching label `htmlFor`
- Focus states use blue-400 (focus token) for all control types
- Disabled states: no hover/focus interaction, reduced opacity
