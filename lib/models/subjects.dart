// To parse this JSON data, do
//
//     final subjects = subjectsFromJson(jsonString);

import 'dart:convert';

class SubjectsResponse {
  String msg;
  Subjects materi;
  Syllaba syllaba;

  SubjectsResponse(
      {required this.msg, required this.materi, required this.syllaba});

  SubjectsResponse copyWith({
    String? msg,
    Subjects? materi,
    Syllaba? syllaba,
  }) =>
      SubjectsResponse(
          msg: msg ?? this.msg,
          materi: materi ?? this.materi,
          syllaba: syllaba ?? this.syllaba);

  factory SubjectsResponse.fromRawJson(String str) =>
      SubjectsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) =>
      SubjectsResponse(
        msg: json["msg"],
        materi: Subjects.fromJson(json["materi"]),
        syllaba: Syllaba.fromJson(json['syllaba']),
      );

  Map<String, dynamic> toJson() =>
      {"msg": msg, "materi": materi.toJson(), "syllaba": syllaba.toJson()};
}

class Subjects {
  Subjects subjectsFromJson(String str) => Subjects.fromJson(json.decode(str));

  String subjectsToJson(Subjects data) => json.encode(data.toJson());

  String description;
  String learningObjetive;
  List<ExamDate> examDate;
  String evaluationCriteria;
  String name;
  TeacherBySubjects teachers;
  Semestre semestre;
  List<Syllaba> syllabas;
  String uid;

  Subjects({
    required this.description,
    required this.learningObjetive,
    required this.examDate,
    required this.evaluationCriteria,
    required this.name,
    required this.teachers,
    required this.semestre,
    required this.syllabas,
    required this.uid,
  });

  Subjects copyWith({
    String? description,
    String? learningObjetive,
    List<ExamDate>? examDate,
    String? evaluationCriteria,
    String? name,
    TeacherBySubjects? teachers,
    Semestre? semestre,
    List<Syllaba>? syllabas,
    String? uid,
  }) =>
      Subjects(
        description: description ?? this.description,
        learningObjetive: learningObjetive ?? this.learningObjetive,
        examDate: examDate ?? this.examDate,
        evaluationCriteria: evaluationCriteria ?? this.evaluationCriteria,
        name: name ?? this.name,
        teachers: teachers ?? this.teachers,
        semestre: semestre ?? this.semestre,
        syllabas: syllabas ?? this.syllabas,
        uid: uid ?? this.uid,
      );

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        description: json["description"] ?? '',
        learningObjetive: json["learningObjetive"],
        examDate: List<ExamDate>.from(
            json["examDate"].map((x) => ExamDate.fromJson(x))),
        evaluationCriteria: json['evaluationCriteria'],
        name: json["name"],
        teachers: TeacherBySubjects.fromJson(json["teachers"]),
        semestre: Semestre.fromJson(json["semestre"]),
        syllabas: List<Syllaba>.from(
            json["syllabas"].map((x) => Syllaba.fromJson(x))),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "learningObjetive": learningObjetive,
        "examDate": List<dynamic>.from(examDate.map((x) => x.toJson())),
        'evaluationCriteria': evaluationCriteria,
        "name": name,
        "teachers": teachers.toJson(),
        "semestre": semestre.toJson(),
        "syllabas": List<dynamic>.from(syllabas.map((x) => x)),
        "uid": uid,
      };
}

class ExamDate {
  String partial;
  DateTime date;
  String? id;

  ExamDate({
    required this.partial,
    required this.date,
     this.id,
  });

  ExamDate copyWith({
    String? partial,
    DateTime? date,
    String? id,
  }) =>
      ExamDate(
        partial: partial ?? this.partial,
        date: date ?? this.date,
        id: id ?? this.id,
      );

