import 'package:flutter/material.dart';

abstract final class _Dims {
  static const double shieldIconSize   = 80.0;
  static const double shieldToPillGap  = 12.0;

  static const double pillPaddingH     = 12.0;
  static const double pillPaddingV     = 4.0;

  static const double cardToRowGap     = 20.0;

  static const double propertyIconSize = 20.0;
  static const double propertyIconGap  = 4.0;
}

class OfflineSafetyIllustration extends StatelessWidget {
  const OfflineSafetyIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.verified_user_rounded,
          size: _Dims.shieldIconSize,
          color: cs.primary,
        ),
        const SizedBox(height: _Dims.shieldToPillGap),
        _OfflineSafePill(cs: cs),
        const SizedBox(height: _Dims.cardToRowGap),
        _PropertyRow(cs: cs),
      ],
    );
  }
}

class _OfflineSafePill extends StatelessWidget {
  const _OfflineSafePill({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _Dims.pillPaddingH,
        vertical: _Dims.pillPaddingV,
      ),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'OFFLINE SAFE',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: cs.onSecondaryContainer,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class _PropertyRow extends StatelessWidget {
  const _PropertyRow({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _PropertyItem(cs: cs, icon: Icons.lock_outline_rounded,    label: 'Private'),
        _PropertyItem(cs: cs, icon: Icons.wifi_off_rounded,        label: 'Offline'),
        _PropertyItem(cs: cs, icon: Icons.verified_user_outlined,  label: 'Secure'),
      ],
    );
  }
}

class _PropertyItem extends StatelessWidget {
  const _PropertyItem({
    required this.cs,
    required this.icon,
    required this.label,
  });

  final ColorScheme cs;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: _Dims.propertyIconSize, color: cs.onSurfaceVariant),
        const SizedBox(height: _Dims.propertyIconGap),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: cs.onSurfaceVariant,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
