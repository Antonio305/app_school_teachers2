// To parse this JSON data, do
//
//     final subjects = subjectsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Subjects {
    String name;
    String teachers;
    Semestre semestre;
    String uid;

    Subjects({
        required this.name,
        required this.teachers,
        required this.semestre,
        required this.uid,
    });

    factory Subjects.fromRawJson(String str) => Subjects.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        name: json["name"],
        teachers: json["teachers"],
        semestre: Semestre.fromJson(json["semestre"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "teachers": teachers,
        "semestre": semestre.toJson(),
        "uid": uid,
    };
}

class Semestre {
    String id;
    String name;

    Semestre({
        required this.id,
        required this.name,
    });

    factory Semestre.fromRawJson(String str) => Semestre.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Semestre.fromJson(Map<String, dynamic> json) => Semestre(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}
