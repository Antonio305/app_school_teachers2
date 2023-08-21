import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/generations.dart';
import '../models/host.dart';

class GenerationServices extends ChangeNotifier {
  List<Generations> generations = [];

  // clase para la lista del seemestre
  // List<Semestre> semestres = [];
  // late Generation generation;

  String baseUrl = ConectionHost.baseUrl;

  Map<String, dynamic> generation = {};
  final headers = {'content-Type': 'applicacion/json'};

// este si sirve

  Future allGeneration() async {
    // final url = Uri.http(baseUrl, 'api/generation');
   final url = ConectionHost.myUrl('api/generation',{});
    // final url = Uri.parse('$baseUrl/api/generation');

    final resp = await http.get(url, headers: headers);

    // print(resp.body);
    final List<dynamic> respBody = json.decode(resp.body);

    final generationn = respBody.map((e) => Generations.fromJson(e)).toList();

    generations = [... generationn];
    // notifyListeners();
  }

// este codig no me servie
// funcion para mostrar los dato semestres y grupos por generaciones
  
  // Future getGroupSemestreForGeneration(String id) async {
  //   // final url = Uri.parse('$baseUrl/api/generation/$id');
  //   final url = Uri.http('$baseUrl/api/generation/$id');


  //   final resp = await http.get(url, headers: headers);

  //   final Map<String, dynamic> respBody = json.decode(resp.body);

  //   // generation = json.decode(resp.body);

  //   // generation = Generation.fromMap(respBody);
  //   // print(generation);

  //   print('Datoss del a genraicon');
  //   // print(respBody['semestre']);

  //   List<dynamic> semestre = respBody['semestre'];

  //   semestres = semestre.map((e) => Semestre.fromMap(e)).toList();

  //   print(semestres);
  //   // print('Datos del grupo');
  //   // print(semestre[0]);

  //   // final Map<String, dynamic> groups = semestre[0];
  //   // final List<dynamic> dataGroups = groups['group'];

  //   // print('datos del grup' + semestre);
  //   // generation = json.decode(resp.body);

  //   // generation = Generation(
  //   //     initialDate: respBody['initialDate'],
  //   //     finalDate: respBody['finalDate'],
  //   //     semestre: respBody['semestre'],
  //   //     uid: respBody['uid']);
  //   // // generation = Generation.fromMap(respBody);

  //   // print('dato de la  generacion');
  //   // print(generation);

  //   // return generation;
  //   // final groupSemestreForGeneration =
  // }
}
