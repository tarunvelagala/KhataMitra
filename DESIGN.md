---
version: "1.0"
name: KhataPro
description: A clean, trustworthy design system for small business bookkeeping. Semantic financial colors (green=income, red=expense) over a platform-neutral token system — Material 3 on Android, HIG-compliant on iOS.
colors:
  primary: "#1565C0"
  on-primary: "#FFFFFF"
  primary-container: "#D6E3FF"
  on-primary-container: "#001B3D"
  primary-fixed: "#D6E3FF"
  primary-fixed-dim: "#A9C7FF"
  on-primary-fixed: "#001B3D"
  on-primary-fixed-variant: "#00468C"
  inverse-primary: "#A9C7FF"
  surface-tint: "#1565C0"
  secondary: "#2E7D32"
  on-secondary: "#FFFFFF"
  secondary-container: "#A3F69C"
  on-secondary-container: "#002204"
  secondary-fixed: "#A3F69C"
  secondary-fixed-dim: "#88D982"
  on-secondary-fixed: "#002204"
  on-secondary-fixed-variant: "#005312"
  tertiary: "#C62828"
  on-tertiary: "#FFFFFF"
  tertiary-container: "#FFDAD6"
  on-tertiary-container: "#410003"
  tertiary-fixed: "#FFDAD6"
  tertiary-fixed-dim: "#FFB4AC"
  on-tertiary-fixed: "#410003"
  on-tertiary-fixed-variant: "#93000E"
  error: "#BA1A1A"
  on-error: "#FFFFFF"
  error-container: "#FFDAD6"
  on-error-container: "#410002"
  surface: "#FAF9FD"
  surface-dim: "#DAD9DD"
  surface-bright: "#FAF9FD"
  surface-container-lowest: "#FFFFFF"
  surface-container-low: "#F4F3F7"
  surface-container: "#EFEDF1"
  surface-container-high: "#E9E7EC"
  surface-container-highest: "#E3E2E6"
  on-surface: "#1A1B1E"
  on-surface-variant: "#44474E"
  inverse-surface: "#2F3033"
  inverse-on-surface: "#F1F0F4"
  surface-variant: "#E0E2EC"
  outline: "#74777F"
  outline-variant: "#C4C6CF"
  background: "#FAF9FD"
  on-background: "#1A1B1E"
typography:
  display-lg:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 57px
    fontWeight: "400"
    lineHeight: 64px
    letterSpacing: -0.25px
  display-md:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 45px
    fontWeight: "400"
    lineHeight: 52px
  display-sm:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 36px
    fontWeight: "400"
    lineHeight: 44px
  headline-lg:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 32px
    fontWeight: "800"
    lineHeight: 40px
    letterSpacing: -0.5px
  headline-md:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 28px
    fontWeight: "700"
    lineHeight: 36px
    letterSpacing: -0.25px
  headline-sm:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 24px
    fontWeight: "700"
    lineHeight: 32px
  title-lg:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 22px
    fontWeight: "700"
    lineHeight: 28px
  title-md:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 16px
    fontWeight: "600"
    lineHeight: 24px
    letterSpacing: 0.15px
  title-sm:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 14px
    fontWeight: "600"
    lineHeight: 20px
    letterSpacing: 0.1px
  body-lg:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 16px
    fontWeight: "400"
    lineHeight: 24px
    letterSpacing: 0.5px
  body-md:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 14px
    fontWeight: "400"
    lineHeight: 20px
    letterSpacing: 0.25px
  body-sm:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 12px
    fontWeight: "400"
    lineHeight: 16px
    letterSpacing: 0.4px
  label-lg:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 14px
    fontWeight: "600"
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 12px
    fontWeight: "500"
    lineHeight: 16px
    letterSpacing: 0.5px
  label-sm:
    fontFamily: .AppleSystemUIFont, Roboto
    fontSize: 11px
    fontWeight: "700"
    lineHeight: 16px
    letterSpacing: 1px
rounded:
  sm: 12px
  md: 16px
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  button-padding-v: 20px
  button-padding-h: 24px
  input-padding-v: 20px
  input-padding-h: 16px
  screen-margin: 24px
  section-gap: 32px
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.label-lg}"
    rounded: "{rounded.sm}"
    height: 48px
    padding: 20px 24px
  button-secondary:
    backgroundColor: transparent
    textColor: "{colors.primary}"
    typography: "{typography.label-lg}"
    rounded: "{rounded.sm}"
    height: 48px
    padding: 20px 24px
  button-tertiary:
    backgroundColor: transparent
    textColor: "{colors.primary}"
    typography: "{typography.label-lg}"
    height: 48px
  card-default:
    backgroundColor: "{colors.surface-container-lowest}"
    rounded: "{rounded.sm}"
  card-selected:
    backgroundColor: "{colors.surface-container-lowest}"
    rounded: "{rounded.sm}"
  card-icon-container:
    backgroundColor: "{colors.primary}"
    rounded: "{rounded.md}"
    padding: 16px
    # backgroundColor is applied at 8% opacity at runtime (e.g. primary.withOpacity(0.08))
  input-field:
    backgroundColor: "{colors.surface-container-high}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body-lg}"
    rounded: "{rounded.sm}"
    padding: 20px 16px
  step-indicator-active:
    backgroundColor: "{colors.primary}"
    rounded: "{rounded.full}"
    size: 8px
  step-indicator-inactive:
    backgroundColor: "{colors.outline-variant}"
    rounded: "{rounded.full}"
    size: 8px
  badge-status:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
  income-indicator:
    backgroundColor: "{colors.secondary-container}"
    textColor: "{colors.on-secondary-container}"
    rounded: "{rounded.sm}"
  expense-indicator:
    backgroundColor: "{colors.tertiary-container}"
    textColor: "{colors.on-tertiary-container}"
    rounded: "{rounded.sm}"
---

# KhataPro Design System

