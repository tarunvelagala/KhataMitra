import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';

/// Responsive list tile enforcing 48 dp minimum touch target.
///
/// Used for customer rows, transaction rows, and settings rows.
class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.showDivider = false,
    this.tileColor,
  });

  final Widget title;
  final Widget? subtitle;

  /// Icon, avatar, or badge. Pass [Semantics] with a label for icon-only use.
  final Widget? leading;

  /// Balance chip, chevron, switch, etc.
  final Widget? trailing;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  /// Renders a 1 dp [Divider] below the tile when `true`.
  final bool showDivider;
  final Color? tileColor;

  @override
  Widget build(BuildContext context) {
    final d = context.rDims;
    final colorScheme = Theme.of(context).colorScheme;

    final tile = InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: tileColor,
        constraints: const BoxConstraints(minHeight: 48),
        padding: EdgeInsets.symmetric(
          horizontal: d.screenHorizontalPadding,
          vertical: 12,
        ),
        child: Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 12)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  title,
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    subtitle!,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
          ],
        ),
      ),
    );

    if (showDivider) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tile,
          Divider(
            height: d.dividerSpace,
            thickness: d.dividerThickness,
            color: colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ],
      );
    }
    return tile;
  }
}
