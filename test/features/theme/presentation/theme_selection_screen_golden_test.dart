import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_pro/core/theme/app_theme.dart';
import 'package:khata_pro/features/theme/presentation/theme_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('ThemeSelectionScreen Golden Tests', () {
    Widget buildTestScreen(ThemeMode mode) {
      const locale = Locale('en');
      // Use our real ColorScheme but default fonts to avoid GoogleFonts
      // network/asset exceptions in tests.
      return ProviderScope(
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: AppTheme.light(locale).colorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: AppTheme.dark(locale).colorScheme,
          ),
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          home: const ThemeSelectionScreen(),
        ),
      );
    }

    goldenTest(
      'renders correctly',
      fileName: 'theme_selection_screen',
      skip: true, // Temporarily skipped due to GoogleFonts network issues in CI
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: 'Light Mode - Mobile',
            constraints: const BoxConstraints(
                minWidth: 390, maxWidth: 390, minHeight: 844, maxHeight: 844),
            child: buildTestScreen(ThemeMode.light),
          ),
          GoldenTestScenario(
            name: 'Dark Mode - Mobile',
            constraints: const BoxConstraints(
                minWidth: 390, maxWidth: 390, minHeight: 844, maxHeight: 844),
            child: buildTestScreen(ThemeMode.dark),
          ),
        ],
      ),
    );
  });
}
