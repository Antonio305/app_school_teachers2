import 'dart:io';

import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/adviseAndTutorServices.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/screen/student/list_student.dart';
import 'package:preppa_profesores/widgets/myBackground.dart';
import 'dart:ui' as ui;

import 'package:preppa_profesores/widgets/utils/style_ElevatedButton.dart';
import 'package:provider/provider.dart';

import '../Services/teacher_services.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({super.key});

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  String? idGroup;
  String? idSemestre;
  String? idGeneration;

  @override
  Widget build(BuildContext context) {
    final teachersServices = Provider.of<TeachaerServices>(context);
    final teachers = teachersServices.teacherForID;

    final adviser = Provider.of<AdviserTutorServices>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: IsMobile.isMobile()
            ? const EdgeInsets.all(0)
            : const EdgeInsets.all(50.0),
        child: SizedBox(
          // color: Colors.white,
          width: double.infinity,
          child: Stack(
            children: [
              const Positioned(right: -200, top: 20, child: myBackground()),
              const Positioned(
                left: -180,
                bottom: -130,
                child: myBackground(),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/show_student.png'),
                    SizedBox(
                      width: 270,
                      child: ElevatedButton(
                          style: StyleElevatedButton.styleButton,
                          onPressed: () async {
                            String? datos =
                                await adviser.amIAdviser(teachers.uid);

                            // print(datos);
                            if (datos != null) {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Asesor e Tutor'),
                                      content: Text(datos),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                          child: const Text('Aceptar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              return;
                            } else {
                              adviser.getStudentForAdviser(
                                  adviser.adviserTutor.generation.uid,
                                  adviser.adviserTutor.semestre.uid,
                                  adviser.adviserTutor.group.uid);
                              // print('Buscadno ALUMNOS');

                              // final students = adviser.studentAdviser;
                              // HACER LA NAVEGACIN A LA OTRA  VIDTA
                              // ignore: use_build_context_synchronously
                              // Navigator.pushNamed(context, 'list_student',
                              //     arguments: students);

                              // ignore: use_build_context_synchronously

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) =>
                                      const ScreenListStudent(),
                                  transitionDuration:
                                      const Duration(milliseconds: 150),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: animation.drive(
                                        Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: const Offset(0.0, 0.0),
                                        ),
                                      ),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: adviser.status == true
                                ? const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Verificando si eres tutor'),
                                      CircularProgressIndicator.adaptive(),
                                    ],
                                  )
                                : const Text('VER ALUMNOS'),
                          )),
                    )
                  ],
                ),
              ),
              // if (adviser.status == true)
              //   Positioned(
              //     // left: 180,
              //     right: 90,
              //     left: 90,
              //     bottom: 300,
              //     child: Container(
              //       width: 100,
              //       height: 100,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(10),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.withOpacity(0.5),
              //             spreadRadius: 5,
              //             blurRadius: 7,
              //             offset: const Offset(0, 3), // changes shadow position
              //           ),
              //         ],
              //       ),
              //       child: const Row(
              //         children: [
              //           Text('Verificando si eres tutor'),
              //           CircularProgressIndicator.adaptive(),
              //         ],
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
