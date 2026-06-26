# Content & Grid System

> Dependencies: `layout.md`, `typography.md`

## Containers

| Type | Max width | Horizontal padding |
|---|---|---|
| Standard (mobile) | fluid | 16px |
| Standard (≥640px) | fluid | 28px |
| Standard (≥900px) | 1080px | 28px |
| Standard (≥1140px) | 1080px | 0 |
| Standard (≥1471px) | 1321px | 0 |
| Internal (reading) | 750px | — (45–75 char line length) |

## Vertical Padding

| Breakpoint | Vertical padding |
|---|---|
| Mobile | 32–42px |
| Tablet (≥640px) | 48–60px |
| Laptop (≥900px) | 60–90px |
| Desktop (≥1471px) | 84–120px for hero/feature sections |

## Grid System

Mobile-first with flexible desktop configurations.

| Context | Gap |
|---|---|
| Standard content/cards | 24–30px |
| Compact widgets/metadata | 8–16px |

### Responsive Columns

| Breakpoint | Columns |
|---|---|
| Mobile (default) | 1 |
| Small (≥640px) | 1–2 |
| Tablet (≥700px) | 2 |
| Laptop (≥900px) | 2–3 |
| Desktop (≥1471px) | 2–4+ |

Full support for multi-column grids where needed.

## Breakpoints

| Name | Width |
|---|---|
| Extra small | 480px |
| Phone | 600px |
| Small | 640px |
| Tablet | 700px |
| Medium | 800px |
| Laptop | 900px |
| Wide | 1080px |
| Desktop | 1471px |
| Large | 1600px |
| Extra large | 1800px |

## Rules

- Always design mobile-first
- Use layout shifts (column → row) to accommodate horizontal space
- Lists: 24px indentation, 8px vertical gap between items
- Body copy: 18px (text-base), 28px line-height, 0.01em letter-spacing
- All interactive links follow Paper's underline decoration protocol (foreground at 20%, hover → 60%)
- Card padding scales: 30px (mobile), 40px (laptop), 60px (desktop)
