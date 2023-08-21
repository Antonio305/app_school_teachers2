// To parse this JSON data, do
//
//     final taskReceived = taskReceivedFromJson(jsonString);

import 'dart:convert';

class TaskReceived {
  TaskReceived({
     this.id,
    required this.task,
    required this.student,
    required this.rating,
    required this.isQualified,
    this.comments,
    required this.v,
    this.archivos,
  });

  String? id;
  TaskReceiveds task;
  TaskStudent student;
  double rating;
  bool isQualified;
  String? comments;
  int v;
  String? archivos;

  factory TaskReceived.fromRawJson(String str) =>
      TaskReceived.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskReceived.fromJson(Map<String, dynamic> json) => TaskReceived(
        id: json["_id"],
        task: TaskReceiveds.fromJson(json["task"]),
        student: TaskStudent.fromJson(json["student"]),
        rating: json["rating"].toDouble(),
        // rating: double.parse(json["rating"]),
        isQualified: json["isQualified"],
        comments: json["comments"],
        v: json["__v"],
        archivos: json["archivos"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "task": task.toJson(),
        "student": student.toJson(),
        "rating": rating,
        "isQualified": isQualified,
        "comments": comments,
        "__v": v,
        "archivos": archivos,
      };
}

class TaskStudent {
  TaskStudent({
    required this.name,
    required this.lastName,
    required this.secondName,
    required this.uid,
  });

  String name;
  String lastName;
  String secondName;
  String uid;

  factory TaskStudent.fromRawJson(String str) =>
      TaskStudent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskStudent.fromJson(Map<String, dynamic> json) => TaskStudent(
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "uid": uid,
      };
}

class TaskReceiveds {
  TaskReceiveds({
    required this.id,
    required this.subject,
    required this.nameTask,
    required this.description,
    required this.status,
    required this.group,
    required this.userTeacher,
    required this.v,
     this.archivos,
  });

  String id;
  String subject;
  String nameTask;
  String description;
  bool status;
  String group;
  String userTeacher;
  int v;
  String? archivos;

  factory TaskReceiveds.fromRawJson(String str) =>
      TaskReceiveds.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskReceiveds.fromJson(Map<String, dynamic> json) => TaskReceiveds(
        id: json["_id"],
        subject: json["subject"],
        nameTask: json["nameTask"],
        description: json["description"],
        status: json["status"],
        group: json["group"],
        userTeacher: json["userTeacher"],
        v: json["__v"],
        archivos: json["archivos"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subject": subject,
        "nameTask": nameTask,
        "description": description,
        "status": status,
        "group": group,
        "userTeacher": userTeacher,
        "__v": v,
        "archivos": archivos,
      };
}
