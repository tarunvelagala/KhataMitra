import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_mitra/core/constants/app_dimensions.dart';
import 'package:khata_mitra/core/responsive/app_breakpoints.dart';
import 'package:khata_mitra/core/responsive/responsive_dimensions.dart';
import 'package:khata_mitra/core/responsive/responsive_extension.dart';
import 'package:khata_mitra/core/responsive/responsive_layout_builder.dart';
import 'package:khata_mitra/core/responsive/responsive_text_styles.dart';
import 'package:khata_mitra/core/theme/app_text_styles.dart';

void main() {
  // ── AppBreakpoints ────────────────────────────────────────────────

  group('AppBreakpoints.formFactorOf', () {
    test('returns mobile for widths below tabletMinWidth', () {
      expect(AppBreakpoints.formFactorOf(0), FormFactor.mobile);
      expect(AppBreakpoints.formFactorOf(375), FormFactor.mobile);
      expect(AppBreakpoints.formFactorOf(599.9), FormFactor.mobile);
    });

    test('returns tablet at exactly tabletMinWidth', () {
      expect(AppBreakpoints.formFactorOf(600), FormFactor.tablet);
    });

    test('returns tablet for widths up to tabletMaxWidth', () {
      expect(AppBreakpoints.formFactorOf(768), FormFactor.tablet);
      expect(AppBreakpoints.formFactorOf(1024), FormFactor.tablet);
      expect(AppBreakpoints.formFactorOf(1199.9), FormFactor.tablet);
    });
  });

  group('AppBreakpoints.scaleFactorOf', () {
    test('returns 1.0 for mobile widths', () {
      expect(AppBreakpoints.scaleFactorOf(375), 1.0);
    });

    test('returns 1.15 for tablet widths', () {
      expect(AppBreakpoints.scaleFactorOf(768), 1.15);
    });
  });

  // ── ResponsiveDimensions ──────────────────────────────────────────

  group('ResponsiveDimensions.forMobile', () {
    const dims = ResponsiveDimensions.forMobile();

    test('matches AppDimensions constants exactly', () {
      expect(dims.radiusSmall, AppDimensions.radiusSmall);
      expect(dims.radiusMedium, AppDimensions.radiusMedium);
      expect(dims.radiusPill, AppDimensions.radiusPill);
      expect(dims.elevationFlat, AppDimensions.elevationFlat);
      expect(dims.buttonPaddingV, AppDimensions.buttonPaddingV);
      expect(dims.buttonPaddingH, AppDimensions.buttonPaddingH);
      expect(dims.inputPaddingV, AppDimensions.inputPaddingV);
      expect(dims.inputPaddingH, AppDimensions.inputPaddingH);
      expect(dims.borderFocused, AppDimensions.borderFocused);
      expect(dims.borderDefault, AppDimensions.borderDefault);
      expect(dims.dividerThickness, AppDimensions.dividerThickness);
      expect(dims.dividerSpace, AppDimensions.dividerSpace);
      expect(dims.appBarOpacity, AppDimensions.appBarOpacity);
    });

    test('has expected mobile layout tokens', () {
      expect(dims.screenHorizontalPadding, 16.0);
      expect(dims.contentMaxWidth, double.infinity);
      expect(dims.gridColumnCount, 1);
    });
  });

  group('ResponsiveDimensions.forTablet', () {
    final dims = ResponsiveDimensions.forTablet();
    const scale = 1.15;

    test('scales spatial tokens by 1.15', () {
      expect(dims.radiusSmall, closeTo(AppDimensions.radiusSmall * scale, 0.001));
      expect(dims.buttonPaddingV, closeTo(AppDimensions.buttonPaddingV * scale, 0.001));
      expect(dims.inputPaddingH, closeTo(AppDimensions.inputPaddingH * scale, 0.001));
    });

    test('does not scale optical constants', () {
      expect(dims.radiusPill, AppDimensions.radiusPill);
      expect(dims.elevationFlat, AppDimensions.elevationFlat);
      expect(dims.borderFocused, AppDimensions.borderFocused);
      expect(dims.borderDefault, AppDimensions.borderDefault);
      expect(dims.appBarOpacity, AppDimensions.appBarOpacity);
    });

    test('has expected tablet layout tokens', () {
      expect(dims.screenHorizontalPadding, 24.0);
      expect(dims.contentMaxWidth, 720.0);
      expect(dims.gridColumnCount, 2);
    });
  });

  // ── ResponsiveTextStyles ──────────────────────────────────────────

  group('ResponsiveTextStyles.forMobile', () {
    const styles = ResponsiveTextStyles.forMobile();

    test('font sizes match AppTextStyles exactly', () {
      expect(styles.displayLarge.fontSize, AppTextStyles.displayLarge.fontSize);
      expect(styles.headlineMedium.fontSize, AppTextStyles.headlineMedium.fontSize);
      expect(styles.bodyLarge.fontSize, AppTextStyles.bodyLarge.fontSize);
      expect(styles.labelSmall.fontSize, AppTextStyles.labelSmall.fontSize);
    });
  });

  group('ResponsiveTextStyles.forTablet', () {
    final styles = ResponsiveTextStyles.forTablet();
    const scale = 1.15;

    test('scales all font sizes by 1.15', () {
      expect(
        styles.displayLarge.fontSize,
        closeTo(AppTextStyles.displayLarge.fontSize! * scale, 0.001),
      );
      expect(
        styles.bodyMedium.fontSize,
        closeTo(AppTextStyles.bodyMedium.fontSize! * scale, 0.001),
      );
    });

    test('preserves font weights', () {
      expect(styles.headlineLarge.fontWeight, AppTextStyles.headlineLarge.fontWeight);
      expect(styles.labelSmall.fontWeight, AppTextStyles.labelSmall.fontWeight);
    });

    test('preserves letter spacing', () {
      expect(styles.displayLarge.letterSpacing, AppTextStyles.displayLarge.letterSpacing);
      expect(styles.labelSmall.letterSpacing, AppTextStyles.labelSmall.letterSpacing);
    });
  });

  // ── ResponsiveContext extension ───────────────────────────────────

  Widget buildTestApp({required double width, required WidgetBuilder child}) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: Size(width, 800)),
        child: SizedBox(
          width: width,
          height: 800,
          child: Builder(builder: child),
        ),
      ),
    );
  }

  testWidgets('context.formFactor is mobile at 375dp', (tester) async {
    late FormFactor captured;
    await tester.pumpWidget(
      buildTestApp(
        width: 375,
        child: (ctx) {
          captured = ctx.formFactor;
          return const SizedBox.shrink();
        },
      ),
    );
    expect(captured, FormFactor.mobile);
  });

  testWidgets('context.formFactor is tablet at 768dp', (tester) async {
    late FormFactor captured;
    await tester.pumpWidget(
      buildTestApp(
        width: 768,
        child: (ctx) {
          captured = ctx.formFactor;
          return const SizedBox.shrink();
        },
      ),
    );
    expect(captured, FormFactor.tablet);
  });

  testWidgets('context.isMobile and isTablet are mutually exclusive', (tester) async {
    late bool mobile, tablet;
    await tester.pumpWidget(
      buildTestApp(
        width: 600,
        child: (ctx) {
          mobile = ctx.isMobile;
          tablet = ctx.isTablet;
          return const SizedBox.shrink();
        },
      ),
    );
    expect(mobile, isFalse);
    expect(tablet, isTrue);
  });

  testWidgets('context.rDims returns forMobile on mobile', (tester) async {
    late double padding;
    await tester.pumpWidget(
      buildTestApp(
        width: 375,
        child: (ctx) {
          padding = ctx.rDims.screenHorizontalPadding;
          return const SizedBox.shrink();
        },
      ),
    );
    expect(padding, 16.0);
  });

  testWidgets('context.rDims returns forTablet on tablet', (tester) async {
    late double padding;
    await tester.pumpWidget(
      buildTestApp(
        width: 768,
        child: (ctx) {
          padding = ctx.rDims.screenHorizontalPadding;
          return const SizedBox.shrink();
        },
      ),
    );
    expect(padding, 24.0);
  });

  testWidgets('context.rText font size scales on tablet', (tester) async {
    late double mobileSize, tabletSize;

    await tester.pumpWidget(
      buildTestApp(
        width: 375,
        child: (ctx) {
          mobileSize = ctx.rText.bodyLarge.fontSize!;
          return const SizedBox.shrink();
        },
      ),
    );

    await tester.pumpWidget(
      buildTestApp(
        width: 768,
        child: (ctx) {
          tabletSize = ctx.rText.bodyLarge.fontSize!;
          return const SizedBox.shrink();
        },
      ),
    );

    expect(mobileSize, AppTextStyles.bodyLarge.fontSize);
    expect(tabletSize, closeTo(AppTextStyles.bodyLarge.fontSize! * 1.15, 0.001));
  });

  // ── ResponsiveLayoutBuilder ───────────────────────────────────────

  testWidgets('ResponsiveLayoutBuilder renders mobile builder at 375dp', (tester) async {
    tester.view.physicalSize = const Size(375, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: ResponsiveLayoutBuilder(
          mobile: _mobileBuilder,
          tablet: _tabletBuilder,
        ),
      ),
    );
    expect(find.text('mobile-view'), findsOneWidget);
    expect(find.text('tablet-view'), findsNothing);
  });

  testWidgets('ResponsiveLayoutBuilder renders tablet builder at 768dp', (tester) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: ResponsiveLayoutBuilder(
          mobile: _mobileBuilder,
          tablet: _tabletBuilder,
        ),
      ),
    );
    expect(find.text('tablet-view'), findsOneWidget);
    expect(find.text('mobile-view'), findsNothing);
  });
}

// Top-level builders used as const references in ResponsiveLayoutBuilder tests.
Widget _mobileBuilder(BuildContext context) => const Text('mobile-view');
Widget _tabletBuilder(BuildContext context) => const Text('tablet-view');
