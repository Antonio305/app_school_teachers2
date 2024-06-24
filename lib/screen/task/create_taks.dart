import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/uploadFile.dart';
import 'package:preppa_profesores/models/date/time.dart';
import 'package:preppa_profesores/models/subjects.dart';
import 'package:preppa_profesores/models/task/newTask.dart';
import 'package:preppa_profesores/models/task/tasks.dart';
import 'package:preppa_profesores/providers/form_task.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/providers/thme_provider.dart';
import 'package:preppa_profesores/widgets/listsDropDowns.dart';
import 'package:preppa_profesores/widgets/showDialogs/showDialogRequesthHttp.dart';
import 'package:preppa_profesores/widgets/text_fileds.dart';
import 'package:provider/provider.dart';

import '../../Services/group_services.dart';
import '../../Services/subject_services.dart';
import '../../Services/task_services.dart';
import '../../widgets/myBackground.dart';
import '../../widgets/utils/style_ElevatedButton.dart';
import '../../widgets/widgetUpload.dart';

// FormToCreateTask
class ScreenCreateTask extends StatefulWidget {
  const ScreenCreateTask({super.key});

  @override
  State<ScreenCreateTask> createState() => _ScreenCreateTaskState();
}

class _ScreenCreateTaskState extends State<ScreenCreateTask> {
  late NewTask newTask;

  @override
  Widget build(BuildContext context) {
    final taskServices = Provider.of<TaskServices>(context);
    final task = taskServices.selectedTask;
    if (task == null) {
      newTask = NewTask(
          nameTask: '',
          description: '',
          subject: '',
          semestre: '',
          group: '',
          nameSubject: '',
          date: DateTime.now());
    } else {
      newTask = NewTask(
          nameTask: task.nameTask,
          description: task.description,
          subject: task.subject.uid,
          // semestre: task.t.,
          group: task.group.uid,
          nameSubject: task.subject.name,
          date: task.expiredAt);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva tarea')),
      body: const FormToCreateTask(),
    );
  }
}

class FormToCreateTask extends StatefulWidget {
  const FormToCreateTask({super.key});

  @override
  State<FormToCreateTask> createState() => _FormToCreateTaskState();
}

class _FormToCreateTaskState extends State<FormToCreateTask> {
  // controller
  final ScrollController _scrollControllerTitle = ScrollController();
  final ScrollController _scrollControllerDescription = ScrollController();
  final _focusNode = FocusNode();

  String? nameFile;
  List<XFile> file = []; // BY  DESKTOP

  File? fileTwo;
  List<File> listFiles = [];
  List<String> nameFiles = [];
  String? nameTask;
  String descriptionTask = '';
  String? group;

  String? nameSubject;

  late Subjects materia;

  // fecha por defecto
  DateTime fecha = DateTime.now();
  DateTime fechaOnly = DateTime.now();

// for fecha de exporacio de la tarea
  DateTime? expiredAt;
  DateTime _selectedDateTime = DateTime.now();

  late NewTask task;

  void initialData() {
    final formCreateTask = Provider.of<FormCreateTaskProvider>(context);
    task = formCreateTask.task;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialData();
  }

  @override
  Widget build(BuildContext context) {
    final subjectServices = Provider.of<SubjectServices>(context);
    final themeServices = Provider.of<ThemeProvier>(context);
    final taskServices = Provider.of<TaskServices>(context);
    final uploadFileServices = Provider.of<UploadFileServices>(context);

    final subjects = subjectServices.subjects;
    final isDarkTheme = themeServices.currentTheme;
    final size = MediaQuery.of(context).size;

    return IsMobile.isMobile()
        ? widgetCreateTaskMobile(context, size, subjects, isDarkTheme,
            uploadFileServices, taskServices)
        // PARA ESCRITORIO
        : widgetCreateTaskDesktop(size, context, subjects, taskServices);

    // funcion para cargar las taras que 7an son activas
  }

