import 'dart:convert';

import 'package:preppa_profesores/models/teacher.dart';

class LoginResponseTeacher {
  String msg;
  LoginData loginData;
  String token;
  bool? status;
  dynamic userData;

  LoginResponseTeacher(
      {required this.msg,
      required this.loginData,
      required this.token,
      this.status,
      this.userData});

  LoginResponseTeacher copyWith({
    String? msg,
    LoginData? loginData,
    String? token,
    Teachers? userData,
  }) =>
      LoginResponseTeacher(
        msg: msg ?? this.msg,
        loginData: loginData ?? this.loginData,
        token: token ?? this.token,
        userData: userData ?? this.userData,
      );

  factory LoginResponseTeacher.fromRawJson(String str) =>
      LoginResponseTeacher.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseTeacher.fromJson(Map<String, dynamic> json) =>
      LoginResponseTeacher(
        msg: json["msg"],
        loginData: LoginData.fromJson(json["loginData"]),
        token: json["token"],
        status: json['status'],
        // userData: Teachers.fromMap(json["userData"]),
        userData: json['userData'],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "loginData": loginData.toJson(),
        "token": token,
        "userData": userData!.toJson(),
      };
}

class LoginData {
  bool status;
  String id;
  String user;
  String password;
  String typeUser;
  int v;

  LoginData({
    required this.status,
    required this.id,
    required this.user,
    required this.password,
    required this.typeUser,
    required this.v,
  });

  LoginData copyWith({
    bool? status,
    String? id,
    String? user,
    String? password,
    String? typeUser,
    int? v,
  }) =>
      LoginData(
        status: status ?? this.status,
        id: id ?? this.id,
        user: user ?? this.user,
        password: password ?? this.password,
        typeUser: typeUser ?? this.typeUser,
        v: v ?? this.v,
      );

  factory LoginData.fromRawJson(String str) =>
      LoginData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        status: json["status"],
        id: json["_id"],
        user: json["user"],
        password: json["password"],
        typeUser: json["typeUser"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "user": user,
        "password": password,
        "typeUser": typeUser,
        "__v": v,
      };
}

class UserData {
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
  String tokenFcm;
  DateTime updatedAt;
  String userLogin;
  String uid;

  UserData({
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
    required this.tokenFcm,
    required this.updatedAt,
    required this.userLogin,
    required this.uid,
  });

  UserData copyWith({
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
      UserData(
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

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
        updatedAt: DateTime.parse(json["updatedAt"]),
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
        "updatedAt": updatedAt.toIso8601String(),
        "userLogin": userLogin,
        "uid": uid,
      };
}
