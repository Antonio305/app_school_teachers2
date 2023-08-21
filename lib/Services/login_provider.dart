import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure-storage.dart';
import 'package:preppa_profesores/models/login_response.dart';
import 'package:preppa_profesores/models/teacher.dart';

import '../models/host.dart';
import '../models/login.dart';

class LoginServices extends ChangeNotifier {
  // aca vamos guardar el token
  // final storage =  FlutterSecureStorage();

  final storage = SecureStorageServices.secureStorageServices;

  // instance classs techer
  late LoginUser userLogin;

  bool isLoading = false;

  Teachers teachers = Teachers(
      name: '',
      lastName: '',
      secondName: '',
      gender: '',
      collegeDegree: '',
      typeContract: '',
      status: false,
      rol: '',
      numberPhone: '',
      email: '',
      tuition: '',
      uid: '');

  // final baseUrl= ConectionHost.baseUrl; // este es solo para cuando sea con el telefono
  // final baseUrl = 'localhost:8080';

  // String baseUrl = '192.168.1.68:8080';
  // String baseUrl = 'http://192.168.1.70:8080/api/userLogin';
  final String baseUrl = ConectionHost.baseUrl;

// contructor
  // LoginServices();

  // metood para el login

  Future<String?> loginUser(LoginUser login) async {
    isLoading = true;
    notifyListeners();

// local
    // final url = Uri.http(baseUrl, '/api/userLogin/teacher');
    final url = ConectionHost.myUrl('/api/userLogin/teacher', {});
// desplegado
    // final url = Uri.parse('$baseUrl/api/userLogin/teacher');
    final headers = {'Content-Type': 'application/json'};

    print(url);
    final resp = await http.post(url,
        headers: headers,
        body:
            // json.encode({"user": "quimico_beltran", "password": "1234567890"})
            //  json.encode(login.toJson())
            login.toJson());

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    final loginResponse = loginResponseFromJson(resp.body);

    teachers = loginResponse.teacher;

    // final  decodeResp =  json.decode(resp.body);

    print(decodeResp);

    // teacher = Teacher.fromMap(decodeResp);
    //  teacher = Teachers.fromJson(decodeResp['teacher']);
    notifyListeners();

    if (decodeResp.containsKey('token')) {
      // TODO: GUARDAR TOKEN EN UN LUGAR SEGURO

      await storage.write(key: 'token', value: decodeResp['token']);

      print(decodeResp['token']);
      return null; // no retornamos nada si pasa bien
    } else {
      // caso contrario mostramos el mensaje de error
      return decodeResp['msg'];
    }

// codigo 200 indica que todo esta biem
    //   if (resp.statusCode == 200) {
    //     print('Datos con exito');
    //     print(decodeResp);
    //   } else {
    //     print(decodeResp);
    //   }
    isLoading = false;
    notifyListeners();
  }

// metod para elimitar lo que esta guardado del storage

  Future logout() async {
    await storage.delete(key: 'token');
    return;
    // esot no es necesario
  }

//esto nos va a retornar si existe el token
  Future<String> readToken() async {
    // esto puede puede ser nulo en la cual definimos un valor por defecto
    // como una valor vacio
    return await storage.read(key: 'token') ?? '';
  }

//esto nos va a retornar si existpe el token
  Future<String> readToken2() async {
    // esto puede puede ser nulo en la cual definimos un valor por defecto
    // como una valor vacio
    return await storage.read(key: 'token') ?? '';
  }

  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();

    String? _token = await _storage.read(key: 'token');

    return _token!;
  }

  // FUCINO PARA VER SI EL TOKEN  TODAVIA ES VALIDO
  Future<bool> validateToken() async {
    //   TOKNE
    String? token = await storage.read(key: 'token');
    final url = ConectionHost.myUrl('/api/userLogin/validateToken', {});
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    final resp = await http.get(url, headers: headers);

    final respBody = json.decode(resp.body);
    print(respBody);

    return respBody['valido'];
  }
}
