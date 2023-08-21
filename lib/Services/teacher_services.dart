import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'package:preppa_profesores/models/teacher.dart';

import '../models/host.dart';

class TeachaerServices extends ChangeNotifier {
  final storage = SecureStorage.storage();

  String baseUrl = ConectionHost.baseUrl;

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

    final url = ConectionHost.myUrl('/api/teacher/information',{});
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };
    

    final resp = await http.get(url, headers: headers);

    final Map<String, dynamic> respBody = json.decode(resp.body);
print('Estamos dentro del body');
    print(respBody);

    teacherForID = Teachers.fromJson(respBody);
    notifyListeners();
  }

// create data teacher ( register teachers)

  // Future createTeacher(Teachers teacher) async {
  //   final url = Uri.http(baseUrl, '/api/teacher');
  //   final resp = await http.post(
  //     url,
  //     headers: headers,
  //     body: json.encode(teacher.toMap()),
  //   );

  //   if (resp.statusCode == 200) {
  //     final Map<String, dynamic> respBody = json.decode(resp.body);

  //     print(respBody);
  //   } else {
  //     print(resp);
  //   }
  // }
}
