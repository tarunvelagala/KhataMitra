import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  // ── Shared TextTheme ───────────────────────────────────────────────────
  // Cached as a static field so the same instances are reused on every
  // theme rebuild.
  static final TextTheme _textTheme = TextTheme(
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

  // ── Color schemes ──────────────────────────────────────────────────────
  // Exposed as consts so unit tests can verify color tokens without
  // constructing ThemeData.

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.onTertiary,
    tertiaryContainer: AppColors.tertiaryContainer,
    onTertiaryContainer: AppColors.onTertiaryContainer,
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.onErrorContainer,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceContainerHighest: AppColors.surfaceContainerHighest,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    inverseSurface: AppColors.inverseSurface,
    onInverseSurface: AppColors.inverseOnSurface,
    inversePrimary: AppColors.inversePrimary,
    scrim: Colors.black,
    shadow: Colors.black,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    primaryContainer: AppColors.darkPrimaryContainer,
    onPrimaryContainer: AppColors.darkOnPrimaryContainer,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkOnSecondary,
    secondaryContainer: AppColors.darkSecondaryContainer,
    onSecondaryContainer: AppColors.darkOnSecondaryContainer,
    tertiary: AppColors.darkTertiary,
    onTertiary: AppColors.darkOnTertiary,
    tertiaryContainer: AppColors.darkTertiaryContainer,
    onTertiaryContainer: AppColors.darkOnTertiaryContainer,
    error: AppColors.darkError,
    onError: AppColors.darkOnError,
    errorContainer: AppColors.darkErrorContainer,
    onErrorContainer: AppColors.darkOnErrorContainer,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    surfaceContainerHighest: AppColors.darkSurfaceContainerHighest,
    onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    outline: AppColors.darkOutline,
    outlineVariant: AppColors.darkOutlineVariant,
    inverseSurface: AppColors.darkInverseSurface,
    onInverseSurface: AppColors.darkInverseOnSurface,
    inversePrimary: AppColors.darkInversePrimary,
    scrim: Colors.black,
    shadow: Colors.black,
  );

  // ── ThemeData ──────────────────────────────────────────────────────────

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _textTheme,
    cardTheme: _cardTheme(AppColors.surfaceContainerLowest),
    elevatedButtonTheme: _elevatedButtonTheme(
      bg: AppColors.primary,
      fg: AppColors.onPrimary,
    ),
    outlinedButtonTheme: _outlinedButtonTheme(
      fg: AppColors.primary,
      outline: AppColors.outline,
    ),
    inputDecorationTheme: _inputTheme(
      fill: AppColors.surfaceContainerHigh,
      focusBorder: AppColors.primary,
    ),
    appBarTheme: _appBarTheme(
      bg: AppColors.surfaceContainerLowest,
      icon: AppColors.primary,
    ),
    dividerTheme: _dividerTheme(AppColors.outlineVariant),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: _textTheme,
    cardTheme: _cardTheme(AppColors.darkSurfaceContainerLowest),
    elevatedButtonTheme: _elevatedButtonTheme(
      bg: AppColors.darkPrimary,
      fg: AppColors.darkOnPrimary,
    ),
    outlinedButtonTheme: _outlinedButtonTheme(
      fg: AppColors.darkPrimary,
      outline: AppColors.darkOutline,
    ),
    inputDecorationTheme: _inputTheme(
      fill: AppColors.darkSurfaceContainerHigh,
      focusBorder: AppColors.darkPrimary,
    ),
    appBarTheme: _appBarTheme(
      bg: AppColors.darkSurfaceContainerLowest,
      icon: AppColors.darkPrimary,
    ),
    dividerTheme: _dividerTheme(AppColors.darkOutlineVariant),
  );

  // ── Private component builders ─────────────────────────────────────────
  // These eliminate the light/dark duplication. Each builder encodes the
  // layout/shape decisions; callers supply only the color tokens.

  static CardThemeData _cardTheme(Color color) => CardThemeData(
        color: color,
        elevation: AppDimensions.elevationFlat,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
      );

  static ElevatedButtonThemeData _elevatedButtonTheme({
    required Color bg,
    required Color fg,
  }) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: AppDimensions.elevationFlat,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.buttonPaddingV,
            horizontal: AppDimensions.buttonPaddingH,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonTheme({
    required Color fg,
    required Color outline,
  }) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: fg,
          side: BorderSide(
            color: outline,
            width: AppDimensions.borderDefault,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.buttonPaddingV,
            horizontal: AppDimensions.buttonPaddingH,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
        ),
      );

  static InputDecorationTheme _inputTheme({
    required Color fill,
    required Color focusBorder,
  }) =>
      InputDecorationTheme(
        filled: true,
        fillColor: fill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          borderSide: BorderSide(
            color: focusBorder,
            width: AppDimensions.borderFocused,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDimensions.inputPaddingV,
          horizontal: AppDimensions.inputPaddingH,
        ),
      );

  static AppBarTheme _appBarTheme({
    required Color bg,
    required Color icon,
  }) =>
      AppBarTheme(
        backgroundColor: bg.withValues(alpha: AppDimensions.appBarOpacity),
        elevation: AppDimensions.elevationFlat,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: icon),
      );

  static DividerThemeData _dividerTheme(Color color) => DividerThemeData(
        color: color,
        thickness: AppDimensions.dividerThickness,
        space: AppDimensions.dividerSpace,
      );
}
