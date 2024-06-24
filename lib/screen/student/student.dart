import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/rating_services.dart';
import 'package:preppa_profesores/Services/student_services.dart';
import 'package:preppa_profesores/models/group.dart';
import 'package:preppa_profesores/models/rating.dart';
import 'package:preppa_profesores/models/student.dart';
import 'package:preppa_profesores/models/subjects.dart';
import 'package:preppa_profesores/utils/textStyleOptions.dart';
import 'package:preppa_profesores/widgets/myBackground.dart';
import 'package:provider/provider.dart';

import '../../Services/group_services.dart';
import '../../Services/subject_services.dart';
import '../../models/studentForSubject.dart';
import '../../providers/isMobile.dart';
import '../../widgets/restartSessionLogin.dart';
import '../../widgets/text_fileds.dart';
import '../../widgets/utils/border.dart';
import '../../widgets/utils/style_ElevatedButton.dart';

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

// // late Subjects subjects

  Subjects subject = Subjects(
      name: '',
      teachers: TeacherBySubjects(
          name: '',
          lastName: '',
          secondName: '',
          gender: '',
          collegeDegree: '',
          typeContract: '',
          status: false,
          rol: '',
          tuition: '',
          id: ''),
      semestre: Semestre(id: '', name: ''),
      uid: 'uid',
      description: '',
      examDate: [],
      syllabas: [],
      learningObjetive: '',
      evaluationCriteria: '');

  // Student? subject;

  GroupElement group = GroupElement(name: '', uid: '');

  // guarada cuel item esta selecionado en una de las materias
  int indexSubjectSelected = 0;
  late RatingServices ratingServices;

  int indexSelectedStudent = 0;
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 45,
      letterSpacing: 2,
      shadows: [
        Shadow(
          color: Colors.grey.withOpacity(0.5),
          offset: const Offset(1, 1),
          blurRadius: 1,
        ),
      ],
    );

    // instancia deltheme provider
    // final themeProvider = Provider.of<ThemeProvier>(context);
    final studentSubjectsServices = Provider.of<StudentServices>(context);
    final subjectServices = Provider.of<SubjectServices>(context);
    ratingServices = Provider.of<RatingServices>(context);
    final size = MediaQuery.of(context).size;
    final subjects = subjectServices.subjects;

    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -200,
            top: 20,
            child: myBackground(),
          ),
          const Positioned(left: -180, bottom: -130, child: myBackground()),
          Padding(
            padding: IsMobile.isMobile()
                ? const EdgeInsets.symmetric(horizontal: 0)
                : const EdgeInsets.symmetric(horizontal: 38),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              Text(' Alumnos ', style: textStyle),
              SizedBox(height: size.height * 0.05),
              listSubjects(subjects, size, subjectServices),
              const SizedBox(height: 15),
              // Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lista de los estudiantes',
                      style: TextStyleOptionsHome.styleText,
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.restart_alt_rounded),
                        label: const Text('Recargar')),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Total de estudianes ${studentSubjectsServices.studentBySubject.length}',
                      style: TextStyleOptionsHome.styleText,
                    )
                  ],
                ),
              ),
              // Divider(),
              // SizedBox(height: size.height * 0.02),
              listStudent(studentSubjectsServices, size, subjectServices)
            ]),
          ),
        ],
      ),
    );
  }

  SizedBox listSubjects(
      List<Subjects> subjects, ui.Size size, SubjectServices subjectServices) {
    return SizedBox(
      // color: Colors.red,
      // width: 400,
      height: 40,
      // color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subjects.length,
        // itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: indexSubjectSelected == index ? Colors.purple : null,
              onPressed: () async {
                // POR SOLO STRING
                subject = subjects[index];
                subjectServices.subjectSelected = subjects[index];
                subjectServices.subjectSelectedByStudent = subjects[index];
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
                  child: Text(
                subjects[index].name,
              )),
            ),
          );
        },
      ),
    );
  }

  listStudent(StudentServices studentSubjectsServices, Size size,
      SubjectServices subjectServices) {
    final student = studentSubjectsServices.studentBySubject;

    var boxDecoration = BoxDecoration(
        borderRadius: MyBorder.myBorderRadius(),
        border: Border.all(color: Colors.black12));

    return Flexible(
      child: Container(
        width: Platform.isAndroid || Platform.isIOS
            ? size.width * 0.99
            // ? 500
            : size.width * 0.78,
        decoration: boxDecoration,
        child: studentSubjectsServices.status == true
            ? const Center(child: CircularProgressIndicator())
            : student.isEmpty
                ? listStudentIsEmpty()
                : listStudents(student, size, subjectServices),
      ),
    );
  }

  Widget listStudents(
      List<Student> student, ui.Size size, SubjectServices subjectServices) {
    return ListView.builder(
      // shrinkWrap: true,
      itemCount: student.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            final studentServices =
                Provider.of<StudentServices>(context, listen: false);

            studentServices.selectedStudent = student[index];

            // get student by group and subject
            studentServices.getStudent(
                student[index].uid, subjectServices.subjectSelected.uid);

            Navigator.pushNamed(context, 'show_studentByTeacher');
            // indexSelectedStudent = index;

            await ratingServices.getRatingsForSubject(student[index].uid,
                subjectServices.subjectSelectedByStudent.uid);

            // print(respBody);
            if (ratingServices.statusCodes == 401) {
              // ignore: use_build_context_synchronously
              RestartSession.restartSession(context);
              return;
            }
            if (ratingServices.statusCodes == 200) {
              // ignore: use_build_context_synchronously
              // openDialogShowRatings(
              //     context, size, ratingServices.ratingResponse.rating!);
              return;
            }

            // ignore: use_build_context_synchronously
            // await openDialogAdGrades(
            //     context,
            //     size,
            //     group,
            //     // student[index].
            //     subject,
            //     student[index]);
            // return;
            // }

            // caso contrari si ya existe ejecutamos esta parte del codigo
          },
          child: ListTile(
            selectedColor: Colors.indigo,
            leading: CircleAvatar(
              // radius: 15,
              child: Text(
                index.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
            title: Text(
              student[index].name,
            ),
            subtitle: const Text('Agregar calificacion'),
            trailing:
                ratingServices.status == true && indexSelectedStudent == index
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.chevron_right_rounded),
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
        //               await openDialogAdGrades(
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
        //                   await openDialogAdGrades(
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
    );
  }

  Center listStudentIsEmpty() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/search.png', width: 75, height: 75),
        const Text('LISTA VACIA - SELECCIONAR MATERIA Y GRUPO'),
      ],
    ));
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
            return AlertDialog(
              icon: const Icon(Icons.groups_3_rounded),
              title: const Text('Grupos'),
              content: SelectGroup(subject: subject, group: group),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                    style: StyleElevatedButton.styleButton,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Salir'))
              ],
            );
          });

