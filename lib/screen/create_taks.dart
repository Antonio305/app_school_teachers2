import 'dart:io';
import 'dart:ui' as ui;

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:preppa_profesores/models/subjects.dart';
import 'package:preppa_profesores/widgets/text_fileds.dart';
import 'package:provider/provider.dart';

import '../Services/group_services.dart';
import '../Services/subject_services.dart';
import '../Services/task_services.dart';
import '../widgets/myBackground.dart';
import '../widgets/toast_achievement.dart';
import '../widgets/utils/style_ElevatedButton.dart';
import '../widgets/widgetUpload.dart';

class ScreenCreateTask extends StatefulWidget {
  const ScreenCreateTask({super.key});

  @override
  State<ScreenCreateTask> createState() => _ScreenCreateTaskState();
}

class _ScreenCreateTaskState extends State<ScreenCreateTask> {
  String? nameTask;
  // se engvia com oun string vacio
  // pero esta inicalizado

  String descriptionTask = '';
  List<XFile> file = [];
  String? group;

  // name subject  creamos de  SubjectElement

  String? nameSubject;
  String? materia;

  // fecha por defecto
  DateTime fecha = DateTime.now();
  DateTime fechaOnly = DateTime.now();

// for fecha de exporacio de la tarea
  DateTime? expiredAt;
  @override
  Widget build(BuildContext context) {
    //  obtener la lista de las maashterial en al cuales se desean hacer
    final subjectServices = Provider.of<SubjectServices>(context);
    final subjects = subjectServices.subjects;

    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(' Crear tareas'),
        ),
        // PARA MOVILES
        body: Platform.isAndroid || Platform.isIOS
            ? Stack(
                children: [
                  const Positioned(
                    right: -200,
                    top: 20,
                    child: myBackground(),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Center(
                                    child: Text('SELECIONA MATERIA Y GRUPO')),
                                const SizedBox(height: 20),
                                Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          style:
                                              StyleElevatedButton.styleButton,
                                          onPressed: () {
                                            _showGroup(context);
                                          },
                                          child: const Text(' GRUPO')),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                          style:
                                              StyleElevatedButton.styleButton,
                                          onPressed: () {
                                            // _showGroup(context);

                                            showMateria(
                                                context, size, subjects);
                                          },
                                          child: const Text(' MATERIA')),
                                    ]),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  autofocus: false,
                                  validator: (value) {},
                                  onChanged: (String value) {
                                    // setState(() {});

                                    nameTask = value;
                                  },
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    // label: Text('CHALES'),

                                    hintMaxLines: 3,

                                    labelText: "TITULO",
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                TextFormField(
                                  autofocus: false,
                                  validator: (value) {},
                                  maxLines: 3,
                                  onChanged: (String value) {
                                    // setState(() {});
                                    descriptionTask = value;
                                  },
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    // label: Text('CHALES'),

                                    // hintMaxLines: 5,

                                    labelText: "DESCRIPCION",
                                  ),
                                ),
                                const SizedBox(height: 40),
                                // FECHA DE CREACION
                                // Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       const Text('FECHA DE CREACION : '),
                                //       Text(fechaOnly.toString().substring(0, 10)),
                                //     ]),
                                const SizedBox(height: 40),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 0.5, color: Colors.white10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('FECHA DE ENTREGA: '),
                                          Text(fecha
                                              .toString()
                                              .substring(0, 10)),
                                        ],
                                      ),

                                      const SizedBox(height: 30),

                                      // Text(dateTime.selectDateTime.toString()),
                                      // Text(dateTime.selectDateTime.year.toString()  + dateTime.selectDateTime.month.toString() + dateTime.selectDateTime.hour.toString()),
                                      // BOTON APRA SELECCCIONAR LAFEHCA
                                      ElevatedButton(
                                          onPressed: () async {
                                            _selectDate(context);
                                          },
                                          child: const Text(
                                              'Seleccionar Fecha de Entrega'))
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('AGREGAR ARCHIVO'),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: Colors.black,
                              onPressed: () async {
                                // instancia de la clased para crear la

                                final taskServices = Provider.of<TaskServices>(
                                    context,
                                    listen: false);

                                // verificar si el titulo se ha escrito
                                // en la cual lo demas puede ser nulo
                                if (nameTask == null ||
                                    nameSubject == null ||
                                    materia == null ||
                                    group == null ||
                                    expiredAt == null) {
                                  showDialogAlert(context);
                                  return null;
                                }

                                if (file.isEmpty) {
                                  // crear tareas sin image
                                  print('creando tareas  sin archivos');

                                  await taskServices.createTaskNotFile(
                                      '${nameSubject! + " : " + nameTask!}',
                                      descriptionTask,
                                      materia!,
                                      group!,
                                      fecha
                                      // expiredAt!
                                      );
                                  Show.show(
                                      context: context,
                                      title: 'Tarea Creado',
                                      subTitle: " chales ");
                                } else {
                                  // PASAR EL ID EN LA CUAL SE DESEA AGERGAR EL ARCHIVO
                                  // PATH DEL IMAGEN
                                  print('Creando datos con archivo primero');
                                  final task =
                                      await taskServices.createTaskNotFile(
                                          '${nameSubject! + " : " + nameTask!}',
                                          descriptionTask!,
                                          materia!,
                                          group!,
                                          // expiredAt!,
                                          fecha);

                                  // fileUploadServices.fileUpload(widget.file[index]);

                                  await taskServices.updateTaskAddFile(task,
                                      file.first); // fileUploadServices.fileUpload(widget.file[index]);

                                  // updateTaskAddFile
                                  Show.show(
                                      context: context,
                                      title: 'Tarea Creado',
                                      subTitle: " chales ");
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 55, right: 55, top: 15, bottom: 15),
                                child: Text('CREAR TAREA',
                                    style: TextStyle(color: Colors.white)),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            // PARA ESCRITORIO
            : Center(
                child: SizedBox(
                  // color: Colors.red,
                  width: size.width * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('AGREGAR TAREA'),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: Form(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              _showGroup(context);
                                            },
                                            child: const Text(
                                                'SELECCIONAR GRUPO')),
                                        ElevatedButton(
                                            onPressed: () {
                                              showMateria(
                                                  context, size, subjects);
                                            },
                                            child: const Text(
                                                'SELECCIONAR MATERIA'))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      // decoration:
                                      //     InputDecorations.authDecoration(
                                      //         hintText: 'Titulo',
                                      //         labelText: 'Titulo'),
                                      validator: (value) {},
                                      onChanged: (String value) {
                                        // setState(() {});

                                        nameTask = value;
                                      },
                                      keyboardType: TextInputType.text,
                                      // textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        // label: Text('CHALES'),

                                        hintMaxLines: 3,

                                        labelText: "TITULO",
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    TextFormField(
                                      validator: (value) {},
                                      maxLines: 3,
                                      onChanged: (String value) {
                                        // setState(() {});
                                        descriptionTask = value;
                                      },
                                      keyboardType: TextInputType.text,
                                      // textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        // label: Text('CHALES'),

                                        // hintMaxLines: 5,

                                        labelText: "DESCRIPCION",
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                        child: Column(children: [
                                          Text(
                                              'FECHA DE ENTREGA:  ${fecha.toString().substring(0, 10)}'),
                                          const SizedBox(height: 30),

                                          // BOTON APRA SELECCCIONAR LAFEHCA
                                          ElevatedButton(
                                              onPressed: () async {
                                                _selectDate(context);
                                              },
                                              child: const Text(
                                                  'Seleccionar Fecha de Entrega'))
                                        ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Platform.isAndroid || Platform.isIOS
                                ? Container()
                                : WidgetUpload(
                                    file: file,
                                  ),
                          ],
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: const Text('AGREGAR ARCHIVO'),
                        // ),
                        const SizedBox(
                          height: 50,
                        ),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Colors.black,
                            onPressed: () async {
                              // instancia de la clased para crear la

                              final taskServices = Provider.of<TaskServices>(
                                  context,
                                  listen: false);

                              // verificar si el titulo se ha escrito
                              // en la cual lo demas puede ser nulo
                              if (nameTask == null ||
                                  nameSubject == null ||
                                  materia == null ||
                                  group == null ||
                                  expiredAt == null) {
                                showDialogAlert(context);
                                return null;
                              }

                              if (file.isEmpty) {
                                // crear tareas sin image
                                print('creando tareas  sin archivos');

                                await taskServices.createTaskNotFile(
                                    '${nameSubject! + " : " + nameTask!}',
                                    descriptionTask,
                                    materia!,
                                    group!,
                                    fecha
                                    // expiredAt!
                                    );
                                Show.show(
                                    context: context,
                                    title: 'Tarea Creado',
                                    subTitle: " chales ");
                              } else {
                                // PASAR EL ID EN LA CUAL SE DESEA AGERGAR EL ARCHIVO
                                // PATH DEL IMAGEN
                                print('Creando datos con archivo primero');
                                final task =
                                    await taskServices.createTaskNotFile(
                                        '${nameSubject! + " : " + nameTask!}',
                                        descriptionTask!,
                                        materia!,
                                        group!,
                                        // expiredAt!,
                                        fecha);

                                // fileUploadServices.fileUpload(widget.file[index]);

                                await taskServices.updateTaskAddFile(task,
                                    file.first); // fileUploadServices.fileUpload(widget.file[index]);

                                // updateTaskAddFile
                                Show.show(
                                    context: context,
                                    title: 'Tarea Creado',
                                    subTitle: " chales ");
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 55, right: 55, top: 15, bottom: 15),
                              child: Text('INGRESAR',
                                  style: TextStyle(color: Colors.white)),
                            )),
                      ],
                    ),
                  ),
                ),
              ));
  
       // funcion para cargar las taras que 7an son activas
  }


  // par la alerta de los datos
  // por si no se agrega el titulo de la tareas en la cual si lo demas no no pasa dnasa
  void showDialogAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Título de la alerta'),
          content: Text('Mensaje de la alerta'),
          actions: [
            ElevatedButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> showMateria(
          BuildContext context, Size size, List<Subjects> subjects) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                width: size.width * 0.6,
                height: Platform.isAndroid || Platform.isIOS
                    ? size.height / 2
                    : size.height / 3,
                child: Center(
                  child: Wrap(
                    children: List.generate(
                        subjects.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SizedBox(
                                // color: Colors.red,
                                width: 150,
                                // height: 50,
                                child: ElevatedButton(
                                  style: StyleElevatedButton.styleButton,
                                  onPressed: () async {
                                    materia = subjects[index].uid;
                                    nameSubject = subjects[index].name;
                                    Navigator.pop(context);
                                    setState(() {});

                                    //   openSelectGroup(
                                    //       context,
                                    //       size,
                                    //       subjects.subject[index].name,
                                    //       subjects.subject[index].uid);
                                    //   // openDialog(context, size, nameTask!,
                                    //   //     descriptionTask!, file);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Text(subjects[index].name),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              ),
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
            );
          });

  _showGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final groupServider =
            Provider.of<GroupServices>(context, listen: false);
        final groups = groupServider.group;
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          title: const Text('SELECCIONAR GRUPO'),
          content: SizedBox(
            width: size.width * 0.6,
            height: size.height / 3,
            child: Center(
              child: Wrap(
                children: List.generate(groups.groups.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: StyleElevatedButton.styleButton,
                      onPressed: () async {
                        group = groups.groups[index].uid;
                        Navigator.pop(context);
                        setState(() {});
                        // final subjectServices =
                        //     Provider.of<SubjectServices>(context, listen: false);

                        // final taskServices =
                        //     Provider.of<TaskServices>(context, listen: false);

                        // // taskServices.getTaskForSbubject(
                        // //     groups.groups[index].uid,
                        // //     idSubject);

                        // List<Tasks> tasks = taskServices.tasksForSubject;
                        // Navigator.pop(context);
                        // // hacmeos la navegacion hacia la vista
                        // Navigator.pushNamed(context, 'allTaskSubject',
                        //     arguments: tasks);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          height: 30,
                          child: Center(child: Text(groups.groups[index].name)),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

// / funciuon para las fechas
  _selectDate(BuildContext context) async {
    // DateTime selectedDate = DateTime.now();

    // varaible que guarda la fecha seleccionada
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
      // cambaira el texto de los botones
      helpText: 'Seleccionar Fecha ',
      cancelText: 'Cancelar',
      confirmText: 'Guardar',
      // locale: const Locale('es', 'MX'),
    );

    // si para una de stas condiciones actualizamos el  datos
    if (selected != null && selected != fecha) {
      fecha = selected;
      expiredAt = selected;
      // dateTime.selectDateTime = selected;
      setState(() {});
      //  dateServices.
    }
  }
}

// ignore: camel_case_types
class widgetOpload extends StatefulWidget {
  // const widgetOpload({super.key});

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
                color: isDragging == false ? Colors.red : Colors.white,
                width: 250,
                height: 250,
                child: Center(
                  child: isDragging == false
                      ? Text('ARRSTRE EL ARCHIVO ACA')
                      : Text('AGREGANDO ARCHIVO....'),
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

    print('Typo de extension de la imagen' + extend);

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
