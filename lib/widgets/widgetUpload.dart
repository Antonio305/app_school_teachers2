

import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/task_services.dart';

// ignore: camel_case_types
class WidgetUpload extends StatefulWidget {
  final List<XFile>? file;

  const WidgetUpload({super.key, required this.file});

  @override
  State<WidgetUpload> createState() => _widgetOploadState();
}

class _widgetOploadState extends State<WidgetUpload> {
  bool isDragging = false;

  String nameTask = '';
  String descriptionTask = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          DropTarget(
            onDragDone: (details) async {
              widget.file!.addAll(details.files);
              print('nombre del archivo' + details.files[0].name);
    
              final createTask =
                  Provider.of<TaskServices>(context, listen: false);
    
              // await createTask.fileUpload(details.files.first.name);
              // await createTask.uploadImage(details.files[0].path);
    //
            },
            onDragEntered: (details) {
              setState(() {
                isDragging = true;
              });
            },
            onDragExited: (details) => setState(() => isDragging = false),
    
            child: Column(
              children: [
                Container(
                  color: isDragging == false ? Color.fromARGB(255, 28, 17, 78).withOpacity(0.3)          // Colors.red 
                  : Colors.white,
                  width: size.width * 0.34,
                  height: 
                  isDragging == true
                  ?size.height * 0.54
                  : size.height * 0.5,
                  child: Center(
                    child: isDragging == false
                        ? Text('ARRARTRE EL ARCHIVO ACA')
                        : Text('AGREGANDO ARCHIVO....'),
                  ),
                ),
              ],
            ),
    
            // para mostrar los archivod que se van agregando
          ),
          buildFiles()
        ],
      ),
    );
  }

//para mostarr todos los datos
  Widget buildFiles() => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // children: file.map((e) => buildFile(e.path)).toList(),
          children: List.generate(
              widget.file!.length,
              (index) => GestureDetector(
                  onTap: () {
                    // final fileUploadServices =
                    //     Provider.of<TaskServices>(context, listen: false);
                    // fileUploadServices.fileUpload(widget.file[index]);
                  },
                  child: buildFile(widget.file![index]))),
        ),
      );

  //  widget para mostar  cada una de las imagens

  Widget buildFile(XFile url) {
    final typeExtends = url.path.split('.');
    final extend = typeExtends[typeExtends.length - 1];

    print('Typo de extension de la imagen' + extend);

    return Row(
      children: [
        extend == "pdf"
            ? const Icon(Icons.picture_as_pdf)
            : Image.file(File(url.path),
                width: 100, height: 100, fit: BoxFit.cover),
        Text(url.name),
      ],
    );
  }
}