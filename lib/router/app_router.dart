import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khata_mitra/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_mitra/core/localization/locale_provider.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => Consumer(
        builder: (context, ref, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.appTitle),
          ),
          body: Center(
            child: Text(
              AppLocalizations.of(context)!.comingSoon,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => ref.read(localeStateProvider.notifier).toggleLocale(),
            tooltip: 'Toggle Language',
            child: const Icon(Icons.translate),
          ),
        ),
      ),
    ),
  ],
);
