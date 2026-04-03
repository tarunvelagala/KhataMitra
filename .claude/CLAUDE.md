# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Role

Act as a Senior Software Development Engineer. Prioritize correctness, maintainability, re-usability, readability, extensibility and simplicity. Push back on over-engineering. When multiple approaches exist, recommend the one with the best long-term maintainability and explain the trade-offs briefly.

---

# KhataMitra

A Flutter app for small business bookkeeping (khata = ledger in Hindi/Urdu).

## Design Reference

UI designs are in Google Stitch: https://stitch.withgoogle.com/project/3823020204310937544

Always refer to this project when implementing or reviewing UI screens.

## Requirements

Detailed functional and non-functional requirements are in [`specs/initial-requirements.md`](../specs/initial-requirements.md).

The commit-by-commit implementation plan is in [`specs/implementation-plan.md`](../specs/implementation-plan.md). Always consult it before implementing a feature to understand the intended file structure, dependencies, and test requirements for each commit.

## Tech Stack

- Flutter / Dart (SDK ^3.11.1)
- State management: Riverpod with code generation (`flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`)
- Navigation: `go_router`
- Design system: Material 3
- Localization: Flutter's built-in `flutter_localizations` + `.arb` files (EN, HI, TE)
- Local database: `drift` (SQLite ORM with code generation)
- Secure storage: `flutter_secure_storage` (session token)
- Preferences: `shared_preferences` (theme, language)
- Permissions: `permission_handler`
- Sharing: `share_plus`
- Image handling: `image_picker`, `flutter_image_compress`
- Utilities: `path_provider`, `uuid`, `package_info_plus`

## Commands

```bash
flutter run                                                      # Run the app
flutter test                                                     # Run all tests
flutter test test/theme_test.dart                                # Run a single test file
dart analyze                                                     # Lint / static analysis
dart format .                                                    # Format all Dart files
dart run build_runner build --delete-conflicting-outputs         # Regenerate Riverpod/go_router code
flutter gen-l10n                                                 # Regenerate localization files
```

Riverpod providers annotated with `@riverpod` and router files annotated with `@TypedGoRoute` require code generation. Run `build_runner` after modifying these files. Generated files end in `.g.dart` and must not be edited manually.

After adding new localization strings to `.arb` files in `lib/l10n/`, run `flutter gen-l10n` (or `flutter pub get`) to regenerate `app_localizations*.dart`.

## Development Workflow

- Implement features end-to-end (repository + state + UI) rather than single files in isolation.
- Before marking any task complete, run `dart analyze` and `flutter test` to verify no regressions.
- Use Plan Mode (Shift+Tab twice) to break down complex requirements into steps before writing code.

## Git & Push Policy

**Every commit must be production-ready.** Each commit — not just the final one before a push — must leave the codebase in a fully working, shippable state. Never commit half-finished work, commented-out code, debug prints, TODO stubs, or anything that breaks the build, tests, or static analysis. A reviewer should be able to check out any single commit and run the app without issue.

**Never push broken code.** Before any `git push`, all of the following must pass locally:

```bash
dart analyze                              # zero issues — no warnings, no hints
dart format . --set-exit-if-changed       # no unformatted files
flutter test --coverage                   # all tests green
```

- Do not use `--no-verify` to bypass hooks.
- Do not push directly to `main`. All changes go through a feature branch and a reviewed PR.
- Commit messages follow Conventional Commits: `feat:`, `fix:`, `refactor:`, `test:`, `chore:`.
- A PR may only be merged when the reviewer agent gives no **Critical** or **Major** findings and coverage check passes (see Production Standards → Testing).

## Production Standards

- **Error handling**: surface user-facing errors via a dedicated error state in the Riverpod provider, never swallow exceptions silently.
- **Security**: never log or persist PII (names, phone numbers) to crash reporters or analytics; treat all user-entered financial data as sensitive.
- **Offline-first**: all writes must succeed without network; design data layer around local DB (e.g., `drift` or `isar`) with optional sync layer on top.
- **Performance**: avoid `setState` / rebuilds in list items; use `select` on Riverpod providers to minimize widget rebuilds; profile with Flutter DevTools before shipping.
- **Accessibility**: all interactive elements must meet 48×48 dp minimum; support `semanticsLabel` on icon-only buttons.
- **Testing**: every provider must have unit tests; every screen must have at least one widget smoke test; use `ProviderContainer` for isolated provider tests. Coverage must not drop below **80%** on new code — run `flutter test --coverage` and inspect `coverage/lcov.info`.
- **UI fidelity**: every screen must visually match the Google Stitch design reference before it is considered done. Check spacing, color tokens, typography scale, and component shapes against the design. Do not ship screens that deviate from the design system.

