import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../Services/dowloandFile.dart';
import '../Services/saveFileServices.dart';

// ignore: must_be_immutable
class ScreenViewPdf extends StatefulWidget {
  const ScreenViewPdf({Key? key}) : super(key: key);

  @override
  State<ScreenViewPdf> createState() => _PdfPageState();
}

class _PdfPageState extends State<ScreenViewPdf> {
  // final String pdfPath;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  int? pages = 0;

  int? currentPage = 0;

  bool isReady = false;

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final saveFileServices = Provider.of<SaveFileInLocalProvider>(context);

    File pdfPath = ModalRoute.of(context)?.settings.arguments as File;
    print('Paht del archvo recigvido' + pdfPath.path);
    saveFileServices.pickDirectory;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre del archivo'),
        // actions: [
        // IconButton(
        //     onPressed: () {
        //       saveFileServices.pickFile();
        //     },
        //     icon: const Icon(Icons.save))
        // ],
      ),
      body: body(pdfPath),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // if (await saveFileServices.tengoAccesoParaGuardarDatos()) {
          //   Directory? directory;

          //   if (Platform.isIOS) {
          //     directory = await getDownloadsDirectory();
          //     print(directory!.path);
          //   } else if (Platform.isAndroid) {
          //     directory = await getTemporaryDirectory();
          //     // directory = await getApplicationDocumentsDirectory();
          //   }

          //   // File file = File('${documentsDirectory.path}/my_file2.txt');
          //   File file = File('${directory!.path}/myFiele.txt');

          //   await file.writeAsString('HOLA BUENOS DIAS');

          //   // ignore: use_build_context_synchronously
          //   saveFileServices.saveFileToDirectory(file, context);

          // } else {
          //   openAppSettings();
          //   debugPrint(" --------------------- Permission denied");
          // }
          // final saveFileServices =
          // Provider.of<SaveFileInLocalProvider>(context, listen: false);

          // saveFileServices.saveFileToDirectory(pdfPath, context);
          if (Platform.isAndroid || Platform.isIOS) {
            saveFileServices.saveFile(false, pdfPath);
          } else {
            OpenFile.open(pdfPath.path);
          }
        },
        label: saveFileServices.isBusy == true
            ? const Row(
                children: [Text('Guardado.. '), CircularProgressIndicator()],
              )
            : const Row(
                children: [
                  Text('Descargar Archivo'),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.picture_as_pdf_rounded)
                ],
              ),
      ),
    );
  }

  PDFView body(File pdfPath) {
    return PDFView(
      filePath: pdfPath.path,
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: false,
      onRender: (_pages) {
        setState(() {
          pages = _pages;
          isReady = true;
        });
      },
      onError: (error) {
        print(error.toString());
      },
      onPageError: (page, error) {
        print('$page: ${error.toString()}');
      },
      onViewCreated: (PDFViewController pdfViewController) {
        _controller.complete(pdfViewController);
      },
      // onPageChanged: (int page, int total) {
      //   print('page change: $page/$total');
      // },
    );
  }
}
