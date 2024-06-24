import 'dart:convert';

import 'package:preppa_profesores/models/rating.dart';
import 'package:preppa_profesores/models/taskReceived.dart';

class GradeAndTaksRecivedsResponse {
  String msg;
  List<TaskReceived> tasksReceiveds;
  Ratings? rating;

  GradeAndTaksRecivedsResponse({
    required this.msg,
    required this.tasksReceiveds,
    this.rating,
  });

  GradeAndTaksRecivedsResponse copyWith({
    String? msg,
    List<TaskReceived>? tasksReceiveds,
    Ratings? rating,
  }) =>
      GradeAndTaksRecivedsResponse(
        msg: msg ?? this.msg,
        tasksReceiveds: tasksReceiveds ?? this.tasksReceiveds,
        rating: rating ?? this.rating,
      );

  factory GradeAndTaksRecivedsResponse.fromRawJson(String str) =>
      GradeAndTaksRecivedsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GradeAndTaksRecivedsResponse.fromJson(Map<String, dynamic> json) =>
      GradeAndTaksRecivedsResponse(
        msg: json["msg"],
        tasksReceiveds: List<TaskReceived>.from(
            json["tasksReceiveds"].map((x) => TaskReceived.fromJson(x))),
        rating: json["rating"] == null ? null : Ratings.fromMap(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "tasksReceiveds":
            List<dynamic>.from(tasksReceiveds.map((x) => x.toJson())),
        "rating": rating == null ? null : rating!.toJson(),
      };
}
