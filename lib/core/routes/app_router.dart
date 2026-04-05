import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/language/presentation/language_selection_screen.dart';
import '../../features/theme/presentation/theme_selection_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/language',
    routes: [
      GoRoute(
        path: '/theme',
        builder: (context, state) => const ThemeSelectionScreen(),
      ),
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Login OTP Verification Phase')),
          body: Center(
            child: ElevatedButton(
              onPressed: () => context.go('/shop-details'),
              child: const Text('Next'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/shop-details',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Shop Details Onboarding Phase')),
          body: Center(
            child: ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Next'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Main Dashboard Phase'))),
      ),
    ],
  );
}
