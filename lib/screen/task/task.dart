import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/models/taskReceived.dart';
import 'package:preppa_profesores/screen/task/create_taks.dart';
import 'package:preppa_profesores/screen/task/detailTask.dart';
import 'package:preppa_profesores/utils/shapeBorderDialog.dart';
import 'package:preppa_profesores/widgets/myScrollConfigure.dart';
import 'package:preppa_profesores/widgets/showDialogs/showDialogLogin.dart';
import 'package:provider/provider.dart';

import '../../Services/taskReceived.dart';
import '../../Services/task_services.dart';
import '../../models/subjects.dart';
import '../../models/task/tasks.dart';
import '../../models/taskReceived.dart';
import '../../providers/isMobile.dart';
import '../../widgets/card_task.dart';
import '../../widgets/myBackground.dart';

class ScreenTask extends StatefulWidget {
  const ScreenTask({super.key});

  @override
  State<ScreenTask> createState() => _ScreenTaskState();
}

class _ScreenTaskState extends State<ScreenTask> {
  // para cuanp se entres en la vista ejecuta esta funcion

// Object de tipo DateTime
// para le gecha de netregAA

  // FUNCIO NQUE RETORNA UN LISTA DE MATERIA

  List<String> listIdSubjects(List<Subjects> subjects) {
    List<String> idSubject = [];
    for (var subject in subjects) {
      idSubject.add(subject.uid);
    }
    return idSubject;
  }

//  varaibles for  the function to  obtain assigments by subject
  // group
  String idGroup = '';
  // subjecxt
  String idSubject = '';

