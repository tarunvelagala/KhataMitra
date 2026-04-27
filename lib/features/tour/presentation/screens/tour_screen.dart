import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/illustration_frame.dart';
import '../../../../core/widgets/screen_footer.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/dot_indicator.dart';
import '../widgets/ledger_phone_illustration.dart';
import '../widgets/offline_safety_illustration.dart';
import '../widgets/reminder_card_illustration.dart';
import '../widgets/tour_slide.dart';

// ── File-private layout constants ─────────────────────────────────────────────
abstract final class _Dims {
  static const double headerTopPadding = 24.0;
}

class TourScreen extends ConsumerStatefulWidget {
  const TourScreen({super.key});

  @override
  ConsumerState<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends ConsumerState<TourScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  static const int _pageCount = 3;
  static const Duration _pageDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tour_seen', true);
    if (!mounted) return;
    context.go('/home');
  }

  void _onCta() {
    if (_currentPage < _pageCount - 1) {
      if (MediaQuery.disableAnimationsOf(context)) {
        _pageController.jumpToPage(_currentPage + 1);
      } else {
        _pageController.nextPage(
          duration: _pageDuration,
          curve: Curves.easeInOut,
        );
      }
    } else {
      _complete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isLast = _currentPage == _pageCount - 1;    final slides = [
      TourSlide(
        illustration: const IllustrationFrame(child: LedgerPhoneIllustration()),
        headline: l10n.tourHeadline1,
        body: l10n.tourBody1,
        showSwipeHint: true,
      ),
      TourSlide(
        illustration: const IllustrationFrame(child: ReminderCardIllustration()),
        headline: l10n.tourHeadline2,
        body: l10n.tourBody2,
        showSwipeHint: true,
      ),
      TourSlide(
        illustration: const IllustrationFrame(child: OfflineSafetyIllustration()),
        headline: l10n.tourHeadline3,
        body: l10n.tourBody3,
      ),
    ];

    return Scaffold(
      backgroundColor: cs.surface,      
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: _Dims.headerTopPadding),
              child: DotIndicator(currentPage: _currentPage, count: _pageCount),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: Platform.isIOS
                    ? const BouncingScrollPhysics()
                    : const ClampingScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: slides,
              ),
            ),
            ScreenFooter(
              ctaLabel: isLast ? l10n.tourGetStarted : l10n.tourNext,
              onCta: _onCta,
              secondaryLabel: l10n.tourSkip,
              onSecondary: _complete,
            ),
          ],
        ),
      ),
    );
  }
}

