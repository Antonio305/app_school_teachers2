import 'package:http/http.dart' as http;

class ConectionHost {
// casita

  static String baseUrl = '192.168.1.66:3000';

// https://prepabochil.fly.dev/api/story
//  static String baseUrl = "localhost:8080";

  // fucion que eveulde u valor de tipo Uri  para los estados http  y https

  static Uri myUrl(String path, Map<String, dynamic>? query) {
    final url = Uri.http(baseUrl, path);
    // final url = 'https://prepabochil.fly.dev' + ${path};
    // final url  = Uri.https('prepabochil.fly.dev', path);
    return url;
  }

  // static String baseUrl =
  //     'https://backendprepa-production.up.railway.app/api/generation';
}
