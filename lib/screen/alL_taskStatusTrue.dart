import 'dart:io';

import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../widgets/task_card.dart';

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

  @override
  Widget build(BuildContext context) {
    // tasks = ModalRoute.of(context)?.settings.arguments as List<Tasks>;
    //  nono se recive ningo parametro

    final taskServices = Provider.of<TaskServices>(context);
    tasks = taskServices.taskForStatusTrue;

    return Scaffold(
        // drawer: Drawer(),
        appBar: AppBar(
          title: Text('LISTA DE LAS TAREASs'),
        ),
        body: Padding(
            padding: Platform.isWindows || Platform.isMacOS
                ? const EdgeInsets.symmetric(vertical: 10, horizontal: 30)
                : const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: SingleChildScrollView(
              child: tasks.isEmpty
                  ? const CircularProgressIndicator()
                  : Wrap(
                      children: List.generate(tasks.length, (index) {
                        return TaskCard(tasks: tasks, index: index);
                      }),
                    ),
            )));
  }
}
