import 'dart:io';

import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/rating_services.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:preppa_profesores/models/teacher.dart';
import 'package:preppa_profesores/screen/profile.dart';
import 'package:preppa_profesores/screen/student.dart';
import 'package:preppa_profesores/screen/tutor.dart';
import 'package:provider/provider.dart';
import 'package:preppa_profesores/providers/menu_option_provider.dart';

import '../Services/adviseAndTutor.dart';
import '../screen/group.dart';
import '../screen/homa_page.dart';
import '../screen/horarios.dart';
import '../screen/task.dart';

class Content extends StatelessWidget {
  final Size size;

  const Content({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
//  intancia del provider

    final menuProvider = Provider.of<MenuOptionProvider>(context);

    final size = MediaQuery.of(context).size;
    return  Container(
        // margin: const EdgeInsets.all(10),
        // width: size.width * 0.76,

        width: Platform.isMacOS || Platform.isWindows
            ? size.width * 0.74
            : size.width,

        // width:  double.infinity,
        height: size.height * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Color(0xFF0F1123),
        ),
        // child:
        child: const Menus(),
    );
  }
}

class Menus extends StatefulWidget {
  const Menus({Key? key}) : super(key: key);

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuOptionProvider>(context);
    // final teacher = Provider.of<TeachaerServices>(context, listen: false);
    final teachersServices = Provider.of<TeachaerServices>(context);
    final teachers = teachersServices.teacherForID;

    // get teask
    final taskServices = Provider.of<TaskServices>(context, listen: false);

    switch (menuProvider.itemMenuGet) {
      case 0:
        // subjectServices.getSubjectsForTeacher();j
        return const HomePage2();
      case 1:
        return const ScreenStudent();

      case 2:
        return const ScreenTask();
        break;
        
      case 3:
        return const ScreenChat();
        break;
      case 4:
        // return Horarios();
        return const TutorScreen();
      case 5:
        return const ProfileTeacher();

      // case 5:
      //   return const TutorScreen();
      default:
        return const HomePage2();
    }
  }
}
