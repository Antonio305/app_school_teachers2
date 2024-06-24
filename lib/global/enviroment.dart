import 'dart:io';

class Enviroment {
  /// solo va a tener metodo estaticos

  /// para io y android responde de diferente mane en la cual de crar una  condicion par acada plataforma
  ///

  static String baseUrl = "192.168.1.68:3002 ";
  // static String baseUrl = "localhost:3002 ";

  static String apiUrl = Platform.isAndroid ? baseUrl : '192.168.1.68:3002 ';

  // static String checkUrlSocket =
  //     Platform.isAndroid ? baseUrl : 'http://192.168.1.68:3002 ';

  // static String apiUrl = Platform.isAndroid
  //     ? 'http://192.168.1.68:3002 '
  //     : 'http://192.168.1.68:3002 ';

  static String checkUrlSocket = Platform.isAndroid
      ? 'http://192.168.1.68:3002 '
      : 'http://192.168.1.68:3002 ';

  // Uri url = Uri.https('prepabochil3.fly.dev');
  static final url = Uri.https('prepabochil3.fly.dev');

  // static final urlSocket = url.toString();
}
