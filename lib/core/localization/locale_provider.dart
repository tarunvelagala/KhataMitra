import 'dart:ui';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleState extends _$LocaleState {
  @override
  Locale build() => const Locale('en');

  void setLocale(Locale name) => state = name;

  void toggleLocale() {
    if (state.languageCode == 'en') {
      state = const Locale('hi');
    } else if (state.languageCode == 'hi') {
      state = const Locale('te');
    } else {
      state = const Locale('en');
    }
  }
}
