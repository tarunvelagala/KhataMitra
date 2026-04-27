import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

class ScreenFooter extends StatelessWidget {
  const ScreenFooter({
    super.key,
    required this.ctaLabel,
    required this.onCta,
    this.secondaryLabel,
    this.onSecondary,
  });

  final String ctaLabel;
  final VoidCallback onCta;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  static const double _topRadius    = 24.0;
  static const double _ctaHeight    = 48.0;

  @override
  Widget build(BuildContext context) {
    final cs          = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(_topRadius),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonPaddingV,
        AppDimensions.buttonPaddingH,
        AppDimensions.buttonPaddingV + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: _ctaHeight,
            child: FilledButton(onPressed: onCta, child: Text(ctaLabel)),
          ),
          if (secondaryLabel != null && onSecondary != null) ...[
            const SizedBox(height: AppDimensions.buttonStackGap),
            TextButton(
              onPressed: onSecondary,
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
              child: Text(secondaryLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
