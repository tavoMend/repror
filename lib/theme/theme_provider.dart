import 'package:flutter/material.dart';
import 'package:repro/theme/dark_mode.dart';
import 'package:repro/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
//light mode
  ThemeData _themeData = lightMode;

  // get theme

  ThemeData get themeData => _themeData;

  //dark mode

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;

    //actualizar
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
