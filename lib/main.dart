import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khata_pro/l10n/app_localizations.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/language/application/language_provider.dart';
import 'features/theme/application/theme_provider.dart';

void main() {
  // Disable runtime font fetching — fonts must be bundled as assets.
  // Without this, google_fonts throws unhandled exceptions on devices
  // without internet access (e.g. emulators with no network).
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const ProviderScope(child: KhataMitraApp()));
}

class KhataMitraApp extends ConsumerWidget {
  const KhataMitraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(languageProvider);

    return MaterialApp.router(
      title: 'KhataPro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(locale),
      darkTheme: AppTheme.dark(locale),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
