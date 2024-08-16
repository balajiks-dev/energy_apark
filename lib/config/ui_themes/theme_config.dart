import 'package:energy_park/config/ui_themes/dark_theme.dart';
import 'package:energy_park/config/ui_themes/light_theme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData theme({required ThemeMode themeMode}) {
    if (themeMode == ThemeMode.dark) {
      return darkTheme;
    } else if (themeMode == ThemeMode.light) {
      return lightTheme;
    } else {
      return lightTheme;
    }
  }
}
