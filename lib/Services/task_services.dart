import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:preppa_profesores/Services/secure-storage.dart';
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'package:preppa_profesores/models/host.dart';
import 'package:preppa_profesores/widgets/showDialogs/showDialogLogin.dart';

import '../models/task/tasks.dart';
import '../models/taskResponse.dart';

class TaskServices extends ChangeNotifier {
  bool status = false;

  // para las taras selecionadaA PARA EDITAR
  late Tasks taskSelected;

// we create task list for task tatus = true
  List<Tasks> taskForStatusTrue = [];

  List<Tasks> tasks = [];
  List<Tasks> tasksForSubject = [];

// To save tasks filtered by subject
  List<Tasks?> taskBySubject = [];

  Tasks? selectedTask;

  // TaskElement task = TaskElement(id: '0', subject: Subject(msg: '', subject: ''), nameTask: '', description: '', status: true, generation: '', semestre: '', group: '', userTeacher: '', v: 0);

  // Conection host local
  final String baseUrl = ConectionHost.baseUrl;

// object by FIle
  File? pathFile;

// cret object by file,
  XFile? newFile;

  final storage = SecureStorageServices.secureStorageServices;

//TOOD: la clase la que se hacreado
  // creatar tareas sin el archivo

  Future<dynamic> createTaskNotFile(
      String nameTask,
      String descriptionTask,
      String idSubject,
      String semestre,
      String idGroup,
      String nameSubject,
      DateTime expiredAt) async {
    String? token = await storage.read(key: 'token'); // creat url

    // final url = Uri.http(baseUrl, '/api/tasks');
    final url = ConectionHost.myUrl('/api/tasks', {});
    final Map<String, String> headers = {
      'x-token': token!,
      'Content-Type': 'application/json'
    };

    final Map<String, String> data = {
      "subject": idSubject,
      "nameTask": nameTask,
      "description": descriptionTask,
      "group": idGroup,
      "nameSubject": nameSubject,
      "expiredAt": expiredAt.toString()
    };
    status = true;
    notifyListeners();

    final resp =
        await http.post(url, headers: headers, body: json.encode(data));

    final Map<dynamic, dynamic> respBody = json.decode(resp.body);

    if (resp.statusCode == 401) {
      // ShowDialogLogin.showDialogLogin(context);
      status = false;
      notifyListeners();
      return false;
    }

    if (resp.statusCode == 404) {
      status = false;
      notifyListeners();
      return respBody['msg'];
    }

    if (resp.statusCode == 201) {
      Tasks newTask = Tasks.fromJson(respBody['newTask']);
      selectedTask = newTask;
      status = false;
      notifyListeners();
      // return respBody['task']['_id'];
      return;
    }

    return respBody['msg'];
  }

  /* 
      -THIS FNCTION IS NOT BEING  USED
      - ADD  FILE FOR TASKS
      -  REQUIRED ID
   */

  Future updateTaskAddFile(String id, XFile? pathFile) async {
    String? token = await storage.read(key: 'token');

    // required ID

    // creatae haeader eith token, type date
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'x-token' : token,
    };

    // final resp = await http.put(url, headers:headers);

    if (pathFile == null) {
      print('No hay archivos que subir');
      return null; // indicamos null que no haremos lago mas
    }

    newFile = pathFile;

    // final url = Uri.http(baseUrl, '/api/tasks/$id/addFile');
    final url = ConectionHost.myUrl('/api/tasks/$id/addFile', {});
    // print url
    print('url para subir los archivos $url');

    var fileUploadRequest = http.MultipartRequest('PUT', url);
    // AGREDAR EL PATH DEL ARCHIVOa
    var file = await http.MultipartFile.fromPath('archivo', newFile!.path);

    // agregamos el archivo para su envio
    fileUploadRequest.files.add(file);

    final streamedResponse = await fileUploadRequest.send();

    final resp = await http.Response.fromStream(streamedResponse);
    // status 200 cuando se crear o se actualiza algo
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      return null;
    }

    pathFile = null;
  }

  ///  THIS FUNCTION IS NOT BEING USED
  ///  TO UPLOAD FILE TO THE SERVER - PARA SUBIR ARCHIVOS AL SERVIDOS

