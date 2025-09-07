# Mubdi AI - Neon-Glow Visual Identity & Style Guide

This document outlines the visual design system for the Mubdi AI application, centered around a futuristic "Neon-Glow" aesthetic with a strong foundation in Arabic design principles.

## 1. Color Palette

The palette is designed to be dark, immersive, and highlighted with vibrant, glowing colors to create a sense of digital energy and focus.

| Role | Color | Hex Code | Usage |
| :--- | :--- | :--- | :--- |
| **Background** | Deep Void | `#0D0B14` | Main application background. |
| **Primary Surface** | Dark Matter | `#1A1823` | Card backgrounds, modals, and primary containers. |
| **Borders & Dividers**| Cosmic Line | `#353241` | Subtle borders and separators. |
| **Primary Neon** | Electric Purple | `#A855F7` | Main interactive elements, CTAs, active states. |
| **Accent Neon** | Cyber Blue | `#3B82F6` | Secondary actions, highlights, and gradients. |
| **Text - Primary** | Near White | `#F0F0F5` | Main body text and headings. |
| **Text - Secondary**| Starlight | `#A0A0B2` | Subheadings, descriptions, and placeholder text. |
| **Success** | Galactic Green | `#22C55E` | Success notifications and confirmation messages. |
| **Error** | Solar Flare Red | `#EF4444` | Error messages and critical alerts. |

### Glow Effect

A key part of the identity is the "Neon-Glow" effect around interactive elements. This should be achieved using `drop-shadow` for a more realistic glow that doesn't affect the element's layout.

- **Standard Glow:** `filter: drop-shadow(0 0 6px var(--color-primary-neon-translucent));`
- **Intense Glow (Hover/Active):** `filter: drop-shadow(0 0 12px var(--color-primary-neon));`

## 2. Typography

The typography is chosen to be modern, legible, and elegant, with a focus on a premium Arabic font.

- **Primary Font:** 'Cairo', sans-serif
- **Weights:** 400 (Regular), 600 (Semi-Bold), 700 (Bold)

| Element | Font Size | Weight | Letter Spacing | Usage |
| :--- | :--- | :--- | :--- | :--- |
| **Heading 1** | 2.5rem (40px) | 700 | Normal | Main page titles. |
| **Heading 2** | 2rem (32px) | 700 | Normal | Section titles. |
| **Heading 3** | 1.5rem (24px) | 600 | Normal | Card titles, sub-section titles. |
| **Body** | 1rem (16px) | 400 | Normal | Main text content. |
| **Button/CTA** | 1rem (16px) | 600 | Wide | Call-to-action buttons. |
| **Caption** | 0.875rem (14px)| 400 | Normal | Helper text, metadata. |

## 3. Iconography

Icons should be clean, modern, and line-based. When active or hovered, they should adopt the neon glow effect.

- **Style:** Thin, consistent stroke width.
- **Format:** SVG for scalability and easy color manipulation.
- **Interaction:** On hover/focus, icons should emit a subtle glow using the primary or accent neon color.

## 4. Component States

All interactive components must have clear visual states to provide user feedback.

- **Default:** The standard, resting state of a component.
- **Hover:** The state when a user's cursor is over the component. Should trigger a subtle glow and/or a slight change in background color.
- **Focus:** When a component is selected via keyboard navigation. Should be clearly indicated with a distinct outline or a more intense glow.
- **Active/Pressed:** When a component is being clicked or tapped. Should have a visible change, like a slightly stronger glow or a subtle scale-down effect.
- **Disabled:** The component is not interactive. Should have reduced opacity and no interactive feedback.

## 5. Animations & Micro-interactions

Animations should be smooth, purposeful, and enhance the futuristic feel without being distracting.

- **Timing:** Use ease-in-out timing functions for most transitions (e.g., `transition: all 0.3s ease-in-out;`).
- **Loading:** A custom loading animation that incorporates the neon glow, perhaps a pulsing orb or a spinning geometric shape.
- **Page Transitions:** Subtle fade-in and slide-up transitions for new content.
- **Micro-interactions:**
  - **Button Clicks:** A soft, quick pulse of light.
  - **Toggles/Switches:** A smooth slide with a glowing trail.
  - **Success/Error:** A subtle shake or a gentle pulse of the relevant color.