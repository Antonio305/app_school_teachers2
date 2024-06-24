import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/screen/profile.dart';
import 'package:preppa_profesores/screen/student/student.dart';
import 'package:preppa_profesores/screen/tutor.dart';
import 'package:provider/provider.dart';
import 'package:preppa_profesores/providers/menu_option_provider.dart';

import '../screen/group.dart';
import '../screen/homa_page.dart';
import '../screen/task/task.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
//  intancia del provider

    final menuProvider = Provider.of<MenuOptionProvider>(context);

    final size = MediaQuery.of(context).size;

    return Container(
      // color: Color(0xffD3D3D3),
      width: IsMobile.isMobile()
          ? size.width
          // ? size.width
          : size.width * 0.79,
      child: const SafeArea(child: Menus()),
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

    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);

    // final taskServices = Provider.of<TaskServices>(context, listen: false);

    final subjects = subjectServices.subjects;

    switch (menuProvider.itemMenuGet) {
      case 0:
        // subjectServices.getSubjectsForTeacher();j
        return const HomePage2();
      case 1:
        if (subjects.isEmpty) {
          return const NotSubjects();
        }
        return const ScreenStudent();

      case 2:
        if (subjects.isEmpty) {
          return const NotSubjects();
        }
        return const ScreenTask();
        break;

      case 3:
        if (subjects.isEmpty) {
          return const NotSubjects();
        }
        return const ScreenChat();
        break;
      case 4:
        // return Horarios();
        return const TutorScreen();
      case 5:
        return const ProfileTeacher();

      case 6:
        return const TutorScreen();
      default:
        return const HomePage2();
    }
  }
}

class NotSubjects extends StatefulWidget {
  const NotSubjects({
    super.key,
  });

  @override
  State<NotSubjects> createState() => _NotSubjectsState();
}

class _NotSubjectsState extends State<NotSubjects>
    with SingleTickerProviderStateMixin {
// contrlador par las animaciones
  late AnimationController _controller;

// inicializamos
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        // Duracin de la animacion
        duration: const Duration(seconds: 5),
        vsync: this);
    _controller.addListener(() {
      setState(() {});
    });

    _controller.repeat();
    // _controller.forward();
  }

  @override
  void dispose() {
    // hace que al salir de la vista se elimine la animacion
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/show_student.png'),
        const SizedBox(height: 20),
        AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Text(
                'No tienes materias agregado'
                , style: TextStyle(fontSize: 18)
                // style: TextStyle(fontSize: _controller.value * 30, textBaseline: TextBaseline.alphabetic),
              );
            }),
      ],
    );
  }
}
