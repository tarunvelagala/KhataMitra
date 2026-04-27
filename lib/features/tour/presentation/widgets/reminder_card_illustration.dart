import 'package:flutter/material.dart';

abstract final class _Dims {
  static const double cardWidth = 240.0;

  static const double sendButtonSize = 64.0;
  static const double sendIconSize = 28.0;

  static const double pillRadius = 16.0;
  static const double pillPaddingH = 14.0;
  static const double pillPaddingV = 10.0;
  static const double pillIconSize = 16.0;
  static const double pillIconGap = 8.0;

  static const double avatarSize = 32.0;
  static const double avatarStride = 20.0;
  static const double avatarBorderWidth = 2.0;
  static const double avatarStackWidth = 112.0;
  static const double avatarStackHeight = 32.0;
  static const double avatarBadgeFontSize = 9.0;

  static const double avatarToSendGap = 16.0;
  static const double sendToReminderGap = 16.0;
  static const double reminderToCardGap = 8.0;
}

class ReminderCardIllustration extends StatelessWidget {
  const ReminderCardIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      width: _Dims.cardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AvatarStack(cs: cs),
          const SizedBox(height: _Dims.avatarToSendGap),
          _SendButton(cs: cs),
          const SizedBox(height: _Dims.sendToReminderGap),
          _ReminderPill(cs: cs),
          const SizedBox(height: _Dims.reminderToCardGap),
          _VisitingCardPill(cs: cs),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _Dims.sendButtonSize,
      height: _Dims.sendButtonSize,
      decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
      child: Icon(
        Icons.send_rounded,
        color: cs.onPrimary,
        size: _Dims.sendIconSize,
      ),
    );
  }
}

class _ReminderPill extends StatelessWidget {
  const _ReminderPill({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: _Dims.pillPaddingH,
        vertical: _Dims.pillPaddingV,
      ),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(_Dims.pillRadius),
      ),
      child: Row(
        children: [
          Icon(Icons.chat_rounded, size: _Dims.pillIconSize, color: cs.primary),
          const SizedBox(width: _Dims.pillIconGap),
          Expanded(
            child: Text(
              'Reminder sent',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: cs.onPrimaryContainer),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _VisitingCardPill extends StatelessWidget {
  const _VisitingCardPill({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: _Dims.pillPaddingH,
        vertical: _Dims.pillPaddingV,
      ),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(_Dims.pillRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.badge_outlined,
            size: _Dims.pillIconSize,
            color: cs.primary,
          ),
          const SizedBox(width: _Dims.pillIconGap),
          Text(
            'Card attached',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: cs.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({required this.cs});

  final ColorScheme cs;

  static const _avatarColors = [
    Color(0xFF5C85D6),
    Color(0xFF6BAB72),
    Color(0xFFD47A4A),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _Dims.avatarStackHeight,
      width: _Dims.avatarStackWidth,
      child: Stack(
        children: [
          for (int i = 0; i < 3; i++)
            Positioned(
              left: i * _Dims.avatarStride,
              child: Container(
                width: _Dims.avatarSize,
                height: _Dims.avatarSize,
                decoration: BoxDecoration(
                  color: _avatarColors[i],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: cs.surfaceContainerLowest,
                    width: _Dims.avatarBorderWidth,
                  ),
                ),
              ),
            ),
          Positioned(
            left: 3 * _Dims.avatarStride,
            child: Container(
              width: _Dims.avatarSize,
              height: _Dims.avatarSize,
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(
                  color: cs.surfaceContainerLowest,
                  width: _Dims.avatarBorderWidth,
                ),
              ),
              child: Center(
                child: Text(
                  '+5',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    fontSize: _Dims.avatarBadgeFontSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
