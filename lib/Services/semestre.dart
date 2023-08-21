import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../models/host.dart';
import '../models/semestre.dart';

class SemestreServices extends ChangeNotifier {
// intancia de  clase
// creamos una lista de tipo Semetre

  late List<Semestres> semestres = [];

  // late List<GroupSemestre> groups = [];
  //  lista de grupos

  //base url
  // por el momento solo en local

  // final String baseUrl = "localhost:8080";

 String  baseUrl = ConectionHost.baseUrl;
 
  Future allSemestre() async {
    // final url = Uri.http(baseUrl, '/api/semestre');
    final url = ConectionHost.myUrl('/api/semestre',{});
    
    final headers = {'content-Type': 'application/json'};

    print(url);

    final resp = await http.get(url, headers: headers);
    final List<dynamic> respBody = json.decode(resp.body);

    semestres = respBody.map((e) => Semestres.fromJson(e)).toList();
    notifyListeners();
    print(respBody);
  }

  /// mostrar el semetre por id
  ///

//   Future allsemsetreForId(String id) async {
//     final url = Uri.http(baseUrl, 'api/semestre/$id');
//     final headers = {'content-Type': 'application/json'};

//     print(url);

//     final resp = await http.get(url, headers: headers);

//     // los dato seran almacenados en un mapa
//     final Map<String, dynamic> respBody = json.decode(resp.body);

//     final List<dynamic> group = respBody["group"];

//     groups = group.map((e) => GroupSemestre.fromMap(e)).toList();
//  notifyListeners();
//     // extraer la lista de grouoso

//     print(groups[0]);

  //  if(resp.statusCode == 200){
  //   print('DATOS OBENIDOS CON EXITO');
  //   else{
  //     print('algo fallo');
  //   }
  //  }
}
// }




// class GroupSemestre {
//     GroupSemestre({
//       required  this.id,
//       required  this.name,
//       required  this.adviser,
//       required  this.tutor,
//       required  this.students,
//       required  this.v,
//     });

//     String id;
//     String name;
//     String adviser;
//     String tutor;
//     List<dynamic> students;
//     int v;

//     factory GroupSemestre.fromJson(String str) => GroupSemestre.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory GroupSemestre.fromMap(Map<String, dynamic> json) => GroupSemestre(
//         id: json["_id"],
//         name: json["name"],
//         adviser: json["adviser"],
//         tutor: json["tutor"],
//         students: List<dynamic>.from(json["students"].map((x) => x)),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toMap() => {
//         "_id": id,
//         "name": name,
//         "adviser": adviser,
//         "tutor": tutor,
//         "students": List<dynamic>.from(students.map((x) => x)),
//         "__v": v,
//     };
// }
