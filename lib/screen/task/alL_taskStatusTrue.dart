import 'dart:io';

import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:provider/provider.dart';

import '../../Services/subject_services.dart';
import '../../models/subjects.dart';
import '../../models/task/tasks.dart';
import '../../widgets/task_card.dart';

class ScreenAllTaskStatusTrue extends StatefulWidget {
  const ScreenAllTaskStatusTrue({super.key});

  @override
  State<ScreenAllTaskStatusTrue> createState() =>
      _ScreenAllTaskStatusTrueState();
}

class _ScreenAllTaskStatusTrueState extends State<ScreenAllTaskStatusTrue> {
  List<Tasks> tasks = [];

  @override
  void initState() {
    // super.initState();
    // tasks = [];
  }
  List<String> listIdSubjects(List<Subjects> subjects) {
    List<String> idSubject = [];
    for (var subject in subjects) {
      idSubject.add(subject.uid);
    }
    return idSubject;
  }

  Future<void> onLoadingTask() async {
    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);

    final taskServices = Provider.of<TaskServices>(context, listen: false);

    final subjects = subjectServices.subjects;

    final idSubject = listIdSubjects(subjects);

    await taskServices.getTaskStatusTrue(idSubject);
  }

  @override
  Widget build(BuildContext context) {
    // tasks = ModalRoute.of(context)?.settings.arguments as List<Tasks>;
    //  nono se recive ningo parametro

    final taskServices = Provider.of<TaskServices>(context);
    tasks = taskServices.taskForStatusTrue;
    // padding: Platform.isWindows || Platform.isMacOS
    //     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 30)
    //     : const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
    return Scaffold(
        // drawer: Drawer(),
        appBar: AppBar(
          title: const Text('Tareas activas'),
          centerTitle: true,
        ),
        body: taskServices.status == true
            ? const Center(child: CircularProgressIndicator())
            : tasks.isEmpty
                ? taskReceivedIsEmpty()
                : Center(
                    child: RefreshIndicator(
                      onRefresh: onLoadingTask,
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: List.generate(tasks.length, (index) {
                            return TaskCard(tasks: tasks[index]);
                          }),
                        ),
                      ),
                    ),
                  ));
  }
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
        child: Text('Lista vacia nadie ha entregado tareas repruebalos a todos',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500)),
      ),
    ],
  );
}