// by add ratings
  Future<String?> openDialogAdGrades(
    BuildContext context,
    Size size,
    GroupElement group,
    Subjects subject,
    Student student,
  ) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            // para ios
            return AlertDialog(
              icon: const Icon(Icons.grade_outlined),
              title: const Text('Calificacion'),
              content: SizedBox(
                // color: Colors.red,
                width: size.width * 0.3,
                height: size.height * 0.25,
                child: Form(
                  key: _keyForm,
                  child: Center(
                    child: Wrap(
                      //  runSpacing: 10,
                      spacing: 10,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Parcial 1',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 75,
                              child: TextFormField(
                                decoration: InputDecorations.authDecoration(
                                    hintText: '', labelText: 'Cal.'),

                                // controller: _keyForm
                                //
                                // ,
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
                            const Text(
                              'Parcial 2',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: 75,
                                child: TextFormField(
                                  decoration: InputDecorations.authDecoration(
                                      hintText: '', labelText: 'Cal.'),

                                  // controller: parcial2Controller,
                                  // initialValue: '0.0',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return null;
                                    } else {
                                      final isNumeric =
                                          num.tryParse(value) != null;
                                      if (!isNumeric) {
                                        return 'Solo se permiten números.';
                                      }
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    parcial2 = value;
                                  },
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Parcial 3',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: 75,
                                child: TextFormField(
                                  decoration: InputDecorations.authDecoration(
                                      hintText: '', labelText: 'Cal.'),

                                  // controller: parcial3Controller,
                                  // initialValue: '0.0',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return null;
                                    } else {
                                      final isNumeric =
                                          num.tryParse(value) != null;
                                      if (!isNumeric) {
                                        return 'Solo se permiten números.';
                                      }
                                      return null;
                                    }
                                  },

                                  keyboardType: TextInputType.number,
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
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text('Cancelar'),
                    )),
                ElevatedButton(
                    onPressed: () async {
                      if (_keyForm.currentState!.validate()) {
                        // Navigator.pop(context);
                        final studentServices =
                            Provider.of<RatingServices>(context, listen: false);

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
                            semesterGrade: semesterGrade,
                            generation: student.generation.generation);

                        await studentServices.postRating(rating);

                        parcial1Controller.clear();
                        parcial2Controller.clear();
                        parcial3Controller.clear();

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text('Guardar Cal.'),
                    )),
              ],
            );
          });

