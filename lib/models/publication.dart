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
        archivos: List<dynamic>.from(json["archivos"].map((x) => x)),
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

  // Copia de los datos del modello
  Publication withCopy() => Publication(
      id: id,
      title: title,
      author: author,
      archivos: archivos,
      createdAt: createdAt,
      description: description);

  String authorPubication() {
    String publicationAuthor = '${author?.name}  ${author?.lastName}';
    return publicationAuthor;
  }

  String get authorDetails => '${author!.name} ${author!.lastName}';
  String get initialNameAuthor =>
      '${author!.name.substring(0, 1)} ${author!.lastName.substring(0, 1)}';

// RETORNA HACE CUANTOS DIAS SE HA HECHO LA PUBLICACION

// published ago - publicado hace
  int get publishesAgo {
    // ccrear un objecto que es la instancia de la fecha de hoy

    DateTime now = DateTime.now();
    // fecha  entrega de la tarea
    DateTime ex = createdAt!;

    // comprar la diferencia de dias
    // se hace con el metodo difference de la clase DateTime
    Duration duration = ex.difference(now);
    int missingDays = duration.inDays;

    return missingDays * -1;
  }
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
