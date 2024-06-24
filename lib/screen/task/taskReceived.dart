import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:preppa_profesores/Services/taskReceived.dart';
import 'package:preppa_profesores/widgets/sceen_download.dart';
import 'package:provider/provider.dart';

import '../../models/task/tasks.dart';
import '../../models/taskReceived.dart';
import '../../widgets/text_fileds.dart';

class ScreenGradeAssignments extends StatefulWidget {
  const ScreenGradeAssignments({super.key});

  @override
  State<ScreenGradeAssignments> createState() => _ScreenGradeAssignmentsState();
}

class _ScreenGradeAssignmentsState extends State<ScreenGradeAssignments> {
  late Tasks task = Tasks(
      id: '',
      subject: Group(name: '', uid: ''),
      nameTask: '',
      description: '',
      status: true,
      group: Group(name: '', uid: ''),
      createdAt: DateTime.now(),
      expiredAt: DateTime.now(),
      userTeacher: UserTeacher(
          name: '', lastName: '', secondName: '', collegeDegree: '', uid: ''),
      archivos: [],
      v: 0);

  TaskReceived taskReceiveds = TaskReceived(
      id: '',
      task: TaskReceiveds(
          id: '',
          subject: '',
          nameTask: '',
          description: '',
          status: false,
          group: '',
          userTeacher: '',
          v: 0,
          archivos: []),
      student: TaskStudent(name: '', lastName: '', secondName: '', uid: ''),
      rating: 0,
      isQualified: false,
      comments: '',
      v: 0,
      archivos: [],
      subject: Subject(name: '', uid: ''),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  late List<TaskReceived> taskReceivedd = [];
  final TextEditingController _gradeController = TextEditingController();
  String? grades;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _gradeController.text = grades!;
    grades = _gradeController.text;
  }

  @override
  Widget build(BuildContext context) {
    final taskReceivedServices = Provider.of<TaskReceivedServices>(context);

    final taskReceived = taskReceivedServices.taskReceivedSelected;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(taskReceived.subject.name),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialogAddQualified(context, taskReceived.id!, size);
        },
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Text('Calificar'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.03),
                image(size),
                const SizedBox(height: 50),
                Text(
                  'Fecha de entrega:   ${taskReceived.deliveryDate}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                const Text('Detalles de la tarea'),
                Card(
                  child: SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tarea: '),
                            Text(taskReceived.task.nameTask),
                            const SizedBox(height: 10),
                            const Text('Descripcion: '),
                            Text(taskReceived.task.description),
                          ]),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 15),
                const Text('Detalles de la tarea recivida:'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Calificacion:   ${taskReceived.rating}"),
                    const SizedBox(height: 10),
                    taskReceived.isQualified == false
                        ? const Text("Calificado : NO")
                        : const Text("Calificado : SI"),
                  ],
                ),
                const SizedBox(height: 30),
                taskReceived.archivos == null
                    ? const Text('Archivo: NO')
                    : const Column(
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Text('Archivo: SI'),
                          //     const SizedBox(width: 10),
                          //     TextButton(
                          //       onPressed: () async {
                          //         if (await Permission.storage
                          //             .request()
                          //             .isGranted) {
                          //           // Permission is granted
                          //           // ignore: use_build_context_synchronously
                          //           ScaffoldMessenger.of(context).showSnackBar(
                          //             const SnackBar(
                          //               content: Text(
                          //                   'Permiso de almacenamiento aceptado'),
                          //             ),
                          //           );
                          //         } else {
                          //           // Permission is not granted
                          //           // ignore: use_build_context_synchronously
                          //           ScaffoldMessenger.of(context).showSnackBar(
                          //             const SnackBar(
                          //               content: Text(
                          //                   'Permiso de almacenamiento denegado de forma permanente.'),
                          //             ),
                          //           );
                          //         }
                          //       },
                          //       child: const Text('Descargar'),
                          //     ),
                          //   ],
                          // ),

                          ScreenDownload(
                              urls:
                                  'http://4.bp.blogspot.com/-DYVbSKM0xGQ/UnKclbsDugI/AAAAAAAAAI0/v3FhyPcK02Y/s1600/imagenes-de-perritos-bonitos.jpg',
                              nameFile: 'CHALES'),
                        ],
                      ),
                const SizedBox(height: 8),
                SizedBox(
                  width: size.width / 1.2,
                  child: taskReceived.comments == null
                      ? const Text('Sin comentarios.')
                      : Text('Comentarios ${taskReceived.comments}'),
                ),
                const SizedBox(height: 3),
                const Divider(),
                const SizedBox(height: 20),
                const Text('Alumno:'),
                const SizedBox(height: 5),
                Text(taskReceived.studentName),
                const SizedBox(height: 50),
              ]),
        ),
      ),
    );
  }

  Center image(Size size) {
    return Center(
      child: SizedBox(
        height: size.height * 0.2,
        width: size.width * 0.4,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: Image.asset('assets/gradedtask.png', fit: BoxFit.fill)),
      ),
    );
  }

  Future<String?> showDialogAddQualified(
          BuildContext context, String idReceivedTask, Size size) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(10),
              buttonPadding: const EdgeInsets.all(0),
              scrollable: true,
              icon: const Icon(Icons.grade_outlined),
              title: const Text('Calificar'),
              // content: ContentCalificacion(idReceivedTask: idReceivedTask),
              content: SizedBox(
                width: size.width,
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      grades = value;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecorations.authDecoration(
                      // hintText: 'Ingresa la calificacion',
                      labelText: 'Ingresa la calificacion',

                      // prefixIcon: Icons.grade
                      // ),
                    )),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar')),
                TextButton(
                    onPressed: () async {
                      // Navigator.pop(context);
                      final taskReceived = Provider.of<TaskReceivedServices>(
                          context,
                          listen: false);

                      if (grades!.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              icon: const Icon(Icons.grade),
                              content: const Text(
                                  'No has agregado la calificacion de la tarea'),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Aceptar'))
                              ],
                            );
                          },
                        );
                        return;
                      }
                      await taskReceived.taskQualify(
                          context, idReceivedTask, grades!, true);
                      // ignore: use_build_context_synchronously
                      // Task =  taskReceived.taskReceivedSelected;
                      taskReceiveds = taskReceived.taskReceivedSelected;
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: const Text('Guardar Cal.', style: TextStyle())),
              ],
            );
          });
}
