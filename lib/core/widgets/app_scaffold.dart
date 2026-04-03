import 'package:flutter/material.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';

/// The single [Scaffold] wrapper used by every screen.
///
/// Enforces the horizontal page gutter and the [contentMaxWidth] cap
/// automatically — no screen needs to implement these manually.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.bottom,
  });

  /// Placed in the [AppBar]; accepts a [Text] or custom widget.
  final Widget? title;

  /// [AppBar] trailing actions.
  final List<Widget>? actions;

  /// Content; wrapped in centering + max-width constraint + horizontal gutter.
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;

  /// [AppBar] bottom slot (e.g. [TabBar], search bar).
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    final d = context.rDims;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      appBar: AppBar(
        title: title,
        actions: actions,
        elevation: d.elevationFlat,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface.withValues(alpha: d.appBarOpacity),
        bottom: bottom,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.contentMaxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: d.screenHorizontalPadding,
            ),
            child: body,
          ),
        ),
      ),
    );
  }
}
