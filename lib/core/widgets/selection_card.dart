import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';

const Duration _kAnimDuration = Duration(milliseconds: 150);
const double _kBadgeSize   = 40.0;
const double _kBadgeRadius = 10.0;
const double _kCheckSize   = 18.0;
const double _kPaddingV    = 12.0;
const double _kPaddingH    = 12.0;
const double _kBadgeGap    = 12.0;

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.badge,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final String? badge;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs           = Theme.of(context).colorScheme;
    final tt           = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final decoration = BoxDecoration(
      color: isSelected ? cs.surfaceContainerLowest : cs.surfaceContainerLow,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      border: Border.all(
        color: isSelected ? cs.primary : cs.outlineVariant,
        width: isSelected
            ? AppDimensions.borderFocused
            : AppDimensions.borderDefault,
      ),
    );

    final content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _kPaddingH,
        vertical: _kPaddingV,
      ),
      child: Row(
        children: [
          Container(
            width: _kBadgeSize,
            height: _kBadgeSize,
            decoration: BoxDecoration(
              color: isSelected ? cs.primaryContainer : cs.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(_kBadgeRadius),
            ),
            child: Center(
              child: Text(
                badge ?? title.characters.first,
                style: tt.titleSmall?.copyWith(
                  color: isSelected
                      ? cs.onPrimaryContainer
                      : cs.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: _kBadgeGap),
          Expanded(
            child: Text(
              title,
              style: tt.titleMedium?.copyWith(
                color: isSelected ? cs.onSurface : cs.onSurfaceVariant,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check_circle_rounded,
              color: cs.primary,
              size: _kCheckSize,
            ),
        ],
      ),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      child: reduceMotion
          ? DecoratedBox(decoration: decoration, child: content)
          : AnimatedContainer(
              duration: _kAnimDuration,
              decoration: decoration,
              child: content,
            ),
    );
  }
}
