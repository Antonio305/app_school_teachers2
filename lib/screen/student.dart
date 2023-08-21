import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/rating_services.dart';
import 'package:preppa_profesores/Services/student_services.dart';
import 'package:preppa_profesores/models/group.dart';
import 'package:preppa_profesores/models/rating.dart';
import 'package:preppa_profesores/models/subjects.dart';
import 'package:preppa_profesores/widgets/myBackground.dart';
import 'package:provider/provider.dart';

import '../Services/group_services.dart';
import '../Services/subject_services.dart';
import '../models/studentForSubject.dart';
import '../providers/thme_provider.dart';
import '../widgets/text_fileds.dart';
import '../widgets/utils/style_ElevatedButton.dart';

class ScreenStudent extends StatefulWidget {
  const ScreenStudent({Key? key}) : super(key: key);

  @override
  State<ScreenStudent> createState() => _ScreenStudentState();
}

class _ScreenStudentState extends State<ScreenStudent> {
// creamso los controladores para los campos de texto
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  // controlador para los texto la cual son tres
  TextEditingController parcial1Controller = TextEditingController();
  TextEditingController parcial2Controller = TextEditingController();
  TextEditingController parcial3Controller = TextEditingController();

  String parcial1 = '0.0';
  String parcial2 = '0.0';
  String parcial3 = '0.0';

  @override
  void initState() {
    super.initState();
    parcial1Controller.text = parcial1;
    parcial2Controller.text = parcial2;
    parcial3Controller.text = parcial3;
  }

  // SubjectElement subject = SubjectElement(
  //     name: '', uid: '', semestre: SemestreSubject(id: '', name: ''));

  Subjects subject = Subjects(
      name: '', teachers: '', semestre: Semestre(id: '', name: ''), uid: 'uid');

  GroupElement group = GroupElement(name: '', uid: '');

