// To parse this JSON data, do
//
//     final adviserTutor = adviserTutorFromJson(jsonString);

import 'dart:convert';

class AdviserTutor {
  AdviserTutor({
    required this.id,
    required this.group,
    required this.semestre,
    required this.generation,
    required this.adviser,
    required this.tutor,
    required this.status,
    required this.v,
  });

  String id;
  GroupAdviser group;
  GroupAdviser semestre;
  GenerationAdviser generation;
  String adviser;
  String tutor;
  bool status;
  int v;

  factory AdviserTutor.fromRawJson(String str) =>
      AdviserTutor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
 
  factory AdviserTutor.fromJson(Map<String, dynamic> json) => AdviserTutor(
        id: json["_id"],
        group: GroupAdviser.fromJson(json["group"]),
        semestre: GroupAdviser.fromJson(json["semestre"]),
        generation:
            GenerationAdviser.fromJson(json["generation"]),
        adviser: json["adviser"],
        tutor: json["tutor"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "group": group.toJson(),
        "semestre": semestre.toJson(),
        "generation": generation.toJson(),
        "adviser": adviser,
        "tutor": tutor,
        "status": status,
        "__v": v,
      };
}

class GenerationAdviser {
  GenerationAdviser({
    required this.initialDate,
    required this.finalDate,
    required this.uid,
  });

  DateTime initialDate;
  DateTime finalDate;
  String uid;

  factory GenerationAdviser.fromRawJson(String str) =>
      GenerationAdviser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenerationAdviser.fromJson(Map<String, dynamic> json) =>
      GenerationAdviser(
        initialDate: DateTime.parse(json["initialDate"]),
        finalDate: DateTime.parse(json["finalDate"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
        "uid": uid,
      };
}

class GroupAdviser {
  GroupAdviser({
    required this.name,
    required this.uid,
  });

  String name;
  String uid;

  factory GroupAdviser.fromRawJson(String str) =>
      GroupAdviser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupAdviser.fromJson(Map<String, dynamic> json) => GroupAdviser(
        name: json["name"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
      };
}
