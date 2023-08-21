import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/taskReceived.dart';
import '../Services/task_services.dart';
import '../models/task.dart';
import 'dialongEditTask.dart';

class TaskCard extends StatelessWidget {
  // final size = MediaQuery.of(context).size;
  // final taskServices = Provider.of<TaskServices>(context);
  final List<Tasks> tasks;
  final int index;

  TaskCard({super.key, required this.tasks, required this.index});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0XFF131428),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 300,
        width: Platform.isAndroid || Platform.isIOS
            // ? 300
          ?  size.width
            : 220,
        // height: size.height * 0.16,
        // width: size.width * 0.16,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: _EditButtom(context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(tasks[index].subject.name,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xffC9CACF))),
                    ),

                    Text(tasks[index].group.name,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xff787B9A))),

                    Text(tasks[index].nameTask,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xff787B9A))),
                    SizedBox(height: size.height * 0.01),
                    // Text(tasks[index].description,
                    //     style: const TextStyle(
                    //         fontSize: 12, color: Color(0xff686B89))),

                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            // color:Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: const Color(0xffC9CACF), width: 0.1)),
                        child: MaterialButton(
                          onPressed: () async {
                            final taskReceived =
                                Provider.of<TaskReceivedServices>(context,
                                    listen: false);
                            await taskReceived
                                .getIdReceivedTask(tasks[index].id);

                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(
                                context, 'studentTasktReceived');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                  Text('ENTREGADOS',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xffC9CACF))),
                                  Icon(Icons.chevron_right_rounded, size: 20),
                                ]),
                          ),
                        ),
                      ),
                    ),

                    Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          tasks[index].userTeacher.name +
                              tasks[index].userTeacher.lastName +
                              tasks[index].userTeacher.secondName,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xffC9CACF)),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton _EditButtom(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        // topLeft: Radius.circular(20),
        // bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        topRight: Radius.circular(10),
      )),
      // ignore: sort_child_properties_last
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      ),
      onPressed: () {
        // print(data[index].id);
        // openDialogEditTask(context);
        ShowDialogEditTask.openDialogEditTask(context);
      },
      minWidth: 40,
      height: 40,
      // color: Colors.amber[800],
      color: const Color(0xffFF8B65),
      // color: Color(0xff0F1222),
      //rgb(255,139,101)
    );
  }
}
