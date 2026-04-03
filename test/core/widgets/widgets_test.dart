import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khata_mitra/core/theme/app_theme.dart';
import 'package:khata_mitra/core/widgets/widgets.dart';

/// Wraps [child] in the KhataMitra theme + [MaterialApp] so all widgets
/// can resolve [Theme], [MediaQuery], and [Navigator].
Widget _wrap(Widget child, {double width = 390}) => MaterialApp(
  theme: AppTheme.light,
  home: MediaQuery(
    data: MediaQueryData(size: Size(width, 844)),
    child: Scaffold(body: child),
  ),
);

void main() {
  group('AppScaffold', () {
    testWidgets('renders body on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(AppScaffold(body: const Text('hello'), title: const Text('T'))),
      );
      expect(find.text('hello'), findsOneWidget);
      expect(find.text('T'), findsOneWidget);
    });

    testWidgets('renders body on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(AppScaffold(body: const Text('hello')), width: 768),
      );
      expect(find.text('hello'), findsOneWidget);
    });
  });

  group('AppCard', () {
    testWidgets('renders child on mobile', (tester) async {
      await tester.pumpWidget(_wrap(AppCard(child: const Text('card'))));
      expect(find.text('card'), findsOneWidget);
    });

    testWidgets('renders child on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(AppCard(child: const Text('card')), width: 768),
      );
      expect(find.text('card'), findsOneWidget);
    });

    testWidgets('fires onTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(AppCard(onTap: () => tapped = true, child: const Text('tap'))),
      );
      await tester.tap(find.text('tap'));
      expect(tapped, isTrue);
    });
  });

  group('AppButton', () {
    testWidgets('renders label on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(AppButton(label: 'Save', onPressed: () {})),
      );
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('renders label on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(AppButton(label: 'Save', onPressed: () {}), width: 768),
      );
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        _wrap(AppButton(label: 'Disabled', onPressed: null)),
      );
      final btn = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(btn.onPressed, isNull);
    });

    testWidgets('shows loading indicator', (tester) async {
      await tester.pumpWidget(
        _wrap(AppButton(label: 'Save', onPressed: () {}, isLoading: true)),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Save'), findsNothing);
    });

    testWidgets('outlined variant renders OutlinedButton', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppButton(
            label: 'Out',
            onPressed: () {},
            variant: AppButtonVariant.outlined,
          ),
        ),
      );
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });

  group('AppInput', () {
    testWidgets('renders label on mobile', (tester) async {
      await tester.pumpWidget(_wrap(AppInput(label: 'Name')));
      expect(find.text('Name'), findsOneWidget);
    });

    testWidgets('renders label on tablet', (tester) async {
      await tester.pumpWidget(_wrap(AppInput(label: 'Name'), width: 768));
      expect(find.text('Name'), findsOneWidget);
    });

    testWidgets('onChanged fires on text input', (tester) async {
      String? changed;
      await tester.pumpWidget(
        _wrap(AppInput(label: 'L', onChanged: (v) => changed = v)),
      );
      await tester.enterText(find.byType(TextFormField), 'hello');
      expect(changed, 'hello');
    });
  });

  group('AppListTile', () {
    testWidgets('renders title on mobile', (tester) async {
      await tester.pumpWidget(_wrap(AppListTile(title: const Text('Ravi'))));
      expect(find.text('Ravi'), findsOneWidget);
    });

    testWidgets('renders title on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(AppListTile(title: const Text('Ravi')), width: 768),
      );
      expect(find.text('Ravi'), findsOneWidget);
    });

    testWidgets('fires onTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(
          AppListTile(title: const Text('Ravi'), onTap: () => tapped = true),
        ),
      );
      await tester.tap(find.text('Ravi'));
      expect(tapped, isTrue);
    });

    testWidgets('shows divider when showDivider is true', (tester) async {
      await tester.pumpWidget(
        _wrap(AppListTile(title: const Text('X'), showDivider: true)),
      );
      expect(find.byType(Divider), findsOneWidget);
    });
  });

  group('AppEmptyState', () {
    testWidgets('renders title and body on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppEmptyState(title: 'No customers', body: 'Add one')),
      );
      expect(find.text('No customers'), findsOneWidget);
      expect(find.text('Add one'), findsOneWidget);
    });

    testWidgets('renders title and body on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppEmptyState(title: 'No customers', body: 'Add one'),
          width: 768,
        ),
      );
      expect(find.text('No customers'), findsOneWidget);
    });

    testWidgets('renders CTA button when provided', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(
          AppEmptyState(
            title: 'Empty',
            body: 'Body',
            ctaLabel: 'Add',
            onCta: () => tapped = true,
          ),
        ),
      );
      await tester.tap(find.text('Add'));
      expect(tapped, isTrue);
    });
  });

  group('AppSectionHeader', () {
    testWidgets('renders label uppercased on mobile', (tester) async {
      await tester.pumpWidget(_wrap(const AppSectionHeader(label: 'today')));
      expect(find.text('TODAY'), findsOneWidget);
    });

    testWidgets('renders label uppercased on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppSectionHeader(label: 'today'), width: 768),
      );
      expect(find.text('TODAY'), findsOneWidget);
    });

    testWidgets('renders trailing widget', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppSectionHeader(label: 'X', trailing: Text('See all'))),
      );
      expect(find.text('See all'), findsOneWidget);
    });
  });

  group('AppBottomSheet', () {
    testWidgets('renders child on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(AppBottomSheet(child: const Text('Sheet content'))),
      );
      expect(find.text('Sheet content'), findsOneWidget);
    });

    testWidgets('renders child on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(AppBottomSheet(child: const Text('Sheet content')), width: 768),
      );
      expect(find.text('Sheet content'), findsOneWidget);
    });

    testWidgets('renders title when provided', (tester) async {
      await tester.pumpWidget(
        _wrap(AppBottomSheet(title: 'My Title', child: const Text('Body'))),
      );
      expect(find.text('My Title'), findsOneWidget);
    });
  });

  group('AppConfirmDialog', () {
    testWidgets('renders title and body on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppConfirmDialog(
            title: 'Delete?',
            body: 'This cannot be undone.',
            confirmLabel: 'Delete',
          ),
        ),
      );
      expect(find.text('Delete?'), findsOneWidget);
      expect(find.text('This cannot be undone.'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('renders on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppConfirmDialog(
            title: 'Delete?',
            body: 'Cannot undo.',
            confirmLabel: 'Delete',
          ),
          width: 768,
        ),
      );
      expect(find.text('Delete?'), findsOneWidget);
    });
  });

  group('AppBadge', () {
    testWidgets('renders label on mobile', (tester) async {
      await tester.pumpWidget(_wrap(const AppBadge(label: '₹1,200')));
      expect(find.text('₹1,200'), findsOneWidget);
    });

    testWidgets('renders label on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppBadge(label: '₹1,200'), width: 768),
      );
      expect(find.text('₹1,200'), findsOneWidget);
    });

    testWidgets('positive variant renders without error', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppBadge(label: 'Paid', variant: AppBadgeVariant.positive)),
      );
      expect(find.text('Paid'), findsOneWidget);
    });

    testWidgets('negative variant renders without error', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppBadge(label: 'Owed', variant: AppBadgeVariant.negative)),
      );
      expect(find.text('Owed'), findsOneWidget);
    });
  });
}
