import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:provider/provider.dart';

import '../Services/task_services.dart';
import '../models/subjects.dart';
import '../models/task.dart';
import '../widgets/card_task.dart';
import '../widgets/myBackground.dart';

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
    onLoadingTask();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final taskServices = Provider.of<TaskServices>(context, listen: false);
    // final taskServices = Provider.of<TaskServices>(context);

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
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

              SingleChildScrollView(
                // clipBehavior : Clip.antiAlias,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.05),

                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('TAREAS', style: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(height: size.height * 0.05),
                      // otra opcioens de la tareas
                      OptionTask(
                          context, size, taskServices, idGroup, idSubject),
                      SizedBox(height: size.height * 0.05),

                      TaskReceived(context, taskServices),

                      SizedBox(height: size.height * 0.011),

                      // LIST CARD TASK
                      Container(height: 350, child: const CardTask()),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLoadingTask() async {
    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);

    final taskServices = Provider.of<TaskServices>(context, listen: false);

    final subjects = subjectServices.subjects;

    final idSubject = listIdSubjects(subjects);

    await taskServices.getTaskStatusTrue(idSubject);
  }

  Row TaskReceived(BuildContext context, TaskServices taskServices) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("TAREAS RECIVIDAS"),
        MaterialButton(
          onPressed: () async {
            // EXTRE TPODAS LA TAREA EN LA CUAL SOLO SERIA LAS QUE INGRESA A CADA PROFESOT

            // final subjectServices =
            //     Provider.of<SubjectServices>(context, listen: false);

            // final subjects = subjectServices.subjects;

            // final idSubject = listIdSubjects(subjects);

            // taskServices.getTaskStatusTrue(idSubject);

            // taskServices.getTask();

            final task = taskServices;

            // la vista aun no tiene nada
            Navigator.pushNamed(
              context, 'allTaskStatusTrue',
              // arguments: task.tasks
            );
          },
          child: const Text('VER TODAS LAS TAREAS'),
        ),
      ],
    );
  }

  SizedBox OptionTask(BuildContext context, Size size,
      TaskServices taskServices, String idGroup, String idSubject) {
    return SizedBox(
      // color: Colors.red,
      height: 200,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,

        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            // color: Colors.red,
            // color: Color(0xff191C37),
            color: const Color(0xff13162C).withOpacity(0.1),

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
                  height: Platform.isWindows || Platform.isMacOS
                      ? size.height * 0.2
                      : 200,
                  width: Platform.isWindows || Platform.isMacOS
                      ? size.width * 0.2
                      : 250,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset('assets/addd_task.gif',
                            width: 100, height: 100),
                        const Text('Agregar Tarea',
                            style: TextStyle(fontSize: 20)),
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
                taskServices.getTask(idSubject);

                // la vista aun no tiene nada
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
                        const Text('TODAS LAS TAREAS',
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
                _showSubject(context, idSubject, idGroup);
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
                            style: TextStyle(fontSize: 20)),
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
            height: size.height / 1.9,
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
                        child: Container(
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
              validator: (value) {},
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
              validator: (value) {},

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
