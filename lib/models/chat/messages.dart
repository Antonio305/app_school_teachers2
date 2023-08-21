// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Messages messagesFromJson(String str) => Messages.fromJson(json.decode(str));

String messagesToJson(Messages data) => json.encode(data.toJson());

class Messages {
    bool ok;
    String msg;
    List<Message> messages;

    Messages({
        required this.ok,
        required this.msg,
        required this.messages,
    });

    factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        ok: json["ok"],
        msg: json["msg"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    };
}

class Message {
    String de;
    String para;
    String message;
    DateTime createdAt;
    DateTime updatedAt;
    String uid;

    Message({
        required this.de,
        required this.para,
        required this.message,
        required this.createdAt,
        required this.updatedAt,
        required this.uid,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        de: json["de"],
        para: json["para"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
    };
}
