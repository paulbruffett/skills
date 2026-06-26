# Typography

> Dependencies: `colors.md`

## Core Rules

- **Font:** [Montserrat](https://fonts.google.com/specimen/Montserrat), system-ui — the primary and unique typeface for Paper. Configured at app level via `--default-font-family` and loaded from Google Fonts via `next/font/google`. Never override with another font.
- **Headings:** medium weight (500), foreground text color, **Not** 600 — headings use 500 to preserve the warm, editorial feel.
- **Body copy:** foreground at 90% opacity, never use blue for paragraphs
- **Semantic HTML:** Use `h1`–`h6` in order, never skip levels
- **Anti-aliasing:** Always enable `-webkit-font-smoothing: antialiased` and `-moz-osx-font-smoothing: grayscale`

## Font Weight Scale

| Name | Value | Usage |
|---|---|---|
| Light | 300 | Decorative, large display text |
| Normal | 400 | Body text, paragraphs |
| Medium | 500 | **Headings**, emphasis, UI labels, buttons, nav items |
| Semibold | 600 | Strong emphasis, hero text (use sparingly) |
| Bold | 700 | Maximum emphasis (use very sparingly) |

## Type Scale

| Token | Size | Line-height |
|---|---|---|---|
| text-xs | 14px | 20px |
| text-sm | 16px | 24px |
| text-base | 18px | 28px |
| text-lg | 24px | 32px |
| text-xl | 30px | 38px |
| text-2xl | 40px | 48px |
| text-3xl | 48px | 52px |
| text-4xl | 64px | 68px |

## Heading Scale

### Desktop (≥1471px)
| Element | Size | Line-height |
|---|---|---|---|
| `h1` | 64px (text-4xl) | 68px |
| `h2` | 48px (text-3xl) | 52px |
| `h3` | 40px (text-2xl) | 48px |
| `h4` | 30px (text-xl) | 38px |
| `h5` | 24px (text-lg) | 32px |
| `h6` | 18px (text-base) | 28px |

### Laptop (≥900px)
| Element | Size | Line-height |
|---|---|---|---|
| `h1` | 48px (text-3xl) | 52px |
| `h2` | 40px (text-2xl) | 48px |
| `h3` | 30px (text-xl) | 38px |
| `h4` | 24px (text-lg) | 32px |
| `h5` | 18px (text-base) | 28px |
| `h6` | 16px (text-sm) | 24px |

### Mobile (default)
| Element | Size | Line-height |
|---|---|---|---|
| `h1` | 40px (text-2xl) | 48px |
| `h2` | 30px (text-xl) | 38px |
| `h3` | 24px (text-lg) | 32px |
| `h4` | 18px (text-base) | 28px |
| `h5` | 16px (text-sm) | 24px |
| `h6` | 14px (text-xs) | 20px |

Mobile-first: start with mobile sizes, scale up at laptop and desktop breakpoints.

## Paragraphs

### Leading Paragraph
- Size: 18px (text-base)
- Weight: normal (400)
- Color: foreground at 90%
- Line-height: 28px
- Max width: ~750px

### Normal Paragraph
- Size: 18px (text-base)
- Weight: normal (400)
- Color: foreground at 90%
- Line-height: 28px (or 32px for long-form content)
- Max width: ~750px

### Small Supporting Copy
- Size: 14px (text-xs)
- Weight: normal (400)
- Color: foreground at 50–60%
- Line-height: 20px
- Use for helper text, legal text, captions, metadata

## UI Labels

| Context | Size | Weight |
|---|---|---|
| Button labels | 16px (text-sm) | medium (500) |
| Input labels | 14px or 16px | medium (500) |
| Nav items | 14px (text-xs) | medium (500) |
| Captions / meta / badges | 12px or 14px | normal (400) or medium (500) |
| Uppercase labels | 12px | medium (500), 0.06em letter-spacing |

Do not apply paragraph line-height (28px+) to control labels.

## Links

- **Inline links:** Same size as surrounding text, underline with foreground at 20% decoration color, hover → foreground at 60% decoration color
- **CTA links:** blue color, medium weight, no underline by default, hover → underline
- **Focus:** Remove underline, show 2px focus ring in blue-400

## Code / Monospace

- Font: JetBrains Mono, SFMono-Regular, Menlo, monospace
- Inline code: 0.85em relative size, foreground at 4% background, 4px padding
- Code blocks: 12px size, 20px line-height, foreground at 4% background with matching outline

## Emphasis

- `<strong>` for high-priority emphasis in body text
- `<em>` for tone emphasis only (renders as italic via font-variation-settings)
- All-caps only for short labels: uppercase, 0.06em letter-spacing, 12px, medium (500) weight

## Dark Mode

Hierarchy stays identical. Only color tokens change (automatic via CSS custom properties). Size, weight, and spacing remain constant.
