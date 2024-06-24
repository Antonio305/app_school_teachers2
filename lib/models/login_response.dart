// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:preppa_profesores/models/teacher.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    bool status;
    String token;
     Teachers teacher;

    LoginResponse({
        required this.status,
        required this.token,
        required this.teacher,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        token: json["token"],
        teacher: Teachers.fromJson(json["teacher"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "teacher": teacher.toJson(),
    };
}
