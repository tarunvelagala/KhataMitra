import 'package:flutter/material.dart';

/// All color tokens from the KhataPro design system (DESIGN.md).
/// Seeds: primary #1565C0, secondary #2E7D32, tertiary #C62828.
abstract final class AppColors {
  // --- Primary ---
  static const primary = Color(0xFF1565C0);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFD6E3FF);
  static const onPrimaryContainer = Color(0xFF001B3D);
  static const primaryFixed = Color(0xFFD6E3FF);
  static const primaryFixedDim = Color(0xFFA9C7FF);
  static const onPrimaryFixed = Color(0xFF001B3D);
  static const onPrimaryFixedVariant = Color(0xFF00468C);
  static const inversePrimary = Color(0xFFA9C7FF);
  static const surfaceTint = Color(0xFF1565C0);

  // --- Secondary (Green — credit/income) ---
  static const secondary = Color(0xFF2E7D32);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFA3F69C);
  static const onSecondaryContainer = Color(0xFF002204);
  static const secondaryFixed = Color(0xFFA3F69C);
  static const secondaryFixedDim = Color(0xFF88D982);
  static const onSecondaryFixed = Color(0xFF002204);
  static const onSecondaryFixedVariant = Color(0xFF005312);

  // --- Tertiary (Red — debit/expense) ---
  static const tertiary = Color(0xFFC62828);
  static const onTertiary = Color(0xFFFFFFFF);
  static const tertiaryContainer = Color(0xFFFFDAD6);
  static const onTertiaryContainer = Color(0xFF410003);
  static const tertiaryFixed = Color(0xFFFFDAD6);
  static const tertiaryFixedDim = Color(0xFFFFB4AC);
  static const onTertiaryFixed = Color(0xFF410003);
  static const onTertiaryFixedVariant = Color(0xFF93000E);

  // --- Error ---
  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF410002);

  // --- Surface & Background ---
  static const background = Color(0xFFFAF9FD);
  static const onBackground = Color(0xFF1A1B1E);
  static const surface = Color(0xFFFAF9FD);
  static const onSurface = Color(0xFF1A1B1E);
  static const surfaceDim = Color(0xFFDAD9DD);
  static const surfaceBright = Color(0xFFFAF9FD);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF4F3F7);
  static const surfaceContainer = Color(0xFFEFEDF1);
  static const surfaceContainerHigh = Color(0xFFE9E7EC);
  static const surfaceContainerHighest = Color(0xFFE3E2E6);
  static const surfaceVariant = Color(0xFFE0E2EC);
  static const onSurfaceVariant = Color(0xFF44474E);
  static const inverseSurface = Color(0xFF2F3033);
  static const inverseOnSurface = Color(0xFFF1F0F4);

  // --- Outline ---
  static const outline = Color(0xFF74777F);
  static const outlineVariant = Color(0xFFC4C6CF);

  // ------------------------------------------------------------------ //
  // Dark theme tokens
  // ------------------------------------------------------------------ //

  // --- Primary (dark) ---
  static const darkPrimary = Color(0xFFA9C7FF);
  static const darkOnPrimary = Color(0xFF003063);
  static const darkPrimaryContainer = Color(0xFF00468C);
  static const darkOnPrimaryContainer = Color(0xFFD6E3FF);

  // --- Secondary (dark — credit/income) ---
  static const darkSecondary = Color(0xFF88D982);
  static const darkOnSecondary = Color(0xFF003909);
  static const darkSecondaryContainer = Color(0xFF005312);
  static const darkOnSecondaryContainer = Color(0xFFA3F69C);

  // --- Tertiary (dark — debit/expense) ---
  static const darkTertiary = Color(0xFFFFB4AC);
  static const darkOnTertiary = Color(0xFF690007);
  static const darkTertiaryContainer = Color(0xFF93000E);
  static const darkOnTertiaryContainer = Color(0xFFFFDAD6);

  // --- Error (dark) ---
  static const darkError = Color(0xFFFFB4AB);
  static const darkOnError = Color(0xFF690005);
  static const darkErrorContainer = Color(0xFF93000A);
  static const darkOnErrorContainer = Color(0xFFFFB4AB);

  // --- Surface (dark) ---
  static const darkBackground = Color(0xFF121316);
  static const darkOnBackground = Color(0xFFE3E2E6);
  static const darkSurface = Color(0xFF121316);
  static const darkOnSurface = Color(0xFFE3E2E6);
  static const darkSurfaceDim = Color(0xFF121316);
  static const darkSurfaceBright = Color(0xFF38393C);
  static const darkSurfaceContainerLowest = Color(0xFF0D0E11);
  static const darkSurfaceContainerLow = Color(0xFF1A1B1E);
  static const darkSurfaceContainer = Color(0xFF1E2023);
  static const darkSurfaceContainerHigh = Color(0xFF292A2D);
  static const darkSurfaceContainerHighest = Color(0xFF343538);
  static const darkOnSurfaceVariant = Color(0xFFC4C6CF);
  static const darkInverseSurface = Color(0xFFE3E2E6);
  static const darkInverseOnSurface = Color(0xFF2F3033);
  static const darkInversePrimary = Color(0xFF1565C0);

  // --- Outline (dark) ---
  static const darkOutline = Color(0xFF8E9099);
  static const darkOutlineVariant = Color(0xFF44474E);
}