  // guarada cuel item esta selecionado en una de las materias
  int indexSubjectSelected = 0;
  @override
  Widget build(BuildContext context) {
    // instancia deltheme provider
    final themeProvider = Provider.of<ThemeProvier>(context);
    final isDarkTheme = themeProvider.isDarkTheme;

    // hacemos la instancia de la clase donde obtenemos los arhciovs
    final studentSubjectsServices = Provider.of<StudentServices>(context);
    // StudentForSubject studentSubject = studentSubjectsServices.studentForSubject;

    //query
    final size = MediaQuery.of(context).size;

    final subjectServices = Provider.of<SubjectServices>(context);
    final subjects = subjectServices.subjects;

// physics: const BouncingScrollPhysics(),
    return Container(
      // height: size.height * 0.99,

      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
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
                  color:
                      const ui.Color.fromARGB(87, 75, 12, 117).withOpacity(0.1),
                  // border: Border.all(color: Colors.black),
                ),
              ),
            ),
          ),
          const Positioned(left: -180, bottom: -130, child: myBackground()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.05),

                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(' ALUMNOS',
                        style: TextStyle(fontSize: 24, color: Colors.white70)),
                  ),

                  SizedBox(height: size.height * 0.01),
                  // ignore: prefer_const_constructors
                  Text('SELECCIONA UNA  MATERIA, DESPUES EL GRUPO',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white54)),
                  SizedBox(height: size.height * 0.05),

                  // LSITA DE MAS AMTERIA
                  SizedBox(
                    // color: Colors.red,
                    // width: 400,
                    height: 50,
                    // color: Colors.red,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: subjects.length,
                      // itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: indexSubjectSelected == index
                              ? Colors.red
                              : Colors.transparent,
                          semanticContainer: true,
                          child: MaterialButton(
                            onPressed: () async {
                              // LE VMAOS A ESVIAR DATOS DE UAN MATRIA EN LA CUAL SERIA TODA LA CLASE PARA NO PARASR
                              // POR SOLO STRING

                              subject = subjects[index];
                              openDialog(
                                  context,
                                  size,
                                  //  subjects.subject[index].uid,
                                  subjects[index]);
                              setState(() {
                                indexSubjectSelected = index;
                              });
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: size.height * 0.13,
                                  width: size.width * 0.16,
                                  child: Center(
                                      child: Text(subjects[index].name,
                                          style: const TextStyle(
                                              color: Colors.white54))),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // ListSubjects(size, context, subjects),
                  //  scrollDirection: Axis.horizontal,
                  // physics: const BouncingScrollPhysics(),

                  const SizedBox(height: 15),
                  const Text('Lista de los estudiantes',
                      style: TextStyle(fontSize: 16, color: Colors.white54)),
                  const Spacer(),
                  // const SizedBox(height: 10),

                  ListStudent(studentSubjectsServices, size),
                ]),
          ),
        ],
      ),
    );
  }

  Container ListStudent(StudentServices studentSubjectsServices, Size size) {
    final student = studentSubjectsServices.studentBySubject;

    return Container(
      // color: Colors.red,
      // width: double.infinity,
      width: Platform.isAndroid || Platform.isIOS
          ? size.width * 0.99
          // ? 500
          : size.width * 0.78,
      height: size.height * 0.55,
      decoration: BoxDecoration(
        color: const Color(0xff13162C).withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: studentSubjectsServices.status == true
          ? const Center(child: CircularProgressIndicator())
          : student.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/search.png', width: 150, height: 150),
                    const Text('LISTA VACIA - SELECCIONAR MATERIA Y GRUPO'),
                  ],
                ))
              : ListView.builder(
                  // shrinkWrap: true,
                  itemCount: student.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        final ratingServices =
                            Provider.of<RatingServices>(context, listen: false);

                        final respBody =
                            await ratingServices.getRatingsForSubject(
                                student[index].uid, subject.uid);

                        print(respBody);

                        if (respBody.containsKey('msg')) {
                          // ignore: use_build_context_synchronously
                          await openDialogAddRatings(
                              context,
                              size,
                              group,
                              // student[index].
                              subject,
                              student[index]);
                        } else {
                          Ratings rating = Ratings.fromMap(respBody);
                          // ignore: use_build_context_synchronously

                          // ignore: use_build_context_synchronously
                          openDialogShowRatings(context, size, rating);
                        }
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.5, color: Colors.white10),
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(index.toString(),
                                        style: const TextStyle(
                                            color: Colors.white54)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        "${student[index].name}  ${student[index].lastName}  ${student[index].secondName}",
                                        style: const TextStyle(
                                            color: Colors.white54)),
                                  ],
                                ),
                                Platform.isAndroid || Platform.isIOS
                                    ? Container()
                                    : MaterialButton(
                                        onPressed: () async {
                                          final ratingServices =
                                              Provider.of<RatingServices>(
                                                  context,
                                                  listen: false);

                                          final respBody = await ratingServices
                                              .getRatingsForSubject(
                                                  student[index].uid,
                                                  subject.uid);

                                          print(respBody);

                                          if (respBody.containsKey('msg')) {
                                            // ignore: use_build_context_synchronously
                                            await openDialogAddRatings(
                                                context,
                                                size,
                                                group,
                                                // student[index].
                                                subject,
                                                student[index]);
                                          } else {
                                            Ratings rating =
                                                Ratings.fromMap(respBody);
                                            // ignore: use_build_context_synchronously

                                            // ignore: use_build_context_synchronously
                                            openDialogShowRatings(
                                                context, size, rating);
                                          }
                                          setState(() {});
                                        },
                                        child: const Text(
                                            'Agregar Calificacion',
                                            style: TextStyle(
                                                color: Colors.white54))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         width: 300,
                    //         child: ListTile(
                    //           title: SizedBox(
                    //             width: 200,
                    //             child: Text(
                    //                 "${student[index].name}  ${student[index].lastName}  ${student[index].secondName}"),
                    //           ),
                    //           onTap: () async {
                    //             final ratingServices =
                    //                 Provider.of<RatingServices>(context,
                    //                     listen: false);

                    //             final respBody =
                    //                 await ratingServices.getRatingsForSubject(
                    //                     student[index].uid, subject.uid);

                    //             print(respBody);

                    //             if (respBody.containsKey('msg')) {
                    //               // ignore: use_build_context_synchronously
                    //               await openDialogAddRatings(
                    //                   context,
                    //                   size,
                    //                   group,
                    //                   // student[index].
                    //                   subject,
                    //                   student[index]);
                    //             } else {
                    //               Ratings rating = Ratings.fromMap(respBody);
                    //               // ignore: use_build_context_synchronously

                    //               // ignore: use_build_context_synchronously
                    //               openDialogShowRatings(context, size, rating);
                    //             }
                    //             setState(() {});
                    //           },
                    //         ),
                    //       ),
                    //       //  mostrar si estmao en windowsa
                    //       Platform.isAndroid || Platform.isIOS
                    //           ? Container()
                    //           : MaterialButton(
                    //               onPressed: () async {
                    //                 final ratingServices =
                    //                     Provider.of<RatingServices>(context,
                    //                         listen: false);

                    //                 final respBody = await ratingServices
                    //                     .getRatingsForSubject(
                    //                         student[index].uid, subject.uid);

                    //                 print(respBody);

                    //                 if (respBody.containsKey('msg')) {
                    //                   // ignore: use_build_context_synchronously
                    //                   await openDialogAddRatings(
                    //                       context,
                    //                       size,
                    //                       group,
                    //                       // student[index].
                    //                       subject,
                    //                       student[index]);
                    //                 } else {
                    //                   Ratings rating =
                    //                       Ratings.fromMap(respBody);
                    //                   // ignore: use_build_context_synchronously

                    //                   // ignore: use_build_context_synchronously
                    //                   openDialogShowRatings(
                    //                       context, size, rating);
                    //                 }
                    //                 setState(() {});
                    //               },
                    //               child: const Text('Agregar Calificacion')),
                    //     ],
                    //   ),
                    // );
                  },
                ),
    );
  }

  SizedBox ListSubjects(
      Size size, BuildContext context, List<Subjects> subjects) {
    return SizedBox(
      height: size.height * 0.13,
      width: Platform.isAndroid || Platform.isIOS
          ? size.width * 0.99
          : size.width * 0.76,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.unknown,
            PointerDeviceKind.stylus,
            PointerDeviceKind.invertedStylus
          },
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subjects.length,
          // itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              semanticContainer: true,
              child: MaterialButton(
                onPressed: () async {
                  // LE VMAOS A ESVIAR DATOS DE UAN MATRIA EN LA CUAL SERIA TODA LA CLASE PARA NO PARASR
                  // POR SOLO STRING

                  subject = subjects[index];
                  openDialog(
                      context,
                      size,
                      //  subjects.subject[index].uid,
                      subjects[index]);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: Platform.isAndroid || Platform.isIOS
                          ? 100
                          : size.height * 0.13,
                      width: Platform.isAndroid || Platform.isIOS
                          ? 100
                          : size.width * 0.16,
                      child: Center(child: Text(subjects[index].name)),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

// for groupe
  Future<String?> openDialog(
          BuildContext context,
          Size size,
          // String subjectId,
          Subjects subject) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            return Center(
              child: AlertDialog(
                content: SelectGroup(subject: subject, group: group),
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

// by add ratings
  Future<String?> openDialogAddRatings(
    BuildContext context,
    Size size,
    GroupElement group,
    Subjects subject,
    StudentForSubject student,
  ) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            @override
            void initState() {
              super.initState();
            }

// para ios
            return Center(
              child: AlertDialog(
                content: Container(
                  // color: Colors.red,
                  width: size.width * 0.5,
                  height: size.height / 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // vetical
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('INGRESAR CALIFICACION'),
                        Form(
                          key: _keyForm,
                          child: Platform.isMacOS || Platform.isWindows
                              ? Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Parcial1'),
                                        SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            // controller: parcial1Controller,
                                            // initialValue: '0',
                                            keyboardType: TextInputType.number,

                                            validator: (value) {
                                              if (value == null) {
                                                return 'Agrega una calificacion';
                                              } else {
                                                final isNumeric =
                                                    num.tryParse(value) != null;
                                                if (!isNumeric) {
                                                  return 'Solo se permiten números.';
                                                }
                                                return null;
                                              }
                                            },
                                            // // Expresión regular para verificar si la entrada es numérica

                                            //   final isDigitsOnly =
                                            //       RegExp(r'^\d+$')
                                            //           .hasMatch(value ?? '');
                                            //   if (!isDigitsOnly) {
                                            //     return 'SOLO NUMEROS';
                                            //   }
                                            //   return null;
                                            // },
                                            onChanged: (value) {
                                              parcial1 = value;
                                            },
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Parcial2'),
                                        SizedBox(
                                            width: 150,
                                            child: TextFormField(
                                              // controller: parcial2Controller,
                                              // initialValue: '0.0',
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return null;
                                                } else {
                                                  final isNumeric =
                                                      num.tryParse(value) !=
                                                          null;
                                                  if (!isNumeric) {
                                                    return 'Solo se permiten números.';
                                                  }
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                parcial2 = value;
                                              },
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Parcial3'),
                                        SizedBox(
                                            width: 150,
                                            child: TextFormField(
                                              // controller: parcial3Controller,
                                              // initialValue: '0.0',
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return null;
                                                } else {
                                                  final isNumeric =
                                                      num.tryParse(value) !=
                                                          null;
                                                  if (!isNumeric) {
                                                    return 'Solo se permiten números.';
                                                  }
                                                  return null;
                                                }
                                              },

                                              //   // // Expresión regular para verificar si la entrada es numérica
                                              //   final isDigitsOnly =
                                              //       RegExp(r'^\d+$')
                                              //           .hasMatch(value!); // este puede vacion
                                              //   if (!isDigitsOnly) {
                                              //     return 'SOLO NUMEROS';
                                              //   }
                                              //   return null;
                                              // },
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                parcial3 = value;
                                              },
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    )
                                  ],
                                )
                              :
                              // segunda parte para los moviesF
                              Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Parcial1'),
                                        SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              // si es nulo no hacemos nada
                                              if (value!.isEmpty) {
                                                return 'Parcial 1 es obligatorio';
                                              } else {
                                                // verificamos is son numeros
                                                final isNumeric =
                                                    num.tryParse(value) != null;

                                                if (!isNumeric) {
                                                  return 'Solo se permiten numeros';
                                                }
                                                return null;
                                              }
                                            },
                                            onChanged: (value) {
                                              parcial1 = value;
                                            },
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Parcial2'),
                                        SizedBox(
                                            width: 150,
                                            child: TextFormField(
                                              validator: (value) {
                                                // si es nulo no hacemos nada
                                                if (value!.isEmpty) {
                                                  return null;
                                                } else {
                                                  // verificamos is son numeros
                                                  final isNumeric =
                                                      num.tryParse(value) !=
                                                          null;

                                                  if (!isNumeric) {
                                                    return 'Solo se permiten numeros';
                                                  }
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                parcial2 = value;
                                              },
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Parcial3'),
                                        SizedBox(
                                            width: 150,
                                            child: TextFormField(
                                              validator: (value) {
                                                // si es nulo no hacemos nada
                                                if (value!.isEmpty) {
                                                  return null;
                                                } else {
                                                  // verificamos is son numeros
                                                  final isNumeric =
                                                      num.tryParse(value) !=
                                                          null;

                                                  if (!isNumeric) {
                                                    return 'Solo se permiten numeros';
                                                  }
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                parcial3 = value;
                                              },
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                        ),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Colors.black,
                            onPressed: () async {
                              if (_keyForm.currentState!.validate()) {
                                // Navigator.pop(context);
                                final studentServices =
                                    Provider.of<RatingServices>(context,
                                        listen: false);

// antes de eso en initialValue debe toma el valor pero no9 lo hace

                                final partial11 = double.parse(parcial1);

                                final partial22 = double.parse(parcial2);
                                final partial33 = double.parse(parcial3);

                                final semesterGrade =
                                    (partial11 + partial22 + partial33) / 3;

                                final rating = Ratings(
                                    student: student.uid,
                                    group: student.group.id,
                                    semestre: subject.semestre.id,
                                    subject: subject.uid,
                                    parcial1: partial11,
                                    parcial2: partial22,
                                    parcial3: partial33,
                                    semesterGrade: semesterGrade);

                                await studentServices.postRating(rating);

                                parcial1Controller.clear();
                                parcial2Controller.clear();
                                parcial3Controller.clear();

                                // studentServices.postRating(
                                //     student.uid,
                                //     student.group.id,
                                //     subject.semestre.id,
                                //     subject.uid,
                                //     partial1,
                                //     partial2,
                                //     partial3,
                                //     semesterGrade);

                                Navigator.pop(context);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 35, right: 35),
                              child: Text('GUARDAR CALIFICACION',
                                  style: TextStyle(color: Colors.white)),
                            )),
                      ]),
                ),
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

// show Rating
  Future<String?> openDialogShowRatings(
          BuildContext context, Size size, Ratings rating) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            // Ratings rating = Ratings.fromMap(respBody);

            // String a = rating.parcial1.toString
            @override
            void initState() {
              super.initState();
            }

            String? partial1 = rating.parcial1.toString();
            String? partial2 = rating.parcial2.toString();
            String? partial3 = rating.parcial3.toString();

            return Center(
              child: AlertDialog(
                scrollable: true,
                contentPadding: const EdgeInsets.all(10),
                content: Container(
                  // color: Colors.red,
                  width: Platform.isAndroid || Platform.isIOS
                      ? size.width
                      : size.width * 0.5,
                  height: Platform.isAndroid || Platform.isIOS
                      ? size.height / 1.5
                      : size.height / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // vetical
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('CALIFICACION'),
                      // Row(
                      //   children: [
                      //     Text(rating.semestre),
                      //     // Text(rating.student),
                      //     // Text(rating.subject),
                      //   ],
                      // ),
                      SizedBox(
                        // height: 400,
                        // width: 200,
                        child: Row(
                          // scrollDirection: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 150,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    children: [
                                      const Text('PARCIAL 1'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        // height: 40,
                                        width: 65,
                                        child: TextFormField(
                                          decoration:
                                              InputDecorations.authDecoration(
                                                  hintText: '', labelText: ''),
                                          initialValue:
                                              rating.parcial1.toString(),
                                          validator: (value) {
                                            // // Expresión regular para verificar si la entrada es numérica
                                            final isDigitsOnly =
                                                RegExp(r'^\d+$')
                                                    .hasMatch(value ?? '');
                                            if (!isDigitsOnly) {
                                              return 'SOLO NUMEROS';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            partial1 = value;
                                          },
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      // Text(rating.parcial1.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: Card(
                                  child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    const Text('PARCIAL 2'),

                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      // height: 40,
                                      width: 65,
                                      child: TextFormField(
                                        decoration:
                                            InputDecorations.authDecoration(
                                                hintText: '', labelText: ''),
                                        initialValue:
                                            rating.parcial2.toString(),
                                        validator: (value) {
                                          // // Expresión regular para verificar si la entrada es numérica
                                          final isDigitsOnly = RegExp(r'^\d+$')
                                              .hasMatch(value ?? '');
                                          if (!isDigitsOnly) {
                                            return 'SOLO NUMEROS';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          partial2 = value;
                                        },
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                    // Text(rating.parcial2.toString()
                                  ],
                                ),
                              )),
                            ),
                            SizedBox(
                              height: 150,
                              child: Card(
                                  child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    const Text('PARCIAL 3'),
                                    const SizedBox(
                                      height: 5,
                                    ),

                                    SizedBox(
                                      // height: 40,
                                      width: 65,
                                      child: TextFormField(
                                        decoration:
                                            InputDecorations.authDecoration(
                                                hintText: '', labelText: ''),
                                        initialValue:
                                            rating.parcial3.toString(),
                                        validator: (value) {
                                          // // Expresión regular para verificar si la entrada es numérica
                                          final isDigitsOnly = RegExp(r'^\d+$')
                                              .hasMatch(value ?? '');
                                          if (!isDigitsOnly) {
                                            return 'SOLO NUMEROS';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          partial3 = value;
                                        },
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    // Text(rating.parcial3.toString()),
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Colors.black,
                          onPressed: () async {
                            // Navigator.pop(context);
                            final ratingServices = Provider.of<RatingServices>(
                                context,
                                listen: false);

                            final partial11 = double.parse(partial1 ?? '0');
                            final partial22 = double.parse(partial2 ?? '0');
                            final partial33 = double.parse(partial3 ?? '0');

                            final semesterGrade =
                                (partial11 + partial22 + partial33) / 3;

                            await ratingServices.updateRating(
                                // rating.student, pasa como parametro el id del ratings
                                rating.id!,
                                partial11,
                                partial22,
                                partial33,
                                semesterGrade);
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 35, right: 35),
                            child: Text('GUARDAR CAMBIOS',
                                style: TextStyle(color: Colors.white)),
                          )),
                    ],
                  ),
                ),
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
                            child: Text('SALIR',
                                style: TextStyle(color: Colors.white)),
                          )),
                    ],
                  )
                ],
              ),
            );
          });
}

// ignore: camel_case_types

class SelectGroup extends StatefulWidget {
  final Subjects subject;
  GroupElement group;

  SelectGroup({super.key, required this.subject, required this.group});
  @override
  State<SelectGroup> createState() => _SelectGroupState();
}

class _SelectGroupState extends State<SelectGroup> {
  // intancr group

  @override
  Widget build(BuildContext context) {
    final groupServider = Provider.of<GroupServices>(context, listen: false);
    final groups = groupServider.group;
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
              children: List.generate(groups.groups.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: StyleElevatedButton.styleButton,
                    onPressed: () async {
                      setState(() {});
                      widget.group = groups.groups[index];
                      final studentServices =
                          Provider.of<StudentServices>(context, listen: false);

                      Navigator.pop(context);
                      await studentServices.getStudentForGroupAndSubject(
                          groups.groups[index].uid, widget.subject.uid);
                      // ignore: use_build_context_synchronously
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 50,
                        height: 30,
                        child: Center(child: Text(groups.groups[index].name)),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

//seleste
