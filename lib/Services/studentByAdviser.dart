import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:preppa_profesores/models/host.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/models/student_adviser.dart';

class StudentAdviserServices extends ChangeNotifier {
  ///
  String baserUrl = ConectionHost.baseUrl;

  late  StudentAdviser studentSelectedByAdbiser;

  Map<String, String> headers = {'content-type': 'application/json'};

  bool status = false;

// StudentAviser studentAviser = StudentAviser(studentAviser: studentAviser, name: name, lastName: lastName, secondName: secondName, gender: gender, dateOfBirth: dateOfBirth, bloodGrade: bloodGrade, curp: curp, age: age, town: town, numberPhone: numberPhone, status: status, rol: rol, group: group, semestre: semestre, subjects: subjects, generation: generation, tuition: tuition, uid: uid)
  List<StudentAdviser> studentAdviser = [];

  Future getDateAdviserOrTutor(
      String generation, String semestre, String group) async {
    // final url = Uri.http(
    //     baserUrl, '/api/student/${generation}/${semestre}/${group}/adviser');
    final url = ConectionHost.myUrl(
        '/api/student/$generation/$semestre/$group/adviser', {});

    status = true;
    notifyListeners();

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);
    final studentAdvisers =
        respBody.map((e) => StudentAdviser.fromJson(e)).toList();
    studentAdviser = [...studentAdvisers];
    notifyListeners();
    print(respBody);
    status = false;
    notifyListeners();
  }
}
