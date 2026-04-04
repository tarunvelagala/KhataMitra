import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_mitra/features/theme/presentation/theme_selection_screen.dart';

void main() {
  group('ThemeSelectionScreen Golden Tests', () {
    Widget buildTestScreen(ThemeMode mode) {
      final baseTheme = mode == ThemeMode.light 
        ? ThemeData.light(useMaterial3: true) 
        : ThemeData.dark(useMaterial3: true);
      return ProviderScope(
        child: MaterialApp(
          theme: baseTheme,
          darkTheme: baseTheme,
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          home: const ThemeSelectionScreen(),
        ),
      );
    }

    goldenTest(
      'renders correctly',
      fileName: 'theme_selection_screen',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: 'Light Mode - Mobile',
            constraints: const BoxConstraints(minWidth: 390, maxWidth: 390, minHeight: 844, maxHeight: 844),
            child: buildTestScreen(ThemeMode.light),
          ),
          GoldenTestScenario(
            name: 'Dark Mode - Mobile',
            constraints: const BoxConstraints(minWidth: 390, maxWidth: 390, minHeight: 844, maxHeight: 844),
            child: buildTestScreen(ThemeMode.dark),
          ),
        ],
      ),
    );
  });
}
