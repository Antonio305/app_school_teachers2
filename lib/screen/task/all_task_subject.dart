import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:preppa_profesores/widgets/utils/style_ElevatedButton.dart';
import 'package:provider/provider.dart';
import '../../models/task/tasks.dart';
import '../../widgets/task_card.dart';

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

  void _showModalSheet() {
    showModalBottomSheet(
        elevation: 5,
        context: context,
        builder: (builder) {
          return const ContentShowModalSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    final taskServices = Provider.of<TaskServices>(context);

    tasks = taskServices.tasks;
    final size = MediaQuery.of(context).size;

    return Scaffold(
        // drawer: Drawer(),
        appBar: AppBar(
          title: const Text('Buscar tareas por materia'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _showModalSheet();
            },
            label: const Text('Tareas  por  materia')),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: taskServices.status == true
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Center(
                      child: Wrap(
                        children: List.generate(tasks.length, (index) {
                          return TaskCard(tasks: tasks[index]);
                        }),
                      ),
                    ),
            ),
          ],
        ));
  }
}

class ContentShowModalSheet extends StatefulWidget {
  const ContentShowModalSheet({super.key});

  @override
  State<ContentShowModalSheet> createState() => _ContentShowModalSheetState();
}

class _ContentShowModalSheetState extends State<ContentShowModalSheet> {
  @override
  Widget build(BuildContext context) {
    final subjectsServices = Provider.of<SubjectServices>(context);

    final subjects = subjectsServices.subjects;
    final size = MediaQuery.of(context).size;

    return Container(
      height: 350.0,
      width: size.width * 0.99,
      decoration: BoxDecoration(
          // color: Colors.green,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    // color: Colors.white54,
                    color: Colors.indigo,
                    // color: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Materias',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Seleciona la materia',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Wrap(
                runSpacing: 5,
                spacing: 5,
                children: List.generate(
                    subjects.length,
                    (index) => ElevatedButton(
                        style: StyleElevatedButton.styleButton,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(subjects[index].name))),
              ),
              const Spacer(),
            ]),
      ),
    );
  }
}
