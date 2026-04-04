import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_mitra/features/language/presentation/language_selection_screen.dart';
import 'package:khata_mitra/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    // Necessary for SharedPreferences in tests
    SharedPreferences.setMockInitialValues({});
  });

  group('LanguageSelectionScreen Golden Tests', () {
    Widget buildTestScreen() {
      final baseTheme = ThemeData.light(useMaterial3: true);
      return ProviderScope(
        child: MaterialApp(
          theme: baseTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LanguageSelectionScreen(),
        ),
      );
    }

    goldenTest(
      'renders correctly',
      fileName: 'language_selection_screen',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'Default',
            constraints: const BoxConstraints(minWidth: 390, maxWidth: 390, minHeight: 844, maxHeight: 844),
            child: buildTestScreen(),
          ),
        ],
      ),
    );
  });
}
