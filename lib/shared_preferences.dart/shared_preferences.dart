import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // cresmo una instancia de la clase de tipo static
  static final Preferences _instance = Preferences._internal();
  // contructor para inicializar el SharedPreferences

  factory Preferences() {
    return _instance;
  }

  // contructor privado

  Preferences._internal();

  // initiale date late
  late SharedPreferences _prefs;

  initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // pfunciop para el metodo del tema
// getter
// setter
  bool get getIsDarkMode {
    return _prefs.getBool('DarkMode') ?? false;
  }

  set setIsDarkMode(bool value) {
    _prefs.setBool('DarkMode', value);
    
  }
}
