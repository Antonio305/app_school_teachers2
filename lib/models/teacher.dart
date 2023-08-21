import 'dart:convert';

class Teachers {
  Teachers({
    required this.name,
    required this.lastName,
    required this.secondName,
    required this.gender,
    required this.collegeDegree,
    required this.typeContract,
    required this.status,
    required this.rol,
    this.numberPhone,
    this.email,
    required this.tuition,
    required this.uid,
  });

  String name;
  String lastName;
  String secondName;
  String gender;
  String collegeDegree;
  String typeContract;
  bool status;
  String rol;
  String? numberPhone;
  String? email;
  String tuition;
  String uid;

  factory Teachers.fromRawJson(String str) =>
      Teachers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Teachers.fromJson(Map<String, dynamic> json) => Teachers(
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        gender: json["gender"],
        collegeDegree: json["collegeDegree"],
        typeContract: json["typeContract"],
        status: json["status"],
        rol: json["rol"],
        tuition: json["tuition"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "gender": gender,
        "collegeDegree": collegeDegree,
        "typeContract": typeContract,
        "status": status,
        "rol": rol,
        "tuition": tuition,
        "uid": uid,
      };
}
