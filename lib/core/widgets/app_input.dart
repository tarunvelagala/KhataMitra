import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';

/// Opinionated [TextFormField] wrapper.
///
/// Reads [ResponsiveDimensions] for padding and enforces focused/default
/// border widths from the dimension tokens.
class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.readOnly = false,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.validator,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? errorText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final int maxLines;
  final bool obscureText;
  final bool readOnly;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final d = context.rDims;
    final t = context.rText;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      maxLines: maxLines,
      obscureText: obscureText,
      readOnly: readOnly,
      autofocus: autofocus,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counterStyle: t.labelSmall,
        contentPadding: EdgeInsets.symmetric(
          vertical: d.inputPaddingV,
          horizontal: d.inputPaddingH,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(d.radiusSmall),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: d.borderFocused,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(d.radiusSmall),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: d.borderDefault,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(d.radiusSmall),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: d.borderDefault,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(d.radiusSmall),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: d.borderFocused,
          ),
        ),
      ),
    );
  }
}
