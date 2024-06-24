import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/providers/isMobile.dart';


import 'package:preppa_profesores/widgets/myBackground.dart';
import 'package:provider/provider.dart';

import '../providers/thme_provider.dart';
import '../shared_preferences.dart/shared_preferences.dart';

class ProfileTeacher extends StatefulWidget {
  const ProfileTeacher({super.key});

  @override
  State<ProfileTeacher> createState() => _ProfileTeacherState();
}

class _ProfileTeacherState extends State<ProfileTeacher> {
  final preferences = Preferences();
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    isDarkMode = preferences.getIsDarkMode;
  }

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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),

                  IsMobile.isMobile()
                      ? Row(
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
                                    overflow: TextOverflow.ellipsis),
                                Text(
                                  teacher.collegeDegree,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage('assets/student.png'),
                            ),
                            const SizedBox(height:20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  
                                  "${teacher.name} ${teacher.lastName} ${teacher.secondName}",
                                  style: const TextStyle(fontSize: 20.0),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
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

                  SwitchListTile.adaptive(
                      title: const Text('Tema'),
                      value: preferences.getIsDarkMode,
                      // value: isDarkMode,
                      onChanged: (bool? value) {
                        final themeProvider =
                            Provider.of<ThemeProvier>(context, listen: false);

                        preferences.setIsDarkMode = value!;
                        // isDarkMode = value;
                        value
                            ? themeProvider.setDarkMode()
                            : themeProvider.setLightMode();

                        themeProvider.isDarkTheme = value;
                        setState(() {});
                      }),
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
                  const SizedBox(height: 8.0),
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
                  const SizedBox(height: 8.0),

                  const Text(
                    "Position: 5th Grade Mathematics Teacher",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
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
                  ),
                          
              MaterialButton(
                onPressed: () async {
                  final loginServices =
                      Provider.of<LoginServices>(context, listen: false);
                  loginServices.logout();
                  // despues iremos  al login para el nuevo inicio de sesion
        
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, 'login');
                },
                color: Colors.blueAccent,
                child: const Text('Cerrar Sesion'),
              )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
