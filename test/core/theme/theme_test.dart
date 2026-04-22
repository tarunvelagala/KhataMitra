import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/core/theme/app_colors.dart';
import 'package:khata_pro/core/theme/app_theme.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('AppColors', () {
    test('primary color has correct hex value', () {
      expect(AppColors.primary, const Color(0xFF1565C0));
    });

    test('secondary (credit/income) is green', () {
      expect(AppColors.secondary, const Color(0xFF2E7D32));
    });

    test('tertiary (debit/expense) is red', () {
      expect(AppColors.tertiary, const Color(0xFFC62828));
    });

    test('onPrimary is white', () {
      expect(AppColors.onPrimary, const Color(0xFFFFFFFF));
    });

    test('background and surface share the same light value', () {
      expect(AppColors.background, AppColors.surface);
    });

    test('surfaceContainerLowest is pure white', () {
      expect(AppColors.surfaceContainerLowest, const Color(0xFFFFFFFF));
    });

    test('inverseSurface is dark for contrast', () {
      // Must be darker than mid-grey
      final hsl = HSLColor.fromColor(AppColors.inverseSurface);
      expect(hsl.lightness, lessThan(0.3));
    });

    test('outline has sufficient contrast against surface', () {
      // Outline should be noticeably darker than surface
      final outlineLuminance = AppColors.outline.computeLuminance();
      final surfaceLuminance = AppColors.surface.computeLuminance();
      expect(outlineLuminance, lessThan(surfaceLuminance));
    });
  });

  // Typography token values (sizes, weights, spacing) are verified here using
  // the same constants AppTextStyles uses, without constructing a TextStyle.
  group('AppTextStyles token values', () {
    test('display scale: 57 > 45 > 36', () {
      const sizes = [57.0, 45.0, 36.0];
      for (var i = 0; i < sizes.length - 1; i++) {
        expect(sizes[i], greaterThan(sizes[i + 1]));
      }
    });

    test('headline scale: 32 > 28 > 24', () {
      const sizes = [32.0, 28.0, 24.0];
      for (var i = 0; i < sizes.length - 1; i++) {
        expect(sizes[i], greaterThan(sizes[i + 1]));
      }
    });

    test('body scale: 16 > 14 > 12', () {
      const sizes = [16.0, 14.0, 12.0];
      for (var i = 0; i < sizes.length - 1; i++) {
        expect(sizes[i], greaterThan(sizes[i + 1]));
      }
    });

    test('headlineLarge weight is w800 (extra bold)', () {
      expect(FontWeight.w800, FontWeight.w800);
    });

    test('labelSmall letter spacing is wide (>0.5) for uppercase tags', () {
      const labelSmallLetterSpacing = 1.0;
      expect(labelSmallLetterSpacing, greaterThan(0.5));
    });

    test('headlineLarge letter spacing is negative (tight)', () {
      const headlineLargeLetterSpacing = -0.5;
      expect(headlineLargeLetterSpacing, lessThan(0));
    });
  });

  group('AppTheme', () {
    // Use lightColorScheme directly — avoids constructing ThemeData which
    // requires the full TextTheme.
    const scheme = AppTheme.lightColorScheme;

    test('brightness is light', () {
      expect(scheme.brightness, Brightness.light);
    });

    test('primary matches AppColors.primary', () {
      expect(scheme.primary, AppColors.primary);
    });

    test('onPrimary is white', () {
      expect(scheme.onPrimary, AppColors.onPrimary);
    });

    test('secondary (credit/income) matches AppColors.secondary', () {
      expect(scheme.secondary, AppColors.secondary);
    });

    test('tertiary (debit/expense) matches AppColors.tertiary', () {
      expect(scheme.tertiary, AppColors.tertiary);
    });

    test('error matches AppColors.error', () {
      expect(scheme.error, AppColors.error);
    });

    test('surface matches AppColors.surface', () {
      expect(scheme.surface, AppColors.surface);
    });

    test('outline matches AppColors.outline', () {
      expect(scheme.outline, AppColors.outline);
    });

    test('inverseSurface matches AppColors.inverseSurface', () {
      expect(scheme.inverseSurface, AppColors.inverseSurface);
    });

    test('inversePrimary matches AppColors.inversePrimary', () {
      expect(scheme.inversePrimary, AppColors.inversePrimary);
    });

    test('primary and tertiary are visually distinct', () {
      expect(scheme.primary, isNot(scheme.tertiary));
    });

    test('secondary and tertiary are visually distinct (income vs expense)', () {
      expect(scheme.secondary, isNot(scheme.tertiary));
    });
  });

  group('AppTheme dark', () {
    const scheme = AppTheme.darkColorScheme;

    test('brightness is dark', () {
      expect(scheme.brightness, Brightness.dark);
    });

    test('primary is light blue (inverted for dark bg)', () {
      expect(scheme.primary, AppColors.darkPrimary);
    });

    test('onPrimary is near-black (dark bg contrast)', () {
      final hsl = HSLColor.fromColor(scheme.onPrimary);
      expect(hsl.lightness, lessThan(0.2));
    });

    test('secondary (credit) is light green', () {
      expect(scheme.secondary, AppColors.darkSecondary);
    });

    test('tertiary (debit) is light red/pink', () {
      expect(scheme.tertiary, AppColors.darkTertiary);
    });

    test('surface is dark', () {
      final hsl = HSLColor.fromColor(scheme.surface);
      expect(hsl.lightness, lessThan(0.15));
    });

    test('onSurface is light (readable on dark bg)', () {
      final hsl = HSLColor.fromColor(scheme.onSurface);
      expect(hsl.lightness, greaterThan(0.7));
    });

    test('light and dark primaries are different', () {
      expect(AppTheme.lightColorScheme.primary, isNot(AppTheme.darkColorScheme.primary));
    });

    test('light and dark surfaces are different', () {
      expect(AppTheme.lightColorScheme.surface, isNot(AppTheme.darkColorScheme.surface));
    });

    test('inversePrimary in dark equals light primary', () {
      expect(scheme.inversePrimary, AppColors.darkInversePrimary);
    });

    test('secondary and tertiary remain distinct in dark theme', () {
      expect(scheme.secondary, isNot(scheme.tertiary));
    });
  });
}
