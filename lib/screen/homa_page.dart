import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/group_services.dart';
import 'package:preppa_profesores/providers/dialog_option.dart';
import 'package:preppa_profesores/widgets/card_story.dart';
import 'package:provider/provider.dart';

import '../Services/publication_services.dart';
import '../Services/subject_services.dart';
import '../models/teacher.dart';
import '../widgets/myBackground.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  //  final Subject subjects = Subject(msg: '', subject: []);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

// INTANCIE CLASS PROVIDER
    final teacherServices = Provider.of<TeachaerServices>(context);
    final teachers = teacherServices.teacherForID;

//  para la lsita de materia
    final subjectsServices =
        Provider.of<SubjectServices>(context, listen: false);
    final subjects = subjectsServices.subjects;
    //  final teachers = teacherServices.teacherForID;
    print(" Nombre del profesor  en el ome   ${teachers.name}");

    return
        // app: AppBar

        SizedBox(
      width: Platform.isMacOS || Platform.isWindows
          ? size.width * 0.8
          : double.infinity,
      child: SafeArea(
        child: Stack(
          children: [
            // estso hay qeu extraerlo en un solo widget
            const Positioned(
              right: -200,
              top: 20,
              child: myBackground(),
            ),

            ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      _wecome(teachers: teachers),
                      const SizedBox(
                        height: 15,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Story(),
                          // _anuncios(size, context),
                          Card(
                            // color: Colors.blueAccent,

                            child: Container(
                              width: Platform.isAndroid || Platform.isIOS
                                  ? size.width * 0.96
                                  : size.width / 4,
                              height: Platform.isAndroid || Platform.isIOS
                                  ? size.height * 0.3
                                  : size.height * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text('MIS MATERIAS'),
                                      Container(
                                        // color:Colors.red,
                                        width: 300,
                                        height: 200,
                                        child: Center(
                                          child: SingleChildScrollView(
                                            child: Wrap(
                                                children: List.generate(
                                                    subjects.length,
                                                    (index) => TextButton(
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              'information_subject');
                                                        },
                                                        child: Text(
                                                            subjects[index]
                                                                .name)))),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // SizedBox(
                      const Text(
                        'OTRAS OPCIONES PARA LOS ESTUDIANES',
                        style: TextStyle(color: Colors.white54),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: size.height * 0.007,
                      ),

                      // la pate de abajo
                      // para ver los estudiaens por sus calificaciones
                      // y generar una archivo para descargarlos
                      ShowStudentByGrades(size, context),

                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container ShowStudentByGrades(ui.Size size, BuildContext context) {
    return Container(
        width: double.infinity,
        height: size.height * 0.27,
        decoration: BoxDecoration(
            // color: const Color(0xff25282F).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        child: ListView(
          scrollDirection: Axis.horizontal,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            CardOptionGrades(
              image: 'assets/student.png',
              onPress: () {
                // SE ENVIAR UN NUMNERO APRA SABER CUAL BOT9ON SE ESTA USANDO
                int option = 1;
                ListDialogByStudent.selectedParcial(context, size, option);
              },
              textButton: 'VER ALUMNOS',
              textTile: 'MEJORES CALIFICACIONES',
            ),
            CardOptionGrades(
              image: 'assets/student.png',
              onPress: () {
                int option = 2;
                ListDialogByStudent.selectedParcial(context, size, option);
              },
              textButton: 'VER ALUMNOS',
              textTile: 'CALIFACIONES REGUALES',
            ),
            CardOptionGrades(
              image: 'assets/student.png',
              onPress: () {
                int option = 3;
                ListDialogByStudent.selectedParcial(context, size, option);
              },
              textButton: 'VER ALUMNOS',
              textTile: ' REPROBATORIOS',
            ),
          ],
        ));
  }



  Future<String?> openDialog(BuildContext context, Size size) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            return Center(
              child: AlertDialog(
                content: const SelectGroup(),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Colors.black,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 35, right: 35),
                            child: Text('CANCELAR',
                                style: TextStyle(color: Colors.white)),
                          )),
                    ],
                  )
                ],
              ),
            );
          });
}


class _wecome extends StatelessWidget {
  _wecome({
    Key? key,
    required this.teachers,
  }) : super(key: key);

  Teachers teachers;

  @override
  Widget build(BuildContext context) {
    // final loginServices = Provider.of<LoginServices>(context);

    // // teachers = loginServices.teachers;
    // final teacherS = Provider.of<TeachaerServices>(context);
    // teachers = teacherS.teacherForID;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BUEN DIA',
          style: TextStyle(color: Colors.white60, fontSize: 24),
        ),
        // Text(
        //   teachers.name,
        //   style: const TextStyle(color: Colors.white60, fontSize: 24),
        // ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "${teachers.name}  ${teachers.lastName} ${teachers.secondName}",
          style: const TextStyle(fontSize: 16, color: Colors.white54),
        ),
      ],
    );
  }
}

class CardOptionGrades extends StatefulWidget {
  final String textTile;
  final String textButton;
  final String image;
  final Function onPress;

  const CardOptionGrades(
      {super.key,
      required this.textTile,
      required this.textButton,
      required this.image,
      required this.onPress});

  @override
  State<CardOptionGrades> createState() => _CardOptionState();
}

class _CardOptionState extends State<CardOptionGrades>
    with SingleTickerProviderStateMixin {
  late Animation<double> _opacityAnimatin;
  // controller animatin
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controlador
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // add aniamtino
    _opacityAnimatin = Tween<double>(
      begin: 5.0,
      end: 5.0,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  /// name iamge
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 220,
        // height: 200,
        // color: Colors.red,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.image,
                  width: 50, height: 50, opacity: _opacityAnimatin),
              const SizedBox(height: 10),
              Text(
                widget.textTile,
                style: const TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    widget.onPress();
                    // cambiar el estdo de la aplicacioh
                  },
                  child: Text(widget.textButton,
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 12)))
            ]),
      ),
    );
  }
}

// ignore: camel_case_types
class SelectGroup extends StatefulWidget {
  const SelectGroup({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectGroup> createState() => _SelectGroupState();
}

class _SelectGroupState extends State<SelectGroup> {
  // intancr group

  @override
  Widget build(BuildContext context) {
    final groupServider = Provider.of<GroupServices>(context, listen: false);
    final group = groupServider.group;
    final size = MediaQuery.of(context).size;

    return Container(
      // width: 200,
      height: size.height / 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // seleciona una de tus gropos
            const Text('Seleciona un grupo'),
            Wrap(
              children: List.generate(
                  group.groups.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.red,
                          width: 70,
                          height: 50,
                          child: Center(child: Text(group.groups[index].name)),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
