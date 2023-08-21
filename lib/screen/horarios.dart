import 'package:flutter/material.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:preppa_profesores/Services/files_services.dart';

class Horarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () async {
                // await  UploadFiles.getFiles();

                // String fileName = 'prepa.png';
                final url = Uri.parse(
                    'https://www.mundogatos.com/Uploads/mundogatos.com/ImagenesGrandes/fotos-de-gatitos-7.jpg');
                // final url = Uri.parse('https:/mian/backendprepa-production.up.railway.app/api/uploadFile/63da40d952024d24cee2bcdf/task');

                downloadImage(url);
                print('Descargado');
              },
              child: Text('descargar'),
            ),
            const Text('Descargar'),
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
              // child: Image.network(
              //    'localhost:8080/api/uploadFile/63da40d952024d24cee2bcdf/task'
              // ),
                  // 'https://backendprepa-production.up.railway.app/api/uploadFile/63da40d952024d24cee2bcdf/task'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> downloadImage(Uri url) async {
    Directory docDir = await getApplicationDocumentsDirectory();
  print(docDir.path);

    var response = await http.get(url);

    var pathList = docDir.path.split('\\');
    // pathList[pathList.length - 1] = 'Pictures';
    pathList[pathList.length - 1] = 'Downloads';

    var picturePath = pathList.join('\\');
    print("dicrectorio : $picturePath");

String filename='gayoti.pdf';
    // var thetaImage = File('$picturePath,$fileName');

    // var thetaImage = await File(join(picturePath, 'theta_images'))
    //     .create(recursive: true);

    var thetaImage = await File(join(picturePath,filename))
        .create(recursive: true);


    await thetaImage.writeAsBytes(response.bodyBytes);
    print('Directorio : $thetaImage');
  }
}
