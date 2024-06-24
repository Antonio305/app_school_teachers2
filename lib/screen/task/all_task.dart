import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:provider/provider.dart';

import '../../models/subjects.dart';
import '../../models/task/tasks.dart';
import '../../widgets/task_card.dart';

class ScreenAllTask extends StatefulWidget {
  const ScreenAllTask({super.key});

  @override
  State<ScreenAllTask> createState() => _ScreenAllTaskState();
}

class _ScreenAllTaskState extends State<ScreenAllTask> {
  // List<Tasks?> tasks = [];

  // @override
  // void initState() {
  //   super.initState();
  //   tasks = [];
  // }

  List<Subjects> subjects = [];
  List<Tasks?> tasks = [];

  @override
  Widget build(BuildContext context) {
    final taskServices = Provider.of<TaskServices>(context);
    final subjectServices = Provider.of<SubjectServices>(context);

    tasks = taskServices.taskBySubject;
    subjects = subjectServices.subjects;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Todas las tareas'),
          centerTitle: true,
        ),
        body: Padding(
          padding: IsMobile.isMobile()
              ? const EdgeInsets.symmetric(horizontal: 8, vertical: 0)
              : const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text('Filtrar  tareas por materia'),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      subjects.length,
                      (index) => TextButton.icon(
                          onPressed: () async {
                            // taskServices.status = true;
                            taskServices
                                .filterTaskBySubject(subjects[index].uid);
                            // taskServices.status = false;
                          },
                          icon: const Icon(Icons.subject),
                          label: Text(subjects[index].name))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: taskServices.ts
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: !IsMobile.isMobile()
                            ? const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10)
                            : const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 15,
                            runSpacing: 10,
                            children: List.generate(tasks.length, (index) {
                              return TaskCard(
                                tasks: tasks[index]!,
                              );
                            }),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ));
  }
}