  factory ExamDate.fromRawJson(String str) =>
      ExamDate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExamDate.fromJson(Map<String, dynamic> json) => ExamDate(
        partial: json["partial"],
        date: DateTime.parse(json["date"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "partial": partial,
        "date": date.toIso8601String(),
        "_id": id,
      };
}

class Syllaba {
  String partial;
  String topicsOfPartialSubject;
  List<ListUnit> listUnits;

  Syllaba({
    required this.partial,
    required this.topicsOfPartialSubject,
    required this.listUnits,
  });

  Syllaba copyWith({
    String? partial,
    String? topicsOfPartialSubject,
    List<ListUnit>? listUnits,
  }) =>
      Syllaba(
        partial: partial ?? this.partial,
        topicsOfPartialSubject:
            topicsOfPartialSubject ?? this.topicsOfPartialSubject,
        listUnits: listUnits ?? this.listUnits,
      );

  factory Syllaba.fromRawJson(String str) => Syllaba.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Syllaba.fromJson(Map<String, dynamic> json) => Syllaba(
        partial: json["partial"],
        topicsOfPartialSubject: json["topicsOfPartialSubject"],
        listUnits: List<ListUnit>.from(
            json["listUnits"].map((x) => ListUnit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partial": partial,
        "topicsOfPartialSubject": topicsOfPartialSubject,
        "listUnits": List<dynamic>.from(listUnits.map((x) => x.toJson())),
      };
}

class ListUnit {
  int unitNumber;
  List<UnitTheme> unitThemes;

  ListUnit({
    required this.unitNumber,
    required this.unitThemes,
  });

  ListUnit copyWith({
    int? unitNumber,
    List<UnitTheme>? unitThemes,
  }) =>
      ListUnit(
        unitNumber: unitNumber ?? this.unitNumber,
        unitThemes: unitThemes ?? this.unitThemes,
      );

  factory ListUnit.fromRawJson(String str) =>
      ListUnit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListUnit.fromJson(Map<String, dynamic> json) => ListUnit(
        unitNumber: json["unitNumber"],
        unitThemes: List<UnitTheme>.from(
            json["unitThemes"].map((x) => UnitTheme.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "unitNumber": unitNumber,
        "unitThemes": List<dynamic>.from(unitThemes.map((x) => x.toJson())),
      };
}

class UnitTheme {
  Topics topics;

  UnitTheme({
    required this.topics,
  });

  UnitTheme copyWith({
    Topics? topics,
  }) =>
      UnitTheme(
        topics: topics ?? this.topics,
      );

  factory UnitTheme.fromRawJson(String str) =>
      UnitTheme.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnitTheme.fromJson(Map<String, dynamic> json) => UnitTheme(
        topics: Topics.fromJson(json["topics"]),
      );

  Map<String, dynamic> toJson() => {
        "topics": topics.toJson(),
      };
}

class Topics {
  String themeName;
  List<String> subtopics;

  Topics({
    required this.themeName,
    required this.subtopics,
  });

  Topics copyWith({
    String? themeName,
    List<String>? subtopics,
  }) =>
      Topics(
        themeName: themeName ?? this.themeName,
        subtopics: subtopics ?? this.subtopics,
      );

  factory Topics.fromRawJson(String str) => Topics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Topics.fromJson(Map<String, dynamic> json) => Topics(
        themeName: json["themeName"],
        subtopics: List<String>.from(json["subtopics"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "themeName": themeName,
        "subtopics": List<dynamic>.from(subtopics.map((x) => x)),
      };
}

class Semestre {
  String id;
  String name;

  Semestre({
    required this.id,
    required this.name,
  });

  Semestre copyWith({
    String? id,
    String? name,
  }) =>
      Semestre(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Semestre.fromJson(Map<String, dynamic> json) => Semestre(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class TeacherBySubjects {
  String id;
  String name;
  String lastName;
  String secondName;
  String gender;
  String collegeDegree;
  String typeContract;
  bool status;
  String rol;
  String tuition;

  TeacherBySubjects({
    required this.id,
    required this.name,
    required this.lastName,
    required this.secondName,
    required this.gender,
    required this.collegeDegree,
    required this.typeContract,
    required this.status,
    required this.rol,
    required this.tuition,
  });

  TeacherBySubjects copyWith({
    String? id,
    String? name,
    String? lastName,
    String? secondName,
    String? gender,
    String? collegeDegree,
    String? typeContract,
    bool? status,
    String? rol,
    String? tuition,
  }) =>
      TeacherBySubjects(
        id: id ?? this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        secondName: secondName ?? this.secondName,
        gender: gender ?? this.gender,
        collegeDegree: collegeDegree ?? this.collegeDegree,
        typeContract: typeContract ?? this.typeContract,
        status: status ?? this.status,
        rol: rol ?? this.rol,
        tuition: tuition ?? this.tuition,
      );

  factory TeacherBySubjects.fromJson(Map<String, dynamic> json) =>
      TeacherBySubjects(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        gender: json["gender"],
        collegeDegree: json["collegeDegree"],
        typeContract: json["typeContract"],
        status: json["status"],
        rol: json["rol"],
        tuition: json["tuition"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "gender": gender,
        "collegeDegree": collegeDegree,
        "typeContract": typeContract,
        "status": status,
        "rol": rol,
        "tuition": tuition,
      };
}
