# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

KhataPro — a cross-platform (iOS + Android) Flutter app for small business bookkeeping. "Khata" means ledger in Hindi/Urdu. Target users are small business owners across South Asia, many transitioning from paper ledgers.

## Commands

```bash
flutter run                              # Run the app
dart analyze                             # Lint (must pass clean)
flutter test                             # Run all tests
flutter test test/core/theme/theme_test.dart  # Run a single test file
flutter gen-l10n                         # Regenerate localization files after editing .arb
flutter build apk --debug               # Verify Android builds
flutter build ios --no-codesign          # Verify iOS builds
dart format .                            # Format all code
dart fix --apply                         # Auto-fix common issues
```

## How to Work in This Repo

### Architecture first, then features

Before writing code for any new feature, plan the architecture: models, state management, repository layer, then UI. Describe the approach and get alignment before implementing. Think of each feature as an end-to-end slice (provider + repository + screen + tests), not file-by-file.

### Feature-first structure

New features go under `lib/features/<feature_name>/` with this layout:
```
features/<name>/
  data/           # Repositories, data sources
  domain/         # Models, enums
  presentation/
    providers/    # Riverpod notifiers
    screens/      # Full-page widgets (suffix: _screen.dart)
    widgets/      # Reusable sub-widgets
```

### Design System — DESIGN.md is the single source of truth

**`DESIGN.md` contains the complete design system** as YAML front matter (machine-readable tokens) and markdown prose (human-readable rationale). When Dart code conflicts with DESIGN.md, DESIGN.md wins — update the code.

**Workflow for implementing screens:**
1. **Fetch the screen from Stitch** (project `3823020204310937544`) for layout and visual intent
2. **Apply `DESIGN.md` tokens** — colors, typography, spacing, rounded corners, component specs. DESIGN.md overrides Stitch on any conflict.
3. **Verify** against both Stitch's layout and DESIGN.md's tokens

**Key rules from DESIGN.md:**
- **Semantic colors (critical):** Secondary (green) = income/credit. Tertiary (red) = expense/debit. Primary (blue) = neutral workspace. Never swap.
- **Typography:** Platform system font only (SF Pro on iOS, Roboto on Android). No custom fonts.
- **Elevation:** 0 everywhere. Depth via M3 tonal surface layering.
- **Border radii:** Only 12px (sm), 16px (md), or 9999px (pill).
- **Accessibility:** 48x48dp touch targets, WCAG AA 4.5:1 contrast, +/− icons alongside financial colors for color-blind safety, respect reduced motion.

### Automated guardrails (.claude/hooks)

The `.claude` folder enforces consistency automatically:
- **Post-edit:** `dart analyze` runs after every file edit
- **Pre-commit:** `dart analyze` → `flutter test` → Android build → iOS build → design review
- **Design review hook** (`.claude/hooks/design-review.sh`): Blocks commits that introduce old brand colors or drift from DESIGN.md tokens

You don't need to run these manually — they fire automatically.

## Flutter & Dart Rules

### Code Style

- **Naming:** `PascalCase` for classes, `camelCase` for members, `snake_case` for files. Suffix files by role: `_screen.dart`, `_provider.dart`, `_repository.dart`.
- **Functions:** Keep under 20 lines, single-purpose. Use `=>` for one-liners.
- **Const:** Use `const` constructors everywhere possible to reduce rebuilds.
- **Immutability:** Prefer immutable data. Widgets are immutable — rebuild, don't mutate.
- **Composition over inheritance:** Compose smaller private widgets (`class _MyWidget extends StatelessWidget`) over helper methods that return widgets.
- **Logging:** Use `dart:developer` `log()` instead of `print()`.

### Dart Patterns

- **Null safety:** Write sound null-safe code. Avoid the `!` operator unless the value is guaranteed non-null. Never use `late` as a null-safety shortcut.
- **Async:** Use `Future` + `async`/`await` for operations, `Stream` for events. Always check `mounted` after awaits before using `BuildContext`.
- **Pattern matching:** Use switch expressions and Dart 3 pattern matching where it improves clarity.
- **Error handling:** Use custom exceptions for domain-specific errors. Don't let failures pass silently.

