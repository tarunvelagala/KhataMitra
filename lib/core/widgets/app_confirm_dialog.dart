import 'package:flutter/material.dart';
import 'package:khata_mitra/core/widgets/app_button.dart';

/// Standard destructive-action confirmation dialog.
///
/// Used for delete customer, delete transaction, sign out.
class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.body,
    required this.confirmLabel,
    this.cancelLabel = 'Cancel',
    this.isDestructive = true,
  });

  final String title;
  final String body;
  final String confirmLabel;
  final String cancelLabel;

  /// Confirm button uses [ColorScheme.error] when `true`.
  final bool isDestructive;

  /// Shows the dialog and returns `true` when confirmed, `false` otherwise.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String body,
    required String confirmLabel,
    String cancelLabel = 'Cancel',
    bool isDestructive = true,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AppConfirmDialog(
        title: title,
        body: body,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        AppButton(
          label: cancelLabel,
          onPressed: () => Navigator.of(context).pop(false),
          variant: AppButtonVariant.text,
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: isDestructive
                ? colorScheme.error
                : colorScheme.primary,
            minimumSize: const Size(0, 48),
          ),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