  @override
  void initState() {
    super.initState();
    // onLoadingTask();
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 200.0,
            color: Colors.green,
            child: const Center(
              child: Text(" Modal BottomSheet",
                  textScaleFactor: 2,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          );
        });
  }

  // all subjects
  List<Subjects> subjects = [];

  // tareas recividas o entregados por alumnos
  List<TaskReceived> tasksReceived = [];

  late TaskReceivedServices taskReceivedServices;
  late TaskServices taskServices;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    taskReceivedServices = Provider.of<TaskReceivedServices>(context);
    tasksReceived = taskReceivedServices.taskReceived;
    taskServices = Provider.of<TaskServices>(context);
    final subjectServices = Provider.of<SubjectServices>(context);
    // final taskServices = Provider.of<TaskServices>(context);
    final taskStatusTrue = taskServices.taskForStatusTrue;
    subjects = subjectServices.subjects;
    return Scaffold(
      // appBar: AppBar(title: Text('sfsf'),),
      body: SizedBox(
        // height: double.infinity,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Stack(
            children: [
              const Positioned(
                right: -200,
                top: 20,
                child: myBackground(),
              ),
              const Positioned(left: -180, bottom: -130, child: myBackground()),
              // Option by task

              if (taskServices.status == true) const LinearProgressIndicator(),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Materias impartidos'),
                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // shape: MyShapeBorderAlertDialog
                                    //     .borderAlertDialog,
                                    title: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Nueva tarea'),
                                        CloseButton(),
                                      ],
                                    ),
                                    content: SizedBox(
                                        width: size.width * 0.6,
                                        child: const FormToCreateTask()),
                                  );
                                });
                            // Navigator.pushNamed(context, 'create_task');
                          },
                          icon: const Icon(Icons.create),
                          label: const Text('Nueva tarea'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final subjectServices =
                                Provider.of<SubjectServices>(context,
                                    listen: false);

                            final taskServices = Provider.of<TaskServices>(
                                context,
                                listen: false);

                            final subjects = subjectServices.subjects;

                            final idSubject = listIdSubjects(subjects);
                            // await taskServices.getTaskStatusTrue(idSubject);
                            taskServices.getTask(idSubject);
                          },
                          icon: const Icon(Icons.restart_alt),
                          label: const Text('Recargar tareas'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final subjectServices =
                                Provider.of<SubjectServices>(context,
                                    listen: false);

                            final taskServices = Provider.of<TaskServices>(
                                context,
                                listen: false);

                            final subjects = subjectServices.subjects;

                            final idSubject = listIdSubjects(subjects);
                            // await taskServices.getTaskStatusTrue(idSubject);
                            taskServices.getTask(idSubject);
                          },
                          icon: const Icon(Icons.restart_alt),
                          label: const Text('Recargar Tareas entregados'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          subjects.length,
                          (index) => OutlinedButton(
                              onPressed: () {},
                              child: Text(subjects[index].name))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30)),
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right:
                                            BorderSide(color: Colors.white30))),
                                width: size.width * 0.3,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      hintText: 'Search'),
                                )),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                  4,
                                  (index) => TextButton(
                                      onPressed: () {},
                                      child: const Text('data  aun o '))),
                            )
                          ]),
                      // color: Colors.red,
                    ),
                    const Divider(),
                    Flexible(
                      child: MyScrollConfigure(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              listAllTask(size, 'Todos', taskServices.tasks),
                              listAllTasksReceived(
                                  size, 'Entregados', tasksReceived),
                              listAllTasksReceived(
                                  size, 'Calificado', tasksReceived),
                              listAllTasksReceived(
                                  size, 'No calificado', tasksReceived),

                              // listAllTask(size, 'Entregados', tasksReceived),
                              // listAllTask(size, 'Revisado', taskServices.tasks),
                              // listAllTask(size, 'No calificado',
                              //     taskServices.tasksForSubject),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // SingleChildScrollView(
              //   // clipBehavior : Clip.antiAlias,
              //   child: Padding(
              //     padding: IsMobile.isMobile()
              //         ? const EdgeInsets.symmetric(horizontal: 0)
              //         : const EdgeInsets.symmetric(horizontal: 38),
              //     child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           SizedBox(height: size.height * 0.04),
              //           // const SizedBox(height: 60),

              //           titleScreen(context),
              //           SizedBox(height: size.height * 0.015),
              //           // otra opcioens de la tareas
              //           optionTask(
              //               context, size, taskServices, idGroup, idSubject),
              //           SizedBox(height: size.height * 0.03),
              //           taskReceived(context, taskServices),

              //           SizedBox(height: size.height * 0.015),
              //           // LIST CARD TASKee
              // listTask(size, taskServices, taskStatusTrue),
              //         ]),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Padding listAllTask(Size size, String title, List<Tasks> listTask) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white10)),
        // height: ,
        width: size.width * 0.2,
        // color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 17),
                ),
                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.add,
                //       size: 18,
                //     )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  children: List.generate(
                      listTask.length,
                      (index) => GestureDetector(
                            onTap: () {
                              final taskReceived =
                                  Provider.of<TaskReceivedServices>(context,
                                      listen: false);
                              taskServices.selectedTask =
                                  listTask[index].withCopy();
                              taskReceived
                                  .getIdReceivedTask(listTask[index].id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Card(
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //     // color: Colors.blue,
                                  //     borderRadius: BorderRadius.circular(10),
                                  //     border: Border.all(color: Colors.white10)),
                                  // height: 150,
                                  width: size.width,
                                  // color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  listTask[index].nameTask,
                                                  style: const TextStyle(
                                                      fontSize: 16.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Roboto'),
                                                ),
                                              ),
                                              PopupMenuButton<String>(
                                                padding: EdgeInsets.zero,
                                                iconSize: 15,
                                                // icon: const Icon(Icons.more_vert_sharp, size: 14,),
                                                tooltip: "Menu",
                                                onSelected: (value) =>
                                                    setState(() {
                                                  // _selectedValue = value;
                                                }),
                                                itemBuilder: (context) {
                                                  return [
                                                    const PopupMenuItem<String>(
                                                      value: 'Option 1',
                                                      child: Text(
                                                          'Detalles de la tarea'),
                                                    ),
                                                    const PopupMenuItem<String>(
                                                      value: 'Option 2',
                                                      child: Text('Eliminar'),
                                                    ),
                                                    const PopupMenuItem<String>(
                                                      value: 'Option 3',
                                                      child: Text('Ver tarea'),
                                                    ),
                                                  ];
                                                },
                                                // child:
                                                //     const CircleAvatar(
                                                //       radius: 15,
                                                //       child: Icon(Icons.more_vert_rounded)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            listTask[index].subject.name,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            "Descripcion: ${listTask[index].description}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto'),
                                          ),
                                          // const Spacer(),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 12,
                                                    child: Text(
                                                      'A',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Spacer(),
                                              const Icon(
                                                Icons.calendar_month,
                                                size: 15,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                "${DateFormat('dd-MMM-yyyy').format(listTask[index].createdAt).substring(0, 6)} - ${DateFormat('dd-MMM-yyyy').format(listTask[index].expiredAt)}  ",
                                              )
                                            ],
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Padding listAllTasksReceived(
      Size size, String title, List<TaskReceived> listTasksReceived) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white10)),
        // height: ,
        width: size.width * 0.2,
        // color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 17),
                ),
                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.add,
                //       size: 18,
                //     )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  children: List.generate(
                      listTasksReceived.length,
                      (index) => GestureDetector(
                            onTap: () {
                              taskReceivedServices.taskReceivedSelected =
                                  listTasksReceived[index].copyWith();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    shape: MyShapeBorderAlertDialog
                                        .borderAlertDialog,
                                    title: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Detalles de la tarea'),
                                        CloseButton()
                                      ],
                                    ),
                                    content: SizedBox(
                                        width: size.width * 0.5,
                                        height: size.height * 0.8,
                                        child: const TaskReceivedDetail()),
                                  );
                                },
                              );

                              // final taskReceived =
                              //     Provider.of<TaskReceivedServices>(context,
                              //         listen: false);

                              // taskReceived.getIdReceivedTask(
                              //     listTasksReceived[index].id!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Card(
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //     // color: Colors.blue,
                                  //     borderRadius: BorderRadius.circular(10),
                                  //     border: Border.all(color: Colors.white10)),
                                  // height: 150,
                                  width: size.width,
                                  // color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  listTasksReceived[index]
                                                      .task
                                                      .nameTask,
                                                  style: const TextStyle(
                                                      fontSize: 16.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Roboto'),
                                                ),
                                              ),
                                              PopupMenuButton<String>(
                                                padding: EdgeInsets.zero,
                                                iconSize: 15,
                                                // icon: const Icon(Icons.more_vert_sharp, size: 14,),
                                                tooltip: "Menu",
                                                onSelected: (value) =>
                                                    setState(() {
                                                  // _selectedValue = value;
                                                }),
                                                itemBuilder: (context) {
                                                  return [
                                                    const PopupMenuItem<String>(
                                                      value: 'Option 1',
                                                      child: Text(
                                                          'Detalles de la tarea'),
                                                    ),
                                                    const PopupMenuItem<String>(
                                                      value: 'Option 2',
                                                      child: Text('Eliminar'),
                                                    ),
                                                    const PopupMenuItem<String>(
                                                      value: 'Option 3',
                                                      child: Text('Ver tarea'),
                                                    ),
                                                  ];
                                                },
                                                // child:
                                                //     const CircleAvatar(
                                                //       radius: 15,
                                                //       child: Icon(Icons.more_vert_rounded)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            listTasksReceived[index]
                                                .subject
                                                .name,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto'),
                                          ),
                                          listTasksReceived[index]
                                                      .isQualified ==
                                                  false
                                              ? const Text(
                                                  'Calificado: No',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'Roboto'),
                                                )
                                              : Row(
                                                  children: [
                                                    const Text(
                                                        'Calificado: Si'),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      'Cal. ${listTasksReceived[index].rating.toString()}',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Roboto'),
                                                    ),
                                                  ],
                                                ),
                                          // Text(
                                          //   "Descripcion: ${listTasksReceived[index].task.description}",
                                          //   maxLines: 2,
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: const TextStyle(
                                          //       fontSize: 12,
                                          //       color: Colors.red,
                                          //       fontWeight: FontWeight.w500,
                                          //       fontFamily: 'Roboto'),
                                          // ),
                                          // const Spacer(),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "${listTasksReceived[index].student.name}  ${listTasksReceived[index].student.lastName}",
                                                    // .substring(0, 1),
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              const Spacer(),
                                              const Icon(
                                                Icons.calendar_month,
                                                size: 15,
                                              ),
                                              const SizedBox(width: 8),
                                              // Text(
                                              // "${DateFormat('dd-MMM-yyyy').format(listTasksReceived[index].createdAt).substring(0, 6)} - ${DateFormat('dd-MMM-yyyy').format(listTasksReceived[index].expiredAt)}  ",
                                              // )
                                            ],
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

