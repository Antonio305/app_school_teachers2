import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'dart:convert';
import '../models/host.dart';

class ApiServices {
  final storage = SecureStorage.storage();

  Future<Map<String, String>> getHeaders() async {
    String? token = await storage.read(key: 'token');
    return {'Content-Type': 'application/json', 'x-token': token!};
  }

  Future returnResp(String path) async {
    final headers = await getHeaders();
    final url = ConectionHost.myUrl(path, {});
    final resp = await http.get(url, headers: headers);
    return resp;
  }

  Future<Response> get(String path) async {
    final headers = await getHeaders();
    final url = ConectionHost.myUrl(path, {});
    final resp = await http.get(url, headers: headers);
    return resp;
  }

  Future<Response> create(Map<String, dynamic> data, String path) async {
    final headers = await getHeaders();
    final url = ConectionHost.myUrl(path, {});
    final resp =
        await http.post(url, headers: headers, body: json.encode(data));
    return resp;
  }

  Future update(Map<String, dynamic> body, String path) async {
    final headers = await getHeaders();
    final url = ConectionHost.myUrl(path, {});

    final resp = await http.put(url, headers: headers, body: json.encode(body));
    return resp;
  }

  Future<Response> delete(String path) async {
    final headers = await getHeaders();
    final url = ConectionHost.myUrl(path, {});
    final resp = await http.delete(url, headers: headers);
    return resp;
  }
}

// class Data {
//     final api = ApiServices();

//     void init () {
//       api.returnResp();
//     }   
// }