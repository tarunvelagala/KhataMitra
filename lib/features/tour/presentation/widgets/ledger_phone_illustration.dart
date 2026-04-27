import 'package:flutter/material.dart';

abstract final class _Dims {
  static const double width         = 240.0;
  static const double rowGap        = 12.0;

  static const double avatarSize    = 36.0;
  static const double avatarGap     = 12.0;
  static const double nameBarHeight = 10.0;
  static const double nameBarRadius = 5.0;
  static const double amountGap     = 8.0;
}

class LedgerPhoneIllustration extends StatelessWidget {
  const LedgerPhoneIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      width: _Dims.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LedgerRow(amountLabel: '+₹1,250', amountColor: cs.secondary),
          const SizedBox(height: _Dims.rowGap),
          _LedgerRow(amountLabel: '−₹400', amountColor: cs.tertiary),
          const SizedBox(height: _Dims.rowGap),
          _LedgerRow(amountLabel: '+₹800', amountColor: cs.secondary),
        ],
      ),
    );
  }
}

class _LedgerRow extends StatelessWidget {
  const _LedgerRow({required this.amountLabel, required this.amountColor});

  final String amountLabel;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: _Dims.avatarSize,
          height: _Dims.avatarSize,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: _Dims.avatarGap),
        Expanded(
          child: Container(
            height: _Dims.nameBarHeight,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(_Dims.nameBarRadius),
            ),
          ),
        ),
        const SizedBox(width: _Dims.amountGap),
        Text(
          amountLabel,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: amountColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
