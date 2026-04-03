import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';

/// Button variant selector.
enum AppButtonVariant { filled, outlined, text }

/// Responsive button with enforced 48 dp minimum touch target.
///
/// Wraps [FilledButton], [OutlinedButton], or [TextButton] in a unified API.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.fullWidth = false,
  });

  final String label;

  /// `null` disables the button.
  final VoidCallback? onPressed;

  final AppButtonVariant variant;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  /// Replaces label with a [CircularProgressIndicator] and disables taps.
  final bool isLoading;

  /// Expands to fill parent width when `true`.
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final d = context.rDims;
    final buttonStyle = ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          vertical: d.buttonPaddingV,
          horizontal: d.buttonPaddingH,
        ),
      ),
      minimumSize: WidgetStateProperty.all(const Size(0, 48)),
    );

    final effectiveOnPressed = isLoading ? null : onPressed;
    final child = _buildChild();

    Widget button;
    switch (variant) {
      case AppButtonVariant.filled:
        button = FilledButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: child,
        );
      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: child,
        );
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: child,
        );
    }

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  Widget _buildChild() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    if (leadingIcon != null || trailingIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[leadingIcon!, const SizedBox(width: 8)],
          Text(label),
          if (trailingIcon != null) ...[
            const SizedBox(width: 8),
            trailingIcon!,
          ],
        ],
      );
    }
    return Text(label);
  }
}
