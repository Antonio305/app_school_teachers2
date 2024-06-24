import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/apiServices.dart';
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'package:preppa_profesores/models/MessageError.dart';
import 'package:preppa_profesores/models/taskReceived.dart';
import 'package:preppa_profesores/screen/task/studentTaskReceived.dart';
import 'package:preppa_profesores/widgets/showDialogs/showDialogRequesthHttp.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/host.dart';

class TaskReceivedServices extends ChangeNotifier {
  // status de la estado http

  bool statusSearchTask = false;

// INSTANCE CLASS FOR HOST CONECTION
  String baseUrl = ConectionHost.baseUrl;

  // Map<String, dynamic> taskReceived = {};
  List<TaskReceived> taskReceived = [];
  bool requestStatus = false;
  TaskReceived taskReceivedSelected = TaskReceived(
      id: '',
      task: TaskReceiveds(
          id: '',
          subject: '',
          nameTask: '',
          description: '',
          status: false,
          group: '',
          userTeacher: '',
          v: 0,
          archivos: []),
      student: TaskStudent(name: '', lastName: '', secondName: '', uid: ''),
      rating: 0,
      isQualified: false,
      comments: '',
      v: 0,
      archivos: [],
      subject: Subject(name: '', uid: ''),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());

// header type aplication/json

  // instance class for Secure storage
  final storage = SecureStorage.storage();

  // api services
  final apiServices = ApiServices();

  // status
  bool status = false;
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    // falta el token
  };

// for ID
// ver la taras recividas  por id de la tarea
// tareas recividas por tarrea
  Future getIdReceivedTask(String id) async {
    String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    final url = ConectionHost.myUrl('api/taskReceived/teacher/$id', {});

    requestStatus = true;
    notifyListeners();
    final resp = await http.get(url, headers: headers);
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    // indica falta de toquen
    // usuario equivocado etc.
    if (resp.statusCode == 401) {
      requestStatus = false;
      notifyListeners();
      return false;
    }
    if (resp.statusCode == 404) {
      requestStatus = false;
      taskReceived = [];
      notifyListeners();
      return decodeResp['msg'];
    }

    if (resp.statusCode == 200) {
      final taskReceiveds = decodeResp['taskReceived']
          .map((e) => TaskReceived.fromJson(e))
          .toList();

      taskReceived = [...taskReceiveds];
      requestStatus = false;
      notifyListeners();
    }

    requestStatus = false;
    notifyListeners();
    return decodeResp['msg'];
  }

// para calificar la tareas
  Future taskQualify(
      BuildContext context, String id, String rating, bool isQualified) async {
    Map<String, dynamic> data = {"rating": rating, "isQualified": isQualified};

    status = true;
    notifyListeners();
    final resp = await apiServices.update(
        data, '/api/taskReceived/gradeReceivedHomework/$id');

    if (resp.statusCode == 401) {
      status = false;
      notifyListeners();
      return false;
    } else {
      if (resp.statusCode == 400) {
        List<ErrorMessage> errors = messageErrorFromJson(resp.body);

        // print(erros);
        // ignore: use_build_context_synchronously
        ShowDialogHttpResponsesMessages.showDialogErrorStatus400(
            context, const Icon(Icons.error), 'Error', errors);
        status = false;
        notifyListeners();
        return;
      }

      Map<String, dynamic> respBody = json.decode(resp.body);

      if (resp.statusCode == 404) {
        status = false;
        notifyListeners();
        return respBody['msg'];
      }

      if (resp.statusCode == 200) {
        final task = TaskReceived.fromJson(respBody['taskReceived']);
        taskReceivedSelected = task;
        final tasks = await updateTaskReceived(task);
        taskReceived = tasks;
        status = false;
        notifyListeners();
        notifyListeners();
      }

      status = false;
      notifyListeners();
      return respBody['msg'];
    }
  }

// solo actualiza la lista con los nuevos datos del que se edito
  Future<List<TaskReceived>> updateTaskReceived(TaskReceived task) async {
    List<TaskReceived> tasks = taskReceived.map((e) {
      if (e.id == task.id) {
        e = task;
      }
      return e;
    }).toList();

    return tasks;
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
    final url =
        ConectionHost.myUrl('/api/taskReceived/taskQualified/$idSubjects', {});

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
