// import 'package:flutter/material.dart';

// class ContentShowModalSheet extends StatefulWidget {
//   const ContentShowModalSheet({super.key});

//   @override
//   State<ContentShowModalSheet> createState() => _ContentShowModalSheetState();
// }

// class _ContentShowModalSheetState extends State<ContentShowModalSheet> {
//   // BY FILE
//   File? file;
//   String? nameFile;
//   String? filePath;
//   String comments = '';
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final student = Provider.of<StudentServices>(context, listen: false);

//     final sendTask = Provider.of<TaskServices>(context);

//     final taskServices = Provider.of<TaskServices>(context);

//     final task = taskServices.taskSelected;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Card(
//           // color: const Color(0xff25282F),
//           child: SizedBox(
//             width: double.infinity,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   nameFile == null
//                       ? const Text('NO HAY ARCHIVOS SELECCIONADOS')
//                       : Text(
//                           "$nameFile",
//                           style: const TextStyle(
//                               color: Colors.white60, fontSize: 14),
//                         ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   ElevatedButton(
//                     // color: Colors.black87,

//                     onPressed: () async {
//                       // intancia de la clase para abreri los archivos
//                       // PickerFiles resultPicker =
//                       //       PickerFiles()       ;
//                       // final  result =
//                       //       await resultPicker.pickerFile();

//                       FilePickerResult? result =
//                           await FilePicker.platform.pickFiles();

//                       if (result == null) {
//                         // ignore: use_build_context_synchronously
//                         // MySnackBar.MySnack(
//                         //     context, 'No se seleciono ningun archivo');
//                         // User canceled the picker
//                         print('USER CANCELED THE PICKER');
//                       } else {
//                         setState(() {
//                           // file = File(
//                           //     result.files.single.path!);
//                           file = File(result.files.single.path!);
//                           nameFile = result.files.single.name;
//                         });
//                         // setState(() {});
//                         print(file!.path);
//                       }
//                     },

//                     child: const Text(
//                       ' Selecionar Archivo ',
//                       style: TextStyle(color: Colors.white60, fontSize: 14),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: sendTask.status == true
//               ? const CircularProgressIndicator.adaptive()
//               : ElevatedButton(
//                   // color: Colors.blue.withOpacity(0.7),
//                   onPressed: () async {
//                     final fileServices =
//                         Provider.of<FilesServices>(context, listen: false);

//                     // await sendTask.sendTask(
//                     //     student.student.uid!, task.id, 'cahles');

//                     // ahy queregresar en la vida anterios
//                     // Navigator.pop(context);
//                     // taskReceived

// // si no hay archivos
//                     if (file == null) {
//                       // ignore: use_build_context_synchronously
//                       messageNotFile(context);

//                       // await sendTask.sendTask(student.student.uid!,
//                       //     task.id, task.subject.uid, comments);

//                       // Navigator.pushNamed(
//                       //     context, 'create_task');

//                       // print('No hay archivos seleccionados');
//                       return;
//                     } else {
//                       // si hay archivos

//                       // verificamos i no ehemos hechio el registro de los datos

// // esto  no tien que ir
//                       final Map<String, dynamic> respBody = await sendTask
//                           .getByStudentTask(student.student.uid!, task.id);

//                       if (respBody.containsKey('msg')) {
//                         await sendTask.sendTask(student.student.uid!, task.id,
//                             task.subject.uid, comments);

//                         await fileServices.uploadFiles(
//                             file, task.id, 'taskReceived');

//                         // AchievementView(
//                         //   context,
//                         //   color: Colors.orange,
//                         //   isCircle: true,
//                         //   title: "TAREA ENVIADO",
//                         //   subTitle: "FELICIDADES   " +
//                         //       student.student.name,
//                         //   icon: const Icon(Icons.star,
//                         //       color: Color.fromARGB(
//                         //           255, 126, 120, 209)),
//                         //   typeAnimationContent:
//                         //       AnimationTypeAchievement
//                         //           .fadeSlideToUp,
//                         //   borderRadius:
//                         //       BorderRadius.circular(10),
//                         // ).show();

//                         //   showDialog(
//                         //     context: context,
//                         //     builder: (BuildContext context) {
//                         //       return AlertDialog(
//                         //         title:
//                         //             const Text("FELICIDADES"),
//                         //         content: Text(respBody['msg']),
//                         //         actions: [
//                         //           ElevatedButton(
//                         //             child:
//                         //                 const Text("ACEPTAR"),
//                         //             onPressed: () {
//                         //               Navigator.of(context)
//                         //                   .pop();
//                         //             },
//                         //           ),
//                         //         ],
//                         //       );
//                         //     },
//                         //   );
//                       } else {
//                         // ignore: use_build_context_synchronously
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text("Felicidades"),
//                               content: const Text("YA HABIAS HECHO LA ENTREGA"),
//                               actionsAlignment: MainAxisAlignment.center,
//                               actions: [
//                                 ElevatedButton(
//                                   child: const Text("ACEPTAR"),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         );

//                         // await sendTask.sendTask(
//                         //     student.student.uid!,
//                         //     task.id,
//                         //     'cahles');

//                         // await fileServices.uploadFiles(
//                         //     file, task.id, 'taskReceived');

//                         // AchievementView(
//                         //   context,
//                         //   color: Colors.orange,
//                         //   isCircle: true,
//                         //   title: "TAREA ENVIADO",
//                         //   subTitle: "FELICIDADES   " +
//                         //       student.student.name,
//                         //   icon: const Icon(Icons.star,
//                         //       color: Color.fromARGB(
//                         //           255, 126, 120, 209)),
//                         //   typeAnimationContent:
//                         //       AnimationTypeAchievement
//                         //           .fadeSlideToUp,
//                         //   borderRadius:
//                         //       BorderRadius.circular(10),
//                         // ).show();
//                       }
//                     }
//                   },
//                   child: const Padding(
//                     padding:
//                         EdgeInsets.only(top: 8, bottom: 8, right: 45, left: 45),
//                     child: Text('ENVIAR  TAREA'),
//                   ),
//                 ),
//         )
//       ],
//     );
//   }

//   Future<dynamic> messageNotFile(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Error"),
//           content: const Text("No se ha seleccionado un archivo."),
//           actions: [
//             ElevatedButton(
//               child: const Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
