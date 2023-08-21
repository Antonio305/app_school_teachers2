// To parse this JSON data, do
//
//     final studentAdviser = studentAdviserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class StudentAdviser {
    StudentTutor studentTutor;
    String name;
    String lastName;
    String secondName;
    String gender;
    DateTime dateOfBirth;
    String bloodGrade;
    String curp;
    int age;
    String town;
    int numberPhone;
    bool status;
    String rol;
    Group group;
    List<Semestre> semestre;
    List<Group> subjects;
    Generation generation;
    String tuition;
    String uid;

    StudentAdviser({
        required this.studentTutor,
        required this.name,
        required this.lastName,
        required this.secondName,
        required this.gender,
        required this.dateOfBirth,
        required this.bloodGrade,
        required this.curp,
        required this.age,
        required this.town,
        required this.numberPhone,
        required this.status,
        required this.rol,
        required this.group,
        required this.semestre,
        required this.subjects,
        required this.generation,
        required this.tuition,
        required this.uid,
    });

    factory StudentAdviser.fromRawJson(String str) => StudentAdviser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StudentAdviser.fromJson(Map<String, dynamic> json) => StudentAdviser(
        studentTutor: StudentTutor.fromJson(json["student_tutor"]),
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        bloodGrade: json["bloodGrade"],
        curp: json["curp"],
        age: json["age"],
        town: json["town"],
        numberPhone: json["numberPhone"],
        status: json["status"],
        rol: json["rol"],
        group: Group.fromJson(json["group"]),
        semestre: List<Semestre>.from(json["semestre"].map((x) => Semestre.fromJson(x))),
        subjects: List<Group>.from(json["subjects"].map((x) => Group.fromJson(x))),
        generation: Generation.fromJson(json["generation"]),
        tuition: json["tuition"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "student_tutor": studentTutor.toJson(),
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "gender": gender,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "bloodGrade": bloodGrade,
        "curp": curp,
        "age": age,
        "town": town,
        "numberPhone": numberPhone,
        "status": status,
        "rol": rol,
        "group": group.toJson(),
        "semestre": List<dynamic>.from(semestre.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
        "generation": generation.toJson(),
        "tuition": tuition,
        "uid": uid,
    };
}

class Generation {
    String id;
    DateTime initialDate;
    DateTime finalDate;

    Generation({
        required this.id,
        required this.initialDate,
        required this.finalDate,
    });

    factory Generation.fromRawJson(String str) => Generation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Generation.fromJson(Map<String, dynamic> json) => Generation(
        id: json["_id"],
        initialDate: DateTime.parse(json["initialDate"]),
        finalDate: DateTime.parse(json["finalDate"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
    };
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

class Semestre {
    String id;
    int v;

    Semestre({
        required this.id,
        required this.v,
    });

    factory Semestre.fromRawJson(String str) => Semestre.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Semestre.fromJson(Map<String, dynamic> json) => Semestre(
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "__v": v,
    };
}

class StudentTutor {
    String nameTutor;
    String lastNameTutor;
    String secondNameTutor;
    String kinship;
    int numberPhoneTutor;

    StudentTutor({
        required this.nameTutor,
        required this.lastNameTutor,
        required this.secondNameTutor,
        required this.kinship,
        required this.numberPhoneTutor,
    });

    factory StudentTutor.fromRawJson(String str) => StudentTutor.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StudentTutor.fromJson(Map<String, dynamic> json) => StudentTutor(
        nameTutor: json["nameTutor"],
        lastNameTutor: json["lastNameTutor"],
        secondNameTutor: json["secondNameTutor"],
        kinship: json["kinship"],
        numberPhoneTutor: json["numberPhoneTutor"],
    );

    Map<String, dynamic> toJson() => {
        "nameTutor": nameTutor,
        "lastNameTutor": lastNameTutor,
        "secondNameTutor": secondNameTutor,
        "kinship": kinship,
        "numberPhoneTutor": numberPhoneTutor,
    };
}
