import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/publication_services.dart';
import 'package:preppa_profesores/models/publication.dart';
import 'package:preppa_profesores/models/subjects.dart';
import 'package:preppa_profesores/providers/dialog_option.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/screen/horarios.dart';
import 'package:preppa_profesores/utils/padding.dart';
import 'package:preppa_profesores/widgets/card_story.dart';
import 'package:preppa_profesores/widgets/utils/style_ElevatedButton.dart';
import 'package:provider/provider.dart';

import '../Services/saveFileServices.dart';
import '../models/teacher.dart';
import '../providers/thme_provider.dart';
import '../shared_preferences.dart/shared_preferences.dart';
import '../widgets/myScrollConfigure.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
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
    // final saveFileServices = Provider.of<SaveFileInLocalProvider>(context);

    return SizedBox(
      width: IsMobile.isMobile() ? size.width : size.width * 0.75,
      child: Stack(
        children: [
          // estso hay qeu extraerlo en un solo widget
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Padding(
                padding: IsMobile.isMobile()
                    ? const EdgeInsets.symmetric(horizontal: 10)
                    : const EdgeInsets.symmetric(horizontal: 38),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: IsMobile.isMobile()
                            ? size.height * 0.05
                            : size.height * 0.015,
                      ),
                      Welcome(
                        teachers: teachers,
                        size: size,
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      const Text(
                        'Materias',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: SizedBox(
                          height: 35,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                                subjects.length,
                                (index) => Padding(
                                      padding: MyPadding.paddingH(),
                                      child: TextButton.icon(
                                          onPressed: () {
                                            final subjectServices =
                                                Provider.of<SubjectServices>(
                                                    context,
                                                    listen: false);
                                            subjectServices.subjectSelected =
                                                subjects[index].copyWith();

                                            setState(() {
                                              subjectServices.syllaba = null;
                                            });

                                            Navigator.pushNamed(
                                                context, 'information_subject');
                                          },
                                          icon: const Icon(
                                              Icons.verified_rounded),
                                          label: Text(subjects[index].name)),
                                    )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Story and subjects
                      Container(
                        // color: Colors.red,
                        child: IsMobile.isMobile()
                            ? Column(
                                children: [
                                  Story(),
                                  Container(
                                    height: 200,
                                    width: size.width * 0.2,
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Story(),
                                  Card(
                                    elevation: 2,
                                    child: Container(
                                      // color: Colors.red,
                                      height: size.height * 0.5,
                                      width: size.width * 0.27,
                                      child: Padding(
                                        padding: MyPadding.paddingInsideCard(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Horarios'),
                                            SizedBox(
                                                height: 30,
                                                child: MyScrollConfigure(
                                                  child: ListView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    children: List.generate(
                                                        5,
                                                        (index) => TextButton.icon(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.verified),
                                                            label: TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child: const Text(
                                                                    'Hols')))),
                                                  ),
                                                )),
                                            Flexible(
                                                child: ListView(
                                              children: List.generate(
                                                  8,
                                                  (index) =>
                                                      const Text('Horas')),
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                        'Generacines en la que ha sido profesor',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),

                      const Text(
                        'Estudiantes por calificacion',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ShowStudentByGrades(size, context),

                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      // Publications
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Publicaciones'),
                          TextButton(
                            style: StyleElevatedButton.styleButton,
                            onPressed: () {
                              Navigator.pushNamed(context, 'list_publications');
                            },
                            child: const Text('Ver todas'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // publicaciones
                      const ListPublications(),
                      const SizedBox(
                        height: 100,
                      ),
                    ]),
              ),
            ),
          ),

          // const Positioned(
          //   right: -200,
          //   top: 20,
          //   child: myBackground(),
          // ),
        ],
      ),
    );
  }

  SizedBox ShowStudentByGrades(ui.Size size, BuildContext context) {
    return SizedBox(
        width: size.width * 0.99,
        height: size.height * 0.2,
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
              textButton: 'Ver alumnos',
              textTile: 'Mejores calificaciones',
            ),
            CardOptionGrades(
              image: 'assets/student.png',
              onPress: () {
                int option = 2;
                ListDialogByStudent.selectedParcial(context, size, option);
              },
              textButton: 'Ver alumnos',
              textTile: 'Calificaciones regulares',
            ),
            CardOptionGrades(
              image: 'assets/student.png',
              onPress: () {
                int option = 3;
                ListDialogByStudent.selectedParcial(context, size, option);
              },
              textButton: 'Ver alumnos',
              textTile: 'Reprobatorios',
            ),
          ],
        ));
  }

  Future<String?> openDialog(BuildContext context, size) => showDialog<String>(
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

class ListPublications extends StatefulWidget {
  const ListPublications({super.key});

  @override
  State<ListPublications> createState() => _ListPublicationsState();
}

class _ListPublicationsState extends State<ListPublications> {
  void onLoading() async {
    final publicationServices =
        Provider.of<PublicationServices>(context, listen: false);
    await publicationServices.allPublicationByPagination();
  }

  @override
  void initState() {
    // TODO: implement initState
    // onLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final publicationServices = Provider.of<PublicationServices>(context);
    final listPublicatios = publicationServices.publications;

    return SizedBox(
      // decoration:MyBorder.myDecorationBorder(Colors.red),
      height: 245,
      child: MyScrollConfigure(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: listPublicatios.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  final publicationServices =
                      Provider.of<PublicationServices>(context, listen: false);
                  publicationServices.publicationSelected =
                      listPublicatios[index].withCopy();

                  Navigator.pushNamed(context, 'show_publications');
                },
                child: cardPublicationByHome(size, listPublicatios[index]));
          },
        ),
      ),
    );
  }
  // rAYO OCN ETO SI QUE E MUY REA

  Widget cardPublicationByHome(Size size, Publication publication) {
    return Card(
      // color: Colors.indigo.withOpacity(0.9),
      // color: const Color(0xff242529),
      // color: Color.fromARGB(255, 23, 30, 54),

      child: SizedBox(
        width: Platform.isAndroid || Platform.isIOS ? size.width * 0.93 : 350,
        // height: 200,
        // color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.sp,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 20, child: Text(publication.initialNameAuthor)
                      //  Icon(Icons.person, size: 30),
                      ),
                  const SizedBox(width: 14),
                  Text(
                    publication.authorDetails,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text('${publication.publishesAgo} dias'),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                publication.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15.5),
              ),
              const SizedBox(height: 10),
              if (publication.description != null)
                Text(publication.description!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Welcome extends StatefulWidget {
  Welcome({Key? key, required this.teachers, required this.size})
      : super(key: key);

  Teachers teachers;
  Size size;

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late TextStyle myStyleText;

// Función para retornar el horario en formato de 24 horas
  int getHorario() {
    DateTime now = DateTime.now();

    String hour = now.hour.toString().padLeft(2, '0');
    int newHour = int.parse(hour);
    return newHour;
  }

  Widget nose(int hour) {
    // && indica que los dos tiene que ser  verdaderos
    //  || Solo tiene que ser uno de los dos verdadeors para ser verdadeors
    if (hour >= 5 && hour <= 11) {
      return myText('Buenos dias');
    }
    if (hour >= 12 && hour <= 19) {
      return myText('Buenas  tardes');
    }

    if (hour >= 17 && hour <= 24) {
      return myText('Buenas  noches');
    }
    //  por defecto retornnaria
    // de la hora 1 a 5  de la madrugada
    return myText('Linda  madrugada');
  }

  Text myText(String text) {
    return Text(
      text,
      style: myStyleText,
    );
  }

  final preferences = Preferences();
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    isDarkMode = preferences.getIsDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    myStyleText = TextStyle(
      fontWeight: FontWeight.bold,
      // fontSize: 45,
      // fontSize: MediaQuery.of(context).size.height * 0.047,
      fontSize: MediaQuery.of(context).size.height * 0.042,

      letterSpacing: 2,
      shadows: [
        Shadow(
          color: Colors.grey.withOpacity(0.5),
          offset: const Offset(1, 1),
          blurRadius: 1,
        ),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: nose(getHorario()),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              // ignore: unnecessary_string_interpolations
              child: Text(
                widget.teachers.nameTeacher,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        if (Platform.isWindows || Platform.isMacOS)
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final loginServices =
                      Provider.of<LoginServices>(context, listen: false);
                  loginServices.logout();
                  // despues iremos  al login para el nuevo inicio de sesion

                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: const Text('Cerrar Sesion'),
              ),
              SizedBox(
                width: 180,
                child: SwitchListTile.adaptive(
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
              ),
            ],
          )
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
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    // add aniamtino
    _opacityAnimatin = Tween<double>(
      begin: 4.5,
      end: 5.0,
    ).animate(_controller);
    _controller.repeat(); //repoite la animacion
    // _controller.forward(); // solo ejecuta la animacino una vez
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
    return GestureDetector(
      onTap: () {
        widget.onPress();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black12)),
        width: 270,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  widget.image,
                  width: 40, height: 40,
                  // opacity: _opacityAnimatin
                ),
                // const Icon(Icons.grade_sharp),
                const SizedBox(height: 10),
                Text(
                  widget.textTile,
                  // style: const TextStyle(color: Colors.white54),
                ),
                // ElevatedButton(
                //     style: StyleElevatedButton.styleButton,
                //     onPressed: () {
                //       widget.onPress();
                //       // cambiar el estdo de la aplicacioh
                //     },
                //     child: Text(
                //       widget.textButton,
                //       // style:
                //       //     const TextStyle(color: Colors.white54, fontSize: 12
                //       // )
                //     ))
              ]),
        ),
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

    return SizedBox(
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
