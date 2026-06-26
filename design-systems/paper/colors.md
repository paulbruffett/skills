# Color Tokens

> All values are CSS custom properties defined in `globals.css`. Reference them by token name. They handle light/dark mode automatically.

## Core Palette

### Paper (warm whites)
| Token | Value |
|---|---|
| paper-50 | #FCFCF9 |
| paper-100 | #EFEFE4 |
| paper-200 | #DEDECB |

### Gray (warm neutrals)
| Token | Value |
|---|---|
| gray-50 | #F5F5F2 |
| gray-100 | #EAEAE7 |
| gray-200 | #D7D7D6 |
| gray-300 | #C1C1C0 |
| gray-400 | #A8A8A8 |
| gray-500 | #909090 |
| gray-600 | #666666 |
| gray-700 | #5B5B5B |
| gray-800 | #424242 |
| gray-900 | #2C2C2C |
| gray-950 | #222222 |

### Blue (accent)
| Token | Value |
|---|---|
| blue-300 | #A4C6F7 |
| blue-400 | #81ADEC |
| blue-500 | #5D8CD7 |

### Base
| Token | Value |
|---|---|
| black | #000000 |
| white | #FFFFFF |

## Semantic Tokens

### Background
| Token | Light | Dark |
|---|---|---|
| root | paper-100 (#EFEFE4) | gray-950 (#222222) |
| background | paper-50 (#FCFCF9) | gray-950 (#222222) |
| surface | white (#FFFFFF) | gray-900 (#2C2C2C) |
| cream | paper-100 (#EFEFE4) | gray-900 (#2C2C2C) |
| raised | gray-50 (#F5F5F2) | gray-950 (#222222) |

### Foreground / Text
| Token | Light | Dark |
|---|---|---|
| foreground | gray-950 (#222222) | paper-100 (#EFEFE4) |
| off-black | gray-950 (#222222) | #010101 |
| muted | gray-500 (#909090) | gray-400 (#A8A8A8) |
| dark-gray | gray-600 (#666666) | gray-600 (#666666) |

### Border
| Token | Light | Dark |
|---|---|---|
| border | paper-200 (#DEDECB) | gray-800 (#424242) |
| border-dark | gray-900 (#2C2C2C) | gray-800 (#424242) |

### Accent / Interactive
| Token | Light | Dark |
|---|---|---|
| blue | blue-400 (#81ADEC) | blue-400 (#81ADEC) |
| light-blue | blue-300 (#A4C6F7) | blue-300 (#A4C6F7) |
| focus | #81ADEC | #81ADEC |
| selection | #8AB9FF at 50% opacity | #8AB9FF at 50% opacity |

### Opacity-based Surfaces
| Token | Light | Dark |
|---|---|---|
| foreground/4 | foreground at 4% | foreground at 4% |
| foreground/8 | foreground at 8% | foreground at 8% |
| foreground/10 | foreground at 10% | foreground at 10% |
| foreground/12 | foreground at 12% | foreground at 12% |
| foreground/6 (border) | foreground at 6% | foreground at 6% |
| black/5 | black at 5% | — |
| black/8 (border) | black at 8% | white at 8% |
| black/10 | black at 10% | white at 10% |
| white/10 | — | white at 10% |
| white/15 | — | white at 15% |

### Status
| Token | Light | Dark |
|---|---|---|
| success-soft | #ECFDF5 | #002C22 |
| success | #007A55 | #009966 |
| success-strong | #006045 | #007A55 |
| danger-soft | #FEF0F2 | #4D0218 |
| danger | #C70036 | #C70036 |
| danger-strong | #A50036 | #A50036 |
| warning-soft | #FFF7ED | #7C2D12 |
| warning | #F97316 | #F97316 |
| warning-strong | #C2410C | #C2410C |

### Status Text
| Token | Light | Dark |
|---|---|---|
| fg-success | #047857 | #10B981 |
| fg-danger | #BE123C | #F43F5E |
| fg-warning | #EA580C | #FBBF24 |
| fg-disabled | gray-400 (#A8A8A8) | gray-600 (#666666) |

### Status Border
| Token | Light | Dark |
|---|---|---|
| border-success | #047857 | #065F46 |
| border-danger | #BE123C | #BE123C |
| border-warning | #EA580C | #F97316 |

## Semantic Usage Rules

- Page backgrounds: root (cream) or background (paper-50)
- Cards / surfaces: surface (white light, gray-900 dark) with thin outline borders
- Headings: foreground color
- Body text: foreground at 90% opacity, or foreground at 60–80% for secondary text
- Links: blue token, underline with foreground at 20% decoration color
- Default borders: border token, or foreground at 6% for subtle card outlines
- Focus rings: 2px solid focus (blue-400) with 2px offset
- Status borders match intent: success → border-success, danger → border-danger, warning → border-warning
- Disabled: foreground at 8% background + fg-disabled text
- Dark mode cards: outline 1px solid white at 10%

## Prohibited

- No raw hex/rgb values in component code — always use design tokens
- No blue text color for long-form paragraphs
- No status/accent text for body copy or navigation
- No brand backgrounds for large layout surfaces — backgrounds are always warm paper/cream tones
- No manual light/dark value swapping — let the CSS custom properties handle it
- No cool/blue-tinted grays — this palette is warm and paper-like throughout
