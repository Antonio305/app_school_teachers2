// La clase para mostarb los datos

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure_storage.dart';

import '../models/group.dart';
import '../models/host.dart';

class GroupServices extends ChangeNotifier {
  List<Groups> groups = [];

// instancia de la clase group
  Groups group = Groups(groups: [], msg: '');

  final String baseUrl = ConectionHost.baseUrl;

  final storage = SecureStorage.storage();
  GroupElement? selectedGroup;
  Future allGroups() async {
    String? token = await storage.read(key: 'token');

    // final url = Uri.http(baseUrl, '/api/group/groupForTeacher');
    final url = ConectionHost.myUrl('/api/group/groupForTeacher', {});

    print(url);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    final resp = await http.get(url, headers: headers);

    // print(resp.body);
    final Map<String, dynamic> respBody = json.decode(resp.body);
    // notifyListeners();

    group = Groups.fromMap(respBody);
    print('LISTA DE GRUPOS');
    print(resp.body);
    notifyListeners();
  }
}
