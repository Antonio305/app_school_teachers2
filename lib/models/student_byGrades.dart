import 'dart:convert';

class StudentByGrades {
  String id;
  Student student;
  String group;
  String semestre;
  String subject;
  int parcial1;
  int parcial2;
  int parcial3;
  double semesterGrade;
  int v;
  DateTime updatedAt;
  String generation;

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
    required this.updatedAt,
    required this.generation,
  });

  StudentByGrades copyWith({
    String? id,
    Student? student,
    String? group,
    String? semestre,
    String? subject,
    int? parcial1,
    int? parcial2,
    int? parcial3,
    double? semesterGrade,
    int? v,
    DateTime? updatedAt,
    String? generation,
  }) =>
      StudentByGrades(
        id: id ?? this.id,
        student: student ?? this.student,
        group: group ?? this.group,
        semestre: semestre ?? this.semestre,
        subject: subject ?? this.subject,
        parcial1: parcial1 ?? this.parcial1,
        parcial2: parcial2 ?? this.parcial2,
        parcial3: parcial3 ?? this.parcial3,
        semesterGrade: semesterGrade ?? this.semesterGrade,
        v: v ?? this.v,
        updatedAt: updatedAt ?? this.updatedAt,
        generation: generation ?? this.generation,
      );

  factory StudentByGrades.fromRawJson(String str) =>
      StudentByGrades.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentByGrades.fromJson(Map<String, dynamic> json) =>
      StudentByGrades(
        id: json["_id"],
        student: Student.fromJson(json["student"]),
        group: json["group"],
        semestre: json["semestre"],
        subject: json["subject"],
        parcial1: json["parcial1"],
        parcial2: json["parcial2"],
        parcial3: json["parcial3"],
        semesterGrade: json["semesterGrade"]?.toDouble(),
        v: json["__v"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        generation: json["generation"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "student": student?.toJson(),
        "group": group,
        "semestre": semestre,
        "subject": subject,
        "parcial1": parcial1,
        "parcial2": parcial2,
        "parcial3": parcial3,
        "semesterGrade": semesterGrade,
        "__v": v,
        "updatedAt": updatedAt.toIso8601String(),
        "generation": generation,
      };
}

class Student {
  String name;
  String lastName;
  String secondName;
  String uid;

  Student({
    required this.name,
    required this.lastName,
    required this.secondName,
    required this.uid,
  });

  String get nameStudent => "$name $lastName $secondName";

  Student copyWith({
    String? name,
    String? lastName,
    String? secondName,
    String? uid,
  }) =>
      Student(
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        secondName: secondName ?? this.secondName,
        uid: uid ?? this.uid,
      );

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
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
