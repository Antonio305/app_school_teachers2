import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure-storage.dart';
import 'package:preppa_profesores/models/students.dart';

import '../models/host.dart';
import '../models/subjects.dart';

class SubjectServices extends ChangeNotifier {
  List<Subjects> subjects = [];

  final storage = SecureStorageServices.secureStorageServices;

  // List<Subject> subjects = [];

  // base  url la cual es local
  // String baseUrl = '192.168.1.70:8080';

  // String baseUrl = '192.168.1.67:8080';

  final String baseUrl = ConectionHost.baseUrl;

  // funtion para obtener los datos

  Future getSubjects() async {
    // final url = Uri.http(baseUrl, 'api/matery');

 final url = ConectionHost.myUrl('api/matery',{});
    final headers = {'content-Type': 'application/json'};

    final resp = await http.get(url, headers: headers);

    //  final subject  = Subject.fromJson(resp.body);
    print(resp.body);
    //  subjects.add(subject);
    // final Map<String, dynamic>  decodeResp = json.decode(resp.body);

    // final subject = Subject.fromMap(decodeResp);

    // if (resp.statusCode == 200) {

    //   print('datos de materia  obtenidos  con exito ');
    // } else {
    //   print('HA SURGIDO UN GRAVE ERROR');
    // }
  }

/**
 * 
 * Method for teacher
 * 
 */

  // enviaremos su token en vez del id
  // // Future<Subject> getSubjectsForTeacher() async {

  Future getSubjectsForTeacher() async {
    final String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'content-type': 'application/json',
      'x-token': token!
    };

    // final url = Uri.http(baseUrl, '/api/matery/subjectTeacher');
     final url = ConectionHost.myUrl('/api/matery/subjectTeacher',{});

    print(url);
    final resp = await http.get(url, headers: headers);

    // final Map<String, dynamic> respBody = json.decode(resp.body);
    

    // SE RECIVE UNA LSITA NO UN MAAP
    final List<dynamic> respBody = json.decode(resp.body);

    final subject = respBody.map((e) => Subjects.fromJson(e)).toList();
    print(resp.body);

    subjects = [...subject];

    notifyListeners();

    // return subject;
    // print(respBody);
  }
}
