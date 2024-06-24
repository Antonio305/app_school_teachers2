import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure-storage.dart';
import 'package:preppa_profesores/models/taskReceived.dart';

import '../models/host.dart';
import '../models/subjects.dart';

class SubjectServices extends ChangeNotifier {
  late Subjects subjectSelected;
  late Subjects subjectSelectedByStudent;
  Subjects? selectedSubject;
  List<Subjects> subjects = [];

  final storage = SecureStorageServices.secureStorageServices;

  // List<Subject> subjects = [];

  // base  url la cual es local
  // String baseUrl = '192.168.1.70:8080';

  // String baseUrl = '192.168.1.67:8080';

  final String baseUrl = ConectionHost.baseUrl;

  bool requestStatus = false;
  int statusCodes = 0;

  // funtion para obtener los datos

  Future getSubjects() async {
    // final url = Uri.http(baseUrl, 'api/matery');

    final url = ConectionHost.myUrl('api/matery', {});
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

  Future getSubjectById(String subjectId) async {
    final url =
        ConectionHost.myUrl('api/matery/teacher/subject/$subjectId', {});
    final headers = {'content-Type': 'application/json'};

    final resp = await http.get(url, headers: headers);

    Map<String, dynamic> respBody = json.decode(resp.body);

    print(respBody);

    subjectSelected = Subjects.fromJson(respBody['subject']);
    notifyListeners();
  }

  ///
  /// Method for teacher
  ///

  // enviaremos su token en vez del id
  // // Future<Subject> getSubjectsForTeacher() async {

  Future getSubjectsForTeacher() async {
    final String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'content-type': 'application/json',
      'x-token': token!
    };

    final url = ConectionHost.myUrl('/api/matery/subjects/Teacher', {});
    requestStatus = true;

    notifyListeners();
    // print(url);
    final resp = await http.get(url, headers: headers);

    Map<String, dynamic> respBody = json.decode(resp.body);

    if (resp.statusCode == 404) {
      subjects = [];
      requestStatus = false;
      statusCodes = 404;
      notifyListeners();
      // return;
    }

    if (resp.statusCode == 200) {
      // SE RECIVE UNA LSITA NO UN MAAP
      // final List<dynamic> respBody = json.decode(resp.body);

      final subject =
          respBody['subject'].map((e) => Subjects.fromJson(e)).toList();

      subjects = [...subject];
      notifyListeners();
    }
    // print(respBody);
  }

  Future updateSubject(Subjects subject) async {
    String? tokken = await storage.read(key: 'token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'z-token': tokken!
    };

    final url = ConectionHost.myUrl('/api/matery/${subject.uid}', {});
    // final resp = await http.putu(rl,
    //     headers: headers, body: json.encode(subject.toJson()));

    final resp = await http.put(url,
        headers: headers, body: json.encode(subject.toJson()));

    final respBody = json.decode(resp.body);
    print(respBody);

    Subjects sub = Subjects.fromJson(respBody);

    List<Subjects> s = subjects.map((e) {
      if (e.uid == subject.uid) {
        e = sub;
      }
      return e;
    }).toList();

    print(s);

    // subjects = [...s];
    subjects = s;
    notifyListeners();
  }

// Function that returns the topics by partial

  Syllaba? syllaba;

  returnTopicsByPartial(Syllaba subject, String partial) {}

  // function add topics  subtopic by subject

  Future<Syllaba> addSyllabasBySubject(
      Syllaba newSyllaba, String idSubject) async {
    String? token = await storage.read(key: 'token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    // Map<String, dynamic> syllaba = {'syllaba': newSyllaba.toRawJson()};

    final url = ConectionHost.myUrl(
        '/api/matery/teacher/addTopicAndSubtopicsByTeacher/$idSubject', {});

    // final resp =
    //     await http.put(url, headers: headers, body: json.encode(syllaba));
    final resp =
        await http.put(url, headers: headers, body: newSyllaba.toRawJson());

    Map<String, dynamic> respBody = json.decode(resp.body);

    print(respBody);

    final newSubject = SubjectsResponse.fromRawJson(resp.body);
    subjectSelected = newSubject.materi;
    // print(newSyllaba.)
    // syllaba = subjectSelected.syllabas;
    notifyListeners();

    // cuando se hace los cambios  modificamos la lista de los materias
    // la cualse ha modificado

    List<Subjects> newListSubject = subjects.map((e) {
      if (e.uid == idSubject) {
        e.syllabas.add(newSubject.syllaba);
      }
      return e;
    }).toList();
    subjectSelected = newSubject.materi;
    subjectSelected.syllabas.add(newSubject.syllaba);

    subjects = newListSubject;
    notifyListeners();
    return newSubject.syllaba;
  }

  // update syllab
  Future updateSyllabasBySubject(
      Syllaba syllaba, String idSubject, int partial) async {
    String? token = await storage.read(key: 'token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    // Map<String, dynamic> syllabas = {'syllaba': syllaba.toRawJson()};

    final url = ConectionHost.myUrl(
        '/api/matery/teacher/updateTopicAndSubtopicsByTeacher/$idSubject/$partial',
        {});

    // final resp =
    //     await http.put(url, headers: headers, body: json.encode(syllaba));
    final resp =
        await http.put(url, headers: headers, body: syllaba.toRawJson());

    Map<String, dynamic> respBody = json.decode(resp.body);

    // print(respBody);

    // final newSubject = Subjects.fromJson(respBody['materi']);
    // subjectSelected = newSubject;
    // notifyListeners();
  }
}
