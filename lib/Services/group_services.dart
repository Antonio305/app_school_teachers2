// La clase para mostarb los datos

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../models/group.dart';
import '../models/host.dart';

class GroupServices extends ChangeNotifier {
  // mapa param mostar los datos por id
  // Map<String, dynamic> group = {};

  List<Groups> groups = [];

// instancia de la clase group
  Groups group = Groups(groups: [], msg: '');

// Basis for url

  // final String baseUrl = 'localhost:8080';

  final String baseUrl = ConectionHost.baseUrl;
  // FUNCTION  TO GET  THE DATA

  final headers = {'content-type': 'application/json'};

  // Future allGroup() async {
  //   final url = Uri.http(baseUrl, 'api/group');

  //   // print(url);

  //   final resp = await http.get(url, headers: headers);

  //   final List<dynamic> respBody = json.decode(resp.body);

  //   final group = respBody.map((e) => Group.fromMap(e)).toList();
  //   groups = [...group];

  //   notifyListeners();

  //   // if (resp.statusCode == 200) {
  //   //   print('Datos con exito');
  //   // } else {

  //   //   print('Datos no obtenidos');

  //   // }
  // }

// function para crear los datos

  Future getGroupForId() async {

    // final url = Uri.http(baseUrl, '/api/group/groupForTeacher');
    final url = ConectionHost.myUrl('/api/group/groupForTeacher',{});

    print(url);
    final resp = await http.get(url, headers: headers);

    // print(resp.body);
    final Map<String, dynamic> respBody = json.decode(resp.body);
    // notifyListeners();

    group = Groups.fromMap(respBody);
    notifyListeners();
    // final List<dynamic> data = groupsForId['students'];
    // print("datos" + data[0]);
  }

  // Obtener en las materia que da clase la maestre
}
