import 'package:flutter/material.dart';

abstract final class _Dims {
  static const double horizontalPadding  = 32.0;
  static const double topPadding         = 48.0;
  static const double maxBodyWidth       = 280.0;
  static const double illustrationGap    = 32.0;
  static const double headlineToBodyGap  = 8.0;
  static const double bodyToSwipeHintGap = 24.0;
  static const double swipeHintIconGap   = 4.0;
  static const double swipeHintIconSize  = 14.0;
  static const double swipeHintOpacity   = 0.6;
}

class TourSlide extends StatelessWidget {
  const TourSlide({
    super.key,
    required this.illustration,
    required this.headline,
    required this.body,
    this.showSwipeHint = false,
  });

  final Widget illustration;
  final String headline;
  final String body;
  final bool showSwipeHint;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: _Dims.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: _Dims.topPadding),
          illustration,
          const SizedBox(height: _Dims.illustrationGap),
          Text(headline, style: tt.headlineMedium, textAlign: TextAlign.center),
          const SizedBox(height: _Dims.headlineToBodyGap),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _Dims.maxBodyWidth),
            child: Text(
              body,
              style: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ),
          if (showSwipeHint) ...[
            const SizedBox(height: _Dims.bodyToSwipeHintGap),
            _SwipeHint(color: cs.onSurfaceVariant),
          ],
        ],
      ),
    );
  }
}

class _SwipeHint extends StatelessWidget {
  const _SwipeHint({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _Dims.swipeHintOpacity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SWIPE TO EXPLORE',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
          ),
          const SizedBox(width: _Dims.swipeHintIconGap),
          Icon(Icons.chevron_right_rounded, size: _Dims.swipeHintIconSize, color: color),
        ],
      ),
    );
  }
}
