import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/task_services.dart';

// ignore: camel_case_types
class WidgetUpload extends StatefulWidget {
  final List<XFile>? file;
  final Size size;

  const WidgetUpload({super.key, this.file, required this.size});

  @override
  State<WidgetUpload> createState() => _widgetOploadState();
}

class _widgetOploadState extends State<WidgetUpload> {
  bool isDragging = false;
  int? selectedIndexFile;
  String nameTask = '';
  String descriptionTask = '';
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropTarget(
            onDragDone: (details) async {
              widget.file!.addAll(details.files);
              print('nombre del archivo${details.files[0].name}');

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
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.lightBlue,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        style: BorderStyle.solid),
                    color: isDragging == false
                        ? Colors.white
                        // ? const Color.fromARGB(255, 28, 17, 78)
                        //     .withOpacity(0.3) // Colors.red
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: size.width * 0.3,
                  height: isDragging == true
                      ? size.height * 0.4
                      : size.height * 0.35,
                  child: Center(
                    child: isDragging == false
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Flexible(
                                  child: Text('Haga clic para cargar'),
                                ),
                              ),
                              const Text(
                                  'o arrastrar y soltar PNG, JPG Y pdf (max,2mb)'),
                            ],
                          )
                        : const Text('Agregando archivo....'),
                  ),
                ),
              ],
            ),

            // para mostrar los archivod que se van agregando
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Archivos (${widget.file?.length})',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          buildFiles()
        ],
      ),
    );
  }

//para mostarr todos los datos
  Widget buildFiles() => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          runAlignment: WrapAlignment.start,
          // children: file.map((e) => buildFile(e.path)).toList(),
          children: List.generate(
              widget.file!.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndexFile = index;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildFile(widget.file![index]),
                        if (index == selectedIndexFile)
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.file!.removeAt(index);
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.lightBlue,
                              )),
                      ],
                    ),
                  )),
        ),
      );

  //  widget para mostar  cada una de las imagens

  Widget buildFile(XFile url) {
    final typeExtends = url.path.split('.');
    final extend = typeExtends[typeExtends.length - 1];

    print('Typo de extension de la imagen$extend');

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          // color: Colors.red,
          border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10)),
      height: 50,
      width: size.width * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            extend == "pdf"
                ? const Icon(
                    Icons.picture_as_pdf,
                    size: 30,
                  )
                : Image.file(File(url.path),
                    width: 100, height: 100, fit: BoxFit.cover),
            const SizedBox(
              width: 10,
            ),
            Text(
              url.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
