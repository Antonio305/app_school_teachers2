

import 'dart:convert';

import 'package:preppa_profesores/models/student.dart';


class Ratings {
  Ratings({
    this.id,
    // this.idStudent,
    required this.student,
    required this.group,
    required this.semestre,
    required this.subject,
    required this.parcial1,
    required this.parcial2,
    required this.parcial3,
    required this.semesterGrade,
    this.v,
  });

  String? id;
  // String? idStudent;
  // Students student;
  String student;
  String group;
  String semestre;
  String subject;
  double parcial1;
  double parcial2;
  double semesterGrade;
  double parcial3;
  int? v;

  factory Ratings.fromJson(String str) => Ratings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ratings.fromMap(Map<String, dynamic> json) => Ratings(
        id: json["_id"],
        student: json["student"],
        group: json["group"],
        semestre: json["semestre"],
        subject: json["subject"],
        parcial1: json["parcial1"].toDouble(),
        parcial2: json["parcial2"].toDouble(),
        parcial3: json["parcial3"].toDouble(),
        semesterGrade: json['semesterGrade'].toDouble(),
        v: json["__v"],
      );

  // esto se enviaren el json

  Map<String, dynamic> toMap() => {
        // "_id": id,
        
        "student": student,
        "group": group,
        "semestre": semestre,
        "subject": subject,
        "parcial1": parcial1,
        "parcial2": parcial2,
        "parcial3": parcial3,
        "semesterGrade": semesterGrade,
        // "__v": v,
      };
}
