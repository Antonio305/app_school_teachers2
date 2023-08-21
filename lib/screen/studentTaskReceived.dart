import 'package:flutter/material.dart';
import 'package:preppa_profesores/models/task.dart';
import 'package:preppa_profesores/models/taskReceived.dart';
import 'package:provider/provider.dart';

import '../Services/taskReceived.dart';

class StudentTasktReceived extends StatefulWidget {
  const StudentTasktReceived({super.key});

  @override
  State<StudentTasktReceived> createState() => _StudentTasktReceivedState();
}

class _StudentTasktReceivedState extends State<StudentTasktReceived> {
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
      archivos: '',
      v: 0);

// para mostrar en cada campo de la vista

  TaskReceived taskReceiveds = TaskReceived(id: '', task: TaskReceiveds(id: '', subject: '', nameTask: '', description: '', status: false, group: '', userTeacher: '', v: 0, archivos: ''),
   student: TaskStudent(name: '', lastName: '', secondName: '', uid: ''), 
   rating: 0, isQualified: false, comments: '', v: 0, archivos: '');     
  late List<TaskReceived> taskReceivedd = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final taskReceivedServices = Provider.of<TaskReceivedServices>(context);

    final List<TaskReceived> taskReceived = taskReceivedServices.taskReceived;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Lista de estudiantes con tarea')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ListStudent(size: size),
              ListStudent(size, taskReceived),
              // ContentTask(size: size),
              ContentTask(size, taskReceived),
            ],
          ),
        ),
      ),
    );
  }

  Container ContentTask(Size size, List<TaskReceived> taskReceived) {
    return Container(
      width: size.width * 0.685,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff13162a),
      ),
      child: taskReceived.isEmpty
          ? const Center(
              child: Text('Nodie ha entregado tara',
                  style: TextStyle(fontSize: 20)),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  SizedBox(height: size.height * 0.02),

// para mostar el detalle de la tareas recivida

                  const Text('DATOS DE LA TAREAS RECIVIDO:'),

                  // Text('tareas ${task.archivos}'),
                  Container(
                    width: size.width * 0.5,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(width: 0.1, color: Colors.white38),
                      color: Color(0xff191C37),

                      // color:Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.37,
                            width: size.width * 0.31,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: task.archivos == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset('assets/prepa.gif',
                                        fit: BoxFit.fill))
                                : Center(child: const Text('chales')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: size.width * 0.3,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Calificacion:  ${taskReceiveds.rating}"),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        taskReceiveds.isQualified == false
                                            ? Text("Calificado : NO")
                                            : Text("Calificado : SI"),
                                        taskReceiveds.archivos == null
                                            ? Text('Archivo: NO')
                                            : Row(
                                                children: [
                                                  Text('Archivo: SI'),
                                                  const SizedBox(width: 10),
                                                  MaterialButton(
                                                    color: Colors.black54,
                                                    onPressed: () {},
                                                    child:
                                                        const Text('Descargar'),
                                                  ),
                                                ],
                                              )
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(task.nameTask),
                                    SizedBox(height: size.height * 0.1),
                                    Center(
                                      child: MaterialButton(
                                        color: Colors.black87,
                                        elevation: 2,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                          // topLeft: Radius.circular(20),
                                          // bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          topRight: Radius.circular(10),
                                        )),
                                        onPressed: () {
                                          openDialogCalificacion(
                                              context, taskReceiveds.id!);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 15),
                                          child: Text('Calificar'),
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
    );
  }

  Container ListStudent(Size size, List<TaskReceived> taskReceived) {
    return Container(
      width: size.width * 0.285,
      // height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff13162C),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text('LISTA DE ALUMNOS'),
          const SizedBox(height: 15),
          Expanded(
            child: taskReceived.length == 0
                ? const Center(
                    child: Text('Nodie ha entregado tara',
                        style: TextStyle(fontSize: 20)),
                  )
                : ListView.builder(
                    itemCount: taskReceived.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                          dense: true,
                          onTap: () {
                            // el valor de la claes lo vamos a cambiar por la que seleccionaremos aca
                            taskReceiveds = taskReceived[index];

                            // task = taskReceived.taskReceived[index].task;
                            setState(() {});
                            //  Task(rating: rating, id: id, subject: subject, nameTask: nameTask, description: description, status: status, group: group, userTeacher: userTeacher, v: v)
                            print(task.nameTask);
                          },
                          selectedColor: Colors.white54,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          style: ListTileStyle.drawer,
                          title: Text(
                              taskReceived[index].student.name +
                                  "  " +
                                      taskReceived[index].student.lastName +
                                  " " +
                                      taskReceived[index].student.secondName),
                          leading: CircleAvatar(
                              child: Text('Diana'.substring(0, 2))),
                          subtitle: Text('Grado  - Grupo'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<String?> openDialogCalificacion(
          BuildContext context, String idReceivedTask) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            return Center(
              child: AlertDialog(
                content: ContentCalificacion(idReceivedTask: idReceivedTask),
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

class ContentCalificacion extends StatefulWidget {
  final String idReceivedTask;

  const ContentCalificacion({super.key, required this.idReceivedTask});
  @override
  State<ContentCalificacion> createState() => _ContentCalificacionState();
}

class _ContentCalificacionState extends State<ContentCalificacion> {
  final List<String> calificacion = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '7',
    '8',
    '9',
    '0',
    '.'
  ];
  String calificacionFinal = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 2,
      // height: size.height * 0.4,
      // color: Colors.red,
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('SELECCIONA LA CALIFICACION'),
            Wrap(
              children: List.generate(
                  calificacion.length,
                  (index) => Card(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // topLeft: Radius.circular(20),
                          // bottomRight: Radius.circular(20),
                          // bottomLeft: Radius.circular(20),
                          // topRight: Radius.circular(10),
                          // )
                          // ),
                          onPressed: () {
                            setState(() {
                              calificacionFinal =
                                  calificacionFinal + calificacion[index];
                              print(calificacionFinal);
                            });
                            // openDialogCalificacioConfirmation(context, size);
                          },

                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(calificacion[index].toString()),
                          ),
                        ),
                      )),
            ),
            Container(
                width: 250,
                height: 50,
                margin: const EdgeInsetsDirectional.all(20),
                color: Colors.black38,
                child: Center(
                    child: Text(calificacionFinal,
                        style: const TextStyle(fontSize: 20)))),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.black87,
              onPressed: () async {
                if (calificacionFinal.isEmpty) {
                  print('no se ha calificado');
                  // return null;
                  openDialogCalificacioConfirmation(context, size);
                  return null;
                }

                final taskReceived =
                    Provider.of<TaskReceivedServices>(context, listen: false);
                await taskReceived.taskQualify(
                    widget.idReceivedTask, calificacionFinal, true);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: const Text('CALIFICAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> openDialogCalificacioConfirmation(
          BuildContext context, Size size) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            return Center(
              child: AlertDialog(
                content: SizedBox(
                  height: size.height / 4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('¿CONFIRMAR CALIFICACION?'),
                        SizedBox(height: size.height * 0.2),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                color: Colors.black87,
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: const Text('SI'),
                                ),
                              ),
                              SizedBox(width: size.width * 0.1),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                color: Colors.black87,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: const Text('NO'),
                                ),
                              ),
                            ]),
                      ]),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // MaterialButton(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     color: Colors.black,
                      //     onPressed: () async {
                      //       Navigator.pop(context);
                      //     },
                      //     child: const Padding(
                      //       padding: EdgeInsets.only(left: 35, right: 35),
                      //       child: Text('CANCELAR',
                      //           style: TextStyle(color: Colors.white)),
                      //     )),
                    ],
                  )
                ],
              ),
            );
          });
}
