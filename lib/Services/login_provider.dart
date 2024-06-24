import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure-storage.dart';
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'package:preppa_profesores/models/loginResponseTeacher.dart';
import 'package:preppa_profesores/models/login_response.dart';
import 'package:preppa_profesores/models/student_byGrades.dart';
import 'package:preppa_profesores/models/teacher.dart';

import '../models/host.dart';
import '../models/login.dart';

class LoginServices extends ChangeNotifier {
  // aca vamos guardar el token
  // final storage =  FlutterSecureStorage();

  // final storage = SecureStorageServices.secureStorageServices;
  final storage = SecureStorage.storage();
  // instance classs techer
  late LoginUser userLogin;

  bool isLoading = false;
  late LoginResponseTeacher loginResponseTeacher;
  Teachers? teachers;
  // Teachers teachers = Teachers(
  //     name: '',
  //     lastName: '',
  //     secondName: '',
  //     gender: '',
  //     collegeDegree: '',
  //     typeContract: '',
  //     status: false,
  //     rol: '',
  //     numberPhone: '',
  //     email: '',
  //     tuition: '',
  //     uid: '',
  //     updatedAt: DateTime.now());

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

    // send type user, is the is TEACHER

    final url = ConectionHost.myUrl('/api/userLogin/PROFESOR', {});
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

// En este caso, el estado HTTP que debes usar es 403 Forbidden. Este estado indica que el acceso al recurso solicitado está
//prohibido. En tu caso, el usuario no tiene permiso para acceder al recurso porque su estado es false.

    if (resp.statusCode == 401) {
      isLoading = false;
      notifyListeners();
      return decodeResp['msg'];
    }

    if (resp.statusCode == 403) {
      isLoading = false;
      notifyListeners();

      return decodeResp['msg'];
    }

    final loginResponseTeacher = loginResponseFromJson(resp.body);

    teachers = loginResponseTeacher.teacher;

    // final  decodeResp =  json.decode(resp.body);

    print(decodeResp);

    // teacher = Teacher.fromMap(decodeResp);
    //  teacher = Teachers.fromJson(decodeResp['teacher']);
    notifyListeners();

    if (decodeResp.containsKey('token')) {
      // TODO: GUARDAR TOKEN EN UN LUGAR SEGURO

      await storage.write(key: 'token', value: decodeResp['token']);

      print(decodeResp['token']);
      isLoading = false;
      notifyListeners();
      return null; // no retornamos nada si pasa bien
    } else {
      // caso contrario mostramos el mensaje de error
      isLoading = false;
      notifyListeners();

      return decodeResp['msg'];
    }

// codigo 200 indica que todo esta biem
    //   if (resp.statusCode == 200) {
    //     print('Datos con exito');
    //     print(decodeResp);
    //   } else {
    //     print(decodeResp);
    //   }
    // isLoading = false;
    // notifyListeners();
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
    const storage = FlutterSecureStorage();

    String? token = await storage.read(key: 'token');
    // si no hay token retorna un string vacio
    return token ?? '';
  }

  // FUCINO PARA VER SI EL TOKEN  TODAVIA ES VALIDO,

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

    if (respBody['valido'] == false) {
      logout();
    }

    return respBody['valido'];
  }

  // funcion par haer la validcion del token
  //  condiciones
  // si el token es vacio retornnar false
