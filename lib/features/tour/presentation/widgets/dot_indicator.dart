import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.currentPage,
    required this.count,
  });

  final int currentPage;
  final int count;

  static const double _activeDiameter = 10.0;
  static const double _inactiveDiameter = 8.0;
  static const double _gap = 8.0;
  static const Duration _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == currentPage;
        final diameter = isActive ? _activeDiameter : _inactiveDiameter;
        final color = isActive ? cs.primary : cs.outlineVariant;

        return Padding(
          padding: EdgeInsets.only(right: i < count - 1 ? _gap : 0),
          child: reduceMotion
              ? _Dot(diameter: diameter, color: color)
              : AnimatedContainer(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  width: diameter,
                  height: diameter,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
        );
      }),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.diameter, required this.color});

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: diameter,
      height: diameter,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