//   Future fileUpload(XFile? pathFile) async {
//     if (pathFile == null) {
//       print(
//           'No se ha selecionado un archivo en la cual no se ejecurta la funcio');
//       return null;
//     }

//     newFile = pathFile;

//     // final url = Uri.parse(baseUrl);
//     // String baseUrl = ConectionHost.baseUrl;
//     String baseUrl = "localhost:8080";
// // Uri.parse('localhost:8080/api/hours')

//     final url = Uri.http(baseUrl, 'api/hours');
//     print("este es el url  $url ");

//     var fileUploadRequest = http.MultipartRequest('POST', url);

//     // var fileUploadRequest = http.MultipartRequest('POST', Uri.parse('localhost:8080/api/hours'));

//     // esp ra cargar el achivo desde el path
//     var file = await http.MultipartFile.fromPath('archivo', newFile!.path);
//     // agergamos el archivo para su envio
//     fileUploadRequest.files.add(file);

//     // ahora disparemos la peticion
//     final streamedResponse = await fileUploadRequest.send();

//     final resp = await http.Response.fromStream(streamedResponse);

// // pregntmos e por el estatus de la imagne

//     if (resp.statusCode != 200 && resp.statusCode != 201) {
//       print('algo salio mal');
//       print(resp.body);
//       return null;
//     }

//     final decodeData = json.decode(resp.bodyBytes.toString());
//     print(decodeData);
//     pathFile = null;
//   }

  //  GET TASK STUDENT FOR GROUP AND MATERIA
  // get all task

  // Future getTask() async {
  //   final Map<String, String> headers = {"content-type": "application/json"};
  //   final url = Uri.http(baseUrl, '/api/tasks');
  //   final resp = await http.get(url, headers: headers);

  //   final List<dynamic> respBody = json.decode(resp.body);

  //   // tasks = respBody.map((e) => Tasks.fromMap(e)).toList();
  //   // tasks
  //   final listTasks = respBody.map((e) => Tasks.fromJson(e)).toList();
  //   tasks = [...listTasks];
  //   notifyListeners();

  //   // print(respBody);
  //   // final task = Tasks.fromMap(respBody);
  // }

/*
-- get assigment  bdddddddddddddy teacher and by subject 
-- parameters teachers users  TOKEN THE INDENTIFICATION and list subject   
.. task - status = true
*/

// get task by status true
  TaskResponse? taskResponse;
  int statusCode = 0;

  Future<String?> getTaskStatusTrue(List<String> subject) async {
    String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      "content-type": "application/json",
      "x-token": token!
    };

// url get all taks teacher
    // final url = Uri.http(baseUrl, '/api/tasks/teacher/forStatus/$subject');

    status = true;
    notifyListeners();
    final url =
        ConectionHost.myUrl('/api/tasks/teacher/statusTrue/$subject', {});

    final resp = await http.get(url, headers: headers);
    print(resp.body);

    Map<String, dynamic> respBody = json.decode(resp.body);

    // creamos los estados http para mostrar los  tipos de error

    if (resp.statusCode == 401) {
      status = false;
      statusCode = 401;
      notifyListeners();
      return respBody['msg'];
    }

    if (resp.statusCode == 404) {
      taskResponse = TaskResponse.fromRawJson(resp.body);
      taskForStatusTrue = [];
      status = false;
      notifyListeners();
      return taskResponse!.msg;
    }

    if (resp.statusCode == 200) {
      // print('Lista de tareas activas');
      print(respBody);
      // final listTasks = respBody['task'].map((e) => Tasks.fromJson(e)).toList();
      taskResponse = TaskResponse.fromRawJson(resp.body);

      final listTasks = taskResponse!.task;
      taskForStatusTrue = [...listTasks!];
      status = false;
      notifyListeners();
    }
  }

// status true and false
// all assigments

  int statusCodes = 0;

  Future<bool> getTask(List<String> idSubjects) async {
    String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      "content-type": "application/json",
      "x-token": token!
    };

