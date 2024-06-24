import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenDownload extends StatefulWidget {
  final String urls;
  final String nameFile;

  const ScreenDownload({Key? key, required this.urls, required this.nameFile})
      : super(key: key);

  @override
  State<ScreenDownload> createState() => _ScreenDownloadState();
}

class _ScreenDownloadState extends State<ScreenDownload> {
//  funcion para pedir permiso al usuarios para guardar los datos
  Future<void> _askPermission(BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      // Permission is granted
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permiso de almacenamiento aceptado'),
        ),
      );
    } else {
      // Permission is not granted
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Permiso de almacenamiento denegado de forma permanente.'),
        ),
      );
    }
  }

  double porcentDownload = 0.0;
  String? downloadMessage = 'INITIZALIZED .......';
  bool isDownloading = false;

// para la linear progress
  var percentage;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  Future<void> _askStoragePermission() async {
    debugPrint(" ---------------- Asking for permission...");
    await Permission.manageExternalStorage.request();

    if (await Permission.manageExternalStorage.request().isGranted) {
      PermissionStatus permissionStatus =
          await Permission.manageExternalStorage.status;
      setState(() {
        _permissionStatus = permissionStatus;
      });
    }
  }

// funcion para descargar  para  windoess p pero para mas aun fala
  /// flata la implememtacion para mac
  void downloadWindowsMac() async {
    Dio dio = Dio();
    // String filename = 'progresssVidio.mp4';
    // String url =
    // "https://jsoncompare.org/LearningContainer/SampleFiles/Video/MP4/sample-mp4-file.mp4";
    Directory docDir;
    // para WINDOWS

    docDir = await getApplicationDocumentsDirectory();
    
    var pathList = docDir.path.split('\\');
    // pathList[pathList.length - 1] = 'Pictures';
    pathList[pathList.length - 1] = 'Downloads';
    var picturePath = pathList.join('\\');

    File thetaImage =
        // await File(join(picturePath, filename));
        await File(join(picturePath, widget.nameFile)).create(recursive: true);
    // await thetaImage
    //     .writeAsBytes(response.bodyBytes);
    /// instancia de dio para la descargar de archivos
    print(" path para guardar el archivo :  $thetaImage");

    // if (thetaImage.existsSync()) {
    //   print('El archivo ya existe');
    //   return null;
    // }

    await dio.download(widget.urls, thetaImage.path,
        onReceiveProgress: (actualbytes, totalbytes) {
      var percentage = actualbytes / totalbytes * 100;
      if (percentage < 100) {
        porcentDownload = percentage / 100;
        setState(() {
          downloadMessage = 'Dowloading .... ${percentage.floor()} %';
        });
      } else {
        downloadMessage =
            'Se ha descargado correctamente has click arriba para descargar de nuevo';
      }
    });
  }


  dowloadFilesAAndroidIos() async {
    bool value = false;

    Dio dio = Dio();
    String filename = 'yess.pdf';
    // permisos
    var status = await Permission.storage.status;
    setState(() {
      _permissionStatus = status;
    });

    Directory? directory;

    File file;

    if (_permissionStatus.isGranted) {
      if (Platform.isIOS) {
        directory = await getDownloadsDirectory();
        print(directory!.path);
      } else if (Platform.isAndroid) {
        directory = await getTemporaryDirectory();
      }
      if (directory == null) {
        throw Exception('Could not access local storage for '
            'download. Please try again.');
      }

      print('Temp cache save path: ${directory.path}/$filename');

// si toodo sale bien hacemos la descarga de los datos

      await dio.download(widget.urls, '${directory.path}/$filename',
          onReceiveProgress: (actualbytes, totalbytes) {
        var percentage = actualbytes / totalbytes * 100;
        if (percentage < 100) {
          porcentDownload = percentage / 100;
          setState(() {
            downloadMessage = 'Dowloading .... ${percentage.floor()} %';
          });
        } else {
          downloadMessage =
              'Se ha descargado correctamente has click arriba para descargar de nuevo';
        }
      });
      final url = Uri.parse(widget.urls);
      // var response = await http.get(url);

      // file = await File('${directory.path}/$filename');

      // await file.writeAsBytes(response.bodyBytes);

      print(' path dle archivo descargado: ${directory.path}/$filename');

      // for save file... selectec  files
      if (Platform.isAndroid) {
        if (!await FlutterFileDialog.isPickDirectorySupported()) {
          print(' picking Directory  not support, no esta soportado');
          return null;
        }

        final params =
            SaveFileDialogParams(sourceFilePath: '${directory.path}/$filename');

        // ruta del archivo de donde se guarda
        final filePath = await FlutterFileDialog.saveFile(params: params);
        print('Download path: $filePath');
      }
    } else {
      // openAppSettings();
      debugPrint(" --------------------- Permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'DatosDeLosOvnis.pdf',
                  style: TextStyle(fontSize: 14),
                ), 
                TextButton(
                  onPressed: () async {
                    // HACE FALTA PEDIR PERMISO, SI ES LA PRIMERA VEZ
                    // CUANDO SE ENTREGA LA TAREA AHI SE AGREGA EL PERMISO
                    // PERO ESO SE HACE DESPUES
                    // _askStoragePermission();
                    _askPermission(context);
                    Platform.isAndroid
                        ? await dowloadFilesAAndroidIos()
                        : downloadWindowsMac();
                  },
                  child: const Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'DESCARGAR',
                        style: TextStyle(fontSize: 14),
                      ),
                      Icon(Icons.download),
                    ],
                  ),
                ),
              ],
            ),
            const Text('Progeso de la descargar'),
            const SizedBox(height: 30),
            Text(downloadMessage ?? ''),
            LinearProgressIndicator(
              semanticsLabel: 'datoss locos.....',
              semanticsValue: 'chaless.......',
              minHeight: 15,
              value: porcentDownload,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
