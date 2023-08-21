import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'package:preppa_profesores/models/taskReceived.dart';
import '../models/host.dart';

class TaskReceivedServices extends ChangeNotifier {
// INSTANCE CLASS FOR HOST CONECTION
  String baseUrl = ConectionHost.baseUrl;

  // Map<String, dynamic> taskReceived = {};
  List<TaskReceived> taskReceived = [];
// header type aplication/json

  // instance class for Secure storage
  final storage = SecureStorage.storage();

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    // falta el token
  };

// function get task
  Future getReceivedTask() async {
    // final url = Uri.http(baseUrl, 'api/taskReceived');
    final url = ConectionHost.myUrl('api/taskReceived',{});
    print('Url task received  $url');

    final resp = await http.get(url, headers: headers);
    final Map<String, dynamic> respBody = json.decode(resp.body);

    // print(respBody);
  }

// for ID
// ver la taras recividas  por id de la tarea
  Future getIdReceivedTask(String id) async {
    // final url = Uri.http(baseUrl, 'api/taskReceived/$id');
    final url = ConectionHost.myUrl('api/taskReceived/$id',{});
    print('Url task received  $url');

    final resp = await http.get(url, headers: headers);
    // final Map<String, dynamic> respBody = json.decode(resp.body);
    final List<dynamic> respBody = json.decode(resp.body);

    // taskReceived = TaskReceived.fromMap(respBody);

    final taskReceiveds =
        respBody.map((e) => TaskReceived.fromJson(e)).toList();
    taskReceived = [...taskReceiveds];
    notifyListeners();
    print('task entregados $respBody');
  }



// para calificar la tareas
  Future taskQualify(String id, String rating, bool isQualified) async {
    // final url = Uri.http(baseUrl, '/api/taskReceived/$id');
    final url = ConectionHost.myUrl('/api/taskReceived/$id',{});
    print(url);
    Map<String, dynamic> data = {"rating": rating, "isQualified": isQualified};

    final resp = await http.put(url,
        body: json.encode(data), headers: {'Content-Type': 'application/json'});

    final respBody = json.decode(resp.body);
    print(respBody);
  }

/*
 
 * to obtain the assignments that  have been graded, in the subjects, in the subjects they teach,
 * for the teachers
 * 
 *  parameter 
 *  - token for authentication 
 *  - subjects
 * 
 */

  Future getTaskQualified(List<String> idSubjects) async {
    String? token = await storage.read(key: 'token');

    final headers = {'Content-Type': 'application/json', 'token': token!};

    // final url = Uri.http(baseUrl, '/api/taskReceived/taskQualified/$idSubjects');
    final url = ConectionHost.myUrl('/api/taskReceived/taskQualified/$idSubjects',{});

    print('url para als tareas calificados:  $url');

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);

    final taskReceiveds =
        respBody.map((e) => TaskReceived.fromJson(e)).toList();
    taskReceived = [...taskReceiveds];
    notifyListeners();
    // print(' tareas calificados : $respBody');
    // return taskReceiveds;
  }

// craete taskReceived
  Future craeteReceivedTask() async {}
}
