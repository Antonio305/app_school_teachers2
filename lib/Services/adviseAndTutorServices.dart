import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'package:preppa_profesores/models/adviser_tutor.dart';

import 'dart:convert';

import '../models/host.dart';
import '../models/student_adviser.dart';

class AdviserTutorServices extends ChangeNotifier {
  List<StudentAdviser> studentAdviser = [];

  AdviserTutor adviserTutor = AdviserTutor(
      id: '',
      group: GroupAdviser(name: '', uid: ''),
      semestre: GroupAdviser(name: '', uid: ''),
      generation: GenerationAdviser(
          initialDate: DateTime.now(), finalDate: DateTime.now(), uid: ''),
      adviser: '',
      tutor: '',
      status: false,
      v: 0);

  bool status = false;

  String baserUrl = ConectionHost.baseUrl;

  final storage = SecureStorage.storage();

// para obtener los datos del tutor,
// de que grupo de asesor, grupo, y semestre

  Future<String?> amIAdviser(String id) async {
    final url = ConectionHost.myUrl('/api/adviserTutor/$id/teacher', {});

    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'content-type': 'application/json',
      "x-token": token!
    };
    status = true;
    notifyListeners();

    final resp = await http.get(url, headers: headers);

    final Map<String, dynamic> respBody = json.decode(resp.body);
    // print('datos del tutor en la que puede hacer');
    // print(resp.body);

    if (respBody.containsKey('msg')) {
      status = false;
      notifyListeners();
      return respBody['msg'];
    } else {
      adviserTutor = AdviserTutor.fromJson(respBody);
      status = false;
      notifyListeners();
    }

    status = false;
    notifyListeners();
    return null;

  }

// esta funcion es  para consultzr por materiap er no seu tal parece que si

  Future getStudentForAdviser(
      String generation, String semestre, String group) async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'content-type': 'application/json',
      "token": token!
    };

    status = true;
    notifyListeners();

    // final url = Uri.http(
    //     baserUrl, '/api/student/${generation}/${semestre}/${group}/adviser');
    final url = ConectionHost.myUrl(
        '/api/student/$generation/$semestre/$group/adviser', {});

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);

    final student = respBody.map((e) => StudentAdviser.fromJson(e)).toList();
    studentAdviser = [...student];
    print(resp.body);

    status = false;
    notifyListeners();
  }
}
