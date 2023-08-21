import 'package:flutter/material.dart';

class ThemeProvier extends ChangeNotifier {
  // create getter setter
  // for change state

//  receribe two params  one ( is dark mode type bool) two
//  recerive theme
  ThemeData currentTheme;

   final mycolor =  const MaterialColor(0xFF0F1123, <int, Color>
   {
      50:   Color(0xFF558B2F),
      100: Color(0xFF558B2F),
      200: Color(0xFF558B2F),
      300: Color(0xFF558B2F),
      400: Color(0xFF558B2F),
      500: Color(0xFF558B2F),
      600: Color(0xFF558B2F),
      700: Color(0xFF558B2F),
      800: Color(0xFF558B2F),
      900: Color(0xFF558B2F),
     
    },
  );

  // create contructor
  ThemeProvier({required bool isDarkMode})
        : currentTheme = isDarkMode ? ThemeData.dark( 
           useMaterial3: true,
              
              // primaryColorDark: mycolor,
              // primarySwatch: mycolor,
              // scaffoldBackgroundColor: mycolor,
              // dialogBackgroundColor: Color(0xFF0F1123)
              
              ) : ThemeData.light();

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
