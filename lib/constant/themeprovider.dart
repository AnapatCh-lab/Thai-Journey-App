import 'package:flutter/material.dart';
import 'constant.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _selectedTheme = lightTheme;
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;
  bool get isDarkMode => _isDarkMode;
  String fontFamily = '';

  void toggleTheme() {
    if (_selectedTheme == lightTheme) {
      _selectedTheme = darkTheme;
      _isDarkMode = true;
      fontFamily = "ThaiFont";
    } else {
      _selectedTheme = lightTheme;
      _isDarkMode = false;
    }
    notifyListeners();
  }

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();
}
