

import 'dart:convert';

// LoginUser loginFromMap(String str) => LoginUser.fromMap(json.decode(str));


class LoginUser {
 LoginUser({required this.user, required this.password});

  String user;
  String password;

 // converte al mapa en un json
String toJson() => json.encode(toMap());

  factory LoginUser.fromMap(Map<String, dynamic> json) => LoginUser(
        user: json["user"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {"user": user, "password": password};
}
