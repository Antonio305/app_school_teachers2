import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:preppa_profesores/widgets/utils/theme.dart';

class StyleTextPublication {
  static TextStyle styleAuthor(BuildContext context, double fontSize) {
    return ThemeSelected.isDarkTheme(context)
        ? TextStyle(
            fontSize: fontSize,
            color: Colors.white54,
          )
        : TextStyle(
            fontSize: fontSize,
            color: Colors.black87,
          );
  }

  static TextStyle styleRolAuthor(BuildContext context) {
    return ThemeSelected.isDarkTheme(context)
        ? const TextStyle(
            fontSize: 15, color: Colors.white70, fontWeight: FontWeight.bold)
        : const TextStyle(
            fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold);
  }

  static TextStyle styleTile(BuildContext context, double fontSize) {
    return ThemeSelected.isDarkTheme(context)
        ? TextStyle(fontSize: fontSize, color: Colors.white60)
        : TextStyle(fontSize: fontSize, color: Colors.black87);
  }

  static TextStyle styleDescription(BuildContext context) {
    return ThemeSelected.isDarkTheme(context)
        ? const TextStyle(fontSize: 14, color: Colors.white38)
        : const TextStyle(fontSize: 14, color: Colors.black87);
  }
}
