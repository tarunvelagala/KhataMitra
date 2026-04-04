import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/theme_provider.dart';

class ThemeSelectionScreen extends ConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 64, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.menu_book,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'KhataMitra',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Choose your theme',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 40),

                  // Selection Cards
                  _buildThemeCard(
                    context,
                    ref: ref,
                    title: 'Light',
                    subtitle: 'Bright white background',
                    icon: Icons.light_mode,
                    mode: ThemeMode.light,
                    currentMode: themeMode,
                  ),
                  const SizedBox(height: 16),
                  _buildThemeCard(
                    context,
                    ref: ref,
                    title: 'Dark',
                    subtitle: 'Easy on the eyes at night',
                    icon: Icons.dark_mode,
                    mode: ThemeMode.dark,
                    currentMode: themeMode,
                  ),
                  const SizedBox(height: 16),
                  _buildThemeCard(
                    context,
                    ref: ref,
                    title: 'System Default',
                    subtitle: 'Follows your phone setting',
                    icon: Icons.contrast,
                    mode: ThemeMode.system,
                    currentMode: themeMode,
                  ),
                  
                  const SizedBox(height: 48),
                ],
              ),
            ),
            
            // Sticky Footer
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                      Theme.of(context).colorScheme.surface.withValues(alpha: 0.0),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/language');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeCard(
    BuildContext context, {
    required WidgetRef ref,
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeMode mode,
    required ThemeMode currentMode,
  }) {
    final isSelected = currentMode == mode;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
         ref.read(themeModeProvider.notifier).setThemeMode(mode);
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? colorScheme.primary : colorScheme.surface,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: colorScheme.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
