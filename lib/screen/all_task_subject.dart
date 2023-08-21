import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:preppa_profesores/models/task.dart';
import 'package:provider/provider.dart';
import '../widgets/task_card.dart';

class ScreenAllTaskSubject extends StatefulWidget {
  const ScreenAllTaskSubject({super.key});

  @override
  State<ScreenAllTaskSubject> createState() => _ScreenAllTaskSubjectState();
}

class _ScreenAllTaskSubjectState extends State<ScreenAllTaskSubject> {
  List<Tasks> tasks = [];

  @override
  void initState() {
    super.initState();
    // tasks = [];
  }

  @override
  Widget build(BuildContext context) {
    final taskServices = Provider.of<TaskServices>(context);

     tasks  = taskServices.tasksForSubject;


    return Scaffold(
        // drawer: Drawer(),
        appBar: AppBar(
          title: Text('LISTA DE LA TAREAS'),
        ),
        body: SingleChildScrollView(
          child: tasks.isEmpty
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Wrap(
                  children: List.generate(tasks.length, (index) {
                    return TaskCard(tasks: tasks, index: index);
                  }),
                ),
        ));
  }
}
