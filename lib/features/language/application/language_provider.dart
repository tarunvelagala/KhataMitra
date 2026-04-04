import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_provider.g.dart';

@Riverpod(keepAlive: true)
class LanguageNotifier extends _$LanguageNotifier {
  static const _langKey = 'selected_language';

  @override
  Locale build() {
    _loadFromPrefs();
    return const Locale('en');
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final langMode = prefs.getString(_langKey);
    if (langMode != null) {
      state = Locale(langMode);
    }
  }

  Future<void> setLanguage(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, locale.languageCode);
  }
}
