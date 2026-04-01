import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/app_breakpoints.dart';
import 'package:khata_mitra/core/theme/app_text_styles.dart';

/// Text style tokens resolved for the current form factor.
///
/// Mirrors every constant in [AppTextStyles]. On mobile the values are
/// identical to [AppTextStyles]. On tablet, font sizes are scaled by
/// [AppBreakpoints.scaleFactorOf] (× 1.15); all other properties
/// (weight, letter-spacing) are preserved via [TextStyle.copyWith].
///
/// Obtain via `context.rText` (see [ResponsiveContext]).
@immutable
class ResponsiveTextStyles {
  // ── Display ───────────────────────────────────────────────────────
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;

  // ── Headline ──────────────────────────────────────────────────────
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;

  // ── Title ─────────────────────────────────────────────────────────
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  // ── Body ──────────────────────────────────────────────────────────
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  // ── Label ─────────────────────────────────────────────────────────
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  const ResponsiveTextStyles._({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  /// Mobile text styles — structurally identical to [AppTextStyles] constants.
  const ResponsiveTextStyles.forMobile()
      : this._(
          displayLarge: AppTextStyles.displayLarge,
          displayMedium: AppTextStyles.displayMedium,
          displaySmall: AppTextStyles.displaySmall,
          headlineLarge: AppTextStyles.headlineLarge,
          headlineMedium: AppTextStyles.headlineMedium,
          headlineSmall: AppTextStyles.headlineSmall,
          titleLarge: AppTextStyles.titleLarge,
          titleMedium: AppTextStyles.titleMedium,
          titleSmall: AppTextStyles.titleSmall,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.labelLarge,
          labelMedium: AppTextStyles.labelMedium,
          labelSmall: AppTextStyles.labelSmall,
        );

  /// Tablet text styles — font sizes scaled by
  /// [AppBreakpoints.scaleFactorOf] (× 1.15). All other style properties
  /// (weight, letter-spacing, etc.) are inherited from [AppTextStyles].
  ResponsiveTextStyles.forTablet()
      : this._(
          displayLarge: _scale(AppTextStyles.displayLarge),
          displayMedium: _scale(AppTextStyles.displayMedium),
          displaySmall: _scale(AppTextStyles.displaySmall),
          headlineLarge: _scale(AppTextStyles.headlineLarge),
          headlineMedium: _scale(AppTextStyles.headlineMedium),
          headlineSmall: _scale(AppTextStyles.headlineSmall),
          titleLarge: _scale(AppTextStyles.titleLarge),
          titleMedium: _scale(AppTextStyles.titleMedium),
          titleSmall: _scale(AppTextStyles.titleSmall),
          bodyLarge: _scale(AppTextStyles.bodyLarge),
          bodyMedium: _scale(AppTextStyles.bodyMedium),
          bodySmall: _scale(AppTextStyles.bodySmall),
          labelLarge: _scale(AppTextStyles.labelLarge),
          labelMedium: _scale(AppTextStyles.labelMedium),
          labelSmall: _scale(AppTextStyles.labelSmall),
        );

  /// Scales [style]'s [TextStyle.fontSize] by the tablet scale factor.
  static TextStyle _scale(TextStyle style) {
    final scaleFactor = AppBreakpoints.scaleFactorOf(AppBreakpoints.tabletMinWidth);
    return style.copyWith(fontSize: style.fontSize! * scaleFactor);
  }
}