// caso contrario true
// si eo token aunm es valiodo rettornar tur
// caso contrario false

  Future<bool> isValidToekn() async {
    String? token = await storage.read(key: 'token');

    if (token == null) return false;

    // Si tnemos token ejecutamos este codigo

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token
    };

    final url = ConectionHost.myUrl('/api/userLogin/validateToken', {});

    final resp = await http.get(url, headers: headers);

    final respBody = json.decode(resp.body);
    print(respBody);

    if (respBody['valido'] == false) {
      logout();
      return false;
    }
    return true;
  }

  /**
   * Funcciones para el loogin y validar el token si es valido
   * rettorna varios datos el login 
   * como:
   * 
   * - token
   * - userData - datos del personales del profesor
   * - userLogin - datos de como el password 
   * - msg 
   */

  /// Fucion para el nuevo login en la cuaol se ha modificado la base de datos en la parte de arriba

  Future validateTokens() async {
    String? token = await storage.read(key: 'token');

    if (token!.isEmpty) {
      return false; // si la variable del token esta vacio se retorna false
    }

    // headers- encabazedo
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token
    };

    // ruta para el validar el token
    final url = ConectionHost.myUrl('/api/userLogin/renNew/validateTooken', {});

    // peticion http
    final resp = await http.get(url, headers: headers);

    final respBody = json.decode(resp.body);

    // status 401 error del token etc
    if (resp.statusCode == 401) {
      print(respBody['msg']);
      return false;
    }
    // status 200 cuando la peticio nes correcta
    if (resp.statusCode == 200) {
      loginResponseTeacher = LoginResponseTeacher.fromRawJson(resp.body);
      teachers = Teachers.fromJson(loginResponseTeacher.userData);
      notifyListeners();
      return loginResponseTeacher.status ?? true;
    }

    // si sale otro errores retornamos un estado false
    logout();
    teachers = null;
    notifyListeners();
    return respBody['status'];
  }

  bool status = false;
  int statusCde = 0;

  Future<String?> loginUser2(LoginUser login) async {
    String typeUser = 'TEACHER';
    final url = ConectionHost.myUrl('/api/userLogin/login/$typeUser', {});

    final headers = {'content-Type': 'application/json'};

    status = true;
    notifyListeners();

    // print(url);
    final resp = await http.post(url, headers: headers, body: login.toJson());
    // print('datos del boy');
    print(resp.body);

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (resp.statusCode == 401) {
      // eroro en el inicio de sesion
      // final loginResponseTeacher = LoginResponseTeacher.fromRawJson(resp.body);+
      status = false;
      statusCde = 401;
      notifyListeners();
      return decodeResp['msg'];
    }
    // print(resp);
    if (resp.statusCode == 404) {
      loginResponseTeacher = LoginResponseTeacher.fromRawJson(resp.body);

      await storage.write(key: 'token', value: loginResponseTeacher.token);
      statusCde = 404;
      teachers = null;
      notifyListeners();

      if (loginResponseTeacher.userData == null) {
        loginResponseTeacher = LoginResponseTeacher.fromRawJson(resp.body);
        teachers = null;
        status = false;
        notifyListeners();
        // await storage.write(key: 'token', value: loginResponseTeacher.token);
        return loginResponseTeacher.msg;
      }
      return loginResponseTeacher.msg;
    }

    if (resp.statusCode == 200) {
      loginResponseTeacher = LoginResponseTeacher.fromRawJson(resp.body);
      await storage.write(key: 'token', value: loginResponseTeacher.token);
      status = false;
      statusCde = 200;
      teachers = Teachers.fromJson(loginResponseTeacher.userData);
      notifyListeners();
      return null;
    }

    // caso contrario mostramos el mensaje de error
    status = false;
    notifyListeners();
    return decodeResp['msg'];
  }

  Future<bool> validateToken2() async {
    String? token = await storage.read(key: 'token') ?? '';

    if (token.isEmpty) {
      return false;
    }

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token
    };
    final url = ConectionHost.myUrl('/api/userLogin/renNew/validateToken', {});

    final resp = await http.get(url, headers: headers);

    final respBody = json.decode(resp.body);

    print(resp.body);

    if (resp.statusCode == 401) {
      print(respBody['msg']);
      statusCde = 401;
      notifyListeners();
      return false;
    }

    if (resp.statusCode == 404) {
      loginResponseTeacher = LoginResponseTeacher.fromRawJson(resp.body);
      teachers = null;
      if (loginResponseTeacher.userData == null) {
        loginResponseTeacher = LoginResponseTeacher.fromRawJson(resp.body);
        teachers = null;
        status = false;
        notifyListeners();
        // await storage.write(key: 'token', value: loginResponseTeacher.token);
        return loginResponseTeacher.status ?? true;
      }
      return loginResponseTeacher.status ?? true;
    }

    if (resp.statusCode == 200) {
      // student2 = Student.fromMap(loginResponseTeacher.userData);
      // returnStudent(Student.fromMap(loginResponseTeacher.userData));

      loginResponseTeacher = LoginResponseTeacher.fromRawJson(resp.body);
      teachers = Teachers.fromJson(loginResponseTeacher.userData);
      notifyListeners();
      return loginResponseTeacher.status ?? true;
    }

    // if (respBody['status'] == false) {
    //   logout();
    // }
    logout();
    teachers = null;
    notifyListeners();
    return respBody['status'];
  }
}
