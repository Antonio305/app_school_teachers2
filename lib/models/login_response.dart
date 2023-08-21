// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:preppa_profesores/models/teacher.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    bool ok;
    String token;
     Teachers teacher;

    LoginResponse({
        required this.ok,
        required this.token,
        required this.teacher,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        token: json["token"],
        teacher: Teachers.fromJson(json["teacher"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "token": token,
        "teacher": teacher.toJson(),
    };
}
