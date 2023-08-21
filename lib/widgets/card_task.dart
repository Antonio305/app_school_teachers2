import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/taskReceived.dart';
import 'package:provider/provider.dart';

import '../Services/task_services.dart';
import 'dialongEditTask.dart';

class CardTask extends StatelessWidget {
  const CardTask({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final taskServices = Provider.of<TaskServices>(context);
    final taskForStatusTrue = taskServices.taskForStatusTrue;

    return Expanded(
      // width: size.width * 0.76,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.unknown,
            PointerDeviceKind.stylus,
            PointerDeviceKind.invertedStylus
          },
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: taskForStatusTrue.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0XFF131428).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 450,
                width: Platform.isAndroid || Platform.isIOS ? 300 : 220,
                // height: size.height * 0.16,
                // width: size.width * 0.16,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 2, 28, 48),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      taskForStatusTrue[index].subject.name,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xffC9CACF))),
                                ),
                              ),
                            ),
                            Text('GRUPO : ' + taskForStatusTrue[index].group.name,
                                style: const TextStyle(
                                    fontSize: 14, color: Color(0xff787B9A))),
                            Text(taskForStatusTrue[index].nameTask,
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
                                        color: const Color(0xffC9CACF),
                                        width: 0.1)),
                                child: MaterialButton(
                                  onPressed: () async {
                                    final taskReceived =
                                        Provider.of<TaskReceivedServices>(context,
                                            listen: false);
                                    await taskReceived.getIdReceivedTask(
                                        taskForStatusTrue[index].id);

                                    // ignore: use_build_context_synchronously
                                    Navigator.pushNamed(
                                        context, 'studentTasktReceived');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.add,
                                            size: 20,
                                          ),
                                          Text('ENTREGADOS',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xffC9CACF))),
                                          Icon(Icons.chevron_right_rounded,
                                              size: 20),
                                        ]),
                                  ),
                                ),
                              ),
                            ),

                            Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  taskForStatusTrue[index].userTeacher.name +
                                      taskForStatusTrue[index]
                                          .userTeacher
                                          .lastName +
                                      taskForStatusTrue[index]
                                          .userTeacher
                                          .secondName,
                                  style: const TextStyle(
                                      fontSize: 10, color: Color(0xffC9CACF)),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Button edit
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

// shoe dialog  subject

  // Future<String?> openDialogEditTask(BuildContext context) =>
  //     showDialog<String>(
  //         // barrierColor: Colors.red[200], // color de fondo del dialong
  //         context: context,
  //         builder: (context) {
  //           return Center(
  //             child: AlertDialog(
  //               content: const ContentTask(),
  //               actions: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     MaterialButton(
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                         color: Colors.black,
  //                         onPressed: () async {
  //                           Navigator.pop(context);
  //                         },
  //                         child: const Padding(
  //                           padding: EdgeInsets.only(left: 35, right: 35),
  //                           child: Text('CANCELAR',
  //                               style: TextStyle(color: Colors.white)),
  //                         )),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           );
  //         });
}
