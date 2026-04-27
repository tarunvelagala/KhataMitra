import 'package:flutter/material.dart';

/// Fixed-size container that gives every tour illustration the same footprint.
/// Wrap any illustration widget with this so slide layouts stay consistent
/// regardless of how much content each illustration has.
class IllustrationFrame extends StatelessWidget {
  const IllustrationFrame({super.key, required this.child});

  final Widget child;

  static const double width  = 240.0;
  static const double height = 240.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(child: child),
    );
  }
}
