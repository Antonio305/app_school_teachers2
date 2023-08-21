// To parse this JSON data, do
//
//     final ratings = ratingsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class StudentByGrades {
  String id;
  StudentGrades student;
  String group;
  String semestre;
  String subject;
  double parcial1;
  double parcial2;
  double parcial3;
  double semesterGrade;
  int v;

  StudentByGrades({
    required this.id,
    required this.student,
    required this.group,
    required this.semestre,
    required this.subject,
    required this.parcial1,
    required this.parcial2,
    required this.parcial3,
    required this.semesterGrade,
    required this.v,
  });

  factory StudentByGrades.fromRawJson(String str) =>
      StudentByGrades.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentByGrades.fromJson(Map<String, dynamic> json) =>
      StudentByGrades(
        id: json["_id"],
        student: StudentGrades.fromJson(json["student"]),
        group: json["group"],
        semestre: json["semestre"],
        subject: json["subject"],
        parcial1: json["parcial1"].toDouble(),
        parcial2: json["parcial2"].toDouble(),
        parcial3: json["parcial3"].toDouble(),
        semesterGrade: json["semesterGrade"]?.toDouble(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "student": student.toJson(),
        "group": group,
        "semestre": semestre,
        "subject": subject,
        "parcial1": parcial1,
        "parcial2": parcial2,
        "parcial3": parcial3,
        "semesterGrade": semesterGrade,
        "__v": v,
      };
}

class StudentGrades {
  StudentsTutor studentTutor;
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
  String group;
  List<String> semestre;
  List<String> subjects;
  String generation;
  String tuition;
  String uid;

  StudentGrades({
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

  factory StudentGrades.fromRawJson(String str) =>
      StudentGrades.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentGrades.fromJson(Map<String, dynamic> json) => StudentGrades(
        studentTutor: StudentsTutor.fromJson(json["student_tutor"]),
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
        group: json["group"],
        semestre: List<String>.from(json["semestre"].map((x) => x)),
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        generation: json["generation"],
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
        "group": group,
        "semestre": List<dynamic>.from(semestre.map((x) => x)),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "generation": generation,
        "tuition": tuition,
        "uid": uid,
      };
}

class StudentsTutor {
  String nameTutor;
  String lastNameTutor;
  String secondNameTutor;
  String kinship;
  int numberPhoneTutor;

  StudentsTutor({
    required this.nameTutor,
    required this.lastNameTutor,
    required this.secondNameTutor,
    required this.kinship,
    required this.numberPhoneTutor,
  });

  factory StudentsTutor.fromRawJson(String str) =>
      StudentsTutor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentsTutor.fromJson(Map<String, dynamic> json) => StudentsTutor(
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
