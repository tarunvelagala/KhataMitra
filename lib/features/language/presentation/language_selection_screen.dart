import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../application/language_provider.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(languageProvider);
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Header: Brand Identity ──
            // HTML line 103: pt-16 pb-12 px-6
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.screenPaddingH,
                AppDimensions.headerPaddingTop,
                AppDimensions.screenPaddingH,
                AppDimensions.headerPaddingBottom,
              ),
              child: Column(
                children: [
                  // HTML line 105: app-icon-gradient (#d6e3ff = primaryFixed) rounded-2xl w-20 h-20
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: cs.primaryFixed,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: Icon(
                      Icons.menu_book,
                      size: 48,
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.cardGap),
                  // HTML line 109: font-headline font-extrabold text-2xl text-primary
                  Text(
                    'KhataMitra',
                    style: tt.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.primary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // HTML lines 112-114: font-body text-sm — bodySmall, no weight override
                  Text(
                    'Choose your language',
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  Text(
                    'अपनी भाषा चुनें',
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  Text(
                    'మీ భాష ఎంచుకోండి',
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),

            // ── Language List ──
            // HTML line 118: px-4 pb-32
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.cardGap,
                ),
                child: Column(
                  children: [
                    _LanguageCard(
                      iconText: 'EN',
                      title: l10n.english,
                      subtitle: l10n.continueInEnglish,
                      isSelected: currentLocale.languageCode == 'en',
                      onTap: () => ref
                          .read(languageProvider.notifier)
                          .setLanguage(const Locale('en')),
                    ),
                    const SizedBox(height: AppDimensions.cardGap),
                    _LanguageCard(
                      iconText: 'हि',
                      title: l10n.hindi,
                      subtitle: l10n.continueInHindi,
                      isSelected: currentLocale.languageCode == 'hi',
                      onTap: () => ref
                          .read(languageProvider.notifier)
                          .setLanguage(const Locale('hi')),
                    ),
                    const SizedBox(height: AppDimensions.cardGap),
                    _LanguageCard(
                      iconText: 'తె',
                      title: l10n.telugu,
                      subtitle: l10n.continueInTelugu,
                      isSelected: currentLocale.languageCode == 'te',
                      onTap: () => ref
                          .read(languageProvider.notifier)
                          .setLanguage(const Locale('te')),
                    ),
                    // clearance so content doesn't hide behind the sticky footer
                    const SizedBox(height: AppDimensions.scrollBottomClearance),
                  ],
                ),
              ),
            ),

            // ── Sticky Footer ──
            // HTML line 156: px-6 pt-4 pb-8 — no gradient, surface-container-lowest/80 + blur
            // Flutter doesn't support CSS backdrop-blur; use a semi-opaque surface instead.
            Container(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.screenPaddingH,
                AppDimensions.cardGap,
                AppDimensions.screenPaddingH,
                32, // pb-8 = 32px per HTML line 156
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    cs.surface,
                    cs.surface.withValues(alpha: 0.9),
                    cs.surface.withValues(alpha: 0.0),
                  ],
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                // HTML line 158: bg-primary text-on-primary font-headline font-bold
                //                text-lg rounded-full shadow-lg shadow-primary/20 h-14
                child: ElevatedButton(
                  onPressed: () => context.go('/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
                    shape: const StadiumBorder(),
                    elevation: 4,
                    shadowColor: cs.primary.withValues(alpha: 0.2),
                  ),
                  child: Text(
                    l10n.continueButton,
                    style: tt.titleMedium?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.iconText,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String iconText;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(AppDimensions.cardGap),
        decoration: BoxDecoration(
          // HTML line 92: selected-language = rgba(214,227,255,0.2) = primaryFixed at 0.2
          color: isSelected
              ? cs.primaryFixed.withValues(alpha: 0.2)
              : cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          border: Border.all(
            color: isSelected ? cs.primary : Colors.transparent,
            width: AppDimensions.borderFocused,
          ),
        ),
        child: Row(
          children: [
            // HTML line 122: bg-primary-fixed rounded-lg w-10 h-10
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cs.primaryFixed,
                borderRadius: BorderRadius.circular(AppDimensions.radiusXSmall),
              ),
              alignment: Alignment.center,
              // HTML line 123: font-headline font-bold text-primary
              // titleLarge = Plus Jakarta Sans w700 — closest headline role
              child: Text(
                iconText,
                style: tt.titleLarge?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.cardGap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HTML line 126: font-headline font-bold text-lg text-on-surface
                  Text(
                    title,
                    style: tt.titleLarge?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // HTML line 127: font-body text-sm text-on-surface-variant (no weight override)
                  Text(
                    subtitle,
                    style: tt.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            // HTML line 129-131: w-6 h-6 rounded-full bg-primary, check icon text-on-primary
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primary,
                ),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: cs.onPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
