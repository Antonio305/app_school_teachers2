import 'package:flutter/material.dart';
import 'package:preppa_profesores/models/taskReceived.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/widgets/text_fileds.dart';
import 'package:preppa_profesores/widgets/utils/border.dart';
import 'package:provider/provider.dart';

import '../../Services/taskReceived.dart';
import '../../models/task/tasks.dart';
import '../../widgets/sceen_download.dart';

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
      archivos: [],
      v: 0);

// para mostrar en cada campo de la vista

  TaskReceived taskReceiveds = TaskReceived(
      id: '',
      task: TaskReceiveds(
          id: '',
          subject: "",
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

  // controlador para la calificacion

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
  void dispose() {
    super.dispose();
  }

  bool isSelectedStudent = false;
  List<TaskReceived> taskReceived = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final taskReceivedServices = Provider.of<TaskReceivedServices>(context);

    taskReceived = taskReceivedServices.taskReceived;
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas entregados'),
        centerTitle: true,
      ),
      body: taskReceivedServices.requestStatus == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: MyBorder.myDecorationBorder(null),
              child: taskReceived.isEmpty
                  ? Center(child: taskReceivedIsEmpty())
                  : IsMobile.isMobile()
                      ? listStudents(size, taskReceivedServices)
                      : listStudentAndDataTaskReceived(
                          size, taskReceivedServices),
            ),
    );
  }

// contenido  para escritoriio, muestra la lista de estudiantes que han entregado tareas
// y el contenido de esas tareas
  Widget listStudentAndDataTaskReceived(
      Size size, TaskReceivedServices taskReceivedServices) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        listStudents(size, taskReceivedServices),
        isSelectedStudent != false
            ? contectTask(size)
            : SizedBox(
                width: size.width * 0.685,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30),
                          borderRadius: BorderRadius.circular(150),
                        ),
                        width: 300,
                        height: 300,
                        child: Image.asset('assets/tasks2.png')),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Selecciona un alumno',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                )),
      ],
    );
  }

  Column taskReceivedIsEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon(Icons.list),
        SizedBox(
            height: 150, width: 150, child: Image.asset('assets/search2.png')),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
              'Lista vacia nadie ha entregado tareas repruebalos a todos',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget contectTask(Size size) {
    return Container(
      width: size.width * 0.685,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // border: Border.all(color: Colors.black26)

        // color: const Color(0xff13162a),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Text(
                'Tarea:  ',
                style: TextStyle(fontSize: 26),
              )),
              const SizedBox(height: 30),

              Text("Tarea:  ${taskReceiveds.task.nameTask}"),
              Text("Descripcion :  ${taskReceiveds.task.description}"),

              // SizedBox(
              //   height: size.height * 0.2,
              //   width: size.width * 0.2,
              //   child: ClipRRect(
              //       borderRadius: BorderRadius.circular(300),
              //       child:
              //           Image.asset('assets/gradedtask.png', fit: BoxFit.fill)),
              // ),

              const SizedBox(height: 30),

              const Center(
                  child: Text(
                'Tarea Recibida:',
                style: TextStyle(fontSize: 22),
              )),
              const SizedBox(height: 30),

              Text("Calificacion:  ${taskReceiveds.rating}"),
              const SizedBox(height: 15),
              taskReceiveds.isQualified == false
                  ? const Text("Calificado : NO")
                  : const Text("Calificado : SI"),

              taskReceiveds.archivos == null
                  ? const Text('Archivo: NO')
                  : const SizedBox(
                      // width: 500,
                      child: ScreenDownload(
                          urls:
                              'http://4.bp.blogspot.com/-DYVbSKM0xGQ/UnKclbsDugI/AAAAAAAAAI0/v3FhyPcK02Y/s1600/imagenes-de-perritos-bonitos.jpg',
                          nameFile: 'CHALES.jpg'),
                    ),
              const Row(
                children: [
                  Text('Comentarios'),
                  // SizedBox(
                  //     width: 200, child: TextFormField())
                ],
              ),
              // const SizedBox(height: 15),
              // Text(task.nameTask),
              SizedBox(height: size.height * 0.1),
              Center(
                child: ElevatedButton(
                  // color: Colors.black87,
                  onPressed: () {
                    openDialogCalificacion(context, taskReceiveds.id!);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text('Calificar'),
                  ),
                ),
              )
            ]),
      ),
    );
  }

  Container listStudents(Size size, TaskReceivedServices taskReceivedServices) {
    return Container(
      width: IsMobile.isMobile() ? size.width : size.width * 0.285,
      // height: 300,
      decoration: IsMobile.isMobile()
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black26)
              // color: const Color(0xff13162C),
              ),
      child:
          //  taskReceived.isEmpty
          // ? listIsEmpty()
          // :
          listStudent(taskReceivedServices),
    );
  }

  ListView listStudent(TaskReceivedServices taskReceivedServices) {
    return ListView.builder(
      itemCount: taskReceived.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            dense: true,
            onTap: () {
              if (IsMobile.isMobile()) {
                taskReceivedServices.taskReceivedSelected =
                    taskReceived[index].copyWith();

                Navigator.pushNamed(context, 'taskReceived');
              }

              // el valor de la claes lo vamos a cambiar por la que seleccionaremos aca
              taskReceiveds = taskReceived[index];
              setState(() {
                isSelectedStudent = true;
              });
              //  Task(rating: rating, id: id, subject: subject, nameTask: nameTask, description: description, status: status, group: group, userTeacher: userTeacher, v: v)
              print(task.nameTask);
            },
            selectedColor: Colors.white54,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            style: ListTileStyle.drawer,
            title: Text(
                "${taskReceived[index].student.name}  ${taskReceived[index].student.lastName} ${taskReceived[index].student.secondName}"),
            leading: CircleAvatar(
                child: Text(taskReceived[index].student.name.substring(0, 1) +
                    taskReceived[index].student.lastName.substring(0, 1))),
            subtitle: const Text('Grado  - Grupo'),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        );
      },
    );
  }

  Center listIsEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.list),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
                'Lista vacia, nadie ha entregado tareas, repruebalos a todos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                )),
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
                icon: const Icon(Icons.grade_outlined),
                title: const Text('Calificar tarea'),
                // content: ContentCalificacion(idReceivedTask: idReceivedTask),
                content: SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        // const Text('Agregar Calificacion'),
                        SizedBox(
                            // width: 150,
                            child: TextFormField(
                                onChanged: (value) {
                                  grades = value;
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecorations.authDecoration(
                                  hintText: 'Ingresa la calificacion',
                                  labelText: 'Ingresa la calificacion',
                                  // prefixIcon: Icons.grade
                                  // ),
                                ))),
                      ],
                    )),
                actions: [
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
                        Navigator.pop(context);
                        // Task =  taskReceived.taskReceivedSelected;
                        taskReceiveds = taskReceived.taskReceivedSelected;
                      },
                      child: const Text('Guardar', style: TextStyle())),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'))
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

    return SizedBox(
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
                  return;
                }

                final taskReceived =
                    Provider.of<TaskReceivedServices>(context, listen: false);
                await taskReceived.taskQualify(
                    context, widget.idReceivedTask, calificacionFinal, true);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('CALIFICAR'),
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
                                child: const Padding(
                                  padding: EdgeInsets.all(40.0),
                                  child: Text('SI'),
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
                                child: const Padding(
                                  padding: EdgeInsets.all(40.0),
                                  child: Text('NO'),
                                ),
                              ),
                            ]),
                      ]),
                ),
                actions: const [
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
