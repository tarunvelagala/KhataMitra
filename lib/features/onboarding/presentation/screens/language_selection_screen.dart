import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/onboarding_providers.dart';
import '../widgets/step_indicator.dart';

// ── File-private layout constants ──────────────────────────────────────────
// Values that are only meaningful for this screen. Values shared with other
// features delegate to AppDimensions rather than duplicating the number.
abstract final class _Dims {
  // Scroll area padding
  static const double scrollPadH   = 24;
  static const double scrollPadTop = 32;
  static const double scrollPadBot = 16;

  // Bottom CTA bar padding
  static const double ctaPadTop = 12;
  static const double ctaPadBot = 24;

  // Header icon container
  static const double iconContainerPad    = 16;
  static const double iconContainerRadius = AppDimensions.radiusMedium;
  static const double iconContainerAlpha  = 0.08;
  static const double iconSize            = 40;

  // Spacing
  static const double spaceAfterIcon      = 20;
  static const double spaceAfterSubtitle  = 8;
  static const double spaceBeforeGrid     = 32;
  static const double spaceCardLabel      = 2;

  // Language card grid
  static const int    gridColumns     = 2;
  static const double gridSpacing     = 12;
  static const double gridAspectRatio = 1.6;

  // Language card
  static const double cardPad    = 12;
  static const double cardRadius = AppDimensions.radiusSmall;

  // Selected / unselected border widths reuse shared tokens
  static const double cardBorderSelected   = AppDimensions.borderFocused;
  static const double cardBorderUnselected = AppDimensions.borderDefault;

  // Card shadow
  static const double shadowAlpha   = 0.04;
  static const double shadowBlur    = 8;
  static const double shadowOffsetY = 2;

  // Selection animation
  static const int animationMs = 200;
}

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedLanguageProvider);
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable content ───────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  _Dims.scrollPadH,
                  _Dims.scrollPadTop,
                  _Dims.scrollPadH,
                  _Dims.scrollPadBot,
                ),
                child: Column(
                  children: [
                    // Icon container
                    Container(
                      padding: const EdgeInsets.all(_Dims.iconContainerPad),
                      decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: _Dims.iconContainerAlpha),
                        borderRadius: BorderRadius.circular(_Dims.iconContainerRadius),
                      ),
                      child: Icon(Icons.translate, size: _Dims.iconSize, color: cs.primary),
                    ),
                    const SizedBox(height: _Dims.spaceAfterIcon),

                    // Step indicator
                    const OnboardingStepIndicator(current: 1, total: 4),
                    const SizedBox(height: _Dims.spaceAfterSubtitle),

                    // Title
                    Text(l10n.languageScreenTitle, style: tt.headlineMedium, textAlign: TextAlign.center),
                    const SizedBox(height: _Dims.spaceAfterSubtitle),

                    // Subtitle
                    Text(
                      l10n.languageScreenSubtitle,
                      style: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _Dims.spaceBeforeGrid),

                    // Language grid
                    GridView.count(
                      crossAxisCount: _Dims.gridColumns,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: _Dims.gridSpacing,
                      crossAxisSpacing: _Dims.gridSpacing,
                      childAspectRatio: _Dims.gridAspectRatio,
                      children: AppLanguage.values
                          .map((lang) => _LanguageCard(
                                language: lang,
                                isSelected: selected == lang,
                                onTap: () => ref
                                    .read(selectedLanguageProvider.notifier)
                                    .select(lang),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom CTA ───────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(
                _Dims.scrollPadH,
                _Dims.ctaPadTop,
                _Dims.scrollPadH,
                _Dims.ctaPadBot,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    cs.surface.withValues(alpha: 0),
                    cs.surface,
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      key: const ValueKey('btn_language_next'),
                      onPressed: () => context.push('/onboarding/theme'),
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(l10n.onboardingNext),
                    ),
                  ),
                ],
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
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final AppLanguage language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: _Dims.animationMs),
        padding: const EdgeInsets.all(_Dims.cardPad),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(_Dims.cardRadius),
          border: Border.all(
            color: isSelected ? cs.primary : cs.outlineVariant,
            width: isSelected ? _Dims.cardBorderSelected : _Dims.cardBorderUnselected,
          ),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withValues(alpha: _Dims.shadowAlpha),
              blurRadius: _Dims.shadowBlur,
              offset: const Offset(0, _Dims.shadowOffsetY),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.check_circle_outline,
              color: isSelected ? cs.primary : cs.outlineVariant,
            ),
            const Spacer(),
            Text(
              language.nativeName,
              style: tt.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: _Dims.spaceCardLabel),
            Text(
              language.englishName,
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
