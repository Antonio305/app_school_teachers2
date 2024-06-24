import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/apiServices.dart';

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

  final apiServices = ApiServices();

  bool status = false;

// este si sirve

  Future allGeneration() async {
    // final url = ConnectionHost.myUrl('/api/generation', {});
    // final resp = await returnResp('/api/generation');

    final resp = await apiServices.get('/api/generation');

    // final resp = await http.get(url, headers: headers);

    Map<String, dynamic> respBody = json.decode(resp.body);

    if (resp.statusCode == 401) {
      status = false;
      notifyListeners();

      return false;
    }

    if (resp.statusCode == 404) {
      return respBody['msg'];
    }

    if (resp.statusCode == 200) {
      final List<dynamic> listGeneration = respBody['generation'];

      final generation =
          listGeneration.map((e) => Generations.fromJson(e)).toList();

      // newGeneration.listGeneration = generations;
      generations = [...generation];
      status = false;
      notifyListeners();
    }
    status = false;
    notifyListeners();
    return respBody['msg'];
  }

}
