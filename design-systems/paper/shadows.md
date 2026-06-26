# Shadows

Paper Design favors thin outlines and subtle depth over heavy box-shadows. Elevation is expressed through fine borders and restrained shadow layers.

## Shadow Tokens

| Token | CSS value |
|---|---|
| shadow-subtle | `0 1px 0 0 rgba(0, 0, 0, 0.08)` |
| shadow-sm | `0 2px 4px rgba(0, 0, 0, 0.08)` |
| shadow-card | `0 0 0 1px rgba(0, 0, 0, 0.06)` (outline approach) |
| shadow-hero | `0 0 0 1px rgba(128, 128, 128, 0.15), 0 93px 26px transparent, 0 59px 24px rgba(0, 0, 0, 0.01), 0 33px 20px rgba(0, 0, 0, 0.05), 0 15px 15px rgba(0, 0, 0, 0.09), 0 4px 8px rgba(0, 0, 0, 0.1)` |
| shadow-button | `inset 0 1px rgba(255, 255, 255, 0.12), inset 0 -1px rgba(0, 0, 0, 0.12)` |

## Outline-based Elevation

Paper prefers CSS `outline` over `box-shadow` for card and surface boundaries:

| Context | Light mode | Dark mode |
|---|---|---|
| Cards / surfaces | outline 1px, foreground at 6–8% | outline 1px, white at 10% |
| Hover emphasis | outline 1px, foreground at 12–20% | outline 1px, white at 15–20% |
| Borders / dividers | 1px solid border token | 1px solid border token |

## Component Mapping

| Component type | Approach |
|---|---|
| Cards, containers | Outline 1px (foreground at 6%), no box-shadow |
| Buttons (blue CTA) | Gradient background + inset shadow-button |
| Buttons (secondary) | Outline or border, no shadow |
| Nav bar scroll state | shadow-subtle (1px bottom line) |
| Hero images | shadow-hero (dramatic multi-layer) |
| Modals, overlays | Backdrop blur + dark overlay, shadow-sm on content |
| Tooltips, popovers | shadow-sm + outline |
| Inputs | Outline 1px, no shadow |

## Rules

- Default to outlines (1–2px, foreground/6–12%) over box-shadows for most surfaces
- Shadows are used sparingly — only for hero elements, floating overlays, and CTA buttons
- In dark mode, outlines shift to white at 10–15% opacity
- Never stack multiple shadow tokens on one element
- Never use heavy shadows for dense list items or body containers
- Keep elevation minimal and paper-like — the aesthetic is flat and editorial
