import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';
import 'package:khata_mitra/core/theme/app_theme.dart';

/// Tonal surface card matching the Material 3 card theme.
///
/// Use instead of raw [Card] to get responsive radius and padding
/// automatically.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.color,
    this.borderRadius,
  });

  final Widget child;

  /// Wraps in [InkWell] when provided.
  final VoidCallback? onTap;

  /// Defaults to [ResponsiveDimensions.cardHorizontalPadding] on all sides.
  final EdgeInsetsGeometry? padding;

  /// Defaults to [AppSurfaceColors.lowest].
  final Color? color;

  /// Defaults to [ResponsiveDimensions.radiusMedium].
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final d = context.rDims;
    final radius = borderRadius ?? d.radiusMedium;
    final effectiveColor =
        color ?? Theme.of(context).extension<AppSurfaceColors>()!.lowest;
    final effectivePadding = padding ?? EdgeInsets.all(d.cardHorizontalPadding);

    return Material(
      color: effectiveColor,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Padding(padding: effectivePadding, child: child),
      ),
    );
  }
}