// Lista de tareas

  Widget listTask(
      Size size, TaskServices taskServices, List<Tasks> taskStatusTrue) {
    return SizedBox(
      height: IsMobile.isMobile() ? size.height * 0.41 : size.height * 0.5,
      width: size.width,
      child: taskServices.status == true
          ? const Center(child: CircularProgressIndicator())
          : taskStatusTrue.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/search2.png',
                      width: 70,
                      height: 70,
                    ),
                    const Text(
                      'Lista vacia no tienes tareas agregados',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskStatusTrue.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardTask(
                      taskForStatusTrue: taskStatusTrue[index],
                    );
                  },
                ),
    );
  }

  Padding titleScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text('TAREAS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // fontSize: 45,
            fontSize: MediaQuery.of(context).size.height * 0.05,

            letterSpacing: 2,
            shadows: [
              Shadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(1, 1),
                blurRadius: 1,
              ),
            ],
          )),
    );
  }

  Future<void> onLoadingTask() async {
    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);

    final taskServices = Provider.of<TaskServices>(context, listen: false);

    final subjects = subjectServices.subjects;

    final idSubject = listIdSubjects(subjects);

    await taskServices.getTaskStatusTrue(idSubject);
  }

  Row taskReceived(BuildContext context, TaskServices taskServices) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Tareas recividas"),
        const Spacer(),
        TextButton(
          onPressed: () async {
            // EXTRE TPODAS LA TAREA EN LA CUAL SOLO SERIA LAS QUE INGRESA A CADA PROFESOT

            // final subjectServices =
            //     Provider.of<SubjectServices>(context, listen: false);

            // final subjects = subjectServices.subjects;

            // final idSubject = listIdSubjects(subjects);

            // taskServices.getTaskStatusTrue(idSubject);

            // taskServices.getTask();

            // final task = taskServices;

            // la vista aun no tiene nada
            Navigator.pushNamed(
              context, 'allTaskStatusTrue',
              // arguments: task.tasks
            );
          },
          child: const Text('Ver todas las tareas'),
        ),
        IconButton(
            onPressed: onLoadingTask, icon: const Icon(Icons.refresh_rounded))
      ],
    );
  }

