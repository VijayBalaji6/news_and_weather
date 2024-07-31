import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends Notifier<bool> {
  ThemeNotifier();
  bool darkTheme = false;
  @override
  bool build() {
    return false;
  }

  void onChangeTheme({required bool darkThemeState}) {
    state = darkThemeState;
  }
}

final themeProvider =
    NotifierProvider<ThemeNotifier, bool>(() => ThemeNotifier());
