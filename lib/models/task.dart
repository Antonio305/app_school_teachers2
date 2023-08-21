// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Tasks {
    String id;
    Group subject;
    String nameTask;
    String description;
    bool status;
    Group group;
    DateTime createdAt;
    DateTime expiredAt;
    UserTeacher userTeacher;
    int v;
    String? archivos;

    Tasks({
        required this.id,
        required this.subject,
        required this.nameTask,
        required this.description,
        required this.status,
        required this.group,
        required this.createdAt,
        required this.expiredAt,
        required this.userTeacher,
        required this.v,
         this.archivos,
    });

    factory Tasks.fromRawJson(String str) => Tasks.fromJson(json.decode(str));

    String Json() => json.encode(toJson());

    factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        id: json["_id"],
        subject: Group.fromJson(json["subject"]),
        nameTask: json["nameTask"],
        description: json["description"],
        status: json["status"],
        group: Group.fromJson(json["group"]),
        createdAt: DateTime.parse(json["createdAt"]),
        expiredAt: DateTime.parse(json["expiredAt"]),
        userTeacher: UserTeacher.fromJson(json["userTeacher"]),
        v: json["__v"],
        archivos: json["archivos"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "subject": subject.toJson(),
        "nameTask": nameTask,
        "description": description,
        "status": status,
        "group": group.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "expiredAt": expiredAt.toIso8601String(),
        "userTeacher": userTeacher.toJson(),
        "__v": v,
        "archivos": archivos,
    };
}

class Group {
    String name;
    String uid;

    Group({
        required this.name,
        required this.uid,
    });

    factory Group.fromRawJson(String str) => Group.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        name: json["name"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
    };
}

class UserTeacher {
    String name;
    String lastName;
    String secondName;
    String collegeDegree;
    String uid;

    UserTeacher({
        required this.name,
        required this.lastName,
        required this.secondName,
        required this.collegeDegree,
        required this.uid,
    });

    factory UserTeacher.fromRawJson(String str) => UserTeacher.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserTeacher.fromJson(Map<String, dynamic> json) => UserTeacher(
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        collegeDegree: json["collegeDegree"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "collegeDegree": collegeDegree,
        "uid": uid,
    };
}
