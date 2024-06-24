import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:http/http.dart' as http;

class DownloadFileDio {
  static Future<File> downloadFile(String url) async {
    Dio dio = Dio();
    File file = File('${await getExternalStorageDirectory()}/my_file.pdf');
    // Crea una solicitud HTTP
    await dio.download(url, file.path);

    // Escribe el contenido en el archivo
    // await file.writeAsBytes(bytes);

    // Devuelve el archivo
    return file;
  }

  static Future<File> downloadFiles() async {
    return downloadFile('https://example.com/my_pdf.pdf');
  }

//   // descarga directamanet
//   Future<File> downloadFile2() async {
//   return await dio.download('https://example.com/my_pdf.pdf',
//      '${await getExternalStorageDirectory()}/my_file.pdf');
// }

  static Future<void> dowbloadAndSaveFileToStorage(
      BuildContext context, String link, String nombre) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // ignore: use_build_context_synchronously
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text('Descargar archivo.'),
            content: const Text('¿Desea descargar el archivo correspondiente?'),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  var response = await http.get(Uri.parse(link));
                  // var documentDirectory = await getExternalStorageDirectory();
                      var documentDirectory = await getApplicationDocumentsDirectory();

                  var firstPath = documentDirectory!.path + '/Download';
                  var filePathAndName = firstPath + '/' + nombre + '.pdf';
                  await Directory(firstPath).create(recursive: true);
                  File file = File(filePathAndName);
                file.writeAsBytesSync(response.bodyBytes);

                print(file.path);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text(
                  'Si',
                  style: TextStyle(
                    color: Color.fromRGBO(82, 120, 187, 10),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Color.fromRGBO(82, 120, 187, 10),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
