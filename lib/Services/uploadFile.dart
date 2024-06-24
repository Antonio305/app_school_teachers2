import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

// models
import '../models/host.dart';

class UploadFileServices extends ChangeNotifier {
  final storage = SecureStorage.storage();

// functin to send file with movile

  Future updateTaskAddFiles(String id, List<File>? pathFiles) async {
    String? token = await storage.read(key: 'token');

    // required ID

    // creatae haeader eith token, type date
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'x-token' : token,
    };

    // final resp = await http.put(url, headers:headers);

    if (pathFiles == null) {
      print('No hay archivos que subir');
      return null; // indicamos null que no haremos lago mas
    }

    // newFile = pathFile;

    final url = ConectionHost.myUrl('/api/tasks/$id/addFile', {});

    print('url para subir los archivos $url');

    var fileUploadRequest = http.MultipartRequest('PUT', url);

    for (var i = 0; i < pathFiles.length; i++) {
      // AGREDAR EL PATH DEL ARCHIVOa
      final file =
          await http.MultipartFile.fromPath('archivo', pathFiles[i].path);
      // files.add(file);

      fileUploadRequest.files.add(file);
    }

    final streamedResponse = await fileUploadRequest.send();

    final resp = await http.Response.fromStream(streamedResponse);
    print(resp);

    // status 200 cuando se crear o se actualiza algo
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      return null;
    }

    // pathFile = null;
  }
}
