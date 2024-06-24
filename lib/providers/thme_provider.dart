import 'package:flutter/material.dart';

class ThemeProvier extends ChangeNotifier {
  // create getter setter
  // for change state

//  receribe two params  one ( is dark mode type bool) two
//  recerive theme
  ThemeData currentTheme;

  // create contructor
  ThemeProvier({required bool isDarkMode})
      : currentTheme = isDarkMode
            ? ThemeData.dark(
                //  useMaterial3: true,

                // primaryColorDark: mycolor,
                // primarySwatch: mycolor,
                // scaffoldBackgroundColor: mycolor,
                // dialogBackgroundColor: Color(0xFF0F1123)

                )
            : ThemeData.light(
                // useMaterial3: true
                );

  // : currentTheme = isDarkMode ? ThemeData( primarySwatch : mycolor) : ThemeData.light();

  // funtion set state theme

  setLightMode() {
    currentTheme = ThemeData.light();
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = ThemeData.dark();
    notifyListeners();
  }

  //  para el cambio en  otros widgets,
  //// colo colores en algunos container
  bool isDark = false;
  
  bool get isDarkTheme {
    return isDark;
  }

  set isDarkTheme(bool value) {
    isDark = value;
    notifyListeners();
  }
}