// show Rating
  // Future<String?> openDialogShowRatings(
  //         BuildContext context, Size size, Ratings rating) =>
  //     showDialog<String>(
  //         // barrierColor: Colors.red[200], // color de fondo del dialong
  //         context: context,
  //         builder: (context) {
  //           // Ratings rating = Ratings.fromMap(respBody);

  //           // String a = rating.parcial1.toString
  //           @override
  //           void initState() {
  //             super.initState();
  //           }

  //           String? partial1 = rating.parcial1.toString();
  //           String? partial2 = rating.parcial2.toString();
  //           String? partial3 = rating.parcial3.toString();

  //           return Center(
  //             child: AlertDialog(
  //               icon: const Icon(Icons.grade_sharp),
  //               title: const Text('Calificacion'),
  //               scrollable: true,
  //               // contentPadding: const EdgeInsets.all(10),
  //               content: SizedBox(
  //                 // color: Colors.red,
  //                 width: IsMobile.isMobile() ? size.width : size.width * 0.4,
  //                 height: IsMobile.isMobile()
  //                     ? size.height * 0.3
  //                     : size.height * 0.18,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   // vetical
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     SizedBox(
  //                       child: Wrap(
  //                         // scrollDirection: Axis.horizontal,
  //                         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(10.0),
  //                             child: Column(
  //                               children: [
  //                                 const Text(
  //                                   '1',
  //                                   style: TextStyle(
  //                                       fontSize: 22,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 5,
  //                                 ),
  //                                 SizedBox(
  //                                   // height: 40,
  //                                   width: 75,
  //                                   child: TextFormField(
  //                                     decoration:
  //                                         InputDecorations.authDecoration(
  //                                             hintText: '', labelText: ''),
  //                                     initialValue: rating.parcial1
  //                                         .toString()
  //                                         .substring(0, 3),
  //                                     validator: validationField,
  //                                     onChanged: (value) {
  //                                       partial1 = value;
  //                                     },
  //                                     textAlign: TextAlign.center,
  //                                   ),
  //                                 ),
  //                                 // Text(rating.parcial1.toString()),
  //                               ],
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.all(10.0),
  //                             child: Column(
  //                               children: [
  //                                 const Text(
  //                                   '2',
  //                                   style: TextStyle(
  //                                       fontSize: 20,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),

  //                                 const SizedBox(
  //                                   height: 5,
  //                                 ),
  //                                 SizedBox(
  //                                   // height: 40,
  //                                   width: 65,
  //                                   child: TextFormField(
  //                                     decoration:
  //                                         InputDecorations.authDecoration(
  //                                             hintText: '', labelText: ''),
  //                                     initialValue: rating.parcial2.toString(),
  //                                     validator: validationField,
  //                                     onChanged: (value) {
  //                                       partial2 = value;
  //                                     },
  //                                     textAlign: TextAlign.center,
  //                                   ),
  //                                 ),

  //                                 // Text(rating.parcial2.toString()
  //                               ],
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.all(10.0),
  //                             child: Column(
  //                               children: [
  //                                 const Text(
  //                                   '3',
  //                                   style: TextStyle(
  //                                       fontSize: 20,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 5,
  //                                 ),

  //                                 SizedBox(
  //                                   // height: 40,
  //                                   width: 75,
  //                                   child: TextFormField(
  //                                     decoration:
  //                                         InputDecorations.authDecoration(
  //                                             hintText: '', labelText: ''),
  //                                     initialValue: rating.parcial3.toString(),
  //                                     validator: validationField,
  //                                     onChanged: (value) {
  //                                       partial3 = value;
  //                                     },
  //                                     textAlign: TextAlign.center,
  //                                   ),
  //                                 ),

  //                                 // Text(rating.parcial3.toString()),
  //                               ],
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.all(10.0),
  //                             child: Column(
  //                               children: [
  //                                 Text(
  //                                   'Cal. Semestral :  ${rating.semestreGrades}',
  //                                   style: const TextStyle(
  //                                       fontSize: 20,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 5,
  //                                 ),

  //                                 // Text(rating.parcial3.toString()),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               actions: [
  //                 TextButton(
  //                     onPressed: () async {
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Padding(
  //                       padding: EdgeInsets.only(left: 10, right: 10),
  //                       child: Text(
  //                         'SALIR',
  //                       ),
  //                     )),
  //                 TextButton(
  //                     onPressed: () async {
  //                       // Navigator.pop(context);
  //                       final ratingServices =
  //                           Provider.of<RatingServices>(context, listen: false);

  //                       final partial11 = double.parse(partial1 ?? '0');
  //                       final partial22 = double.parse(partial2 ?? '0');
  //                       final partial33 = double.parse(partial3 ?? '0');

  //                       final semesterGrade =
  //                           (partial11 + partial22 + partial33) / 3;

  //                       await ratingServices.updateRating(
  //                           // rating.student, pasa como parametro el id del ratings
  //                           rating.id!,
  //                           partial11,
  //                           partial22,
  //                           partial33,
  //                           semesterGrade);
  //                       // ignore: use_build_context_synchronously
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Padding(
  //                       padding: EdgeInsets.only(left: 10, right: 10),
  //                       child: Text(
  //                         'Guardar',
  //                       ),
  //                     )),
  //               ],
  //             ),
  //           );
  //         });

  String? validationField(value) {
    // // Expresión regular para verificar si la entrada es numérica
    final isDigitsOnly = RegExp(r'^\d+$').hasMatch(value ?? '');
    if (!isDigitsOnly) {
      return 'SOLO NUMEROS';
    }
    return null;
  }
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

    return Wrap(
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 10,
      spacing: 10,
      children: List.generate(groups.groups.length, (index) {
        return ElevatedButton(
          style: StyleElevatedButton.styleButton,
          onPressed: () async {
            setState(() {});
            widget.group = groups.groups[index];

            final studentServices =
                Provider.of<StudentServices>(context, listen: false);

            Navigator.pop(context);
            // consulta la  informacion de los alumnos por el grupo y la materia

            await studentServices.getStudentForGroupAndSubject(
                groups.groups[index].uid, widget.subject.uid);
            // ignore: use_build_context_synchronously
          },
          child: Text(groups.groups[index].name),
        );
      }),
    );
  }
}

//seleste
