import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/onboarding_providers.dart';
import '../widgets/step_indicator.dart';

// ── File-private layout constants ──────────────────────────────────────────
abstract final class _Dims {
  // Scroll area padding
  static const double scrollPadH   = 24;
  static const double scrollPadTop = 8;
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
  static const double spaceAfterIcon     = 20;
  static const double spaceAfterSubtitle = 8;
  static const double spaceBeforeCards   = 20;
  static const double spaceBetweenCards  = 12;

  // Theme card
  static const double cardRadius  = AppDimensions.radiusMedium;
  static const double cardPad     = 12;
  static const double cardPadBot  = 16;

  // Card border widths reuse shared tokens
  static const double cardBorderSelected   = AppDimensions.borderFocused;
  static const double cardBorderUnselected = AppDimensions.borderDefault;

  // Card preview window
  static const double previewHeight = 80;

  // Preview mock elements
  static const double previewBarH       = 8;
  static const double previewBarRadius  = 4;
  static const double previewBarW1      = 80;
  static const double previewBarW2      = 120;
  static const double previewBarW3      = 60;
  static const double previewBarW5      = 48;
  static const double previewCardRadius = AppDimensions.radiusSmall;
  static const double previewSpacingSm  = 4;
  static const double previewSpacingMd  = 6;
  static const double previewPad        = 8;
  static const double previewDividerH   = 1;

  // Active badge
  static const double badgePadH   = 8;
  static const double badgePadV   = 2;
  static const double badgeRadius = AppDimensions.radiusPill;

  // Card shadow
  static const double shadowAlpha   = 0.06;
  static const double shadowBlur    = 12;
  static const double shadowOffsetY = 2;

  // Selection animation
  static const int animationMs = 200;
}

class ThemeSelectionScreen extends ConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(themeModeProvider);
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Back navigation ──────────────────────────────────────
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
            ),

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
                      child: Icon(Icons.palette_outlined, size: _Dims.iconSize, color: cs.primary),
                    ),
                    const SizedBox(height: _Dims.spaceAfterIcon),

                    // Step indicator
                    const OnboardingStepIndicator(current: 2, total: 4),
                    const SizedBox(height: _Dims.spaceAfterSubtitle),

                    // Title
                    Text(
                      l10n.themeScreenTitle,
                      style: tt.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _Dims.spaceAfterSubtitle),

                    // Subtitle
                    Text(
                      l10n.themeScreenSubtitle,
                      style: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _Dims.spaceBeforeCards),

                    // Theme cards
                                        _ThemeModeCard(
                      mode: ThemeMode.system,
                      label: l10n.themeSystemLabel,
                      activeLabel: l10n.themeActive,
                      isSelected: selected == ThemeMode.system,
                      onTap: () => ref.read(themeModeProvider.notifier).select(ThemeMode.system),
                    ),
                    const SizedBox(height: _Dims.spaceBetweenCards),
                    _ThemeModeCard(
                      mode: ThemeMode.light,
                      label: l10n.themeLightLabel,
                      activeLabel: l10n.themeActive,
                      isSelected: selected == ThemeMode.light,
                      onTap: () => ref.read(themeModeProvider.notifier).select(ThemeMode.light),
                    ),
                    const SizedBox(height: _Dims.spaceBetweenCards),
                    _ThemeModeCard(
                      mode: ThemeMode.dark,
                      label: l10n.themeDarkLabel,
                      activeLabel: l10n.themeActive,
                      isSelected: selected == ThemeMode.dark,
                      onTap: () => ref.read(themeModeProvider.notifier).select(ThemeMode.dark),
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
                      key: const ValueKey('btn_theme_next'),
                      onPressed: () => context.push('/onboarding/shop-details'),
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

// ── Theme mode card ───────────────────────────────────────────────────────────

class _ThemeModeCard extends StatelessWidget {
  const _ThemeModeCard({
    required this.mode,
    required this.label,
    required this.activeLabel,
    required this.isSelected,
    required this.onTap,
  });

  final ThemeMode mode;
  final String label;
  final String activeLabel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = mode == ThemeMode.dark ||
        (mode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: _Dims.animationMs),
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
            // Preview window
            _ThemePreview(isDark: isDark),

            // Card label row
            Padding(
              padding: const EdgeInsets.fromLTRB(
                _Dims.cardPad,
                _Dims.cardPad,
                _Dims.cardPad,
                _Dims.cardPadBot,
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isSelected ? cs.primary : cs.outlineVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label, style: tt.titleMedium),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _Dims.badgePadH,
                        vertical: _Dims.badgePadV,
                      ),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(_Dims.badgeRadius),
                      ),
                      child: Text(
                        activeLabel,
                        style: tt.labelSmall?.copyWith(
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
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

// ── Mini app preview inside the card ─────────────────────────────────────────

class _ThemePreview extends StatelessWidget {
  const _ThemePreview({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bg     = isDark ? const Color(0xFF111111) : const Color(0xFFF8F9FF);
    final surf   = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final text1  = isDark ? const Color(0xFFE2E2E9) : const Color(0xFF1A1C1C);
    final text2  = isDark ? const Color(0xFF8E8E9A) : const Color(0xFF6B7280);
    final accent = isDark ? const Color(0xFFA9C7FF) : const Color(0xFF004D99);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(_Dims.cardRadius),
      ),
      child: Container(
        height: _Dims.previewHeight,
        color: bg,
        padding: const EdgeInsets.all(_Dims.previewPad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fake app bar bar
            Row(
              children: [
                Container(
                  width: _Dims.previewBarW2,
                  height: _Dims.previewBarH,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(_Dims.previewBarRadius),
                  ),
                ),
                const Spacer(),
                Container(
                  width: _Dims.previewBarW5,
                  height: _Dims.previewBarH,
                  decoration: BoxDecoration(
                    color: text2.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(_Dims.previewBarRadius),
                  ),
                ),
              ],
            ),
            const SizedBox(height: _Dims.previewSpacingMd),

            // Divider
            Container(height: _Dims.previewDividerH, color: text2.withValues(alpha: 0.15)),
            const SizedBox(height: _Dims.previewSpacingMd),

            // Fake card
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(_Dims.previewSpacingMd),
                decoration: BoxDecoration(
                  color: surf,
                  borderRadius: BorderRadius.circular(_Dims.previewCardRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: _Dims.previewBarW1,
                      height: _Dims.previewBarH,
                      decoration: BoxDecoration(
                        color: text1,
                        borderRadius: BorderRadius.circular(_Dims.previewBarRadius),
                      ),
                    ),
                    const SizedBox(height: _Dims.previewSpacingSm),
                    Container(
                      width: _Dims.previewBarW3,
                      height: _Dims.previewBarH - 2,
                      decoration: BoxDecoration(
                        color: text2.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(_Dims.previewBarRadius),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
