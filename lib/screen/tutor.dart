import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:preppa_profesores/Services/studentByAdviser.dart';
import 'package:preppa_profesores/widgets/utils/style_ElevatedButton.dart';
import 'package:provider/provider.dart';

import '../Services/adviseAndTutor.dart';
import '../Services/generation_services.dart';
import '../Services/group_services.dart';
import '../Services/semestre.dart';
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

    return Scaffold(
      body: Padding(
        padding: Platform.isAndroid || Platform.isIOS
            ? const EdgeInsets.all(0)
            : const EdgeInsets.all(50.0),
        child: Container(
          // color: Colors.white,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                right: -200,
                top: 20,
                child: Transform.rotate(
                  angle: 15,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const ui.Color.fromARGB(87, 75, 12, 117)
                          .withOpacity(0.1),
                      // border: Border.all(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -180,
                bottom: -130,
                child: Transform.rotate(
                  angle: 15,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: const ui.Color.fromARGB(87, 75, 12, 117)
                          .withOpacity(0.1),
                      // Color.fromARGB(85, 111, 49, 153).withOpacity(0.1),

                      // border: Border.all(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/show_student.png'),
                    ElevatedButton(
                        style: StyleElevatedButton.styleButton,
                        onPressed: () async {
                          final adviser = Provider.of<AdviserTutorServices>(
                              context,
                              listen: false);
                          // adviser.getStudentForAdviser(teachers., semestre, group));

                          /**
                       * Primero hacer una verificacion si es un tutor */

                          String? datos = await adviser
                              .getStudentForAdviserss(teachers.uid);

                          print(datos);
                          if (datos != null) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(' Asesor'),
                                    content: Text(datos),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                            return null;
                          } else {

                             adviser.getStudentForAdviser(
                                adviser.adviserTutor.generation.uid,
                                adviser.adviserTutor.semestre.uid,
                                adviser.adviserTutor.group.uid);
                            print('Buscadno ALUMNOS');

                            final students = adviser.studentAdviser;
                            // HACER LA NAVEGACIN A LA OTRA  VIDTA
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, 'list_student',
                                arguments: students);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text('VER ALUMNOS'),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
