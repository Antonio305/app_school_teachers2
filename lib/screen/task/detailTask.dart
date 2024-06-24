import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:preppa_profesores/Services/taskReceived.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:preppa_profesores/models/taskReceived.dart';
import 'package:preppa_profesores/utils/shapeBorderDialog.dart';
import 'package:preppa_profesores/widgets/text_fileds.dart';
import 'package:provider/provider.dart';

import '../../models/task/tasks.dart';

class TaskReceivedDetail extends StatefulWidget {
  const TaskReceivedDetail({super.key});

  @override
  State<TaskReceivedDetail> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskReceivedDetail> {
  late TaskReceivedServices taskReceivedServices;
  late TaskServices taskServices;
  late TaskReceived taskReceived;
  late Tasks task;
  // contoller text field by add grades the task
  TextEditingController gradeController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gradeController.text = '';
  }

  bool editAssignmentGrade = false;

  @override
  Widget build(BuildContext context) {
    taskReceivedServices = Provider.of<TaskReceivedServices>(context);
    taskServices = Provider.of<TaskServices>(context);
    // if (taskReceived != null) {
    taskReceived = taskReceivedServices.taskReceivedSelected;
    task = taskServices.selectedTask!;
    // }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estudiante',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white12)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(taskReceived.nameLastNameStudentSecondName),
              )),
          const Divider(),
          Row(
            children: [
              const Icon(Icons.task, size: 16),
              const SizedBox(
                width: 10,
              ),
              Text("Tarea. ${taskReceived.task.nameTask}"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.stream_outlined,
                size: 16,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('Estado'),
              const SizedBox(
                width: 5,
              ),
              Text(taskReceived.task.status == true
                  ? 'En proceeso'
                  : 'No activo')
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                Icons.description,
                size: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Descripcion'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white12)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  " To select all documents in the collection, pass an empty document as the query filter parameter to the query bar. The query filter parameter determines the select criteria:${taskReceived.task.description}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Icon(
                Icons.date_range,
                size: 16,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('Fechas de creacion y entrega'),
              const SizedBox(
                width: 30,
              ),
              Text(
                "${DateFormat('dd-MMM-yyyy').format(taskReceived.createdAt!).substring(0, 6)} - ${DateFormat('dd-MMM-yyyy').format(taskReceived.updatedAt!)} ",
              ),
            ],
          ),
          // const Divider(),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Archivos (3)'),
              OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.download,
                    size: 16,
                  ),
                  label: const Text('Descargar todo'))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            children: List.generate(
              3,
              (index) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 230,
                    height: 60,
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(
                        Icons.picture_as_pdf,
                        size: 50,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Profile-noadd-filedddde@2x.png',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.download),
                                label: const Text('Descargar')),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (taskReceived.isQualified)
                Row(
                  children: [
                    const Icon(Icons.grade),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Calificacion:  ${taskReceived.rating}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          editAssignmentGrade = true;
                        });
                      },
                      icon: const Icon(Icons.edit),
                    )
                  ],
                ),
              const SizedBox(
                width: 10,
              ),
              if (taskReceived.isQualified == false ||
                  editAssignmentGrade == true)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        // height: 45,
                        width: 170,
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _globalKey,
                          child: TextFormField(
                            validator: (value) {
                              // // Expresión regular para verificar si la entrada es numérica
                              final isDigitsOnly =
                                  RegExp(r'^\d+$').hasMatch(value ?? '');
                              if (!isDigitsOnly) {
                                return 'Solo se permite números';
                              }
                              return null;
                            },
                            controller: gradeController,
                            textAlign: TextAlign.center,
                            autocorrect: true,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecorations.authDecoration(
                                // hintText: 'hi',
                                labelText: 'Calificacion'),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          if (_globalKey.currentState!.validate() == false) {
                            return;
                          }
                          if (gradeController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: MyShapeBorderAlertDialog
                                      .borderAlertDialog,
                                  // icon: const Icon(Icons.grade),
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Calificacion de la tarea no agregado'),
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

                          await taskReceivedServices.taskQualify(context,
                              taskReceived.id!, gradeController.text, true);

                          // Navigator.pop(context);

                          // Task =  taskReceived.taskReceivedSelected;
                          // taskReceiveds = taskReceived.taskReceivedSelected;
                        },
                        icon:
                            // taskReceivedServices.
                            const Icon(
                          Icons.data_saver_on_rounded,
                          size: 20,
                        ),
                        label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: taskReceivedServices.status == false
                                ? const Text(
                                    'Calificar',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(
                                    'Calificando ...',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))),
                  ],
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comentarios: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'The following example retrieves all documents from the inventory collection where status equals either "A" or "D":.Copy the following filter into the Compass query bar and click Find.',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
