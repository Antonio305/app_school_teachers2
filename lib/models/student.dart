import 'dart:convert';

class StudentResponse {
  String msg;
  List<Student> student;

  StudentResponse({
    required this.msg,
    required this.student,
  });

  StudentResponse copyWith({
    String? msg,
    List<Student>? student,
  }) =>
      StudentResponse(
        msg: msg ?? this.msg,
        student: student ?? this.student,
      );

  factory StudentResponse.fromRawJson(String str) =>
      StudentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentResponse.fromJson(Map<String, dynamic> json) =>
      StudentResponse(
        msg: json["msg"],
        student:
            List<Student>.from(json["student"].map((x) => Student.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "student": List<dynamic>.from(student.map((x) => x.toJson())),
      };
}

class Student {
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
  String password;
  bool status;
  String rol;
  Group group;
  List<Group> semestre;
  List<Group> subjects;
  Generation generation;
  String tuition;
  String kindOfLow;
  DateTime updatedAt;
  String email;
  String specialtyArea;
  bool isGraduate;
  String uid;

  Student({
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
    required this.password,
    required this.status,
    required this.rol,
    required this.group,
    required this.semestre,
    required this.subjects,
    required this.generation,
    required this.tuition,
    required this.kindOfLow,
    required this.updatedAt,
    required this.email,
    required this.specialtyArea,
    required this.isGraduate,
    required this.uid,
  });

  Student copyWith({
    StudentTutor? studentTutor,
    String? name,
    String? lastName,
    String? secondName,
    String? gender,
    DateTime? dateOfBirth,
    String? bloodGrade,
    String? curp,
    int? age,
    String? town,
    int? numberPhone,
    String? password,
    bool? status,
    String? rol,
    Group? group,
    List<Group>? semestre,
    List<Group>? subjects,
    Generation? generation,
    String? tuition,
    String? kindOfLow,
    DateTime? updatedAt,
    String? email,
    String? specialtyArea,
    bool? isGraduate,
    String? uid,
  }) =>
      Student(
        studentTutor: studentTutor ?? this.studentTutor,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        secondName: secondName ?? this.secondName,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        bloodGrade: bloodGrade ?? this.bloodGrade,
        curp: curp ?? this.curp,
        age: age ?? this.age,
        town: town ?? this.town,
        numberPhone: numberPhone ?? this.numberPhone,
        password: password ?? this.password,
        status: status ?? this.status,
        rol: rol ?? this.rol,
        group: group ?? this.group,
        semestre: semestre ?? this.semestre,
        subjects: subjects ?? this.subjects,
        generation: generation ?? this.generation,
        tuition: tuition ?? this.tuition,
        kindOfLow: kindOfLow ?? this.kindOfLow,
        updatedAt: updatedAt ?? this.updatedAt,
        email: email ?? this.email,
        specialtyArea: specialtyArea ?? this.specialtyArea,
        isGraduate: isGraduate ?? this.isGraduate,
        uid: uid ?? this.uid,
      );

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
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
        password: json["password"],
        status: json["status"],
        rol: json["rol"],
        group: Group.fromJson(json["group"]),
        semestre:
            List<Group>.from(json["semestre"].map((x) => Group.fromJson(x))),
        subjects:
            List<Group>.from(json["subjects"].map((x) => Group.fromJson(x))),
        generation: Generation.fromJson(json["generation"]),
        tuition: json["tuition"],
        kindOfLow: json["kindOfLow"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        email: json["email"] ?? '',
        specialtyArea: json["specialtyArea"],
        isGraduate: json["isGraduate"],
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
        "password": password,
        "status": status,
        "rol": rol,
        "group": group.toJson(),
        "semestre": List<dynamic>.from(semestre.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
        "generation": generation.toJson(),
        "tuition": tuition,
        "kindOfLow": kindOfLow,
        "updatedAt": updatedAt.toIso8601String(),
        "email": email,
        "specialtyArea": specialtyArea,
        "isGraduate": isGraduate,
        "uid": uid,
      };

      String get nameStudent => '$name  $lastName $secondName';
            String get nameInitial => '${name.substring(0,1)}${lastName.substring(0,1)}';

}

class Generation {
  String id;
  DateTime initialDate;
  DateTime finalDate;
  int v;

  Generation({
    required this.id,
    required this.initialDate,
    required this.finalDate,
    required this.v,
  });

  Generation copyWith({
    String? id,
    DateTime? initialDate,
    DateTime? finalDate,
    int? v,
  }) =>
      Generation(
        id: id ?? this.id,
        initialDate: initialDate ?? this.initialDate,
        finalDate: finalDate ?? this.finalDate,
        v: v ?? this.v,
      );

  factory Generation.fromRawJson(String str) =>
      Generation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Generation.fromJson(Map<String, dynamic> json) => Generation(
        id: json["_id"],
        initialDate: DateTime.parse(json["initialDate"]),
        finalDate: DateTime.parse(json["finalDate"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
        "__v": v,
      };

      String get generation => '${initialDate.toString().substring(0,4)} - ${finalDate.toString().substring(0,4)}';
}

class Group {
  String id;
  String name;

  Group({
    required this.id,
    required this.name,
  });

  Group copyWith({
    String? id,
    String? name,
  }) =>
      Group(
        id: id ?? this.id,
        name: name ?? this.name,
      );

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

  StudentTutor copyWith({
    String? nameTutor,
    String? lastNameTutor,
    String? secondNameTutor,
    String? kinship,
    int? numberPhoneTutor,
  }) =>
      StudentTutor(
        nameTutor: nameTutor ?? this.nameTutor,
        lastNameTutor: lastNameTutor ?? this.lastNameTutor,
        secondNameTutor: secondNameTutor ?? this.secondNameTutor,
        kinship: kinship ?? this.kinship,
        numberPhoneTutor: numberPhoneTutor ?? this.numberPhoneTutor,
      );

  factory StudentTutor.fromRawJson(String str) =>
      StudentTutor.fromJson(json.decode(str));

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

      String get tutorName => '$nameTutor $lastNameTutor';
}