  Widget widgetCreateTaskDesktop(Size size, BuildContext context,
      List<Subjects> subjects, TaskServices taskServices) {
    return Center(
      child: Container(
        // color: Colors.red,
        // width: size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detailTask(size, context, subjects, taskServices),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.blue.withOpacity(0.3),
                    width: 1,
                    height: size.height,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  addFile(size),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox addFile(Size size) {
    return SizedBox(
      // width: size.width * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Subir desde tu dispositivo'),
          const SizedBox(
            height: 20,
          ),
          WidgetUpload(
            size: size,
            file: file,
          ),
        ],
      ),
    );
  }

  Row buttonTaskCreate(BuildContext context, TaskServices taskServices) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      // mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(onPressed: () {}, child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: () async {
            // instancia de la clased para crear la

            // verificar si el titulo se ha escrito
            // en la cual lo demas puede ser nulo
            if (nameTask == null ||
                nameSubject == null ||
                // materia == null ||
                group == null ||
                expiredAt == null) {
              showDialogAlert(context);
              return;
            }

            if (file.isEmpty) {
              // crear tareas sin image
              print('creando tareas  sin archivos');

              final resp = await taskServices.createTaskNotFile(
                  nameTask!,
                  descriptionTask,
                  materia.uid,
                  materia.semestre.id,
                  group!,
                  materia.name,
                  fecha
                  // expiredAt!
                  );

              // ignore: use_build_context_synchronously
              ShowDialogHttpResponsesMessages.showMessage(
                  context, 'Crear tarea', resp);
              // Show.show(
              // context: context,
              // title: 'Tarea Creado',
              // subTitle
              //
              //: " chales ");
            } else {
              // PASAR EL ID EN LA CUAL SE DESEA AGERGAR EL ARCHIVO
              // PATH DEL IMAGEN
              print('Creando datos con archivo primero');
              final task = await taskServices.createTaskNotFile(
                  "${nameSubject!} : ${nameTask!}",
                  descriptionTask,
                  materia.uid,
                  materia.semestre.id,
                  group!,
                  materia.name,
                  // expiredAt!,
                  fecha);

              // fileUploadServices.fileUpload(widget.file[index]);
              // task is idTask
              // await taskServices.updateTaskAddFile(task,
              //     file.first); // fileUploadServices.fileUpload(widget.file[index]);

              // updateTaskAddFile
              // Show.show(
              //     context: context,
              //     title: 'Tarea Creado',
              //     subTitle: " chales ");
            }
          },
          child: const Text('Crear tarea'),
        ),
      ],
    );
  }

  Stack widgetCreateTaskMobile(
      BuildContext context,
      Size size,
      List<Subjects> subjects,
      ThemeData isDarkTheme,
      UploadFileServices uploadFileServices,
      TaskServices taskServices) {
    return Stack(
      children: [
        const Positioned(
          right: -200,
          top: 20,
          child: myBackground(),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Form(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Selecciona materia y grupo',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                              // spaceBetween acomodal os  wwwidgets a los extremos
                              MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: StyleElevatedButton.styleButton,
                                onPressed: () {
                                  _showGroup(context);
                                },
                                child: const Text('Grupo')),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                style: StyleElevatedButton.styleButton,
                                onPressed: () {
                                  // _showGroup(context);

                                  showMateria(context, size, subjects);
                                },
                                child: const Text('Materia')),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        scrollController: _scrollControllerTitle,
                        maxLength: 200,
                        maxLines: 5,
                        minLines: 1,
                        keyboardType: TextInputType.text,
                        focusNode: _focusNode,
                        autofocus: false,

                        validator: (value) {
                          return null;
                        },
                        onChanged: (String value) {
                          // setState(() {});

                          nameTask = value;
                        },
                        // textAlign: TextAlign.center,
                        decoration: InputDecorations.authDecoration(
                            labelText: 'Titulo'),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      const Text('Descripcion'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        scrollController: _scrollControllerDescription,
                        // maxLength: 500,
                        maxLength: 400,
                        maxLines: 8,
                        minLines: 1,
                        keyboardType: TextInputType.text,
                        focusNode: _focusNode,
                        autocorrect: true,
                        autofocus: false,
                        validator: (value) {
                          return null;
                        },
                        onChanged: (String value) {
                          // setState(() {});
                          descriptionTask = value;
                        },
                        // textAlign: TextAlign.center,
                        decoration: InputDecorations.authDecoration(
                            labelText: 'Descripcion'),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // color: Colors.red,

                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 0.5,
                              // ignore: unrelated_type_equality_checks
                              color: isDarkTheme == false
                                  ? Colors.white24
                                  : Colors.white12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Fecha  de entrega: '),
                                Text(fecha.toString().substring(0, 10)),
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
                                child:
                                    const Text('Seleccionar Fecha de Entrega'))
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  // color: const Color(0xff25282F),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (nameFiles.isEmpty)
                            const Text('NO HAY ARCHIVOS SELECCIONADOS')
                          else
                            SizedBox(
                                height: 40,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    nameFiles.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          nameFiles[index],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          const SizedBox(
                            height: 5,
                          ),
                          if (IsMobile.isMobile())
                            ElevatedButton(
                              // color: Colors.black87,

                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(allowMultiple: true);

                                // Si es diferente a null

                                if (result != null) {
                                  // addl ist files
                                  setState(() {
                                    listFiles = result.paths
                                        .map((path) => File(path!))
                                        .toList();
                                    // add list name Files
                                    nameFiles =
                                        result.names.map((e) => e!).toList();
                                  });
                                } else {
                                  // User canceled the picker - el usuario cancelo el selector
                                  print('No se seleciono nada');
                                }

                                // FilePickerResult? result =
                                //     await FilePicker.platform
                                //         .pickFiles();

                                // if (result == null) {
                                //   // ignore: use_build_context_synchronously
                                //   // MySnackBar.MySnack(
                                //   //     context, 'No se seleciono ningun archivo');
                                //   // User canceled the picker
                                //   print('USER CANCELED THE PICKER');
                                // } else {
                                //   setState(() {
                                //     // file = File(
                                //     //     result.files.single.path!);
                                //     fileTwo = File(
                                //         result.files.single.path!);
                                //     nameFile =
                                //         result.files.single.name;
                                //   });
                                //   // setState(() {});
                                //   print(fileTwo!.path);
                                // }
                              },

                              child: const Text(
                                ' Selecionar Archivoss ',
                                style: TextStyle(
                                    // color: Colors.white60,
                                    fontSize: 14),
                              ),
                            )
                          else
                            Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          Navigator.of(context);
                        },
                        child: const Text('Cancelar')),
                    ElevatedButton(
                      onPressed: () async {
                        _focusNode.requestFocus();

                        // instancia de la clased para crear la

                        final taskServices =
                            Provider.of<TaskServices>(context, listen: false);

                        if (nameTask == null ||
                            nameSubject == null ||
                            materia == null ||
                            group == null ||
                            expiredAt == null) {
                          showDialogAlert(context);
                          return;
                        }

                        if (listFiles.isEmpty) {
                          // crear tareas sin image
                          print('creando tareas  sin archivos');

                          await taskServices.createTaskNotFile(
                              nameTask!,
                              descriptionTask,
                              materia.uid,
                              materia.semestre.id,
                              group!,
                              materia.name,
                              fecha
                              // expiredAt!
                              );
                          // Show.show(
                          //     context: context,
                          //     title: 'Tarea Creado',
                          //     subTitle: " chales ");
                        } else {
                          // PASAR EL ID EN LA CUAL SE DESEA AGERGAR EL ARCHIVO
                          // PATH DEL IMAGEN
                          print('Creando datos con archivo primero');
                          final task = await taskServices.createTaskNotFile(
                              nameTask!,
                              descriptionTask,
                              materia.uid,
                              materia.semestre.id,
                              group!,
                              materia.name,
                              // expiredAt!,
                              fecha);

                          await uploadFileServices.updateTaskAddFiles(task,
                              listFiles); // fileUploadServices.fileUpload(widget.file[index]);

                          // updateTaskAddFile
                          //   Show.show(
                          //       context: context,
                          //       title: 'Tarea Creado',
                          //       subTitle: " chales ");
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 55, right: 55, top: 10, bottom: 10),
                          child: taskServices.status == true
                              ? const Row(
                                  children: [
                                    Text('CREANDO TAREA...'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                )
                              : const Text(
                                  'Crear',
                                )),
                    ),
                  ],
                ),
                const SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget detailTask(Size size, BuildContext context, List<Subjects> subjects,
      TaskServices taskServices) {
    return SizedBox(
      // width: size.width * 0.4, //antes
      // width: size.width * 0.3,
      width: size.width * 0.27,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Requerimientos de la tarea'),
            const SizedBox(
              height: 10,
            ),
            const Text('Titulo*'),
            const SizedBox(
              height: 8,
            ),
            taskTitle(),
            const SizedBox(height: 40),
            listOfGroupAndSuject(),
            const SizedBox(height: 40),
            date(),
            const SizedBox(
              height: 40,
            ),
            description(),
            const SizedBox(
              height: 50,
            ),
            buttonTaskCreate(context, taskServices),
          ],
        ),
      ),
    );
  }

  Column description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Descripcion*'),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: (value) {
            return null;
          },
          autocorrect: true,
          textAlign: TextAlign.start,
          minLines: 2,
          maxLines: 8,
          onChanged: (String value) {
            // setState(() {});
            descriptionTask = value;
          },
          keyboardType: TextInputType.text,
          decoration: InputDecorations.authDecoration(
              labelText: 'Introducir descripcion'),
        ),
      ],
    );
  }

  Widget date() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fecha de vencimiento',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // ignore: prefer_interpolation_to_compose_strings
                  Text("${fecha.toString().substring(0, 16)} hrs."
                      //  +
                      // fecha.hour.toString() +
                      // fecha.minute.toString(),
                      ),
                  const SizedBox(height: 30),
                ]),
              ),
            ),
            TextButton.icon(
                onPressed: () async {
                  _showDateTimePicker();
                },
                icon: const Icon(
                  Icons.add,
                  size: 16,
                ),
                label: const Text('Hora y Fecha'))
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Text('Tiempo restante*'),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(MyTime(initialDate: DateTime.now(), finalDate: fecha)
                    .daysToSubmitAssignment),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column listOfGroupAndSuject() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '° Selecionar materia y grupo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        const Text(
          'Grupo*',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 10,
        ),
        DropDownGroups(onTap: () {}),
        const SizedBox(
          width: 50,
        ),
        const Text(
          'Materia*',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 10,
        ),
        DropDownSubjects(onTap: () {}),
      ],
    );
  }

  TextFormField taskTitle() {
    return TextFormField(
      // expands: true,
      validator: (value) {
        return null;
      },
      minLines: 1,
      maxLines: 3,
      autocorrect: true,
      onChanged: (String value) {
        // setState(() {});

        nameTask = value;
      },
      keyboardType: TextInputType.text,
      decoration:
          InputDecorations.authDecoration(labelText: 'Introducir titulo'),
    );
  }

  Future _showDateTimePicker() async {
    // DatePicker.showDatePicker(
    final pickedDateTime = await showDatePicker(
      // locale: const Locale('es', 'MX'),
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      // locale: LocaleType.es
    );
    if (pickedDateTime != null) {
      // ignore: use_build_context_synchronously
      final pickedTime = await showTimePicker(
        confirmText: "Aceptar",
        context: context,
        initialTime: TimeOfDay.fromDateTime(pickedDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          fecha = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          expiredAt = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          // _selectedDateTime = DateTime(
          //   pickedDateTime.year,
          //   pickedDateTime.month,
          //   pickedDateTime.day,
          //   pickedTime.hour,
          //   pickedTime.minute,
          // );
        });
      }
    }
  }

  // par la alerta de los datos
  // por si no se agrega el titulo de la tareas en la cual si lo demas no no pasa dnasa
  void showDialogAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('No has seleccionado las opiones requeridas'),
          actions: [
            ElevatedButton(
              child: const Text('Aceptar'),
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
              icon: const Icon(Icons.subject_outlined),
              title: const Text('Materias'),
              content: Wrap(
                spacing: 10,
                children: List.generate(
                    subjects.length,
                    (index) => ElevatedButton(
                          style: StyleElevatedButton.styleButton,
                          onPressed: () async {
                            materia = subjects[index];
                            nameSubject = subjects[index].name;
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Text(subjects[index].name),
                        )),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                    style: StyleElevatedButton.styleButton,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 35, right: 35),
                      child: Text(
                        'Salir',
                      ),
                    ))
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
        return AlertDialog(
          title: const Text('Grupos'),
          icon: const Icon(Icons.group_outlined),
          // contentPadding: const EdgeInsets.all(10),
          content: Wrap(
            children: List.generate(groups.groups.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
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
                    child: SizedBox(
                      width: 25,
                      height: 30,
                      child: Center(child: Text(groups.groups[index].name)),
                    ),
                  ),
                ),
              );
            }),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              style: StyleElevatedButton.styleButton,
              child: const Text('Salir'),
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
                width: 250,
                height: 250,
                child: Center(
                  child: isDragging == false
                      ? const Text('ARRSTRE EL ARCHIVO ACA')
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
