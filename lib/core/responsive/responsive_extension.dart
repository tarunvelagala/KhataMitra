import 'package:flutter/widgets.dart';
import 'package:khata_mitra/core/responsive/app_breakpoints.dart';
import 'package:khata_mitra/core/responsive/responsive_dimensions.dart';
import 'package:khata_mitra/core/responsive/responsive_text_styles.dart';

/// Convenience extension that exposes the responsive system on [BuildContext].
///
/// All getters derive the current form factor from [MediaQuery.sizeOf], which
/// subscribes only to size changes — the widget will not rebuild on keyboard
/// appearance, text-scale changes, or other unrelated [MediaQuery] updates.
///
/// Typical usage:
/// ```dart
/// final d = context.rDims;
/// final t = context.rText;
///
/// Padding(
///   padding: EdgeInsets.symmetric(horizontal: d.screenHorizontalPadding),
///   child: Text('Balance', style: t.headlineMedium),
/// )
/// ```
extension ResponsiveContext on BuildContext {
  /// The [FormFactor] for the current screen width.
  FormFactor get formFactor =>
      AppBreakpoints.formFactorOf(MediaQuery.sizeOf(this).width);

  /// `true` when the current form factor is [FormFactor.mobile].
  bool get isMobile => formFactor == FormFactor.mobile;

  /// `true` when the current form factor is [FormFactor.tablet].
  bool get isTablet => formFactor == FormFactor.tablet;

  /// Dimension tokens resolved for the current form factor.
  ///
  /// Prefer this over [AppDimensions] directly whenever a value should
  /// differ between mobile and tablet.
  ResponsiveDimensions get rDims => isMobile
      ? const ResponsiveDimensions.forMobile()
      : ResponsiveDimensions.forTablet();

  /// Text style tokens resolved for the current form factor.
  ///
  /// Prefer this over [AppTextStyles] directly whenever a text size should
  /// scale between mobile and tablet. Built-in Material widgets that read
  /// from [ThemeData.textTheme] are unaffected.
  ResponsiveTextStyles get rText => isMobile
      ? const ResponsiveTextStyles.forMobile()
      : ResponsiveTextStyles.forTablet();
}
