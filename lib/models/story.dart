


import 'dart:convert';

class Storys {
    String id;
    String? data;
    bool status;
    DateTime expiredAt;
    String? user;
    DateTime createAt;
    int v;
    String? archivos;

    Storys({
        required this.id,
         this.data,
        required this.status,
        required this.expiredAt,
         this.user,
        required this.createAt,
        required this.v,
         this.archivos,
    });

    factory Storys.fromRawJson(String str) => Storys.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Storys.fromJson(Map<String, dynamic> json) => Storys(
        id: json["_id"],
        data: json["data"],
        status: json["status"],
        expiredAt: DateTime.parse(json["expiredAt"]),
        user: json["user"],
        createAt: DateTime.parse(json["createAt"]),
        v: json["__v"],
        archivos: json["archivos"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "data": data,
        "status": status,
        "expiredAt": expiredAt.toIso8601String(),
        "user": user,
        "createAt": createAt.toIso8601String(),
        "__v": v,
        "archivos": archivos,
    };
}
