import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Private type scale tokens ──────────────────────────────────────────────
// These are implementation details of the typography system.
// Callers should use AppTextStyles, never these raw numbers.
abstract final class _TypeScale {
  // Font sizes
  static const double displayLarge   = 57;
  static const double displayMedium  = 45;
  static const double displaySmall   = 36;
  static const double headlineLarge  = 32;
  static const double headlineMedium = 28;
  static const double headlineSmall  = 24;
  static const double titleLarge     = 22;
  static const double titleMedium    = 16;
  static const double titleSmall     = 14;
  static const double bodyLarge      = 16;
  static const double bodyMedium     = 14;
  static const double bodySmall      = 12;
  static const double labelLarge     = 14;
  static const double labelMedium    = 12;
  static const double labelSmall     = 11;

  // Letter spacing — named by magnitude, not role, because several styles
  // share the same value (e.g. 0.1 → titleSmall & labelLarge).
  static const double spacingTight2 = -0.50;
  static const double spacingTight1 = -0.25;
  static const double spacingXs     =  0.10;
  static const double spacingSm     =  0.15;
  static const double spacingMd     =  0.25;
  static const double spacingLg     =  0.40;
  static const double spacingXl     =  0.50;
  static const double spacingXxl    =  1.00;
}

/// Typography system for KhataPro.
///
/// Call [forLocale] to get a [TextTheme] with the correct font family for the
/// active locale:
/// - Latin (en): Plus Jakarta Sans (headlines) + Inter (body/labels)
/// - Hindi (hi): Noto Sans Devanagari
/// - Telugu (te): Noto Sans Telugu
/// - Tamil (ta): Noto Sans Tamil
/// - Kannada (kn): Noto Sans Kannada
/// - Malayalam (ml): Noto Sans Malayalam
///
/// `inherit: true` is set on every style so Flutter can lerp between light and
/// dark ThemeData without "Failed to interpolate TextStyles" errors.
/// Colors are intentionally absent — they are applied by ThemeData.textTheme
/// so that light and dark themes resolve correctly at runtime.
abstract final class AppTextStyles {
  /// Returns the correct [TextTheme] for [locale].
  static TextTheme forLocale(Locale locale) => switch (locale.languageCode) {
    'hi' => _notoSansDevanagariTheme,
    'te' => _notoSansTeluguTheme,
    'ta' => _notoSansTamilTheme,
    'kn' => _notoSansKannadaTheme,
    'ml' => _notoSansMalayalamTheme,
    _    => _latinTheme,
  };

  // ── Latin theme (en) — Plus Jakarta Sans + Inter ───────────────────────

  static final TextTheme _latinTheme = TextTheme(
    displayLarge:   displayLarge,
    displayMedium:  displayMedium,
    displaySmall:   displaySmall,
    headlineLarge:  headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall:  headlineSmall,
    titleLarge:     titleLarge,
    titleMedium:    titleMedium,
    titleSmall:     titleSmall,
    bodyLarge:      bodyLarge,
    bodyMedium:     bodyMedium,
    bodySmall:      bodySmall,
    labelLarge:     labelLarge,
    labelMedium:    labelMedium,
    labelSmall:     labelSmall,
  );

  // ── Indic themes — single Noto Sans family per script ──────────────────
  // Noto Sans families cover all weight/size roles in a single typeface,
  // so we use GoogleFonts.*TextTheme() which applies the font to every
  // TextTheme slot, then override sizes to match our type scale.

  static final TextTheme _notoSansDevanagariTheme =
      GoogleFonts.notoSansDevanagariTextTheme(_latinTheme);

  static final TextTheme _notoSansTeluguTheme =
      GoogleFonts.notoSansTeluguTextTheme(_latinTheme);

  static final TextTheme _notoSansTamilTheme =
      GoogleFonts.notoSansTamilTextTheme(_latinTheme);

  static final TextTheme _notoSansKannadaTheme =
      GoogleFonts.notoSansKannadaTextTheme(_latinTheme);

  static final TextTheme _notoSansMalayalamTheme =
      GoogleFonts.notoSansMalayalamTextTheme(_latinTheme);

  // ── Latin style getters (used to build _latinTheme above) ─────────────

  // ── Display ───────────────────────────────────────────────────────
  static TextStyle get displayLarge => GoogleFonts.plusJakartaSans(
        fontSize: _TypeScale.displayLarge,
        fontWeight: FontWeight.w400,
        letterSpacing: _TypeScale.spacingTight1,
      ).copyWith(inherit: true);

  static TextStyle get displayMedium => GoogleFonts.plusJakartaSans(
        fontSize: _TypeScale.displayMedium,
        fontWeight: FontWeight.w400,
      ).copyWith(inherit: true);

  static TextStyle get displaySmall => GoogleFonts.plusJakartaSans(
        fontSize: _TypeScale.displaySmall,
        fontWeight: FontWeight.w400,
      ).copyWith(inherit: true);

  // ── Headline ──────────────────────────────────────────────────────
  static TextStyle get headlineLarge => GoogleFonts.plusJakartaSans(
        fontSize: _TypeScale.headlineLarge,
        fontWeight: FontWeight.w800,
        letterSpacing: _TypeScale.spacingTight2,
      ).copyWith(inherit: true);

  static TextStyle get headlineMedium => GoogleFonts.plusJakartaSans(
        fontSize: _TypeScale.headlineMedium,
        fontWeight: FontWeight.w700,
        letterSpacing: _TypeScale.spacingTight1,
      ).copyWith(inherit: true);

  static TextStyle get headlineSmall => GoogleFonts.plusJakartaSans(
        fontSize: _TypeScale.headlineSmall,
        fontWeight: FontWeight.w700,
      ).copyWith(inherit: true);

  // ── Title ─────────────────────────────────────────────────────────
  static TextStyle get titleLarge => GoogleFonts.plusJakartaSans(
        fontSize: _TypeScale.titleLarge,
        fontWeight: FontWeight.w700,
      ).copyWith(inherit: true);

  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: _TypeScale.titleMedium,
        fontWeight: FontWeight.w600,
        letterSpacing: _TypeScale.spacingSm,
      ).copyWith(inherit: true);

  static TextStyle get titleSmall => GoogleFonts.inter(
        fontSize: _TypeScale.titleSmall,
        fontWeight: FontWeight.w600,
        letterSpacing: _TypeScale.spacingXs,
      ).copyWith(inherit: true);

  // ── Body ──────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: _TypeScale.bodyLarge,
        fontWeight: FontWeight.w400,
        letterSpacing: _TypeScale.spacingXl,
      ).copyWith(inherit: true);

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: _TypeScale.bodyMedium,
        fontWeight: FontWeight.w400,
        letterSpacing: _TypeScale.spacingMd,
      ).copyWith(inherit: true);

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: _TypeScale.bodySmall,
        fontWeight: FontWeight.w400,
        letterSpacing: _TypeScale.spacingLg,
      ).copyWith(inherit: true);

  // ── Label ─────────────────────────────────────────────────────────
  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: _TypeScale.labelLarge,
        fontWeight: FontWeight.w600,
        letterSpacing: _TypeScale.spacingXs,
      ).copyWith(inherit: true);

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: _TypeScale.labelMedium,
        fontWeight: FontWeight.w500,
        letterSpacing: _TypeScale.spacingXl,
      ).copyWith(inherit: true);

  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: _TypeScale.labelSmall,
        fontWeight: FontWeight.w700,
        letterSpacing: _TypeScale.spacingXxl,
      ).copyWith(inherit: true);
}
