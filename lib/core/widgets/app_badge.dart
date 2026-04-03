import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';
import 'package:khata_mitra/core/theme/app_theme.dart';

/// Badge variant for conveying balance/status semantics.
enum AppBadgeVariant { positive, negative, neutral }

/// Inline balance / status chip.
///
/// Used in customer list rows, ledger header, and transaction tiles.
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.neutral,
    this.compact = false,
  });

  final String label;
  final AppBadgeVariant variant;

  /// Smaller padding for dense list rows.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final d = context.rDims;
    final t = context.rText;
    final colorScheme = Theme.of(context).colorScheme;
    final surfaces = Theme.of(context).extension<AppSurfaceColors>()!;

    final (bgColor, fgColor) = switch (variant) {
      AppBadgeVariant.positive => (
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
      ),
      AppBadgeVariant.negative => (
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
      ),
      AppBadgeVariant.neutral => (surfaces.high, colorScheme.onSurface),
    };

    return Container(
      padding: compact
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(d.radiusPill),
      ),
      child: Text(
        label,
        style: t.labelMedium.copyWith(color: fgColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
