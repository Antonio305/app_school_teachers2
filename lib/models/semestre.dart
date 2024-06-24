// To parse this JSON data, do
//
//     final semestres = semestresFromJson(jsonString);

import 'dart:convert';

class Semestres {
  Semestres({
    required this.name,
    required this.periodic,
    required this.cursando,
    required this.uid,
  });

  String name;
  String periodic;
  bool cursando;
  String uid;

  factory Semestres.fromRawJson(String str) =>
      Semestres.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Semestres.fromJson(Map<String, dynamic> json) => Semestres(
        name: json["name"],
        periodic: json["periodic"],
        cursando: json["cursando"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "periodic": periodic,
        "cursando": cursando,
        "uid": uid,
      };
}
