import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // initially, light mode
  ThemeMode _themeMode = ThemeMode.system;

  // get theme
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
  }
}