// Lista de tareas
// parte de arriba
  SizedBox optionTask(BuildContext context, Size size,
      TaskServices taskServices, String idGroup, String idSubject) {
    return SizedBox(
      // color: Colors.red,
      height: size.height * 0.25,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,

        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            color: const Color(0xff13162C).withOpacity(0.1),
            // color: Color.fromARGB(255, 32, 36, 71).withOpacity(0.1),

            elevation: 3,
            borderOnForeground: true,
            child: MaterialButton(
              // shape: Shape,
              onPressed: () async {
                Navigator.pushNamed(context, 'create_task');

                // openDialogForMateri(context, size);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: !IsMobile.isMobile() ? size.height * 0.2 : 200,
                  width: !IsMobile.isMobile() ? size.width * 0.2 : 250,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset('assets/addd_task.gif',
                            width: 100, height: 100),
                        const Text('Agregar Tarea',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Card(
            // color: Colors.red,
            // color: Color(0xff191C37),

            // THIS IS THE ORIGINAL
            // color: const Color(0xff13162C),
            color: const Color(0xff13162C).withOpacity(0.1),

            elevation: 3,
            borderOnForeground: true,
            child: MaterialButton(
              // shape: Shape,
              onPressed: () async {
                final subjectServices =
                    Provider.of<SubjectServices>(context, listen: false);
                final subjects = subjectServices.subjects;

                final idSubject = listIdSubjects(subjects);
                // taskServices.getTaskForSbubject(idSubject);
                final resp = await taskServices.getTask(idSubject);
                if (resp == false) {
                  // ignore: use_build_context_synchronously
                  ShowDialogLogin.showDialogLogin(context);
                  return;
                }

                // la vista aun no tiene nada
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(
                  context, 'allTask',
                  // arguments: task.tasks
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size.height * 0.18,
                  // width: size.width * 0.18,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset('assets/task_qualifield.gif',
                            width: 90, height: 90),
                        const Text('Todas las tareas',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Card(
            // color: Colors.red,
            // color: const Color(0xff191C37),
            // color: const Color(0xff13162C).withOpacity(0.2),
            color: const Color(0xff13162C).withOpacity(0.1),

            elevation: 1,
            borderOnForeground: true,
            child: MaterialButton(
              // shape: Shape,
              onPressed: () {
                // _showSubject(context, idSubject, idGroup);
                Navigator.pushNamed(
                  context, 'allTaskSubject',
                  // arguments: task.tasks
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size.height * 0.18,
                  // width: size.width * 0.18,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset('assets/task_qualifield2.png',
                            width: 90, height: 90),
                        const Text('Tareas por materia',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// for selected materiau qualifield
// Create a simple alert
  void _showSubject(BuildContext context, String idStudent, String idGroup) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final subjectServices = Provider.of<SubjectServices>(context);
        final subjects = subjectServices.subjects;
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          title: const Text('Alert'),
          content: SizedBox(
            width: size.width * 0.8,
            height: size.height / 3,
            child: Center(
              child: Wrap(
                children: List.generate(
                    subjects.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.red,
                            width: 200,
                            height: 60,

                            // height: 50,
                            child: MaterialButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                _showGroup(context, subjects[index].uid);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
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
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showGroup(BuildContext context, String idSubject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final groupServider =
            Provider.of<GroupServices>(context, listen: false);
        final groups = groupServider.group;
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          title: const Text('Alert'),
          content: SizedBox(
            width: size.width * 0.4,
            height: size.height / 5,
            child: Center(
              child: Wrap(
                children: List.generate(groups.groups.length, (index) {
                  return Card(
                    color: Colors.red,
                    // color: indexSelected == index ? Colors.red : Colors.white54,
                    child: MaterialButton(
                      onPressed: () async {
                        final subjectServices = Provider.of<SubjectServices>(
                            context,
                            listen: false);

                        final taskServices =
                            Provider.of<TaskServices>(context, listen: false);

                        taskServices.getTaskbySubject(
                            groups.groups[index].uid, idSubject);

                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'allTaskSubject');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 70,
                          height: 50,
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
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class FormTask extends StatefulWidget {
  String nameTask;
  String descriptionTask;

  FormTask({super.key, required this.nameTask, required this.descriptionTask});

  @override
  State<FormTask> createState() => _FormTaskState();
}

class _FormTaskState extends State<FormTask> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: 600,
      height: 150,
      child: Form(
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                return null;
              },
              onChanged: (String value) {
                setState(() {});

                widget.nameTask = value;
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
                setState(() {});
                widget.descriptionTask = value;
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
    );
  }
}
