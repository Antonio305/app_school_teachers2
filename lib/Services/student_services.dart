import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure-storage.dart';
import 'package:preppa_profesores/models/student_adviser.dart';

import 'dart:convert';

import '../models/host.dart';
import '../models/studentForSubject.dart';

class StudentServices extends ChangeNotifier {
  // final String baseUrl = "localhost:8080";
  // final String baseUrl = ConectionHost.baseUrl;
  // final String baseUrl = 'localhost:8080';
  final baseUrl = ConectionHost.baseUrl;

  final headers = {'content-type': 'application/json'};

  // inrtacia del Stotage
  final storage = SecureStorageServices.secureStorageServices;

  // get students

  List<StudentForSubject> studentBySubject = [];

  Future getStudentForGroup(
      String generation, String group, String semestre) async {
    String? token = await storage.read(key: 'token');

//  los parametro iran dentro del header
    final Map<String, String> headers = {
      'content-type': 'application/json',
      'token': token!,
      'generation': generation,
      "semestre": semestre,
      "group": group,
    };

// local
    // final url = Uri.parse('$baseUrl/api/student/stuentTeacher');
//desplegado
    // final url = Uri.http(baseUrl, '/api/student/stuentTeacher');
    final url = ConectionHost.myUrl('/api/student/stuentTeacher',{});

    final resp = await http.get(url, headers: headers);

    // recuvos oun String EN LA CUAL  HACEMOS LA CONVERSION DE UN OBJETO
    // COMO SE COMO EN DART MAPAS, ES CASI IGUAL

    final respBody = json.decode(resp.body);
    print('$respBody');
  }

  // OBtENEER LA LISTA DE ESTUDIANES POR MATERIA Y  POR GRUPO

  bool status = false;

  Future getStudentForGroupAndSubject(String group, String subject) async {
    // Future getStudentForGroupAndSubject() async {
    status = true;
    notifyListeners();

    // final url = Uri.http(baseUrl, '/api/student/$group/$subject/student');
    final url = ConectionHost.myUrl('/api/student/$group/$subject/student',{});

    // '/api/student/63a48c048cb9c04c72300b09/6378ed9ce75170454c40f05c/student');

    final resp = await http.get(url);
    final List<dynamic> respBody = json.decode(resp.body);
    // studentForSubject = StudentForSubject.fromMap(respBody);
    final student = respBody.map((e) => StudentForSubject.fromJson(e)).toList();
    studentBySubject = [...student];
    status = false;
    notifyListeners();

    print(respBody);
  }
}
