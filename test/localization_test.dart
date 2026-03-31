import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_mitra/l10n/app_localizations.dart';

void main() {
  testWidgets('Localization verification - English', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('en'),
          home: _LocaleTestWidget(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('KhataMitra — Coming soon!'), findsOneWidget);
  });

  testWidgets('Localization verification - Hindi', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('hi'),
        home: _LocaleTestWidget(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('KhataMitra — जल्द ही आ रहा है!'), findsOneWidget);
  });

  testWidgets('Localization verification - Telugu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('te'),
        home: _LocaleTestWidget(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('KhataMitra — త్వరలో వస్తుంది!'), findsOneWidget);
  });
}

class _LocaleTestWidget extends StatelessWidget {
  const _LocaleTestWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(AppLocalizations.of(context)!.comingSoon)),
    );
  }
}
