import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:provider/provider.dart';

import '../Services/chat/socket_servives.dart';
import '../Services/story_services.dart';
import '../Services/task_services.dart';
import '../models/subjects.dart';
import 'home.dart';
import 'login/login.dart';

import 'dart:math' as math;

class CheckAuthScreen extends StatefulWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  State<CheckAuthScreen> createState() => _CheckAuthScreenState();
}

class _CheckAuthScreenState extends State<CheckAuthScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final loginServices = Provider.of<LoginServices>(context, listen: false);
    final loginServices = Provider.of<LoginServices>(context, listen: false);
    print('token dentro del storage');
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          // se crear un metodo por apart
          // future: loginServices.readToken(),
          future: checkLoginState(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // shanpshot guarda el dato que retorna el el future

            // if (!snapshot.hasData) return const Text('Espere');

            // // Future.Microtask es para esperar que se recostruya todo el widget que se  mostrara a continucacio
            // if (snapshot.data == '') {
            //   Future.microtask(() {
            //     Navigator.pushReplacement(
            //       context,
            //       PageRouteBuilder(
            //         pageBuilder: (_, __, ___) => const LoginScreen(),
            //         transitionDuration: const Duration(seconds: 0),
            //       ),
            //     );
            //   });
            // } else {
            //   Future.microtask(() async {
            //     // final groupServices =
            //     //     Provider.of<GroupServices>(context, listen: false);
            //     // final generationServices =
            //     //     Provider.of<GenerationServices>(context, listen: false);
            //     // final subjectServices =
            //     //     Provider.of<SubjectServices>(context, listen: false);

            //     // // FIRST GET INFIRMATION TEACHER
            //     final teachaerServices =
            //         Provider.of<TeachaerServices>(context, listen: false);
            //     final storyServices =
            //         Provider.of<StoryServices>(context, listen: false);

            //     // final semestreServices =
            //     //     Provider.of<SemestreServices>(context, listen: false);

            //     // await subjectServices.getSubjectsForTeacher();

            //     // // print(subject);
            //     // await generationServices.allGeneration();
            //     // await semestreServices.allSemestre();

            //     // await groupServices.getGroupForId();
            //     await teachaerServices.getForId();

            //     await storyServices.getAllStoryByStatusTrue();

            //     // conecion apra el socker desde el auth
            //     final socketS =
            //         // ignore: use_build_context_synchronously
            //         Provider.of<SocketService>(context, listen: false);
            //     socketS.connect();

            //     Navigator.pushReplacement(
            //         context,
            //         PageRouteBuilder(
            //             pageBuilder: (_, __, ___) => const HomePage(),
            //             transitionDuration: const Duration(seconds: 0)));

            //     //  Navigator.of(context).pushReplacementNamed('home');
            //   });
            // }

            // return Container();
            return const Text('Cargando....');
            // return LoadingAnimation();
            // return const Cube3D(size: 100, color: Colors.red);

            //  const Text('Espere');
          },
        ),
      ),
    );
  }

  // par ver si esta autenticado
  Future checkLoginState(BuildContext context) async {
    // instnaccia del class con providr
    final loginServices = Provider.of<LoginServices>(context, listen: false);

    /**
     * verificar si hay token
     */

    String? token = await loginServices.readToken();
    if (token.isNotEmpty) {
      String? token = await loginServices.storage.read(key: 'token');

      // bool isValid = await loginServices.isValidToekn();
      bool isValid = await loginServices.validateToken2();

      print(isValid);

      if (isValid == false ||
          loginServices.loginResponseTeacher.userData == null) {
        Future.microtask(() {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginScreen(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        });
      } else {
        Future.microtask(() async {
          final storyServices =
              Provider.of<StoryServices>(context, listen: false);
          final loginServices =
              Provider.of<LoginServices>(context, listen: false);
          final teacherServices =
              Provider.of<TeachaerServices>(context, listen: false);
          final subjectServices =
              Provider.of<SubjectServices>(context, listen: false);
          final socketS = Provider.of<SocketService>(context, listen: false);

          teacherServices.teacherForID = loginServices.teachers!;

          await subjectServices.getSubjectsForTeacher();
          await storyServices.getAllStoryByStatusTrue();
          await onLoadingTaskStatusTrue();

          await socketS.connect();

          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const DashBoard(),
                  transitionDuration: const Duration(seconds: 0)));

          //  Navigator.of(context).pushReplacementNamed('home');
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionDuration: const Duration(seconds: 0),
        ),
      );
    }
  }

  List<String> listIdSubjects(List<Subjects> subjects) {
    List<String> idSubject = [];
    for (var subject in subjects) {
      idSubject.add(subject.uid);
    }
    return idSubject;
  }

  Future<void> onLoadingTaskStatusTrue() async {
    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);
    final taskServices = Provider.of<TaskServices>(context, listen: false);

    List<Subjects> subjects = subjectServices.subjects;

    if (subjects.isEmpty) {
      return;
    }

    final idSubject = listIdSubjects(subjects);

    await taskServices.getTaskStatusTrue(idSubject);
  }
}

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (_, child) {
            return Transform.rotate(
              angle: _animation.value,
              child: child,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCube(Colors.red),
              const SizedBox(width: 10),
              _buildCube(Colors.green),
              const SizedBox(width: 10),
              _buildCube(Colors.blue),
            ],
          ),
        ),
        const Text('Cargando', style: TextStyle(fontSize: 24)),
      ],
    );
  }

  Widget _buildCube(Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 2),
      ),
    );
  }
}
