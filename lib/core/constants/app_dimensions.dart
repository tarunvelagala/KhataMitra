/// Shared dimension tokens for KhataPro.
///
/// Use these instead of inline numbers anywhere a layout measurement,
/// border radius, elevation, padding, or stroke width appears.
/// Screen-specific values that have no cross-feature meaning belong in
/// a file-private `_Dims` class inside the relevant screen file.
abstract final class AppDimensions {
  // ── Border radii ──────────────────────────────────────────────────
  /// Cards, buttons, text inputs.
  static const double radiusSmall = 12;

  /// Icon containers, larger surface elements.
  static const double radiusMedium = 16;

  /// Badges, chips, pill-shaped elements.
  static const double radiusPill = 999;

  // ── Elevation ─────────────────────────────────────────────────────
  /// Flat / no shadow — used for cards, buttons, and the app bar.
  static const double elevationFlat = 0;

  // ── Button padding ────────────────────────────────────────────────
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
  /// Focused input border and selected card border.
  static const double borderFocused = 2;

  /// Default / unfocused border width.
  static const double borderDefault = 1;

  // ── Button stack ─────────────────────────────────────────────────
  /// Gap between a primary FilledButton and a secondary TextButton when stacked.
  static const double buttonStackGap = 8;

  // ── Divider ───────────────────────────────────────────────────────
  static const double dividerThickness = 1;
  static const double dividerSpace = 1;

  // ── App bar ───────────────────────────────────────────────────────
  /// Background colour alpha for the frosted-glass app bar effect.
  static const double appBarOpacity = 0.8;

  // ── Badge ─────────────────────────────────────────────────────────
  /// Alpha for the glass-effect badge background on selection cards.
  static const double badgeGlassAlpha = 0.08;
}
