// To parse this JSON data, do
//
//     final messageError = messageErrorFromJson(jsonString);

import 'dart:convert';

List<ErrorMessage> messageErrorFromJson(String str) => List<ErrorMessage>.from(
    json.decode(str).map((x) => ErrorMessage.fromJson(x)));

String messageErrorToJson(List<ErrorMessage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ErrorMessage {
  String value;
  String msg;
  String param;
  String location;

  ErrorMessage({
    required this.value,
    required this.msg,
    required this.param,
    required this.location,
  });

  ErrorMessage copyWith({
    String? value,
    String? msg,
    String? param,
    String? location,
  }) =>
      ErrorMessage(
        value: value ?? this.value,
        msg: msg ?? this.msg,
        param: param ?? this.param,
        location: location ?? this.location,
      );

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
        value: json["value"],
        msg: json["msg"],
        param: json["param"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "msg": msg,
        "param": param,
        "location": location,
      };
}
