import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';

/// Sticky-capable section label used between grouped list items.
///
/// Examples: "Today", "Earlier", settings group labels.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({super.key, required this.label, this.trailing});

  final String label;

  /// Optional right-side action (e.g. "See all" [TextButton]).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final d = context.rDims;
    final t = context.rText;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surface,
      padding: EdgeInsets.fromLTRB(
        d.screenHorizontalPadding,
        8,
        d.screenHorizontalPadding,
        4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label.toUpperCase(),
              style: t.labelMedium.copyWith(color: colorScheme.primary),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
