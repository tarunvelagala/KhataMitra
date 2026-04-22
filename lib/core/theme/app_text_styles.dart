import 'package:flutter/material.dart';

abstract final class _TypeScale {
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
/// Uses the platform system font (SF Pro on iOS, Roboto on Android).
/// Colors are intentionally absent — they are applied by ThemeData.textTheme
/// so that light and dark themes resolve correctly at runtime.
abstract final class AppTextStyles {
  static const displayLarge = TextStyle(
    inherit: true,
    fontSize: _TypeScale.displayLarge,
    fontWeight: FontWeight.w400,
    letterSpacing: _TypeScale.spacingTight1,
  );

  static const displayMedium = TextStyle(
    inherit: true,
    fontSize: _TypeScale.displayMedium,
    fontWeight: FontWeight.w400,
  );

  static const displaySmall = TextStyle(
    inherit: true,
    fontSize: _TypeScale.displaySmall,
    fontWeight: FontWeight.w400,
  );

  static const headlineLarge = TextStyle(
    inherit: true,
    fontSize: _TypeScale.headlineLarge,
    fontWeight: FontWeight.w800,
    letterSpacing: _TypeScale.spacingTight2,
  );

  static const headlineMedium = TextStyle(
    inherit: true,
    fontSize: _TypeScale.headlineMedium,
    fontWeight: FontWeight.w700,
    letterSpacing: _TypeScale.spacingTight1,
  );

  static const headlineSmall = TextStyle(
    inherit: true,
    fontSize: _TypeScale.headlineSmall,
    fontWeight: FontWeight.w700,
  );

  static const titleLarge = TextStyle(
    inherit: true,
    fontSize: _TypeScale.titleLarge,
    fontWeight: FontWeight.w700,
  );

  static const titleMedium = TextStyle(
    inherit: true,
    fontSize: _TypeScale.titleMedium,
    fontWeight: FontWeight.w600,
    letterSpacing: _TypeScale.spacingSm,
  );

  static const titleSmall = TextStyle(
    inherit: true,
    fontSize: _TypeScale.titleSmall,
    fontWeight: FontWeight.w600,
    letterSpacing: _TypeScale.spacingXs,
  );

  static const bodyLarge = TextStyle(
    inherit: true,
    fontSize: _TypeScale.bodyLarge,
    fontWeight: FontWeight.w400,
    letterSpacing: _TypeScale.spacingXl,
  );

  static const bodyMedium = TextStyle(
    inherit: true,
    fontSize: _TypeScale.bodyMedium,
    fontWeight: FontWeight.w400,
    letterSpacing: _TypeScale.spacingMd,
  );

  static const bodySmall = TextStyle(
    inherit: true,
    fontSize: _TypeScale.bodySmall,
    fontWeight: FontWeight.w400,
    letterSpacing: _TypeScale.spacingLg,
  );

  static const labelLarge = TextStyle(
    inherit: true,
    fontSize: _TypeScale.labelLarge,
    fontWeight: FontWeight.w600,
    letterSpacing: _TypeScale.spacingXs,
  );

  static const labelMedium = TextStyle(
    inherit: true,
    fontSize: _TypeScale.labelMedium,
    fontWeight: FontWeight.w500,
    letterSpacing: _TypeScale.spacingXl,
  );

  static const labelSmall = TextStyle(
    inherit: true,
    fontSize: _TypeScale.labelSmall,
    fontWeight: FontWeight.w700,
    letterSpacing: _TypeScale.spacingXxl,
  );
}
