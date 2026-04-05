/// Shared dimension tokens for KhataMitra.
///
/// Use these instead of inline numbers anywhere a layout measurement,
/// border radius, elevation, padding, or stroke width appears.
/// Screen-specific values that have no cross-feature meaning belong in
/// a file-private `_Dims` class inside the relevant screen file.
// ignore: avoid_classes_with_only_static_members
abstract final class AppDimensions {
  // ── Border radii ──────────────────────────────────────────────────
  /// Icon box inside selection cards (rounded-lg = 8px).
  static const double radiusXSmall = 8;

  /// Cards, buttons, text inputs (rounded-xl = 12px).
  static const double radiusSmall = 12;

  /// Icon containers, language/theme cards (rounded-2xl = 16px).
  static const double radiusMedium = 16;

  /// App icon container, bento grid cells (rounded-3xl = 24px).
  static const double radiusLarge = 24;

  /// Badges, chips, pill-shaped buttons (rounded-full).
  static const double radiusPill = 999;

  // ── Elevation ─────────────────────────────────────────────────────
  /// Flat / no shadow — used for cards, buttons, and the app bar.
  static const double elevationFlat = 0;

  // ── Button ────────────────────────────────────────────────────────
  /// Height for full-width primary action buttons (h-14 = 56px).
  static const double buttonHeight = 56;

  /// Vertical padding for ElevatedButton and OutlinedButton.
  static const double buttonPaddingV = 20;

  /// Horizontal padding for ElevatedButton and OutlinedButton.
  static const double buttonPaddingH = 24;

  // ── Input padding ─────────────────────────────────────────────────
  /// Vertical content padding inside InputDecoration.
  static const double inputPaddingV = 20;

  /// Horizontal content padding inside InputDecoration.
  static const double inputPaddingH = 16;

  // ── Border widths ─────────────────────────────────────────────────
  /// Selected card / focused input border (border-[2px]).
  static const double borderFocused = 2;

  /// Unselected card border (border-[1.5px]).
  static const double borderSubtle = 1.5;

  // ── Screen-level spacing ──────────────────────────────────────────
  /// Horizontal screen padding (px-6 = 24px).
  static const double screenPaddingH = 24;

  /// Top padding for the header branding block (pt-16 = 64px).
  static const double headerPaddingTop = 64;

  /// Bottom padding of the header block on language screen (pb-12 = 48px).
  static const double headerPaddingBottom = 48;

  /// Scroll area bottom padding to clear the sticky footer (pb-32 = 128px).
  static const double scrollBottomClearance = 128;

  // ── Component spacing ─────────────────────────────────────────────
  /// Gap between repeated cards / list items (space-y-4 = 16px).
  static const double cardGap = 16;

  /// Gap between header branding and first card section (mb-10 = 40px).
  static const double sectionGap = 40;

  /// Large decorative gap above bento / illustration (mt-12 = 48px).
  static const double illustrationGap = 48;

  // ── Sticky footer ─────────────────────────────────────────────────
  /// Top padding inside footer gradient overlay (pt-8 = 32px).
  static const double footerPaddingTop = 32;

  /// Bottom padding inside footer (pb-4 = 16px on theme, pb-8 = 32px on language).
  static const double footerPaddingBottom = 16;

  // ── Divider ───────────────────────────────────────────────────────
  static const double dividerThickness = 1;
  static const double dividerSpace = 1;

  // ── App bar ───────────────────────────────────────────────────────
  /// Background colour alpha for the frosted-glass app bar effect.
  static const double appBarOpacity = 0.8;
}
