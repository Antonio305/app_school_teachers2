
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/task_services.dart';


class ShowDialogEditTask  {

  static Future<String?> openDialogEditTask(BuildContext context) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            return Center(
              child: AlertDialog(
                content: const ContentTask(),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Colors.black,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 35, right: 35),
                            child: Text('CANCELAR',
                                style: TextStyle(color: Colors.white)),
                          )),
                    ],
                  )
                ],
              ),
            );
          });




}

class ContentTask extends StatefulWidget {
  const ContentTask({super.key});

  @override
  State<ContentTask> createState() => _ContentTaskState();
}

class _ContentTaskState extends State<ContentTask> {
  String? nameTask;
  String? descriptionTask;
  List<XFile> file = [];

  TextEditingController? nameTaskController = TextEditingController();
  TextEditingController? descriptionTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameTask = nameTaskController!.text;
    descriptionTask = descriptionTaskController!.text;
    file = [];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: 600,
      // height: 150,
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    return null;
                  },
                  onChanged: (String value) {
                    // setState(() {});

                    nameTask = value;
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    // label: Text('CHALES'),

                    hintMaxLines: 3,

                    labelText: "NOMBRE DE LA TAREA",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                TextFormField(
                  validator: (value) {
                    return null;
                  },

                  // maxLines: 5,

                  onChanged: (String value) {
                    // setState(() {});
                    descriptionTask = value;
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    // label: Text('CHALES'),

                    // hintMaxLines: 5,

                    labelText: "DESCRICION DE LA TAREA",
                  ),
                ),
              ],
            ),
          ),
          widgetOpload(file: file),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class widgetOpload extends StatefulWidget {
  final List<XFile> file;

  const widgetOpload({super.key, required this.file});

  @override
  State<widgetOpload> createState() => _widgetOploadState();
}

class _widgetOploadState extends State<widgetOpload> {
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        DropTarget(
          onDragDone: (details) async {
            widget.file.addAll(details.files);
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
                color: isDragging == false ? Colors.red : Colors.white,
                width: 300,
                height: 250,
                child: Center(
                  child: isDragging == false
                      ? const Text('ARRARTRE EL ARCHIVO ACA')
                      : const Text('AGREGANDO ARCHIVO....'),
                ),
              ),
            ],
          ),

          // para mostrar los archivod que se van agregando
        ),
        buildFiles()
      ],
    );
  }

//para mostarr todos los datos
  Widget buildFiles() => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // children: file.map((e) => buildFile(e.path)).toList(),
          children: List.generate(
              widget.file.length,
              (index) => GestureDetector(
                  onTap: () {
                    // final fileUploadServices =
                    //     Provider.of<TaskServices>(context, listen: false);
                    // fileUploadServices.fileUpload(widget.file[index]);
                  },
                  child: buildFile(widget.file[index]))),
        ),
      );

  //  widget para mostar  cada una de las imagens

  Widget buildFile(XFile url) {
    final typeExtends = url.path.split('.');
    final extend = typeExtends[typeExtends.length - 1];

    print('Typo de extension de la imagen$extend');

    return Row(
      children: [
        extend == "pdf"
            ? const Icon(Icons.picture_as_pdf)
            : Image.file(File(url.path),
                width: 100, height: 100, fit: BoxFit.cover),
        Text(url.name),
      ],
      // : [
      //     Image.file(File(url.path),
      //         width: 200, height: 200, fit: BoxFit.cover),
      //     Text(url.name)
      //   ],
    );
  }
}
