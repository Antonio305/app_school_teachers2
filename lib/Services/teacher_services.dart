import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure-storage.dart';
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'package:preppa_profesores/models/teacher.dart';

import '../models/host.dart';
import '../models/teacherRegister.dart';

class TeachaerServices extends ChangeNotifier {
  final storage = SecureStorage.storage();

  String baseUrl = ConectionHost.baseUrl;

  bool requestStatus = false;

  Teachers teacherForID = Teachers(
      name: "",
      lastName: "",
      secondName: "",
      gender: "",
      collegeDegree: "",
      typeContract: "",
      status: true,
      rol: "",
      tuition: "",
      uid: "");

  Future getForId() async {
    String? token = await storage.read(key: 'token');

    final url = ConectionHost.myUrl('/api/teacher/information', {});
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    final resp = await http.get(url, headers: headers);

    final Map<String, dynamic> respBody = json.decode(resp.body);

    if (respBody.containsKey('msg')) {
      print(respBody['msg']);
//  print(respBody')
      return;
    }

    print('Estamos dentro del body');
    print(respBody);

    teacherForID = Teachers.fromJson(respBody);
    notifyListeners();
  }

// create data teacher ( register teachers)
  int statusCodes = 0;
  Future<String?> createTeacher(TeacherRegister teacher) async {
    String? token = await storage.read(key: 'token');

    final url = Uri.http(baseUrl, '/api/teacher');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    requestStatus = true;
    notifyListeners();
    final resp = await http.post(
      url,
      headers: headers,
      body: json.encode(teacher.toJson()),
    );

    final Map<String, dynamic> respBody = json.decode(resp.body);
// cuando el token no es valido y para otros provlemas mas ne la cual caen en el etado http 201
    // verifica el rol del quien esta registrando

    if (resp.statusCode == 502) {
      requestStatus = false;
      statusCodes = 502;
      notifyListeners();
      return respBody['msg'];
    }

    if (resp.statusCode == 401) {
      requestStatus = false;
      statusCodes = 401;
      notifyListeners();
      return respBody['msg'];
    }

// retorn un 200 si el usuario ya existe en la base de datos
    if (resp.statusCode == 200) {
      requestStatus = false;
      statusCodes = 200;
      notifyListeners();
      print(respBody);
      return respBody['msg'];
    }
    // si guard con exito status 200
    if (resp.statusCode == 201) {
      // print(resp.body);
      statusCodes = 201;
      requestStatus = false;
      notifyListeners();
      return respBody['msg'];
    }
    // return null;
  }
}
