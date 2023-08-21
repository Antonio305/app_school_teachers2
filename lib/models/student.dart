import 'dart:convert';

class Students {
  Students({
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
    required this.tuition,
    this.password,
    required this.status,
    required this.rol,
     this.group,
     this.semestre,
     this.subjects,
    this.generation,
    required this.uid,
  });

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
  String tuition;
  String? password;
  bool status;
  String rol;
  Group? group;
  List<Semestre>? semestre;
  List<Subject>? subjects;
  Generation? generation;
  String uid;

  factory Students.fromJson(String str) => Students.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Students.fromMap(Map<String, dynamic> json) => Students(
        studentTutor: StudentTutor.fromMap(json["student_tutor"]),
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
        tuition: json["tuition"],
        password: json["password"],
        status: json["status"],
        rol: json["rol"],
        group: Group.fromMap(json["group"]),
        semestre: List<Semestre>.from(
            json["semestre"].map((x) => Semestre.fromMap(x))),
        subjects:
            List<Subject>.from(json["subjects"].map((x) => Subject.fromMap(x))),
        generation: Generation.fromMap(json["generation"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "student_tutor": studentTutor.toMap(),
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
        "tuition": tuition,
        "password": password,
        "status": status,
        "rol": rol,
        "group": group!.toMap(),
        "semestre": List<dynamic>.from(semestre!.map((x) => x.toMap())),
        "subjects": List<dynamic>.from(subjects!.map((x) => x.toMap())),
        "generation": generation!.toMap(),
        "uid": uid,
      };
}

class Generation {
  Generation({
    required this.id,
    required this.initialDate,
    required this.finalDate,
    required this.v,
  });

  String id;
  DateTime initialDate;
  DateTime finalDate;
  int v;

  factory Generation.fromJson(String str) =>
      Generation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Generation.fromMap(Map<String, dynamic> json) => Generation(
        id: json["_id"],
        initialDate: DateTime.parse(json["initialDate"]),
        finalDate: DateTime.parse(json["finalDate"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
        "__v": v,
      };
}

class Group {
  Group({
    required this.id,
    required this.name,
    required this.adviser,
    required this.tutor,
    required this.v,
  });

  String id;
  String name;
  String adviser;
  String tutor;
  int v;

  factory Group.fromJson(String str) => Group.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Group.fromMap(Map<String, dynamic> json) => Group(
        id: json["_id"],
        name: json["name"],
        adviser: json["adviser"],
        tutor: json["tutor"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "adviser": adviser,
        "tutor": tutor,
        "__v": v,
      };
}

class Semestre {
  Semestre({
    required this.id,
    required this.name,
    required this.periodic,
    required this.cursando,
    required this.v,
  });

  String id;
  String name;
  String periodic;
  bool cursando;
  int v;

  factory Semestre.fromJson(String str) => Semestre.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Semestre.fromMap(Map<String, dynamic> json) => Semestre(
        id: json["_id"],
        name: json["name"],
        periodic: json["periodic"],
        cursando: json["cursando"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "periodic": periodic,
        "cursando": cursando,
        "__v": v,
      };
}

class StudentTutor {
  StudentTutor({
    required this.nameTutor,
    required this.lastNameTutor,
    required this.secondNameTutor,
    required this.kinship,
    required this.numberPhoneTutor,
  });

  String nameTutor;
  String lastNameTutor;
  String secondNameTutor;
  String kinship;
  int numberPhoneTutor;

  factory StudentTutor.fromJson(String str) =>
      StudentTutor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StudentTutor.fromMap(Map<String, dynamic> json) => StudentTutor(
        nameTutor: json["nameTutor"],
        lastNameTutor: json["lastNameTutor"],
        secondNameTutor: json["secondNameTutor"],
        kinship: json["kinship"],
        numberPhoneTutor: json["numberPhoneTutor"],
      );

  Map<String, dynamic> toMap() => {
        "nameTutor": nameTutor,
        "lastNameTutor": lastNameTutor,
        "secondNameTutor": secondNameTutor,
        "kinship": kinship,
        "numberPhoneTutor": numberPhoneTutor,
      };
}

class Subject {
  Subject({
    required this.id,
    required this.name,
    required this.teachers,
    required this.semestre,
    required this.v,
  });

  String id;
  String name;
  String teachers;
  String semestre;
  int v;

  factory Subject.fromJson(String str) => Subject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Subject.fromMap(Map<String, dynamic> json) => Subject(
        id: json["_id"],
        name: json["name"],
        teachers: json["teachers"],
        semestre: json["semestre"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "teachers": teachers,
        "semestre": semestre,
        "__v": v,
      };
}
