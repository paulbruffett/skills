# Modals

> Dependencies: `colors.md`, `radius.md`, `shadows.md`, `buttons.md`, `inputs.md`

## Core Specs

### Overlay (Backdrop)
- Fixed, covers full screen
- Z-index: 40
- Background: black at 40% opacity
- Backdrop blur: small amount (optional)

### Content Container
- Background: surface (white light / gray-900 dark)
- Outline: 1px, foreground at 6% (light) / white at 10% (dark)
- Radius: 6px (base)
- Shadow: shadow-sm
- Padding: 20px

## Anatomy

### Header
- Bottom border: border token
- Top corners rounded (6px)
- Title: 20px, medium weight (500), foreground color
- Close button: Ghost variant from `buttons.md`, 6px padding

### Body
- Vertical padding: 24px
- Vertical spacing between elements: 24px
- Text: 18px (text-base), 28px line-height, foreground at 90%

### Footer
- Top border: border token
- Bottom corners rounded (6px)

## Variants

### Default (Information)
Standard header + body + footer with primary/secondary action buttons.

### Pop-up (Confirmation)
Centered text, prominent icon, reduced padding:
- Body: 24px padding, text centered
- Icon: centered, 16px bottom margin, 48x48px, foreground at 40%

### Form Modal
Body contains inputs following `inputs.md`. Vertical spacing between form elements: 16px.

## Rules

- Backdrop covers full screen with fixed positioning
- Content: surface background, 6px radius, outline-first elevation
- Header/Footer separated by border-token borders
- Close button must be present and functional
- Accessibility: `role="dialog"`, implement focus trap in code
- Dark mode automatic via token system
