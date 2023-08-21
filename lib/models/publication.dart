

import 'dart:convert';

class Publication {
  Publication({
    this.id,
    required this.title,
    this.archivos,
    this.author,
    this.createdAt,
    this.v,
     this.description,
  });

  String? id;
  String title;
  List<dynamic>? archivos;
  Author? author;
  DateTime? createdAt;
  int? v;
  String? description;

  factory Publication.fromJson(String str) =>
      Publication.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Publication.fromMap(Map<String, dynamic> json) => Publication(
        id: json["_id"],
        title: json["title"],
        archivos:
            List<dynamic>.from(json["archivos"].map((x) => x)),
        author: Author.fromMap(json["author"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "description": description,
      };
}

class Author {
  Author({
    required this.name,
    required this.lastName,
    required this.secondName,
    required this.collegeDegree,
    required this.rol,
    required this.uid,
  });

  String name;
  String lastName;
  String secondName;
  String collegeDegree;
  String rol;
  String uid;

  factory Author.fromJson(String str) => Author.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Author.fromMap(Map<String, dynamic> json) => Author(
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        collegeDegree: json["collegeDegree"],
        rol: json["rol"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "collegeDegree": collegeDegree,
        "rol": rol,
        "uid": uid,
      };
}
