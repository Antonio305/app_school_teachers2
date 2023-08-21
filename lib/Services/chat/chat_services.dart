import 'package:flutter/cupertino.dart';
import 'package:preppa_profesores/Services/login_provider.dart';
import 'package:preppa_profesores/global/enviroment.dart';
import 'package:preppa_profesores/models/chat/messages.dart';
// import 'package:preppa_profesores/models/student.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:preppa_profesores/models/studentForSubject.dart';

class ChatServices with ChangeNotifier {
// usuari para el que se le envia el menaje

  // Students? userPara;
  StudentForSubject? userPara;

  // para el historial de mensajes
  Future<List<Message>> getMessage(String de) async {
    String? token = await LoginServices.getToken();

    final url = Uri.http(Enviroment.apiUrl, '/api/messages/$de');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };
    final resp = await http.get(url, headers: headers);

    final respBody = json.decode(resp.body);
    final mensajesResp = messagesFromJson(resp.body);

    print(respBody);
    return mensajesResp.messages;
  }
}
