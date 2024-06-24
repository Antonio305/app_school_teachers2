import 'dart:convert';

class TeacherRegister {
  String name;
  String lastName;
  String secondName;
  String gender;
  String collegeDegree;
  String typeContract;
  bool status;
  String rol;
  String tuition;
  String email;
  String numberPhone;
  String? tokenFcm;
  DateTime? updatedAt;
  String userLogin;
  String uid;

  TeacherRegister({
    required this.name,
    required this.lastName,
    required this.secondName,
    required this.gender,
    required this.collegeDegree,
    required this.typeContract,
    required this.status,
    required this.rol,
    required this.tuition,
    required this.email,
    required this.numberPhone,
    this.tokenFcm,
    this.updatedAt,
    required this.userLogin,
    required this.uid,
  });

  TeacherRegister copyWith({
    String? name,
    String? lastName,
    String? secondName,
    String? gender,
    String? collegeDegree,
    String? typeContract,
    bool? status,
    String? rol,
    String? tuition,
    String? email,
    String? numberPhone,
    String? tokenFcm,
    DateTime? updatedAt,
    String? userLogin,
    String? uid,
  }) =>
      TeacherRegister(
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        secondName: secondName ?? this.secondName,
        gender: gender ?? this.gender,
        collegeDegree: collegeDegree ?? this.collegeDegree,
        typeContract: typeContract ?? this.typeContract,
        status: status ?? this.status,
        rol: rol ?? this.rol,
        tuition: tuition ?? this.tuition,
        email: email ?? this.email,
        numberPhone: numberPhone ?? this.numberPhone,
        tokenFcm: tokenFcm ?? this.tokenFcm,
        updatedAt: updatedAt ?? this.updatedAt,
        userLogin: userLogin ?? this.userLogin,
        uid: uid ?? this.uid,
      );

  factory TeacherRegister.fromRawJson(String str) =>
      TeacherRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeacherRegister.fromJson(Map<String, dynamic> json) =>
      TeacherRegister(
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        gender: json["gender"],
        collegeDegree: json["collegeDegree"],
        typeContract: json["typeContract"],
        status: json["status"],
        rol: json["rol"],
        tuition: json["tuition"],
        email: json["email"],
        numberPhone: json["numberPhone"],
        tokenFcm: json["tokenFCM"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userLogin: json["userLogin"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "gender": gender,
        "collegeDegree": collegeDegree,
        "typeContract": typeContract,
        "status": status,
        "rol": rol,
        "tuition": tuition,
        "email": email,
        "numberPhone": numberPhone,
        "tokenFCM": tokenFcm,
        "updatedAt": updatedAt?.toIso8601String(),
        "userLogin": userLogin,
        "uid": uid,
      };
}
