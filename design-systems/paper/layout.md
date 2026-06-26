# Layout & Spacing

## Spacing Rhythm

Base unit: **4px** (Paper uses a tighter grid). All spacing values should be multiples of 4px, with 8px as the comfortable minimum for most UI gaps.

| Context | Value |
|---|---|
| Section vertical padding | 60px (mobile), 90–120px (desktop) |
| Section header → content | 40px or 60px |
| Heading → paragraph | 16–24px |
| Container horizontal padding | 16px (mobile), 28px (sm+) |
| Flex/grid row gap | 8–16px |
| Card grid gap | 24–30px |
| Wide component grid gap | 30px |
| Column layout gap | 40–60px |
| Card internal padding | 30px (mobile), 40px (laptop), 60px (desktop) |

## Container

Standard content container: fluid width with max-width constraints, centered, responsive horizontal padding.

| Breakpoint | Max width | Padding |
|---|---|---|
| Mobile (default) | fluid | 16px |
| Small (≥640px) | fluid | 28px |
| Laptop (≥900px) | 1080px | 28px |
| Wide (≥1140px) | 1080px | 0 |
| Desktop (≥1471px) | 1321px | 0 |

Every major section wraps content in this container.

## Content Composition Order

Inside each section, follow this order:
1. Heading (`h1`–`h3`)
2. Leading paragraph
3. Normal paragraph(s)
4. Lists, CTA links, or component grids

## Section Pattern

Each section has:
- Responsive vertical padding (60px mobile → 120px desktop)
- A background color (paper-50 or cream, alternate as needed)
- A centered container with responsive max-width
- A section header area with 40–60px bottom margin
- Section content below

## Motion & Animation

- Prefer CSS-native: `transition`, `animation`, `@keyframes`. Use Motion library only when CSS cannot achieve the behavior.
- Prioritize high-impact orchestrated moments over scattered micro-interactions. Use staggered `animation-delay` for page-load sequences (Paper uses a custom `enter` animation: translateY + blur + opacity).
- Reserve scroll-triggered and hover transitions for moments that reinforce hierarchy or reward attention.
- Default transition durations: 100ms (micro), 150ms (interactive), 200–300ms (content transitions), 500–800ms (page animations).

## Backgrounds & Visual Depth

- Default to warm, paper-like backgrounds — paper-50 (#FCFCF9) and cream (#EFEFE4)
- Apply contextual treatments: noise textures (texture.png), grid overlays (grid.svg), ruler patterns — aligned with Paper's editorial aesthetic
- Texture overlays use multiply blend mode at 50% opacity (light) or 20% opacity (dark)
- Grid overlays use mix-blend-mode: overlay at 30% opacity
- Every decorative element must serve a compositional purpose (depth, separation, or emphasis). No purely ornamental effects competing with content.

### Paper Texture (required on every section)

Every `<section>` MUST include a subtle paper-grain overlay to reinforce the editorial, stationery feel. Add an absolutely positioned `<div>` as the first child of the section with the following inline styles. Do NOT define these as a CSS class — apply them directly.


**Dark mode adjustment:** When `prefers-color-scheme: dark`, switch `opacity` to `0.04` and `blend-mode` to `overlay`. Apply via a media query or by reading theme context.

Do NOT skip this on any section — it is a core part of the Paper aesthetic.

### Ruler Pattern (for mockup / blueprint areas)

Sections that contain wireframes, layout blueprints, or component showcases should additionally include a ruler overlay. This creates faint horizontal ruled lines (like notebook paper) with a subtle red margin line (like real ruled paper). Apply inline styles directly — do NOT define a CSS class.

```jsx
<div className="relative overflow-hidden ...">
  {/* Ruler pattern overlay */}
  <div
    className="absolute inset-0 pointer-events-none z-0"
    style={{
      backgroundImage: [
        'linear-gradient(to bottom, var(--foreground) 0px, transparent 1px)',
        'linear-gradient(to right, rgba(190,60,60,0.18) 0px, rgba(190,60,60,0.18) 1px, transparent 1px)',
      ].join(', '),
      backgroundSize: '100% 24px, 60px 100%',
      backgroundPosition: '0 0, 0 0',
      opacity: 0.07,
    }}
  />
  {/* Content — relative z-10 */}
  <div className="relative z-10">...</div>
</div>
```

**Dark mode:** Reduce `opacity` to `0.05`.

#### When to use each

| Situation | Paper grain | Ruler pattern |
|---|---|---|
| Normal content section | Yes | No |
| Hero / CTA section | Yes | No |
| Wireframe / layout blueprint showcase | Yes | Yes (stack both) |
| Code preview section | Yes | No |
| Footer | Yes | No |

## Must

- All containers: responsive max-width with centered alignment
- Section headers: 40px or 60px bottom margin
- Consistent vertical rhythm, no crowded sections
- Layouts readable and properly spaced on both desktop and mobile
- Smooth scrolling enabled, scroll-padding-top for fixed headers
