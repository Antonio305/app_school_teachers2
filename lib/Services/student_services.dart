import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure-storage.dart';
import 'package:preppa_profesores/models/gradeAndTaskReceivedResp.dart';
import 'package:preppa_profesores/models/student.dart';

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

  List<Student> studentBySubject = [];
  late Student selectedStudent;

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
    final url = ConectionHost.myUrl('/api/student/stuentTeacher', {});

    final resp = await http.get(url, headers: headers);

    // recuvos oun String EN LA CUAL  HACEMOS LA CONVERSION DE UN OBJETO
    // COMO SE COMO EN DART MAPAS, ES CASI IGUAL

    final respBody = json.decode(resp.body);
  }

  // OBtENEER LA LISTA DE ESTUDIANES POR MATERIA Y  POR GRUPO

  bool status = false;

// clase modificada
  Future getStudentForGroupAndSubject(String group, String subject) async {
    // Future getStudentForGroupAndSubject() async {
    status = true;
    notifyListeners();

    final url =
        ConectionHost.myUrl('/api/student/teacher/$group/$subject/student', {});

    final resp = await http.get(url);
    Map<String, dynamic> respBody = json.decode(resp.body);

    final ss = StudentResponse.fromRawJson(resp.body);
    studentBySubject = [...ss.student];
    // studentBySubject = [];
    status = false;
    notifyListeners();

    print(respBody);
  }

  /// route to get some student data by teacher
  /// To obtain assignments, grades and information about a student
  /// parameters . studentId - subjectId

  GradeAndTaksRecivedsResponse gradeAndTaksRecivedsResponse =
      GradeAndTaksRecivedsResponse(msg: '', tasksReceiveds: []);

  Future getStudent(String studentId, String subjectId) async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    final url = ConectionHost.myUrl(
        '/api/teacher/getstudent/$studentId/$subjectId', {});
    status = true;
    notifyListeners();

    final resp = await http.get(url, headers: headers);
    Map<String, dynamic> respBody = json.decode(resp.body);

    print(respBody);

    gradeAndTaksRecivedsResponse =
        GradeAndTaksRecivedsResponse.fromRawJson(resp.body);
    status = false;
    notifyListeners();
  }
}
