import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_dimensions.dart';
import '../application/theme_provider.dart';

class ThemeSelectionScreen extends ConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.screenPaddingH,
                AppDimensions.headerPaddingTop,
                AppDimensions.screenPaddingH,
                AppDimensions.scrollBottomClearance,
              ),
              child: Column(
                children: [
                  // ── App Icon & Branding ──
                  // bg-[#D6E4FF] = primaryFixed per HTML line 105
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: cs.primaryFixed,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                      boxShadow: [
                        BoxShadow(
                          color: cs.shadow.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.menu_book,
                      size: 40,
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.cardGap),
                  // font-headline font-extrabold text-[22px] tracking-tight
                  Text(
                    'KhataMitra',
                    style: tt.headlineSmall?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // text-on-surface-variant font-medium text-sm (bodySmall)
                  Text(
                    'Choose your theme',
                    style: tt.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.sectionGap),

                  // ── Theme Cards ──
                  _ThemeCard(
                    title: 'Light',
                    subtitle: 'Bright white background',
                    icon: Icons.light_mode,
                    mode: ThemeMode.light,
                    currentMode: themeMode,
                    unselectedIconBg: cs.primaryFixed,
                    unselectedIconColor: cs.onPrimaryFixedVariant,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.light),
                  ),
                  const SizedBox(height: AppDimensions.cardGap),
                  _ThemeCard(
                    title: 'Dark',
                    subtitle: 'Easy on the eyes at night',
                    icon: Icons.dark_mode,
                    mode: ThemeMode.dark,
                    currentMode: themeMode,
                    // HTML line 126: bg-on-surface for dark card icon box
                    unselectedIconBg: cs.onSurface,
                    unselectedIconColor: cs.surface,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark),
                  ),
                  const SizedBox(height: AppDimensions.cardGap),
                  _ThemeCard(
                    title: 'System Default',
                    subtitle: 'Follows your phone setting',
                    icon: Icons.contrast,
                    mode: ThemeMode.system,
                    currentMode: themeMode,
                    unselectedIconBg: cs.primaryFixed,
                    unselectedIconColor: cs.onPrimaryFixedVariant,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.system),
                  ),

                  const SizedBox(height: AppDimensions.illustrationGap),

                  // ── Decorative Bento Grid ──
                  // HTML line 147: bg-white/40 rounded-3xl
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 128,
                          padding: const EdgeInsets.all(AppDimensions.cardGap),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.4),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusLarge),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: cs.secondaryContainer,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Spacer(),
                              // HTML line 149: bg-outline-variant/20
                              Container(
                                height: 8,
                                width: 64,
                                margin: const EdgeInsets.only(bottom: 4),
                                decoration: BoxDecoration(
                                  color: cs.outlineVariant.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                                ),
                              ),
                              Container(
                                height: 8,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: cs.outlineVariant.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.cardGap),
                      Expanded(
                        child: Container(
                          height: 128,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.4),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusLarge),
                          ),
                          child: Icon(
                            Icons.brush_outlined,
                            size: 48,
                            // HTML line 153: text-outline-variant/40
                            color: cs.outlineVariant.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Sticky Footer ──
            // HTML line 158: gradient from-[#F2F3F5] pt-8 pb-4
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.screenPaddingH,
                  AppDimensions.footerPaddingTop,
                  AppDimensions.screenPaddingH,
                  AppDimensions.footerPaddingBottom,
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
                    stops: const [0, 0.6, 1],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () => context.go('/language'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
                    shape: const StadiumBorder(),
                    elevation: 4,
                    shadowColor: cs.primary.withValues(alpha: 0.2),
                  ),
                  // HTML line 160: font-headline font-bold text-base → titleMedium weight bold
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

class _ThemeCard extends StatelessWidget {
  const _ThemeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.mode,
    required this.currentMode,
    required this.unselectedIconBg,
    required this.unselectedIconColor,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final ThemeMode mode;
  final ThemeMode currentMode;
  final Color unselectedIconBg;
  final Color unselectedIconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentMode == mode;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    // HTML line 114: selected = bg-primary-fixed (Light Navy #D6E3FF)
    // HTML line 125: unselected = bg-surface-container-lowest (white)
    final cardBg = isSelected ? cs.primaryFixed : cs.surfaceContainerLowest;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(AppDimensions.cardGap),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          border: Border.all(
            color: isSelected
                ? cs.primary
                : cs.outlineVariant.withValues(alpha: 0.3),
            width: isSelected ? AppDimensions.borderFocused : AppDimensions.borderSubtle,
          ),
        ),
        child: Row(
          children: [
            // HTML line 115: selected = bg-white; unselected varies per card
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : unselectedIconBg,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: Icon(
                icon,
                color: isSelected ? cs.primary : unselectedIconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: AppDimensions.cardGap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HTML line 119: font-headline font-bold text-on-surface text-base
                  // Selected bg is always primaryFixed (light), so use onPrimaryFixed for contrast
                  // in both light and dark themes. Unselected uses the theme's onSurface.
                  Text(
                    title,
                    style: tt.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? cs.onPrimaryFixed : cs.onSurface,
                    ),
                  ),
                  // HTML line 120: text-on-surface-variant text-xs font-medium
                  Text(
                    subtitle,
                    style: tt.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isSelected ? cs.onPrimaryFixedVariant : cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            // HTML line 122: check_circle text-primary (not onPrimary — bg is light)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? Icon(
                      Icons.check_circle,
                      key: const ValueKey('check'),
                      color: cs.primary,
                      size: 24,
                    )
                  : const SizedBox(key: ValueKey('empty'), width: 24, height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
