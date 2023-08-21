import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/taskReceived.dart';
import '../models/taskReceived.dart';

class ScreenAllTaskTeceived extends StatefulWidget {
  const ScreenAllTaskTeceived({super.key});

  @override
  State<ScreenAllTaskTeceived> createState() => _ScreenAllTaskTeceivedState();
}

class _ScreenAllTaskTeceivedState extends State<ScreenAllTaskTeceived> {
  // crear un objecto de una lsita de tipo TaskTReceivbedd
  // create an object from  a list of type TaskReceived

  List<TaskReceived>? taskQualifield;
  @override
  void initState() {
    // TODO: implement initState
    taskQualifield = [];
  }

  @override
  Widget build(BuildContext context) {
// extraer todos los datos de las tareas
    final taskReceivedQualified = Provider.of<TaskReceivedServices>(context);

    late List<TaskReceived> taskQualifield = taskReceivedQualified.taskReceived;
    
    // late List<TaskReceived> taskQualifield =
    //     ModalRoute.of(context)?.settings.arguments as List<TaskReceived>;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('TAREAS CALIFICADAS')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // lista de las tareas calificadas
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('TODAS LAS TAREAS CALIFICADOS'),
            ),
          ),
          // Expanded(
          //   child: ListView(
          //       scrollDirection: Axis.horizontal,
          //       physics: const BouncingScrollPhysics(),
          //       children: List.generate(5, (index) => Text('$index'))),
          // ),

          Container(
            // color: Colors.red,
            width: double.infinity,
            height: size.height * 0.78,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 7,
                children: List.generate(
                    taskQualifield.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0XFF131428),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: size.height * 0.4,
                            width: size.width * 0.17,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(),
                                  // child: _EditButtom(context),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                              "${taskQualifield[index].student.name}  ${taskQualifield[index].student.lastName}  ${taskQualifield[index].student.secondName}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xffC9CACF))),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            taskQualifield[index].task.nameTask,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff787B9A))),
                                      ),

                                      SizedBox(height: size.height * 0.01),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Calificacion :${taskQualifield[index].rating.toString()}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff787B9A))),
                                      ),

                                      // Text(taskServices.tasks[index].description,
                                      //     style: const TextStyle(
                                      //         fontSize: 12, color: Color(0xff686B89))),

                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            taskQualifield[index]
                                                .task
                                                .userTeacher,
                                            // +
                                            //     taskServices
                                            //         .tasks[index].userTeacher.lastName +
                                            //     taskServices
                                            //         .tasks[index].userTeacher.secondName,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffC9CACF)),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
