import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khata_mitra/l10n/app_localizations.dart';
import '../application/language_provider.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(languageProvider);
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
               padding: const EdgeInsets.fromLTRB(24, 64, 24, 48),
               child: Column(
                 children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                         borderRadius: BorderRadius.circular(16)
                      ),
                      child: Icon(Icons.menu_book, size: 48, color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'KhataMitra',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Choose your language', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    Text('अपनी भाषा चुनें', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    Text('మీ భాష ఎంచుకోండి', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                 ]
               )
            ),
            
            // Language List
            Expanded(
              child: SingleChildScrollView(
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: Column(
                   children: [
                     _LanguageCard(
                       iconText: 'EN',
                       title: l10n.english,
                       subtitle: l10n.continueInEnglish,
                       isSelected: currentLocale.languageCode == 'en',
                       onTap: () => ref.read(languageProvider.notifier).setLanguage(const Locale('en')),
                     ),
                     const SizedBox(height: 16),
                     _LanguageCard(
                       iconText: 'हि',
                       title: l10n.hindi,
                       subtitle: l10n.continueInHindi,
                       isSelected: currentLocale.languageCode == 'hi',
                       onTap: () => ref.read(languageProvider.notifier).setLanguage(const Locale('hi')),
                     ),
                     const SizedBox(height: 16),
                     _LanguageCard(
                       iconText: 'తె',
                       title: l10n.telugu,
                       subtitle: l10n.continueInTelugu,
                       isSelected: currentLocale.languageCode == 'te',
                       onTap: () => ref.read(languageProvider.notifier).setLanguage(const Locale('te')),
                     ),
                   ]
                 ),
              )
            ),
            
            // Footer Action
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                    Theme.of(context).colorScheme.surface.withValues(alpha: 0.0),
                  ]
                )
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: Text(l10n.continueButton),
                )
              )
            )
          ]
        ),
      )
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String iconText;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
     required this.iconText,
     required this.title,
     required this.subtitle,
     required this.isSelected,
     required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer.withValues(alpha: 0.2) : colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                 color: colorScheme.primaryContainer,
                 borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(iconText, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                 color: colorScheme.primary,
                 fontWeight: FontWeight.bold,
              ))
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                       color: colorScheme.onSurface,
                       fontWeight: FontWeight.bold,
                   )),
                   Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(
                       color: colorScheme.onSurfaceVariant
                   )),
                ]
              )
            ),
            if (isSelected)
              Container(
                 width: 24,
                 height: 24,
                 decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary,
                 ),
                 child: Icon(Icons.check, size: 16, color: colorScheme.onPrimary),
              )
          ]
        )
      )
    );
  }
}
