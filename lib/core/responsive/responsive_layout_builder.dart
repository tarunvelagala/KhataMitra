import 'package:flutter/widgets.dart';
import 'package:khata_mitra/core/responsive/app_breakpoints.dart';

/// A widget that builds different subtrees for mobile and tablet form factors.
///
/// Prefer value-switching via `context.rDims` / `context.rText` for the vast
/// majority of layout variations — they require no structural widget changes.
/// Use [ResponsiveLayoutBuilder] only when the widget *tree structure itself*
/// differs between form factors (e.g. stacked list vs. two-panel split view).
///
/// Example:
/// ```dart
/// ResponsiveLayoutBuilder(
///   mobile: (context) => const LedgerListView(),
///   tablet: (context) => const LedgerSplitView(),
/// )
/// ```
///
/// Both builders receive a [BuildContext] so they can call `context.rDims`
/// or `context.rText` internally if needed.
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// Builder for the [FormFactor.mobile] subtree.
  final WidgetBuilder mobile;

  /// Builder for the [FormFactor.tablet] subtree.
  final WidgetBuilder tablet;

  const ResponsiveLayoutBuilder({
    required this.mobile,
    required this.tablet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final formFactor = AppBreakpoints.formFactorOf(constraints.maxWidth);
        return switch (formFactor) {
          FormFactor.mobile => mobile(context),
          FormFactor.tablet => tablet(context),
        };
      },
    );
  }
}
