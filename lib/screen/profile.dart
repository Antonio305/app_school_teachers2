import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/models/subjects.dart';

import 'dart:ui' as ui;

import 'package:preppa_profesores/widgets/myBackground.dart';
import 'package:provider/provider.dart';

class ProfileTeacher extends StatelessWidget {
  const ProfileTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    final teachaerServices =
        Provider.of<TeachaerServices>(context, listen: false);
    final teacher = teachaerServices.teacherForID;

    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);
    final subjects = subjectServices.subjects;
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(right: -200, top: 20, child: myBackground()),
          const Positioned(left: -180, bottom: -130, child: myBackground()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/student.png'),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${teacher.name} ${teacher.lastName} ${teacher.secondName}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          teacher.collegeDegree,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Aserca de",
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                const Text('aparatado para mostrar sus paciones'),
                Text(
                  'Rol: ${teacher.rol}',
                  style: const TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Informacion de contacto",
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        teacher.email ?? 'falta agregar su correo',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        "Phone: ${teacher.numberPhone ?? 'Falta agregar su numero de telefono'}",
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Text(
                //   "Age: ${teacher.}",
                //   style: TextStyle(fontSize: 16.0),
                // ),
                const SizedBox(height: 8.0),
                Text(
                  "Tipo de Contrato: ${teacher.typeContract}",
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Professional Title: ${teacher.collegeDegree}",
                  style: const TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),

                Text(
                  "Position: 5th Grade Mathematics Teacher",
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Materias que imparte: ",
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  width: 300,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        subjects.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(subjects[index].name),
                            )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
