import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';

/// Generic bottom sheet shell.
///
/// The permission rationale sheet (P4-C4) and all modal forms compose this
/// widget. Supports both dismissible and non-dismissible modes.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.isDismissible = true,
    this.showDragHandle = true,
    this.padding,
  });

  final Widget child;

  /// Bold title in the sheet header.
  final String? title;

  /// `false` sets `barrierDismissible: false` and `enableDrag: false`.
  final bool isDismissible;
  final bool showDragHandle;
  final EdgeInsetsGeometry? padding;

  /// Shows the bottom sheet and returns the result.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      useSafeArea: true,
      builder: (_) => AppBottomSheet(
        title: title,
        isDismissible: isDismissible,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = context.rDims;
    final t = context.rText;
    final colorScheme = Theme.of(context).colorScheme;
    final effectivePadding =
        padding ??
        EdgeInsets.fromLTRB(
          d.screenHorizontalPadding,
          8,
          d.screenHorizontalPadding,
          24,
        );

    return SafeArea(
      bottom: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showDragHandle)
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          if (title != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: d.screenHorizontalPadding,
                vertical: 8,
              ),
              child: Text(title!, style: t.titleMedium),
            ),
            Divider(height: d.dividerSpace, thickness: d.dividerThickness),
          ],
          Padding(padding: effectivePadding, child: child),
        ],
      ),
    );
  }
}
