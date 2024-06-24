// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

import 'package:preppa_profesores/models/task/tasks.dart';

class TaskResponse {
// para agrgar los dato de tipo String, la cual cons datos que vienen
// en el body del request

  factory TaskResponse.fromRawJson(String str) =>
      TaskResponse.fromMap(json.decode(str));

  String msg;
  List<Tasks>? task = [];

  // contructor
  TaskResponse({
    required this.msg,
    this.task,
  });

  // cntructor para mostrar los datos
  factory TaskResponse.fromMap(Map<String, dynamic> json) {
    return TaskResponse(
      msg: '',
      task: List<Tasks>.from(json['task'].map((task) => Tasks.fromJson(task))),
    );
  }
}
