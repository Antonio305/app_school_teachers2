import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

class NewTask {
  String nameTask;
  String description;
  String subject;
  String? semestre;
  String group;
  String nameSubject;

  //fecha de entrega de la tarea
  DateTime date;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<XFile>? xlistFile; //  how user windows
  List<File>? listFileTwo; // how user phone
  NewTask(
      {required this.nameTask,
      required this.description,
      required this.subject,
      this.semestre,
      required this.group,
      required this.nameSubject,
      required this.date,
      this.createdAt,
      this.updatedAt,
      this.xlistFile,
      this.listFileTwo});

  factory NewTask.fronMap(Map<String, dynamic> json) {
    return NewTask(
      nameTask: json['nameTask'],
      description: json['description'],
      subject: json['subject'],
      semestre: json['semestre'],
      group: json['group'],
      nameSubject: json['nameSubject'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      xlistFile: json['xlistFile'] ?? [],
      listFileTwo: json['listFileTwo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameTask': nameTask,
      'description': description,
      'subject': subject,
      'semestre': semestre,
      'group': group,
      'nameSubject': nameSubject,
      'date': date.toIso8601String(),
    };
  }

  List<XFile>? get listFile => xlistFile;
  List<File>? get listFile2 => listFileTwo;
}
