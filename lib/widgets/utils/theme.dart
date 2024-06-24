import 'package:flutter/material.dart';

class ThemeSelected {
  static bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
