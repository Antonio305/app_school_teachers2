



import 'dart:convert';

class Groups {
    Groups({
        required this.msg,
        required this.groups,
    });

    String msg;
    List<GroupElement> groups;

    factory Groups.fromJson(String str) => Groups.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Groups.fromMap(Map<String, dynamic> json) => Groups(
        msg: json["msg"],
        groups: List<GroupElement>.from(json["groups"].map((x) => GroupElement.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "msg": msg,
        "groups": List<dynamic>.from(groups.map((x) => x.toMap())),
    };
}

class GroupElement {
    GroupElement({
        required this.name,
        required this.uid,
    });

    String name;
    String uid;

    factory GroupElement.fromJson(String str) => GroupElement.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GroupElement.fromMap(Map<String, dynamic> json) => GroupElement(
        name: json["name"],
        uid: json["uid"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "uid": uid,
    };
}
