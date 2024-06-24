// To parse this JSON data, do
//
//     final taskReceived = taskReceivedFromJson(jsonString);

import 'dart:convert';

class TaskReceived {
  TaskReceived(
      {this.id,
      required this.task,
      required this.student,
      required this.rating,
      required this.isQualified,
      this.comments,
      required this.subject,
      required this.v,
      this.archivos,
      required this.createdAt,
      required this.updatedAt});

  String? id;
  TaskReceiveds task;
  TaskStudent student;
  double rating;
  bool isQualified;
  String? comments;
  Subject subject;
  int v;
  List<dynamic>? archivos;
  // para saber la fecha de entrega
  // DateTime? createdAt;
  DateTime createdAt;
  DateTime updatedAt;

  String get nameLastNameStudent => "${student.name} ${student.lastName}";
    String get nameLastNameStudentSecondName => "${student.name} ${student.lastName} ${student.secondName}";


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
        subject: Subject.fromJson(json['subject']),
        v: json["__v"],
        archivos: json["archivos"],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "task": task.toJson(),
        "student": student.toJson(),
        "rating": rating,
        "isQualified": isQualified,
        "comments": comments,
        "subject": subject,
        "__v": v,
        "archivos": archivos,
      };

  TaskReceived copyWith() {
    return TaskReceived(
        id: id,
        task: task,
        student: student,
        rating: rating,
        isQualified: isQualified,
        comments: comments,
        subject: subject,
        archivos: archivos,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v);
  }

  String get deliveryDate => createdAt.toString().substring(0, 10);
  String get studentName =>
      "${student.name} ${student.lastName}  ${student.secondName}";
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
  List<dynamic>? archivos;

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

class Subject {
  String name;
  String uid;

  Subject({
    required this.name,
    required this.uid,
  });

  Subject copyWith({
    String? name,
    String? uid,
  }) =>
      Subject(
        name: name ?? this.name,
        uid: uid ?? this.uid,
      );

  factory Subject.fromRawJson(String str) => Subject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        name: json["name"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
      };
}