// url get all taks teacher
    // final url = Uri.http(baseUrl, '/api/tasks/teacher/$subject');
    final url = ConectionHost.myUrl('/api/tasks/teacher/$idSubjects', {});

    status = true;
    notifyListeners();
    final resp = await http.get(url, headers: headers);

    Map<String, dynamic> respBody = json.decode(resp.body);

    print(respBody['msg']);
    // status error del login

    if (resp.statusCode == 401) {
      /// ceto datos vacios
      statusCodes = 401;
      status = false;
      notifyListeners();
      return false;
    }

    if (resp.statusCode == 404) {
      taskResponse = TaskResponse.fromRawJson(resp.body);
      status = false;
      statusCodes = 404;
      tasks = [];
      notifyListeners();
      return true;
    }

    if (resp.statusCode == 200) {
      print(respBody);
      taskResponse = TaskResponse.fromRawJson(resp.body);

      final listTasks = taskResponse!.task;
      tasks = [...listTasks!];
      status = false;
      statusCodes = 200;
      notifyListeners();
      return true;
    }
    status = false;
    notifyListeners();
    return false;
  }

  // obtener la tareas entrgados por estudiante
  //  function  obtain the assigments submitted student.
  // parameter  - Student ID , subjects

// Future getSubmittedAssignmentsByStudent (){
//      final url = Uri.parse(baseUrl, '/api/task/teacher');
// }

  /*
  ALL ASSIGMENTS 
  BY BUSNJECT AND GROUP
 
  */
  Future getTaskbySubject(String idGroup, idSubject) async {
    // final url = Uri.http(
    //     baseUrl, '/api/tasks/teacher/taskBySubject/$idGroup/$idSubject');
    final url = ConectionHost.myUrl(
        '/api/tasks/teacher/taskBySubject/$idGroup/$idSubject', {});
    String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      "content-type": "application/json",
      "x-token": token!
    };

    final resp = await http.get(url, headers: headers);

    List<dynamic> respBody = json.decode(resp.body);

    final taskSuject = respBody.map((e) => Tasks.fromJson(e)).toList();
    tasksForSubject = [...taskSuject];
    notifyListeners();
    print(respBody);
  }

  // int statusCodes = 0;
  // update taks
  Future<String> updateTask(Tasks task) async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    final url = ConectionHost.myUrl('/api/tasks/${task.id}', {});

    status = true;
    notifyListeners();

    final resp =
        await http.put(url, headers: headers, body: json.encode(task.toJson()));

    Map<String, dynamic> respBody = json.decode(resp.body);

// error en el login  o en el servidor

    if (resp.statusCode == 401) {
      statusCode = 401;
      notifyListeners();
      return respBody['msg'];
    }
    if (resp.statusCode == 201) {
      // print(respBody);
      taskSelected = Tasks.fromJson(respBody['task']);
      upateListTaks(taskSelected);
      statusCodes = 201;
      status = false;
      notifyListeners();
    }
    status = false;
    notifyListeners();
    return respBody['msg'];
  }

  // update file

  // funcion para actualizar las tareas que se ha actualizado
  // task by status true

  void upateListTaks(Tasks task) {
    List<Tasks> newListTask = taskForStatusTrue.map((e) {
      if (e.id == task.id) {
        e = task;
      }
      return e;
    }).toList();
    taskForStatusTrue = newListTask;
    notifyListeners();
  }

  bool ts = false;

// funtion to filter tasks by subject
  Future filterTaskBySubject(String subjectId) async {
    ts = true;
    notifyListeners();

    taskBySubject = await newListsTasks(tasks, subjectId);
    ts = false;
    notifyListeners();
  }

  Future<List<Tasks?>> newListsTasks(
      List<Tasks> tasks, String subjectId) async {
    List<Tasks?> newListTasks = tasks
        .map((e) {
          if (e.subject.uid == subjectId) {
            return e;
          }
          // return e;
        })
        .where((element) => element != null)
        .toList();

    return newListTasks;
  }
}