**Stitch Project:** [3823020204310937544](https://stitch.withgoogle.com/project/3823020204310937544)

---

## Screens

This section is the authoritative index of every screen in the app. Each entry names the screen, its route, its Stitch frame, and which features it belongs to. When implementing a screen:

1. Open the Stitch frame linked below for layout and visual intent.
2. Apply DESIGN.md tokens (colors, typography, spacing, radii). DESIGN.md wins on any conflict with Stitch.
3. Complete the Production Validation checklist in § Engineering Standards before marking done.

**How to add a new screen:** Copy the template at the bottom of this section, fill in every field, and add the row to the correct feature group. Never start implementing a screen that isn't registered here — the table is the contract between design and engineering.

---

### Tour

A 3-slide horizontal swipeable intro shown once on first launch. Communicates three core value propositions before the user sets anything up. After the last slide, "Get Started" navigates to `/home` (onboarding TBD). A "Skip" link on every slide jumps to the same destination.

**Stitch reference screens** (layout/structure reference only — all tokens, fonts, and behavior follow DESIGN.md): see `.stitch/README.md` for asset status.

**Canonical slide content:**

| # | Headline | Body copy | Illustration |
|---|---|---|---|
| 1 | Track every rupee | Add customers, record what they owe you or you owe them. Balances update instantly. | Tilted smartphone frame showing ledger with green +₹1,250 and blue −₹400 entries, circular FAB |
| 2 | Send reminders easily | Send payment reminders via WhatsApp or SMS in one tap. Even attach your visiting card. | White card with a green `secondary` circular send button, a green pill bar, and a horizontal floating pill |
| 3 | Your data, always safe | Everything is stored privately on your phone. No account needed. Works offline too. | White rounded-square card containing filled shield icon in `primary`, "OFFLINE SAFE" green pill; beneath: PRIVATE · ANONYMOUS · LOCAL icon+label row |

**Layout — every slide shares this skeleton:**
```
Scaffold(backgroundColor: tourBg)   // tourBg = const Color(0xFFF2F3F5)
└── SafeArea
    ├── Header — 3 dot indicators, centered, top padding 24px
    ├── Body (Expanded, centered column, horizontal padding 32px)
    │   ├── Illustration area — 200–280px tall, centered
    │   ├── Headline — AppTextStyles.headlineMd (28px w700), on-surface, center
    │   ├── Body copy — AppTextStyles.bodyLg (16px w400), on-surface-variant, center, max-width 280px
    │   └── Swipe hint (slides 1–2 only) — "SWIPE TO EXPLORE" labelSmall + swipe icon, 60% opacity
    └── Footer
        ├── background: surface-container-lowest (white), top radius 24px, shadow (4% opacity, 12px blur)
        ├── padding: 24px horizontal, 24px top, (16px + safe-area-bottom) bottom
        ├── CTA button — full-width, 48dp height, pill-shaped (AppDimensions.radiusPill), primary fill
        │   Slides 1–2: "Next"   |   Slide 3: "Get Started"
        └── Skip — TextButton, primary color, centered
```

**Dot indicator:**
- 3 dots, centered row, 8px gap
- Active: 10dp, `primary` fill
- Inactive: 8dp, `outline-variant` fill
- Animate active dot width 8→10dp on page change, 200ms ease-in-out; skip when `MediaQuery.disableAnimationsOf(context)` is true

**Navigation:**
- `PageView` — `BouncingScrollPhysics` on iOS, `ClampingScrollPhysics` on Android
- "Next" calls `pageController.nextPage(duration: 300ms, curve: easeInOut)`
- Swiping back past slide 1: no-op (PageView natural clamping)
- "Skip" and "Get Started" → `context.go('/home')` (update to `/onboarding` once onboarding is built)
- On "Get Started" or "Skip": write `SharedPreferences` key `tour_seen = true` so tour never shows again

**Illustrations — composed Flutter widgets, no images:**
- Slide 1: `Transform.rotate(-0.035 rad)` phone frame widget — dark rounded rectangle, `primary` status bar strip, two balance chips, 3 ledger rows with `secondary` green and `primary` blue amounts, circular FAB in `primary`
- Slide 2: White rounded card widget — green `secondary` circle with send icon, green `secondary-container` pill bar, floating rounded rectangle overlay
- Slide 3: White card (240×240, 40px radius) — `Icon(Icons.verified_user_rounded, size: 80)` in `primary`; below icon: pill chip with `secondary-container` bg, `on-secondary-container` text, "OFFLINE SAFE" label. Below card: Row of 3 `Column(icon, label)` widgets with `VerticalDivider` separators

**Key UI rules:**
- No `AppBar`, no back button on any slide
- Footer always white, 24px top radius, shadow — visually "floats" above slide content
- Bottom safe area inside footer, not outside
- Reduced motion: disable dot animation and instant page transitions
- Tour flag: `SharedPreferences` key `"tour_seen"`; router reads this on redirect

---

### App Shell

| Screen | Route | Stitch Frame | Notes |
|---|---|---|---|
| Splash | `/splash` | — | Custom `CustomPainter` mark; router redirect sends to `/tour` if `tourSeen=false`, else `/home` |
| Tour | `/tour` | see `.stitch/README.md` | 3-slide `PageView`; full spec in § Tour above |
| Home (shell) | `/home` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Bottom nav host — 3–5 top-level destinations |

---

### Dashboard

The entry point after launch. Shows the business financial summary and quick access to the most recent activity.

| Screen | Route | Stitch Frame | Notes |
|---|---|---|---|
| Dashboard | `/dashboard` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Hero balance (maskable), income/expense summary, recent transactions |

**Key UI rules for this feature:**
- Hero balance is maskable (eye toggle). Default: visible.
- Income/expense summary cards use `secondary-container` / `tertiary-container` backgrounds.
- Recent transactions list: max 5 rows, "See all" link to the full ledger.
- FAB: "Add entry" — navigates to the transaction creation sheet.

---

### Ledger (Transactions)

The core ledger — full transaction history with search, filter, and swipe actions.

| Screen | Route | Stitch Frame | Notes |
|---|---|---|---|
| Transaction list | `/ledger` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Grouped by date, pull-to-refresh, swipe actions |
| Add / Edit transaction | `/ledger/add`, `/ledger/:id/edit` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Modal bottom sheet or full screen |
| Transaction detail | `/ledger/:id` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Read-only view with edit / delete actions |

**Key UI rules for this feature:**
- Date section headers: sticky, `label-sm`, `on-surface-variant`.
- Transaction rows: amount right-aligned with `tabularFigures`, +/− icon for color-blind safety.
- Swipe right → mark paid (green). Swipe left → delete with confirmation dialog.
- Empty state: "No entries yet. Add your first transaction."

---

### Customers (Party Ledger)

Per-customer outstanding balance and transaction history — the "udhaar khata" (credit ledger) feature.

| Screen | Route | Stitch Frame | Notes |
|---|---|---|---|
| Customer list | `/customers` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Search bar, sorted by outstanding amount |
| Customer detail | `/customers/:id` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Balance header + transaction history |
| Add / Edit customer | `/customers/add`, `/customers/:id/edit` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Name, phone, opening balance |

**Key UI rules for this feature:**
- Outstanding balance: `secondary` (green) if they owe you, `tertiary` (red) if you owe them.
- Customer rows: avatar (initials, `primary-container` background), name, outstanding amount.
- FAB: "Add customer".

---

### Reports

Summaries and insights — daily/weekly/monthly P&L, top customers, cash flow.

| Screen | Route | Stitch Frame | Notes |
|---|---|---|---|
| Reports home | `/reports` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Period selector (day / week / month / custom) |
| P&L detail | `/reports/pnl` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Income vs expense breakdown |
| Cash flow | `/reports/cashflow` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Net movement over time |

**Key UI rules for this feature:**
- Charts: `secondary` color for income bars/lines, `tertiary` for expense. No other colors.
- Wrap chart widgets in `RepaintBoundary`.
- All amounts: Indian number format when locale is non-English.
- Period selector: segmented control (`CupertinoSegmentedControl` on iOS, custom `ToggleButtons` on Android).

---

### Settings

App preferences, business profile, backup/restore, and about.

| Screen | Route | Stitch Frame | Notes |
|---|---|---|---|
| Settings home | `/settings` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Grouped list of settings categories |
| Business profile | `/settings/business` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Shop name, type, logo |
| Language | `/settings/language` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | 8-language grid |
| Theme | `/settings/theme` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Light / Dark / System |
| Backup & Restore | `/settings/backup` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Export CSV / PDF, Google Drive backup |
| About | `/settings/about` | [open in Stitch](https://stitch.withgoogle.com/project/3823020204310937544) | Version, licenses, privacy policy |

**Key UI rules for this feature:**
- Settings rows: `ListTile` style, 48dp min height, `on-surface-variant` trailing chevron.
- Destructive settings (clear all data, sign out) use `tertiary` text color and are placed at the bottom of their group.
- Language and theme changes take effect immediately — no restart required.

---

### Template — adding a new screen

When a new feature or screen is designed, add it here before writing any Dart code:

```
### <Feature Name>

<One sentence describing what this feature does for the user.>

| Screen | Route | Stitch Frame | Notes |
|---|---|---|---|
| <Screen name> | `/<route>` | [open in Stitch](<stitch-url>) | <Key behaviour or constraint> |

**Key UI rules for this feature:**
- <Rule 1>
- <Rule 2>
```

---



KhataPro is a cross-platform (iOS + Android) digital bookkeeping app ("khata" = ledger in Hindi/Urdu) designed for small business owners across South Asia. The design system is **clean, trustworthy, and utilitarian** — built to instill confidence in users managing their finances, many of whom may be transitioning from paper ledgers to a digital tool for the first time.

The atmosphere is **airy and bright** in light mode, with generous whitespace and soft neutral surfaces that let the content breathe. In dark mode, the mood shifts to **deep ink-dark zinc tones** that feel modern and restful for evening use. The overall aesthetic is **professional without being corporate** — approachable enough for first-time digital users while maintaining the credibility expected of a financial tool.

The design philosophy uses **Material Design 3** as the token and component foundation on Android, and **Apple's Human Interface Guidelines (HIG)** as the behavioral and interaction foundation on iOS. The shared design system — color palette, typography scale, spacing, and border radii — is platform-neutral and applies identically on both. What adapts per platform is widget behavior and interaction patterns: Cupertino navigation bars, swipe-to-dismiss, iOS-style date pickers, and `BouncingScrollPhysics` on iOS; Material app bars, back gestures via `PopScope`, and `ClampingScrollPhysics` on Android. The result is an app that feels equally native on both platforms without maintaining two separate visual systems. There is no visual noise — every element earns its place.

## Colors

The palette is built around three semantically distinct hues that map directly to financial concepts. This mapping is the most critical design decision in KhataPro — it must be preserved across all screens.

- **Primary — Dependable Ledger Blue (#1565C0):** The brand's anchor color. A vivid mid-tone blue that conveys trust, stability, and professionalism. Used for CTAs, active states, navigation, and brand identity. It is the neutral "workspace" color — neither income nor expense.
- **Secondary — Prosperous Ledger Green (#2E7D32):** Semantically mapped to **income and credit**. Every green element signals money coming in. A confident forest green that feels positive without being flashy.
- **Tertiary — Alert Ledger Red (#C62828):** Semantically mapped to **expenses and debit**. Every red element signals money going out. A bold, unmistakable red that clearly signals cost without being confused with system errors.
- **Error — Signal Red (#BA1A1A):** Reserved strictly for validation errors, system failures, and destructive actions — never for financial data. Visually distinct from the tertiary expense red.
- **Neutral Surfaces (#FAF9FD → #FFFFFF):** An M3-derived tonal surface system with a subtle blue tint from the primary seed. Provides layered depth without competing with the semantic financial colors. The background carries a barely-perceptible cool cast; cards sit on pure white.
- **Outline (#74777F):** Cool Gray borders and dividers provide structure without drawing attention.

### Dark Mode

Dark mode uses M3-derived dark surfaces (`#121316` / `#1A1B1E`) with lightened versions of all semantic colors: Soft Sky Blue (`#A9C7FF`) for primary, Mint Leaf (`#88D982`) for income, and Salmon Blush (`#FFB4AC`) for expenses. All M3 tonal relationships are preserved.

## Typography

The design system uses the **platform system font** — SF Pro on iOS and Roboto on Android. This eliminates the network dependency of custom web fonts, reduces app bundle size, and ensures the app feels native on each platform. In Flutter, this means no `fontFamily` is set on `TextStyle` — the framework resolves the correct font per platform automatically.

Both SF Pro and Roboto support the full weight range (400–800) and have excellent legibility at all sizes, making them well-suited for a financial app where every digit matters.

- **Display:** Regular weight (400) at large sizes (36–57px) for visual impact through scale rather than boldness. Tight letter-spacing (-0.25px) keeps large text from feeling loose.
- **Headlines:** Bold to extra-bold weights (700–800) with tight letter-spacing (-0.50px to -0.25px) for density and authority.
- **Body:** Regular weight (400) with relaxed letter-spacing (+0.25px to +0.50px) for comfortable reading of descriptions and financial data.
- **Labels:** Medium to bold weights (500–700) with wide tracking (+0.50px to +1.00px) for small-size legibility on buttons, chips, and metadata.

## Layout

The layout follows a **fluid single-column model** optimized for mobile-first handheld use. Elements are generously spaced to ensure the interface never feels cramped — critical for users who may be new to digital tools.

- **Rhythm:** A strict 4px/8px baseline grid governs all dimensions. Every spacing value is a multiple of 4.
- **Screen margins:** 24px horizontal padding on each side. 32px top padding below the safe area.
- **Safe areas:** All screens must respect platform safe area insets. On iOS: the notch/Dynamic Island at the top and the home indicator bar at the bottom. On Android: the status bar at the top and the gesture navigation bar or soft-key bar at the bottom. Use `SafeArea` or `MediaQuery.viewPaddingOf` — never hard-code inset values.
- **Grouping:** Selection grids use 2-column layouts with 12–16px cross-axis spacing.
- **Composition:** Every screen follows a consistent vertical rhythm: icon container → step indicator → headline → subtitle → scrollable content → sticky CTA bar.
- **CTA Bar:** A gradient fade from transparent to solid surface (12px top, 24px bottom padding) anchors the primary action at the bottom of each screen.

## Elevation & Depth

The design is intentionally **flat** on both platforms. Cards, buttons, and navigation bars all sit at elevation 0. Depth is communicated through **tonal surface layering** — the same technique used by Material 3 on Android and by iOS's layered sheet system — rather than shadows:

- **Surface hierarchy:** Background (`#FAF9FD`) → Surface Container Low (`#F4F3F7`) → Surface Container (`#EFEDF1`) → Surface Container High (`#E9E7EC`). Each step is a subtle tonal shift, not a shadow.
- **Border contrast:** Selected cards gain a 2px primary-color border; unselected cards have a 1px `outline-variant` border.
- **Whisper-soft shadows:** Applied only to interactive selection cards when selected — rgba black at 4–6% opacity, 8–12px blur, 2px y-offset. These are the only shadows in the entire system.
- **App bar:** On Android, use a `AppBar` with background color at 80% opacity and zero elevation. On iOS, use `CupertinoNavigationBar` with the same background color; the frosted-glass blur is provided by Cupertino natively — do not suppress it.

This flatness reinforces the utilitarian, trustworthy aesthetic — nothing floats, nothing looms, everything feels grounded and reliable.

## Shapes

The shape language is **subtly rounded** — soft enough to feel modern and approachable, sharp enough to maintain a professional, structured feel.

- **Cards, buttons, inputs:** 12px corner radius (`rounded-sm`). Just enough softness to feel contemporary without being playful.
- **Icon containers:** 16px corner radius (`rounded-md`). Slightly more rounded to visually distinguish decorative elements from interactive ones.
- **Badges, chips, step indicators:** Fully pill-shaped (`9999px` / `rounded-full`). Used for small status elements and progress dots.
- **No mixed radii within a single component.** All corners of a given element use the same radius.

## Components

### Buttons

Primary buttons are flat (zero elevation) with a solid Ledger Blue (`#1565C0`) background and white text — implemented as `ElevatedButton` (Android) or `CupertinoButton.filled` (iOS), both styled with the same color token. Secondary (outlined) buttons use a 1px `outline` border with primary-colored text on a transparent background. Tertiary (text) buttons have no background or border — use `TextButton` on Android and `CupertinoButton` on iOS. All buttons share 12px corner radius and generous 20px × 24px padding for confident tap targets. Transitions use 200ms duration.

### Cards

Default cards use a pure white (`#FFFFFF`) background with 12px corners and zero elevation. Interactive selection cards animate between states over 200ms: selected cards gain a 2px primary border and a whisper-soft shadow; unselected cards show a 1px `outline-variant` border. Icon containers use `primary` color at 8% opacity (`primary.withOpacity(0.08)`) as background, with a 40px icon in full `primary` color inside.

### Inputs

Text fields use a filled style with `surface-container-high` (`#E9E7EC`) background and 12px corners — implemented as `TextField` with `InputDecoration(filled: true)` on Android. On iOS, use the same visual appearance (filled background, 12px radius) with a `CupertinoTextField` styled to match; do not use the default iOS underline style. No visible border in default state; a 2px primary-color border appears on focus. Content padding is 20px vertical × 16px horizontal. Prefix icons render in muted `on-surface-variant` gray.

### Financial Indicators

Income/credit elements use the secondary green palette: `secondary-container` (`#A3F69C`) background with `on-secondary-container` text. Expense/debit elements use the tertiary red palette: `tertiary-container` (`#FFDAD6`) background with `on-tertiary-container` text. These must never be mixed or swapped.

### Step Indicator

Progress dots are 8px pill-shaped circles. Active step uses primary color; inactive steps use `outline-variant`. The indicator sits between the icon container and the headline.

### Lists & Dividers

Dividers use 1px lines in `outline-variant` (`#C4C6CF`) — nearly invisible, present for structure rather than decoration. List items use subtle borders with 12px radius.

**Swipe actions on list items** are a first-class interaction in a ledger app. Every transaction list item supports:
- **Swipe right** — quick-mark as paid / received (green `secondary` background, checkmark icon)
- **Swipe left** — delete with confirmation (red `tertiary` background, trash icon)

Swipe background color fills the full item height. The icon appears at 24px, horizontally offset 16px from the revealed edge. On iOS, use `Dismissible` with `confirmDismiss` for the delete direction. On Android, the same `Dismissible` widget applies.

### FAB — Primary Add Action

Every screen that allows creating a new record (transaction, customer, entry) must have a **Floating Action Button** anchored at `bottom: 24px, right: 24px` (adjusted for the safe area bottom inset). Spec:

- Shape: `rounded-full` (pill or circle — circle for a single action, extended pill for labeled add)
- Background: `primary` (`#1565C0`)
- Icon / label: white, 24px icon or `label-lg` text
- Size: 56px diameter (standard) or 48px × auto (extended)
- Shadow: `rgba(0,0,0,0.18)` at 8px blur, 2px y-offset — the only FAB shadow in the system
- The FAB hides (slides down, 200ms ease-in) when the user scrolls down a list, and reappears (slides up, 200ms ease-out) when scrolling back up or reaching the top. Respect reduced motion — skip the animation when `MediaQuery.disableAnimationsOf` is true.

### Bottom Sheet

Bottom sheets are the standard surface for quick-add flows, filters, and contextual actions. Two variants:

**Modal bottom sheet** (blocks underlying content):
- Background: `surface-container-lowest` (`#FFFFFF`)
- Corner radius: 16px top corners only (`rounded-md`), 0px bottom
- Drag handle: 4px × 32px pill in `outline-variant`, centered, 8px from top
- Max height: 90% of screen height. Content inside scrolls if taller.
- On Android: `showModalBottomSheet` with `shape: RoundedRectangleBorder(...)`. On iOS: `showCupertinoModalPopup` or `showModalBottomSheet` with Cupertino styling.

**Persistent bottom sheet** (coexists with content): not used — prefer modal for clarity.

### Snackbars & Toasts

Use snackbars for reversible action feedback (undo delete, entry saved). Spec:
- Background: `inverse-surface` (`#2F3033`)
- Text: `inverse-on-surface` (`#F1F0F4`), `body-md`
- Action label (e.g. "Undo"): `inverse-primary` (`#A9C7FF`), `label-lg`
- Corner radius: `rounded-sm` (12px)
- Duration: 4 seconds for informational, stays until dismissed for errors
- Position: bottom of screen, above FAB and bottom nav if present, respecting safe area
- On Android: `ScaffoldMessenger.of(context).showSnackBar`. On iOS: same — `ScaffoldMessenger` is platform-neutral in Flutter.
- One snackbar at a time. New snackbars replace the current one immediately.

### Confirmation Dialogs

Destructive actions (delete transaction, clear ledger, remove customer) always require an explicit confirmation. Never execute a destructive action on a single tap.

- **Title:** headline-sm, `on-surface`. E.g. "Delete entry?"
- **Body:** body-md, `on-surface-variant`. Describe the consequence. E.g. "This will permanently remove ₹500 from 12 Apr. This cannot be undone."
- **Cancel:** secondary button (outlined), left-aligned or leading position
- **Confirm:** `error`-colored primary button (`#BA1A1A` background), right-aligned. Label "Delete" — never "Yes" or "OK".
- On Android: `AlertDialog.adaptive`. On iOS: `CupertinoAlertDialog`. The destructive action maps to `isDestructiveAction: true` on iOS.

### Navigation — Bottom Navigation Bar

Screens with 3–5 top-level destinations use a bottom navigation bar, not a drawer or tab bar at the top. Spec:

- Background: `surface-container-lowest` (`#FFFFFF`) with 1px `outline-variant` top border
- Selected icon + label: `primary` color
- Unselected icon + label: `on-surface-variant`
- Icon size: 24px; label: `label-sm`
- Height: 64px (plus safe area bottom inset)
- No elevation, no shadow — the top border provides separation
- On Android: `NavigationBar` (M3). On iOS: `CupertinoTabBar` with matching colors.
- Active destination indicator: `primary-container` pill behind the icon, per M3 spec

### Pull-to-Refresh

All screens that display live data (transaction list, customer ledger, summary) support pull-to-refresh. Spec:
- On Android: `RefreshIndicator` with `color: primary`, `backgroundColor: surface-container-lowest`
- On iOS: `CustomScrollView` + `CupertinoSliverRefreshControl` — uses the native iOS spinner aesthetic
- Trigger threshold: default platform value (do not override)
- On refresh completion, show a snackbar only if the refresh found new data ("Ledger updated")

## Motion

Consistent, purposeful motion makes the app feel alive without being distracting. Every animation has a reason — it communicates state change, confirms an action, or guides attention.

### Principles

- **Purposeful:** Every animation communicates something. If removing an animation doesn't reduce clarity, remove it.
- **Fast:** UI transitions 150–300ms. Data-driven animations (charts, amount counters) up to 500ms. Nothing longer.
- **Eased:** Use `Curves.easeInOut` for transitions between states. `Curves.easeOut` for elements entering the screen. `Curves.easeIn` for elements leaving.
- **Reduced motion:** All durations collapse to `Duration.zero` when `MediaQuery.disableAnimationsOf(context)` is true.

### Page Transitions

| Direction | Android | iOS |
|---|---|---|
| Push (forward) | Slide left + fade, 250ms | Native iOS slide (go_router default) |
| Pop (back) | Slide right + fade, 200ms | Native iOS swipe-back gesture |
| Modal sheet | Slide up, 300ms | Slide up (Cupertino default) |
| Dismiss sheet | Slide down, 250ms | Slide down |

`go_router` handles platform-appropriate transitions automatically. Do not override the default transition unless a screen explicitly requires a custom one (e.g. a full-screen modal that should fade rather than slide).

### Micro-interactions

| Interaction | Animation |
|---|---|
| Button tap | Scale 0.97 → 1.0, 100ms ease-out (`InkWell` ripple on Android, opacity pulse on iOS) |
| Card selection | Border color + shadow, 200ms ease-in-out |
| FAB hide/show on scroll | Slide down/up 56px, 200ms ease-in / ease-out |
| Swipe action reveal | Follow finger in real time — no animation until release |
| Snackbar enter | Slide up from bottom, 250ms ease-out |
| Snackbar exit | Fade out, 200ms ease-in |
| Amount counter (on summary) | Count up from 0 to value, 400ms ease-out, on first render only |

## Data Display

### Financial Amounts

Numbers are the core content of a ledger app. Every financial amount must be displayed with maximum clarity:

- **Font feature:** `tabularFigures` (fixed-width digits) on every amount — ensures columns align in lists regardless of value.
- **Alignment:** Right-align all amounts in list rows and tables. Left-align in standalone display contexts (summary cards, hero amounts).
- **Currency symbol:** Always prepend the locale-appropriate symbol (₹ for India). Format via `NumberFormat.currency(locale: ..., symbol: '₹')`.
- **Decimal places:** Always show 2 decimal places for amounts (₹1,500.00). Exception: round-number summaries on dashboard cards may show 0 decimal places with a note ("approx").
- **Large numbers:** Use Indian number formatting (lakhs/crores) when the locale is `hi`, `mr`, `bn`, `kn`, `ta`, `ml`, `te` — `NumberFormat` handles this automatically with the correct locale.
- **Negative amounts:** Prefix with `−` (minus, not hyphen), color in `tertiary` (`#C62828`). Never use parentheses notation.
- **Zero:** Display as `₹0.00`, never blank.
- **Wrapping:** Amounts never truncate with ellipsis. If space is constrained, wrap to the next line.

### Balance Masking

Users often view their ledger in public. The app must support **balance masking** — hiding sensitive amounts behind `••••••`:

- A persistent eye icon (`visibility` / `visibility_off`, 20px, `on-surface-variant`) appears next to every hero balance display.
- Masked state shows `••••••` at the same `title-lg` size as the actual amount — same layout footprint to prevent layout shifts.
- Masked state applies to: dashboard total balance, customer outstanding balance, and any summary card showing a total.
- Does **not** apply to individual transaction rows in a detail list — masking there would make the list useless.
- State is session-local (not persisted). Defaults to visible on every app launch.

### Dates

- **Transaction dates:** `dd MMM` for the current year (e.g. "12 Apr"), `dd MMM yyyy` for prior years (e.g. "12 Apr 2023").
- **Today / Yesterday:** Replace the date with "Today" / "Yesterday" as a localized string.
- **Section headers in lists:** Group transactions by date, with the formatted date as a sticky section header in `label-sm`, `on-surface-variant`.
- Always format via `DateFormat` with the active locale — never hard-code month names.

## App Lifecycle

Production finance apps handle backgrounding and re-foregrounding explicitly.

### Background — blur sensitive data

When the app is sent to the background (home button, app switcher), the OS takes a screenshot for the app switcher thumbnail. This screenshot must not show financial data.

- On iOS: In `AppDelegate.swift`, add a blur overlay in `applicationWillResignActive` and remove it in `applicationDidBecomeActive`.
- On Flutter side: Listen to `AppLifecycleState.inactive` / `AppLifecycleState.paused` via `WidgetsBindingObserver` and render an opaque `surface`-colored overlay over the entire app tree.
- The overlay must appear before the OS takes its screenshot — `inactive` fires first, before `paused`, which is the correct hook.

### Re-foreground — refresh stale data

When the app returns to the foreground after more than 5 minutes in the background, trigger a background refresh of the active screen's data. Listen to `AppLifecycleState.resumed` and call `ref.invalidate(activeProvider)` on the relevant provider. Show no visible loading indicator for this refresh — update silently and only show a snackbar if new data was found.

## Offline & Network

KhataPro users are frequently on slow or intermittent mobile data. The app must be usable offline.

### Offline-first principles

- **All reads serve from local cache first.** Network is for sync, not for rendering. The user should never see a blank screen because of a missing network connection.
- **Writes queue locally.** If a transaction is created offline, it writes to the local database immediately and syncs when connectivity returns. Never block a write on a network call.
- **Sync status indicator:** A small chip in the app bar or top of the list shows sync state: "Synced" (hidden when current), "Syncing…" (spinner, `primary` color), "Offline — changes saved" (`outline-variant` color, no icon). This chip auto-dismisses 3 seconds after sync completes.

### Network error patterns

| Scenario | UI response |
|---|---|
| First load, no cache, no network | Full-screen error with illustration, "No connection" heading, "Try again" button |
| Refresh fails, stale cache exists | Show stale data with a top banner: "Showing data from [time]. Tap to retry." Banner uses `surface-container-high` background, `on-surface-variant` text |
| Write fails (create/update/delete) | Snackbar: "Couldn't save. Will retry when online." Action: "Retry now" |
| Sync conflict | Not surfaced to the user automatically — resolve server-side. If unresolvable, show an inline warning on the affected entry |

## Platform Adaptation

KhataPro ships on both iOS and Android. The design tokens (colors, typography scale, spacing, rounded corners) are **shared across platforms**. What adapts is the widget behavior and interaction patterns so the app feels native on each OS.

### What stays the same (both platforms)
- All color tokens, tonal surfaces, and semantic financial colors
- Typography scale (sizes, weights, letter-spacing) — only the resolved font changes (SF Pro vs Roboto)
- Spacing, padding, and border radii
- Card layouts, icon containers, step indicators
- The financial color mapping: green = income, red = expense

### What adapts per platform
- **Navigation:** On Android, use Material back buttons and app bars. On iOS, prefer `CupertinoNavigationBar` with leading back chevrons and swipe-to-go-back gestures.
- **Dialogs & Sheets:** Use `showModalBottomSheet` on Android and `CupertinoActionSheet` / `CupertinoAlertDialog` on iOS for confirmations and pickers.
- **Date & Time Pickers:** Use `CupertinoDatePicker` (scroll wheel) on iOS and Material date picker on Android.
- **Switches & Toggles:** Use `CupertinoSwitch` on iOS and Material `Switch` on Android — both styled with the primary color token.
- **Scroll Physics:** Use `BouncingScrollPhysics` on iOS and `ClampingScrollPhysics` on Android (Flutter handles this by default).
- **Safe Areas:** iOS requires additional bottom inset for the home indicator bar. Always wrap screen content with `SafeArea` and account for the notch/Dynamic Island at the top.
- **Haptics:** Use iOS-style light haptic feedback on selection events; use standard vibration on Android.

### Implementation guidance (Flutter)
Use `Platform.isIOS` checks or Flutter's `.adaptive` widget constructors (e.g., `Switch.adaptive`, `Slider.adaptive`) where available. For navigation, `go_router` handles platform-appropriate transitions automatically. The `ThemeData` and color scheme remain identical — only widget selection branches by platform.

## Accessibility

### Contrast Ratios

All color pairings must meet **WCAG AA** minimums:
- **4.5:1** for body text (body-sm through body-lg, label-sm through label-lg)
- **3:1** for large text (headline-sm and above, 24px+) and UI components (borders, icons)

Key pairings to validate:
- `on-surface` (`#1A1B1E`) on `surface` (`#FAF9FD`) — primary text
- `on-primary` (`#FFFFFF`) on `primary` (`#1565C0`) — button text
- `on-secondary-container` (`#002204`) on `secondary-container` (`#A3F69C`) — income indicators
- `on-tertiary-container` (`#410003`) on `tertiary-container` (`#FFDAD6`) — expense indicators
- Dark mode equivalents must also be validated independently

### Touch Targets

All interactive elements must meet minimum touch target sizes:
- **48 x 48dp** on Android (Material guideline)
- **44 x 44pt** on iOS (Apple HIG)

Buttons enforce a 48px minimum height via the component token. For smaller interactive elements (chips, step indicator dots, list item trailing icons), ensure the tappable area meets the minimum even if the visual element is smaller — use transparent padding to extend the hit area.

### Color-Blind Safety

The green (income) / red (expense) distinction is critical for the app's core function. Approximately 8% of males have red-green color vision deficiency. To ensure accessibility:

- **Never rely on color alone** to convey financial meaning. All income indicators must include a "+" prefix or upward arrow icon. All expense indicators must include a "−" prefix or downward arrow icon.
- **Text labels** ("Income", "Expense", "Credit", "Debit") are mandatory alongside colored indicators.
- **Container contrast:** Income uses a light green container (`#A3F69C`) with near-black text; expense uses a light pink container (`#FFDAD6`) with near-black text. The lightness difference between these containers (green is darker, pink is lighter) provides a secondary signal beyond hue.

### Focus Indicators

For keyboard navigation and screen reader users, focused interactive elements display a **2px solid outline** in `primary` color with a **2px offset** from the element edge. The focus ring must have at least 3:1 contrast against the surrounding background. In Flutter, use `MaterialStateProperty` or `FocusNode` to apply focus styles consistently.

### Reduced Motion

All 200ms transitions (card selection, theme switching) must be disabled when the user has enabled **Reduce Motion** (iOS) or **Remove Animations** (Android) in system settings. In Flutter, check `MediaQuery.disableAnimationsOf(context)` and set animation duration to `Duration.zero`. Transitions are visual polish, never a requirement for interaction feedback — the UI must be fully functional without them.

## Iconography

Icons follow a single consistent visual language across both platforms. Use **Material Symbols Outlined** as the default icon set — they render identically on Android and iOS in Flutter and are already bundled via the `material_symbols_icons` package. Do not use SF Symbols; they are unavailable in Flutter without a native platform channel and create visual inconsistency across platforms.

- **Size scale:** 16px (inline label icons), 24px (list item / toolbar icons), 32px (action icons), 40px (card hero icons in icon containers)
- **Style:** Outlined (stroke-based), 2px optical stroke weight. Use filled variants only inside hero icon containers and for high-emphasis active states.
- **Color:** Default to `on-surface-variant` (`#44474E` light / `#C4C6CF` dark). Use `primary` for active/selected states. Use `secondary` (green) or `tertiary` (red) only for financial indicator icons.
- **Alignment:** Icons in buttons and list items are vertically centered with adjacent text. Ensure icon optical center aligns with the text x-height, not the bounding box.

## State Patterns

### Loading States

**Splash Screen — "Opening the Ledger"** (total ~1.4s, 4 phases):

1. **Book appears (0–400ms):** The rounded rectangle fades in and scales from 0.85 → 1.0 with ease-out. Just the blank page — no lines yet. Background matches `surface` (light) or dark surface (dark).
2. **Binding draws down (400–800ms):** The two vertical lines (green income, red expense) draw top-to-bottom simultaneously via `strokeEnd` 0 → 1. Green leads by ~50ms, then red follows — a subtle stagger hinting "income first, then expenses."
3. **Entries write in (800–1200ms):** The three horizontal blue lines draw left-to-right, staggered 80ms apart (top → middle → bottom), like writing ledger entries. Each uses `strokeEnd` 0 → 1 with ease-out.
4. **Settle + hold (1200–1400ms):** A barely perceptible scale pulse (1.0 → 1.02 → 1.0) on the entire icon, then hold ~200ms before transitioning to the app.

**Reduced motion fallback:** Skip all draws; show the complete icon at 100% opacity with a single 300ms fade-in.

**Skeleton screens:**

Use a shimmer placeholder that pulses a 10% opacity white sweep over `surface-container` backgrounds. Animation: 800ms duration, ease-in-out, infinite loop. Shimmer shapes should mirror the layout of the content being loaded (card-shaped for cards, line-shaped for text). Respect reduced motion — replace shimmer with a static `surface-container-high` fill when animations are disabled.

### Empty States

When a screen has no data (e.g., no transactions, no customers), display:
1. A 64px outlined icon in `outline-variant` color, centered
2. A headline-sm title in `on-surface` (e.g., "No transactions yet")
3. A body-md description in `on-surface-variant` (e.g., "Your ledger entries will appear here")
4. A primary CTA button if the user can take action (e.g., "Add first entry")

Use 32px+ vertical spacing above the icon and between each element.

### Error States

- **Form validation:** `error` color (`#BA1A1A`) for input field borders and helper text. Never use `tertiary` (expense red) for form errors.
- **System errors:** Display in a card with `error-container` (`#FFDAD6`) background and `on-error-container` (`#410002`) text, with an error icon.
- **Network/connectivity:** Use a banner at the top of the screen with `error-container` background and a retry action.
- **Financial errors** (e.g., "insufficient balance"): Use `tertiary-container` with `on-tertiary-container` to semantically tie them to expense/debit rather than system failure.

## Internationalization

### Supported Languages

KhataPro supports 8 languages: English, Hindi, Kannada, Tamil, Bengali, Marathi, Malayalam, and Telugu. Locale codes: `en`, `hi`, `kn`, `ta`, `bn`, `mr`, `ml`, `te`.

### Flutter — ARB strings (both platforms)

All user-visible strings live in ARB files under `lib/l10n/`. The template is `app_en.arb`. Run `flutter gen-l10n` after any ARB edit. Access strings exclusively via `AppLocalizations.of(context)!` — zero hard-coded strings anywhere in Dart code.

`main.dart` must register all four delegates and every supported locale:

```dart
localizationsDelegates: const [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,  // Material widget strings (Android)
  GlobalCupertinoLocalizations.delegate, // Cupertino widget strings (iOS)
  GlobalWidgetsLocalizations.delegate,   // Directionality, text direction
],
supportedLocales: AppLocalizations.supportedLocales,
```

`GlobalCupertinoLocalizations.delegate` is required even on Android builds — it provides translations for any `Cupertino*` widget used via `.adaptive` constructors.

### iOS — native platform wiring

iOS resolves the app's display language from `CFBundleLocalizations` in `ios/Runner/Info.plist`. Without this list, iOS ignores the Flutter locale and shows English regardless of device language. Keep this list in sync with `supportedLocales`:

```xml
<key>CFBundleDevelopmentRegion</key>
<string>en</string>
<key>CFBundleLocalizations</key>
<array>
  <string>en</string>
  <string>hi</string>
  <string>kn</string>
  <string>ta</string>
  <string>bn</string>
  <string>mr</string>
  <string>ml</string>
  <string>te</string>
</array>
```

`CFBundleDevelopmentRegion` must be the literal `en`, not `$(DEVELOPMENT_LANGUAGE)` — the variable form breaks locale fallback on some Xcode build configurations.

### Android — native platform wiring

**App name** (`android:label`) must reference a string resource, not a hard-coded value, so it localises at the OS level (launcher, recent apps, settings):

`AndroidManifest.xml`:
```xml
<application android:label="@string/app_name" ...>
```

`res/values/strings.xml` (default / English):
```xml
<resources>
  <string name="app_name">KhataPro</string>
</resources>
```

Per-locale overrides go in `res/values-<code>/strings.xml` — one file per language (`values-hi`, `values-kn`, `values-ta`, `values-bn`, `values-mr`, `values-ml`, `values-te`).

**Android 13+ per-app language** (API 33+): declare a `locales_config.xml` and reference it in the manifest so users can set a per-app language in System Settings:

`res/xml/locales_config.xml`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<locale-config xmlns:android="http://schemas.android.com/apk/res/android">
  <locale android:name="en"/>
  <locale android:name="hi"/>
  <locale android:name="kn"/>
  <locale android:name="ta"/>
  <locale android:name="bn"/>
  <locale android:name="mr"/>
  <locale android:name="ml"/>
  <locale android:name="te"/>
</locale-config>
```

`AndroidManifest.xml` application tag:
```xml
android:localeConfig="@xml/locales_config"
```

### Platform-adaptive locale-sensitive widgets

Some widgets that display locale-sensitive data have platform-specific variants. Always use the adaptive form:

| Use case | Android | iOS | Adaptive / shared |
|---|---|---|---|
| Date picker | `showDatePicker` (Material) | `CupertinoDatePicker` | Wrap in `Platform.isIOS` check |
| Time picker | `showTimePicker` (Material) | `CupertinoTimerPicker` | Wrap in `Platform.isIOS` check |
| Number formatting | `NumberFormat` (intl) | `NumberFormat` (intl) | Same — `intl` package handles both |
| Currency display | `NumberFormat.currency(locale: ...)` | Same | Always pass the active locale code |
| Date formatting | `DateFormat(pattern, locale)` | Same | Always pass the active locale code |

For `NumberFormat` and `DateFormat`, always pass the active locale explicitly — never rely on the system default, which may differ between Android and iOS:

```dart
// ✓ correct — locale-explicit
final formatted = NumberFormat.currency(
  locale: Localizations.localeOf(context).toString(),
  symbol: '₹',
).format(amount);

// ✗ wrong — falls back to system locale, inconsistent across platforms
final formatted = NumberFormat.currency(symbol: '₹').format(amount);
```

### Text Expansion

Hindi and Marathi text is typically 15–25% longer than English. Tamil and Malayalam can be 20–30% longer. All layouts must accommodate this without breaking:

- **Headlines:** Clamp to 2 lines maximum with `overflow: TextOverflow.ellipsis`. Never allow headlines to push content below the fold.
- **Body text:** Allow natural wrapping. Set `maxLines` only where layout integrity requires it (list items: 2 lines; card subtitles: 1 line).
- **Buttons:** Use flexible width (not fixed). Button text must never truncate — if a translation is too long, the button stretches horizontally up to `screen-width − 2 × screen-margin`.
- **Financial amounts:** Use the `tabularFigures` font feature for digit alignment. Amounts never truncate — they wrap to the next line if needed.

### Script Considerations

All 8 supported scripts are LTR. If Urdu (RTL) is added in the future, replace all directional `EdgeInsets.only(left/right)` with `EdgeInsetsDirectional.only(start/end)`, and flip directional icons (back arrows, chevrons). The current layout uses `EdgeInsets.symmetric` and `CrossAxisAlignment.center`, which are direction-agnostic by default.

## Engineering Standards

### Dart Code Style — Effective Dart

All code must comply with [Effective Dart](https://dart.dev/effective-dart). The short form of the rules that apply most often:

**Style**
- `PascalCase` for types and extensions, `camelCase` for members and parameters, `snake_case` for files and directories, `SCREAMING_CAPS` for constants only when they are truly global constants (prefer `camelCase` const for local values).
- Order imports: dart → flutter → third-party packages → project-local, each group separated by a blank line, sorted alphabetically within groups.
- Run `dart format .` before every commit. No hand-formatted blocks — the formatter wins.

**Documentation**
- Public API members get a `///` doc comment with a single-sentence summary as the first paragraph.
- Comments describe the *why*, not the *what* — well-named identifiers already do the what.
- Never write comments that merely restate the method name ("// increments counter").

**Usage**
- Prefer `async`/`await` over chained `.then()`. Always `await` futures; never fire-and-forget unless the intent is explicit and documented.
- Use collection literals (`[]`, `{}`, `{:}`) instead of `List()`, `Set()`, `Map()` constructors.
- Avoid `!` (null-assert) except when nullability is provably impossible — always prefer early returns, null-aware operators (`?.`, `??`), or pattern matching.
- Never use `late` as a shortcut for nullable fields. `late` is for fields provably initialised before first read (e.g., `initState`, dependency injection).
- Use `switch` expressions and Dart 3 patterns wherever they replace a chain of `if`/`else if`.
- Check `mounted` after every `await` that touches `BuildContext`.

**Design**
- Make declarations private (`_`) by default; make them public only when needed.
- Prefer named parameters for functions with more than two parameters or any boolean parameter.
- Use `typedef` to name complex function types used in multiple places.
- Avoid deep inheritance; compose with mixins or delegation.

### No Magic Numbers

Every numeric constant that appears more than once, or whose meaning isn't self-evident from context, must be named. There are two canonical places:

| Scope | Where to put it |
|---|---|
| Shared across the whole app | `lib/core/constants/app_dimensions.dart` |
| Specific to one screen | File-private `abstract final class _Dims` at the top of that screen file |

```dart
// ✗ wrong
SizedBox(height: 32)
BorderRadius.circular(12)

// ✓ right (shared token)
SizedBox(height: AppDimensions.sectionGap)   // 32px from design system
BorderRadius.circular(AppDimensions.radiusSm) // 12px from design system

// ✓ right (screen-private)
abstract final class _Dims {
  static const double heroImageHeight = 200.0;
}
SizedBox(height: _Dims.heroImageHeight)
```

`app_dimensions.dart` must mirror the spacing and radius tokens in the DESIGN.md YAML front matter exactly. If a token changes in DESIGN.md, it changes in `app_dimensions.dart` — one source of truth.

### Feature Screen Skeleton

Every screen within a feature shares the same structural scaffold. Use this as the starting point — do not invent novel layouts unless the design explicitly requires a departure.

```
Screen
├── Scaffold
│   ├── appBar (optional — only if the screen has a back action or title)
│   └── body: SafeArea
│       └── Column
│           ├── [Scrollable content area]  — Expanded → ListView / CustomScrollView
│           └── [Sticky CTA bar]           — bottom actions, outside the scroll
```

**Shared layout constants** for every screen in a feature live in a `_Dims` class or, if two or more screens in the same feature share them, in a shared `<feature>_dimensions.dart` file alongside the screens.

**Shared sub-widgets** that appear on more than one screen within a feature belong in `features/<name>/presentation/widgets/`. They must not be copied — duplication between screens in the same feature is a bug, not a style choice.

**What is always shared across all features** lives in `lib/core/widgets/`. Examples: `AppButton`, `AppCard`, `SectionHeader`, `EmptyStateView`, `ErrorBanner`. These are design-system-level components, not feature-specific ones.

### Production Validation Standard

Before any screen or widget is considered done, validate it against how production Flutter apps ship:

1. **Performance:** No jank. Every list must use `ListView.builder` or `SliverList` — never a `Column` with `children: items.map(...)`. No heavy work in `build()`.
2. **`const` everywhere:** Every widget whose constructor arguments are compile-time constants must be `const`. The analyzer lint `prefer_const_constructors` must pass clean.
3. **`RepaintBoundary`:** Wrap independently animating children (progress indicators, shimmer, charts) in `RepaintBoundary` so they don't invalidate parent layers on every frame.
4. **Keys:** Use `ValueKey` or `ObjectKey` on list items whose order can change. Use `GlobalKey` only when required for cross-widget state access — never by default.
5. **Error + loading + empty:** Every screen that loads async data must handle all three `AsyncValue` states explicitly. Skeleton shimmer for loading; `EmptyStateView` for empty; `ErrorBanner` for error. No screen may silently show nothing.
6. **Reduced motion:** All `AnimationController` durations and implicit animation durations must be gated on `MediaQuery.disableAnimationsOf(context)` — set to `Duration.zero` when true.
7. **Text scaling:** Test at 1.0× and 2.0× text scale factor. No overflow, no clipped text, no broken layout.
8. **Localization:** Zero hard-coded user-visible strings. Every string comes from an ARB key via `AppLocalizations.of(context)`.
9. **Accessibility:** All interactive elements carry a `Semantics` label. Tap targets are ≥ 48 × 48dp on Android and ≥ 44 × 44pt on iOS. Run with TalkBack (Android) and VoiceOver (iOS) before marking done.
10. **Platform widgets:** Navigation bars, dialogs, date pickers, switches, and scroll physics use the correct platform-adaptive widget — verified on both a physical or simulated Android device and an iOS simulator.
11. **`dart analyze` passes clean** — zero errors, zero warnings, zero hints — before any code is committed.

### Code Review Checklist

Before any PR is merged:

- [ ] No magic numbers — all constants named in `_Dims` or `AppDimensions`
- [ ] No duplicated widgets between screens in the same feature — extracted to `widgets/`
- [ ] All async code checks `mounted` after `await`
- [ ] All `AsyncValue` states handled explicitly (data, loading, error)
- [ ] No `setState`, `ChangeNotifier`, `Bloc`, or `GetX` — Riverpod only
- [ ] No `Navigator.push/pop` — `go_router` only
- [ ] `dart format` applied, `dart analyze` clean
- [ ] `const` constructors used everywhere possible
- [ ] Screen tested at 1.0× and 2.0× text scale with Hindi locale
- [ ] Reduced motion path exercised manually or in tests
- [ ] All `DateFormat` / `NumberFormat` calls pass the active locale explicitly
- [ ] Financial amounts use `tabularFigures`, right-aligned in lists, never truncated
- [ ] Destructive actions guarded by a confirmation dialog
- [ ] App lifecycle observer blurs sensitive data on background
- [ ] Offline: writes queue locally, reads serve from cache first
- [ ] Platform-adaptive widgets verified on both Android and iOS
