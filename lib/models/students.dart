// // Postman Echo is service you can use to test your REST clients and make sample API calls.
// // It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility
// // endpoints.
// //
// // The documentation for the endpoints as well as example responses can be found at
// // [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)
// // To parsrequirede this JSON data, do
// //
// //     final student = studentFromMap(jsonString);

// import 'dart:convert';

// class Student {
//     Student({
//       required  this.studentTutor,
//       required  this.name,
//       required  this.lastName,
//       required  this.secondName,
//       required  this.gender,
//       required  this.dateOfBirth,
//       required  this.bloodGrade,
//       required  this.curp,
//       required  this.age,
//       required  this.town,
//       required  this.numberPhone,
//       required  this.status,
//       required  this.rol,
//       required  this.group,
//       required  this.semestre,
//       required  this.subjects,
//       required  this.generation,
//         this.uid,
//     });

//     StudentTutor studentTutor;
//     String name;
//     String lastName;
//     String secondName;
//     String gender;
//     DateTime dateOfBirth;
//     String bloodGrade;
//     String curp;
//     int age;
//     String town;
//     int numberPhone;
//     bool status;
//     String rol;
//     Group group;
//     List<Semestre> semestre;
//     List<Subjects> subjects;
//     Generation generation;
//     String? uid;

//     factory Student.fromJson(String str) => Student.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Student.fromMap(Map<String, dynamic> json) => Student(
//         studentTutor: StudentTutor.fromMap(json["student_tutor"]),
//         name: json["name"],
//         lastName: json["lastName"],
//         secondName: json["secondName"],
//         gender: json["gender"],
//         dateOfBirth: DateTime.parse(json["dateOfBirth"]),
//         bloodGrade: json["bloodGrade"],
//         curp: json["curp"],
//         age: json["age"],
//         town: json["town"],
//         numberPhone: json["numberPhone"],
//         status: json["status"],
//         rol: json["rol"],
//         group: Group.fromMap(json["group"]),
//         semestre: List<Semestre>.from(json["semestre"].map((x) => Semestre.fromMap(x))),
//         subjects: List<Subjects>.from(json["subjects"].map((x) => Subjects.fromMap(x))),
//         generation: Generation.fromMap(json["generation"]),
//         uid: json["uid"],
//     );

//     Map<String, dynamic> toMap() => {
//         "student_tutor": studentTutor.toMap(),
//         "name": name,
//         "lastName": lastName,
//         "secondName": secondName,
//         "gender": gender,
//         "dateOfBirth": dateOfBirth.toIso8601String(),
//         "bloodGrade": bloodGrade,
//         "curp": curp,
//         "age": age,
//         "town": town,
//         "numberPhone": numberPhone,
//         "status": status,
//         "rol": rol,
//         "group": group.toMap(),
//         "semestre": List<dynamic>.from(semestre.map((x) => x.toMap())),
//         "subjects": List<dynamic>.from(subjects.map((x) => x.toMap())),
//         "generation": generation.toMap(),
//         "uid": uid,
//     };
// }

// class Generation {
//     Generation({
//       required  this.id,
//       required  this.initialDate,
//       required  this.finalDate,
//     });

//     String id;
//     DateTime initialDate;
//     DateTime finalDate;

//     factory Generation.fromJson(String str) => Generation.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Generation.fromMap(Map<String, dynamic> json) => Generation(
//         id: json["_id"],
//         initialDate: DateTime.parse(json["initialDate"]),
//         finalDate: DateTime.parse(json["finalDate"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "_id": id,
//         "initialDate": initialDate.toIso8601String(),
//         "finalDate": finalDate.toIso8601String(),
//     };
// }

// class Group {
//     Group({
//       required  this.id,
//       required  this.name,
//       required  this.adviser,
//       required  this.tutor,
//     });

//     String id;
//     String name;
//     String adviser;
//     String tutor;
//     int? v;

//     factory Group.fromJson(String str) => Group.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Group.fromMap(Map<String, dynamic> json) => Group(
//         id: json["_id"],
//         name: json["name"],
//         adviser: json["adviser"],
//         tutor: json["tutor"],
//     );

//     Map<String, dynamic> toMap() => {
//         "_id": id,
//         "name": name,
//         "adviser": adviser,
//         "tutor": tutor,
//     };
// }

// class Semestre {
//     Semestre({
//       required  this.id,
//       required  this.name,
//       required  this.periodic,
//       required  this.initialDate,
//       required  this.endDate,
//       required  this.v,
//     });

//     String id;
//     String name;
//     String periodic;
//     DateTime initialDate;
//     DateTime endDate;
//     int v;

//     factory Semestre.fromJson(String str) => Semestre.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Semestre.fromMap(Map<String, dynamic> json) => Semestre(
//         id: json["_id"],
//         name: json["name"],
//         periodic: json["periodic"],
//         initialDate: DateTime.parse(json["initial_date"]),
//         endDate: DateTime.parse(json["end_date"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toMap() => {
//         "_id": id,
//         "name": name,
//         "periodic": periodic,
//         "initial_date": initialDate.toIso8601String(),
//         "end_date": endDate.toIso8601String(),
//         "__v": v,
//     };
// }

// class StudentTutor {
//     StudentTutor({
//       required  this.nameTutor,
//       required  this.lastNameTutor,
//       required  this.secondNameTutor,
//       required  this.kinship,
//       required  this.numberPhoneTutor,
//     });

//     String nameTutor;
//     String lastNameTutor;
//     String secondNameTutor;
//     String kinship;
//     int numberPhoneTutor;

//     factory StudentTutor.fromJson(String str) => StudentTutor.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory StudentTutor.fromMap(Map<String, dynamic> json) => StudentTutor(
//         nameTutor: json["nameTutor"],
//         lastNameTutor: json["lastNameTutor"],
//         secondNameTutor: json["secondNameTutor"],
//         kinship: json["kinship"],
//         numberPhoneTutor: json["numberPhoneTutor"],
//     );

//     Map<String, dynamic> toMap() => {
//         "nameTutor": nameTutor,
//         "lastNameTutor": lastNameTutor,
//         "secondNameTutor": secondNameTutor,
//         "kinship": kinship,
//         "numberPhoneTutor": numberPhoneTutor,
//     };
// }

// class Subjects {
//     Subjects({
//       required  this.id,
//       required  this.name,
//       required  this.teachers,
//       required  this.semestre,
//       required  this.v,
//     });

//     String id;
//     String name;
//     String teachers;
//     String semestre;
//     int v;

//     factory Subjects.fromJson(String str) => Subjects.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Subjects.fromMap(Map<String, dynamic> json) => Subjects(
//         id: json["_id"],
//         name: json["name"],
//         teachers: json["teachers"],
//         semestre: json["semestre"],
//         v: json["__v"],
//     );

//     Map<String, dynamic> toMap() => {
//         "_id": id,
//         "name": name,
//         "teachers": teachers,
//         "semestre": semestre,
//         "__v": v,
//     };
// }