### Widget Best Practices

- **Lists:** Use `ListView.builder` or `SliverList` for long lists — never dump all items into a `Column`.
- **Expensive work:** Use `compute()` / `Isolate` for heavy calculations (JSON parsing of large payloads) to avoid blocking the UI thread.
- **Build methods:** Never perform network calls, file I/O, or heavy computation inside `build()`.
- **Images:** Always provide `errorBuilder` and `loadingBuilder` for network images.
- **Layout:** Use `LayoutBuilder` for responsive decisions. Use `Expanded`/`Flexible` correctly — don't mix them in the same `Row`/`Column`.

### State Management — Riverpod

This project uses Riverpod exclusively. **Do not** introduce `setState`, `ChangeNotifier`, `Bloc`, or `GetX`.

- Use `ref.watch()` inside `build()` for reactive updates
- Use `ref.read()` only in callbacks and event handlers — never in `build()`
- Handle `AsyncValue` states explicitly (data, loading, error) — don't use `maybeWhen`
- Widget tests require `ProviderScope` wrapping with overrides

### Navigation

Use `go_router` exclusively. **Do not** mix with imperative `Navigator.push()` / `Navigator.pop()`. Use `context.push()`, `context.go()`, `context.pop()`.

### Platform Adaptation

- Use `.adaptive` constructors where available (`Switch.adaptive`, `AlertDialog.adaptive`)
- Always wrap page content with `SafeArea`
- Handle `PopScope` for predictive back navigation on Android
- Platform-specific checks: use `Platform.isIOS` or Flutter's adaptive widgets, not manual if/else trees

### Accessibility

- Ensure text contrast ratio of at least **4.5:1** against background
- Test with dynamic text scaling — UI must remain usable at larger font sizes
- Use `Semantics` widget for screen reader labels on non-text interactive elements
- Test with TalkBack (Android) and VoiceOver (iOS)

### Documentation

- Comment *why*, not *what*. Code should be self-explanatory through naming.
- Use `///` for public API doc comments with a single-sentence summary.
- No comments that restate the obvious from the class/method name.

## Architecture

### State Management — Riverpod

App wraps in `ProviderScope` at the root. Screens are `ConsumerWidget`. State uses the `Notifier` + `NotifierProvider` pattern:

```
providers/onboarding_providers.dart → SelectedLanguageNotifier, ThemeModeNotifier, ShopDetailsNotifier
main.dart → watches themeModeProvider & selectedLanguageProvider for live theme/locale switching
```

Immutable state objects use `copyWith` for updates. Enums carry associated data (e.g., `BusinessType` has an `icon` field, `AppLanguage` has `nativeName`, `englishName`, `code`).

### Theme System

All in `lib/core/theme/`. Three `abstract final` utility classes — never instantiated:

- **`AppColors`** — Every M3 color token as a `const Color`. Light and dark variants (prefixed `dark*`). Must match DESIGN.md YAML tokens exactly.
- **`AppTextStyles`** — Full M3 type scale.
- **`AppTheme`** — Builds `ThemeData` for light/dark. Uses private helper methods (`_cardTheme()`, `_elevatedButtonTheme()`, etc.) to eliminate duplication.

Colors are never set on TextStyle — they come from ThemeData at runtime so light/dark resolve automatically. All TextStyles use `inherit: true`.

### Localization

8 languages: en, hi, kn, ta, bn, mr, ml, te. ARB files in `lib/l10n/`. Template is `app_en.arb`. After editing `.arb` files, run `flutter gen-l10n`.

### Routing

`go_router` in `lib/router/app_router.dart`. Flat routes for the onboarding flow → `/home`. Initial route: `/onboarding/language`.

### Screen Layout Convention

Each screen file contains a file-private `_Dims` class with screen-specific layout constants. Shared tokens live in `lib/core/constants/app_dimensions.dart`.

### Testing

Tests use `ProviderContainer` for isolated Riverpod state. Theme tests validate color hex values, luminance, and contrast. Typography tests verify the type scale without constructing `TextStyle`. Provider tests use a `makeContainer()` helper with `addTearDown(container.dispose)`. Do not test private methods, trivial getters, or generated code.