## Architecture

### State Management (Riverpod)

All providers use `@riverpod` annotation and code generation. The generated `*.g.dart` file must be imported alongside the source file. State classes expose mutation methods on their notifier; widgets watch providers via `ref.watch` and trigger changes via `ref.read(...notifier).method()`.

### Navigation (go_router)

Routes are defined in `lib/router/app_router.dart`. The router is a plain `GoRouter` instance consumed by `MaterialApp.router`. When routes need Riverpod state, wrap the builder body in a `Consumer`.

### Responsive System (`lib/core/responsive/`)

Two-tier approach:
- **Value tokens**: `context.rDims` and `context.rText` switch mobile/tablet values via extension methods on `BuildContext`.
- **Layout restructure**: `ResponsiveLayoutBuilder` renders different widget trees for mobile vs. tablet.

Breakpoints: mobile < 600 dp; tablet 600–1200 dp. Optical constants (border widths, elevation, pill radii) never scale — only spatial tokens scale at 1.15× on tablet.

**Responsiveness is non-negotiable.** Every widget written in this codebase must follow these rules without exception:

1. **Never use `AppDimensions` directly in feature code.** Always go through `context.rDims` so the responsive layer is in effect.
2. **Never hardcode a spacing, padding, radius, or font-size number** inline in a widget. All values come from `context.rDims` or `context.rText`.
3. **Never use raw `Scaffold`, `Card`, `ElevatedButton`, `TextFormField`, or `ListTile`** in feature screens. Use the `App*` equivalents from `lib/core/widgets/` (`AppScaffold`, `AppCard`, `AppButton`, `AppInput`, `AppListTile`, etc.) which handle responsive tokens internally.
4. **Feature-specific widgets** (e.g. `CustomerListTile`, `TransactionListTile`) are built by composing `App*` core widgets — not by reimplementing layout from scratch.
5. **Every screen must be visually verified at both 360 dp (mobile) and 768 dp (tablet) widths** before a commit is considered done. Use Flutter DevTools or `MediaQuery` override in widget tests.
6. **No `RenderFlex overflow` errors are acceptable** at any supported width (320 dp minimum). All text containers must use `maxLines` + `overflow: TextOverflow.ellipsis` or wrap gracefully.
7. **`ResponsiveLayoutBuilder`** is reserved for structural tree differences only (e.g. single-column list vs. two-panel split). For value differences, always prefer `context.rDims` / `context.rText`.

### Localization (`lib/l10n/`)

Source strings live in `app_en.arb` / `app_hi.arb` / `app_te.arb`. Generated Dart code is checked in. Use `AppLocalizations.of(context)!.key` in widgets. The active locale is controlled by `localeStateProvider` (Riverpod), which cycles EN → HI → TE → EN.

### Theme (`lib/core/theme/`)

Material 3 light and dark themes configured in `app_theme.dart`. Color tokens in `app_colors.dart`; typography in `app_text_styles.dart`. A custom `ThemeExtension` (`AppSurfaceColors`) provides five tonal surface levels accessible via `Theme.of(context).extension<AppSurfaceColors>()`.

### Feature Structure

New features go under `lib/features/<feature_name>/`. Each feature owns its screens, widgets, and providers. Shared utilities belong in `lib/core/`.

## Code Style

Follow the [Dart Effective Dart style guide](https://dart.dev/effective-dart) for all Dart code:

- **Style**: `UpperCamelCase` for types, `lowerCamelCase` for members/variables, `lowercase_with_underscores` for files/packages.
- **Documentation**: Use `///` doc comments on public APIs.
- **Usage**: Prefer `final` and `const` wherever possible. Use `=>` for simple one-expression functions.
- **Design**: Prefer named parameters for clarity. Avoid positional parameters beyond two. Return `Future` (not `void`) from async functions that callers may need to await.
