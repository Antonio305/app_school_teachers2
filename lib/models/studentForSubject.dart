// To parse this JSON data, do
//
//     final studentForSubject = studentForSubjectFromJson(jsonString);

import 'dart:convert';

class StudentForSubject {
  String name;
  String lastName;
  String secondName;
  Group group;
  String generation;
  List<Group> semestre;
  String uid;

  StudentForSubject({
    required this.name,
    required this.lastName,
    required this.secondName,
    required this.group,
    required this.generation,
    required this.semestre,
    required this.uid,
  });

  factory StudentForSubject.fromRawJson(String str) =>
      StudentForSubject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentForSubject.fromJson(Map<String, dynamic> json) =>
      StudentForSubject(
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        group: Group.fromJson(json["group"]),
        generation: json['generation'],
        semestre:
            List<Group>.from(json["semestre"].map((x) => Group.fromJson(x))),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "group": group.toJson(),
        'generation': generation,
        "semestre": List<dynamic>.from(semestre.map((x) => x.toJson())),
        "uid": uid,
      };

  String get nameStudent => "$name $lastName $secondName";
  String get initilNameStudent =>
      "${name.substring(0, 1)} ${lastName.substring(0, 1)}";
}

class Group {
  String id;
  String name;

  Group({
    required this.id,
    required this.name,
  });

  factory Group.fromRawJson(String str) => Group.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
