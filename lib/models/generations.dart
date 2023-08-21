// To parse this JSON data, do
//
//     final generations = generationsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Generations {
    Generations({
        required this.initialDate,
        required this.finalDate,
        required this.uid,
    });

    DateTime initialDate;
    DateTime finalDate;
    String uid;

    factory Generations.fromRawJson(String str) => Generations.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Generations.fromJson(Map<String, dynamic> json) => Generations(
        initialDate: DateTime.parse(json["initialDate"]),
        finalDate: DateTime.parse(json["finalDate"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
        "uid": uid,
    };
}
