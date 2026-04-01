// Breakpoint system for KhataMitra.
//
// Supports two form factors: [FormFactor.mobile] and [FormFactor.tablet].
// Desktop is intentionally omitted — the app targets mobile and tablet only.
//
// In practice, prefer the [ResponsiveContext] extension on [BuildContext]
// (`context.formFactor`, `context.rDims`, `context.rText`) over calling
// these helpers directly.

/// The two supported form factors.
enum FormFactor {
  /// Logical width below [AppBreakpoints.tabletMinWidth] (< 600 dp).
  mobile,

  /// Logical width in the range [AppBreakpoints.tabletMinWidth]–[AppBreakpoints.tabletMaxWidth]
  /// (600 dp ≤ width < 1200 dp).
  tablet,
}

/// Breakpoint constants and pure helper functions.
///
/// All members are static; the class is not instantiable.
abstract final class AppBreakpoints {
  // ── Width boundaries ────────────────────────────────────────────────

  /// First logical-pixel width classified as a tablet (inclusive).
  static const double tabletMinWidth = 600.0;

  /// Exclusive upper bound for tablet widths (desktop not supported, but
  /// this ceiling keeps the system future-proof).
  static const double tabletMaxWidth = 1200.0;

  // ── Helpers ─────────────────────────────────────────────────────────

  /// Returns the [FormFactor] for the given logical-pixel [width].
  ///
  /// This is the single if-branch for form-factor detection; it is
  /// written here once and called by all other responsive utilities.
  static FormFactor formFactorOf(double width) {
    return width >= tabletMinWidth ? FormFactor.tablet : FormFactor.mobile;
  }

  /// Returns the scale factor to apply to dimensions and font sizes for
  /// the given logical-pixel [width].
  ///
  /// - Mobile → `1.0` (no scaling; matches existing static tokens).
  /// - Tablet → `1.15` (15 % increase; perceptible but not jarring).
  static double scaleFactorOf(double width) {
    return formFactorOf(width) == FormFactor.tablet ? 1.15 : 1.0;
  }
}
