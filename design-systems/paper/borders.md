# Borders

## Width Scale

| Context | Width |
|---|---|
| Default (cards, inputs, dividers) | 1px |
| Emphasis / focus | 2px |
| Hairline (retina-aware) | 0.5px on 2x displays, 1px otherwise |

## Border Colors

| Context | Light mode | Dark mode |
|---|---|---|
| Default border | border (#DEDECB) | border (#424242) |
| Subtle outline | foreground at 6% | white at 10% |
| Hover outline | foreground at 12–20% | white at 15–20% |
| Dark border | border-dark (#2C2C2C) | border-dark (#424242) |
| Divider (inline) | foreground at 4% | foreground at 4% |

## Rules

- Use solid borders by default
- Prefer CSS `outline` over `border` for card/surface boundaries (avoids layout shift)
- Dashed borders only for special cases like file dropzones
- Components in the same family must use matching border widths
- Never mix 1px and 2px borders within a single component
- Use `--hairline` (0.5px on retina, 1px otherwise) for ultra-subtle separators

## Usage

| Context | Approach |
|---|---|
| Cards / containers | outline 1px, foreground at 6–8% |
| Inputs / selects | 1px border, border token; 2px on focus |
| Buttons | outline or transparent border depending on variant |
| Dividers / separators | 1px solid border token or foreground at 4% |
| Nav scroll shadow | 1px bottom shadow-subtle |
