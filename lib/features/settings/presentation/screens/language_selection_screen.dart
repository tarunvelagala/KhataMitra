import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/screen_footer.dart';
import '../../../../core/widgets/selection_card.dart';
import '../../../../l10n/app_localizations.dart';

// ── Language data ─────────────────────────────────────────────────────────────
typedef _Language = ({String code, String nativeName, String badge});

const List<_Language> _languages = [
  (code: 'en', nativeName: 'English',  badge: 'A'),
  (code: 'hi', nativeName: 'हिन्दी',   badge: 'अ'),
  (code: 'kn', nativeName: 'ಕನ್ನಡ',    badge: 'ಕ'),
  (code: 'ta', nativeName: 'தமிழ்',    badge: 'த'),
  (code: 'bn', nativeName: 'বাংলা',    badge: 'ব'),
  (code: 'mr', nativeName: 'मराठी',    badge: 'म'),
  (code: 'ml', nativeName: 'മലയാളം',   badge: 'മ'),
  (code: 'te', nativeName: 'తెలుగు',   badge: 'త'),
];

// ── File-private layout constants ─────────────────────────────────────────────
abstract final class _Dims {
  static const int    gridColumns          = 2;
  static const double gridChildRatio       = 2.8;
  static const double illustrationIconSize = 56.0;
  static const double headerTopPadding     = 40.0;
  static const double iconToTitleGap       = 16.0;
  static const double titleToSubtitleGap   = 8.0;
  static const double subtitleToGridGap    = 32.0;
}

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState
    extends ConsumerState<LanguageSelectionScreen> {
  String _selectedCode = 'en';

  @override
  void initState() {
    super.initState();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('selected_locale');
    if (saved != null && mounted) {
      setState(() => _selectedCode = saved);
    }
  }

  Future<void> _onContinue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', _selectedCode);
    if (!mounted) return;
    context.go('/tour');
  }

  @override
  Widget build(BuildContext context) {
    final l10n        = AppLocalizations.of(context)!;
    final cs          = Theme.of(context).colorScheme;
    final tt          = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.buttonPaddingH,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: _Dims.headerTopPadding),
                    _IllustrationIcon(cs: cs),
                    const SizedBox(height: _Dims.iconToTitleGap),
                    Text(
                      l10n.languageScreenTitle,
                      style: tt.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _Dims.titleToSubtitleGap),
                    Text(
                      l10n.languageScreenSubtitle,
                      style: tt.bodyLarge?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _Dims.subtitleToGridGap),
                    GridView.count(
                      crossAxisCount: _Dims.gridColumns,
                      mainAxisSpacing: AppDimensions.radiusSmall,
                      crossAxisSpacing: AppDimensions.radiusSmall,
                      childAspectRatio: _Dims.gridChildRatio,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: _languages.map((lang) {
                        return SelectionCard(
                          badge: lang.badge,
                          title: lang.nativeName,
                          isSelected: _selectedCode == lang.code,
                          onTap: () =>
                              setState(() => _selectedCode = lang.code),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppDimensions.buttonPaddingH),
                  ],
                ),
              ),
            ),
            ScreenFooter(
              ctaLabel: l10n.languageContinueButton,
              onCta: _onContinue,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _IllustrationIcon extends StatelessWidget {
  const _IllustrationIcon({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.translate_rounded,
      size: _Dims.illustrationIconSize,
      color: cs.primary,
    );
  }
}
