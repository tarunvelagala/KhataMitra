import 'package:flutter/foundation.dart';
import 'package:khata_mitra/core/constants/app_dimensions.dart';
import 'package:khata_mitra/core/responsive/app_breakpoints.dart';

/// Dimension tokens resolved for the current form factor.
///
/// Mirrors every constant in [AppDimensions] and adds layout-level tokens
/// (gutters, max-widths, grid columns) that only make sense in a responsive
/// context.
///
/// Obtain via `context.rDims` (see [ResponsiveContext]).
///
/// **Rule of thumb for scaling**
/// - Optical constants (border widths, opacities, elevation) are never scaled.
/// - Pill radius is never scaled (`999` × anything is still "pill-shaped").
/// - All other spacing and radius tokens scale by [AppBreakpoints.scaleFactorOf].
@immutable
class ResponsiveDimensions {
  // ── Border radii ──────────────────────────────────────────────────
  final double radiusSmall;
  final double radiusMedium;

  /// Always 999 — scaling a pill radius is meaningless.
  final double radiusPill;

  // ── Elevation ─────────────────────────────────────────────────────
  /// Always 0 — flat design regardless of form factor.
  final double elevationFlat;

  // ── Button padding ────────────────────────────────────────────────
  final double buttonPaddingV;
  final double buttonPaddingH;

  // ── Input padding ─────────────────────────────────────────────────
  final double inputPaddingV;
  final double inputPaddingH;

  // ── Border widths (optical constants — never scaled) ──────────────
  final double borderFocused;
  final double borderDefault;

  // ── Divider ───────────────────────────────────────────────────────
  final double dividerThickness;
  final double dividerSpace;

  // ── App bar ───────────────────────────────────────────────────────
  /// Opacity value — not a spatial dimension, never scaled.
  final double appBarOpacity;

  // ── Layout tokens (responsive-only) ──────────────────────────────

  /// Horizontal page gutter (left + right padding on screen edges).
  final double screenHorizontalPadding;

  /// Internal horizontal padding inside cards.
  final double cardHorizontalPadding;

  /// Vertical spacing between major page sections.
  final double sectionSpacingV;

  /// Maximum content width. On mobile this is [double.infinity] (full-bleed).
  /// On tablet, content is capped so it does not span the entire display.
  final double contentMaxWidth;

  /// Number of columns in a grid layout.
  final int gridColumnCount;

  const ResponsiveDimensions._({
    required this.radiusSmall,
    required this.radiusMedium,
    required this.radiusPill,
    required this.elevationFlat,
    required this.buttonPaddingV,
    required this.buttonPaddingH,
    required this.inputPaddingV,
    required this.inputPaddingH,
    required this.borderFocused,
    required this.borderDefault,
    required this.dividerThickness,
    required this.dividerSpace,
    required this.appBarOpacity,
    required this.screenHorizontalPadding,
    required this.cardHorizontalPadding,
    required this.sectionSpacingV,
    required this.contentMaxWidth,
    required this.gridColumnCount,
  });

  /// Mobile dimensions — every value equals the corresponding [AppDimensions]
  /// constant, ensuring zero visual regression on mobile.
  const ResponsiveDimensions.forMobile()
      : this._(
          radiusSmall: AppDimensions.radiusSmall,
          radiusMedium: AppDimensions.radiusMedium,
          radiusPill: AppDimensions.radiusPill,
          elevationFlat: AppDimensions.elevationFlat,
          buttonPaddingV: AppDimensions.buttonPaddingV,
          buttonPaddingH: AppDimensions.buttonPaddingH,
          inputPaddingV: AppDimensions.inputPaddingV,
          inputPaddingH: AppDimensions.inputPaddingH,
          borderFocused: AppDimensions.borderFocused,
          borderDefault: AppDimensions.borderDefault,
          dividerThickness: AppDimensions.dividerThickness,
          dividerSpace: AppDimensions.dividerSpace,
          appBarOpacity: AppDimensions.appBarOpacity,
          screenHorizontalPadding: 16.0,
          cardHorizontalPadding: 16.0,
          sectionSpacingV: 24.0,
          contentMaxWidth: double.infinity,
          gridColumnCount: 1,
        );

  /// Tablet dimensions — spatial tokens are scaled by
  /// [AppBreakpoints.scaleFactorOf] (× 1.15). Optical constants are unchanged.
  ResponsiveDimensions.forTablet()
      : this._(
          radiusSmall: AppDimensions.radiusSmall * AppBreakpoints.scaleFactorOf(AppBreakpoints.tabletMinWidth),
          radiusMedium: AppDimensions.radiusMedium * AppBreakpoints.scaleFactorOf(AppBreakpoints.tabletMinWidth),
          radiusPill: AppDimensions.radiusPill,
          elevationFlat: AppDimensions.elevationFlat,
          buttonPaddingV: AppDimensions.buttonPaddingV * AppBreakpoints.scaleFactorOf(AppBreakpoints.tabletMinWidth),
          buttonPaddingH: AppDimensions.buttonPaddingH * AppBreakpoints.scaleFactorOf(AppBreakpoints.tabletMinWidth),
          inputPaddingV: AppDimensions.inputPaddingV * AppBreakpoints.scaleFactorOf(AppBreakpoints.tabletMinWidth),
          inputPaddingH: AppDimensions.inputPaddingH * AppBreakpoints.scaleFactorOf(AppBreakpoints.tabletMinWidth),
          borderFocused: AppDimensions.borderFocused,
          borderDefault: AppDimensions.borderDefault,
          dividerThickness: AppDimensions.dividerThickness,
          dividerSpace: AppDimensions.dividerSpace,
          appBarOpacity: AppDimensions.appBarOpacity,
          screenHorizontalPadding: 24.0,
          cardHorizontalPadding: 20.0,
          sectionSpacingV: 32.0,
          contentMaxWidth: 720.0,
          gridColumnCount: 2,
        );
}
