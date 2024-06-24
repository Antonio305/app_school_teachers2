import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:preppa_profesores/models/subjects.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/utils/padding.dart';
import 'package:provider/provider.dart';

import '../../Services/rating_services.dart';
import '../../models/rating.dart';
import '../../models/student.dart';
import '../../models/task/tasks.dart';
import '../../models/taskReceived.dart';
import '../../widgets/text_fileds.dart';

class ShowStudentByTeacher extends StatefulWidget {
  const ShowStudentByTeacher({Key? key}) : super(key: key);

  @override
  State<ShowStudentByTeacher> createState() => _ShowStudentByTeacherState();
}

class _ShowStudentByTeacherState extends State<ShowStudentByTeacher> {
  // estas clases puede ser nulos
  Ratings? rating;
  // lista de tareas que ha entregado el alumno por cada materia, la materia que se ha selecionadoF
  List<TaskReceived>? taskReceiveds = [];
  // instnace class Student
  late Student student;
  late Subjects subject;
  List<Tasks> listTasks = [];

  int pendingask = 0;
  @override
  Widget build(BuildContext context) {
    final studentServices = Provider.of<StudentServices>(context);
    final subjectServices = Provider.of<SubjectServices>(context);
    final taskServices = Provider.of<TaskServices>(context);
    student = studentServices.selectedStudent;
    subject = subjectServices.subjectSelected;
    taskReceiveds = studentServices.gradeAndTaksRecivedsResponse.tasksReceiveds;
    rating = studentServices.gradeAndTaksRecivedsResponse.rating;
    listTasks = taskServices.tasks;

    final size = MediaQuery.of(context).size;
    pendingask = listTasks.length - taskReceiveds!.length;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const ColFor(0XFF1d2027),
        title: const Text('Name student'),
      ),

      body: SafeArea(
        child: Padding(
          padding: IsMobile.isMobile()
              ? const EdgeInsets.symmetric(horizontal: 0, vertical: 0)
              : const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: studentServices.status
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: SingleChildScrollView(
                    child: Wrap(spacing: 10, runSpacing: 10, children: [
                      profile(size),
                      dataTutor(size),
                      tasks(size),
                      grade(size, studentServices),
                    ]),
                  ),
                ),
        ),
      ),
      // child: ContenAndroidIos(student: student)),
    );
  }

  Card dataTutor(Size size) {
    return Card(
      child: SizedBox(
        // color: Colors.blue,
        width: IsMobile.isMobile() ? size.width : size.width * 0.22,
        height: size.height * 0.32,
        child: Padding(
          padding: MyPadding.paddingInsideCard(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Datos del tutor', style: titleCardShowStudent()),
            const Spacer(),
            Center(
              child: CircleAvatar(
                child: Text(student.studentTutor.tutorName.substring(0, 1) +
                    student.studentTutor.lastNameTutor.substring(0, 1)),
              ),
            ),
            const Spacer(),
            Text('Tutor: ${student.studentTutor.tutorName}', style: style1()),
            Text('Numeor de contacto: ${student.studentTutor.numberPhoneTutor}',
                style: style1()),
            Text('Parestesco: ${student.studentTutor.kinship}',
                style: style1()),
          ]),
        ),
      ),
    );
  }

  Card grade(Size size, StudentServices studentServices) {
    return Card(
      elevation: 5,
      child: SizedBox(
        // color: Colors.red,
        width: IsMobile.isMobile() ? size.width : size.width * 0.45,
        height: IsMobile.isMobile() ? size.height * 0.6 : size.height * 0.4,
        child: Padding(
          padding: MyPadding.paddingInsideCard(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text('Calificaciones', style: titleCardShowStudent()),
                const Spacer(),
                studentServices.gradeAndTaksRecivedsResponse.rating != null
                    ? IconButton(
                        color: Colors.red,
                        onPressed: () {},
                        icon: const Icon(Icons.edit))
                    : Container(),
              ],
            ),
            const Spacer(),
            studentServices.gradeAndTaksRecivedsResponse.rating == null
                ? Center(
                    child: TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                titleTextStyle: const TextStyle(fontSize: 18),
                                title: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Agregar calificacion'),
                                    CloseButton(),
                                  ],
                                ),
                                content: const ScreenAddGrade(),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.grade),
                        label: const Text('Agregar calificacion')),
                  )
                : Wrap(
                    children: [
                      cardGrade(
                        size,
                        'Primer parcial',
                        rating!.parcial1.toString(),
                      ),
                      cardGrade(
                        size,
                        'Segundo parcial',
                        rating!.parcial2.toString(),
                      ),
                      cardGrade(
                        size,
                        'Tercer parcial',
                        rating!.parcial3.toString(),
                      ),
                      cardGrade(
                        size,
                        'Calificacion final',
                        rating!.semesterGrade.toString(),
                      ),
                    ],
                  ),
            const Spacer(),
          ]),
        ),
      ),
    );
  }

  Card cardGrade(Size size, String textPartial, String grade) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: MyPadding.paddingInsideCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // width: size.width * 0.1,
              width: IsMobile.isMobile() ? size.width : 170,
              child: Row(
                mainAxisAlignment: IsMobile.isMobile()
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.grade),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    textPartial,
                    style: const TextStyle(
                        letterSpacing: 1,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              grade,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget profile(Size size) {
    return Card(
      elevation: 1,
      child: SizedBox(
        // color: Colors.red,
        width: IsMobile.isMobile() ? size.width : size.width * 0.32,
        height: size.height * 0.32,
        child: Padding(
            padding: MyPadding.paddingInsideCard(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Perfil', style: titleCardShowStudent()),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 30,
                      child: Text(student.nameInitial),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Text(student.nameStudent,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    ' Grupo : ${student.group.name}    ${student.semestre.first.name}    Generacion: ${student.generation.generation}',
                    style: style1(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ])),
      ),
    );
  }

  TextStyle titleCardShowStudent() =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  TextStyle style1() =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  SizedBox tasks(Size size) {
    return SizedBox(
      // color: Colors.red,
      width: IsMobile.isMobile() ? size.width : size.width * 0.33,
      height: size.height * 0.32,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: MyPadding.paddingInsideCard(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Tareas, Entregados, calificados',
                  style: titleCardShowStudent()),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('Tareas: ${listTasks.length}',
                      style: titleCardShowStudent()),
                  const Spacer(),
                  buttonGrade(() {}, 'Ver Todos'),
                ],
              ),
              const Spacer(),
              Wrap(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    // const Spacer(),
                    // buttonGrade(() {}, 'Tareas: ${listTasks.length}'),
                    buttonGrade(() {}, 'Entregados:${taskReceiveds!.length}'),
                    buttonGrade(() {}, 'Entregados:${taskReceiveds!.length}'),
                    buttonGrade(() {}, 'Pendientes: $pendingask'),
                    buttonGrade(() {}, 'Calificados : 20'),
                  ]),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }

  TextButton buttonGrade(Function onPressed, String text) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: stuleTextOptioTask(),
      ),
    );
  }

  TextStyle stuleTextOptioTask() {
    return const TextStyle(
        letterSpacing: .5, fontSize: 15, fontWeight: FontWeight.w400);
  }
}

class ScreenAddGrade extends StatefulWidget {
  const ScreenAddGrade({super.key});

  @override
  State<ScreenAddGrade> createState() => _ScreenAddGradeState();
}

class _ScreenAddGradeState extends State<ScreenAddGrade> {
  late Size size;

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

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final subjectS = Provider.of<SubjectServices>(context);
    final subject = subjectS.subjectSelected;
    final studentS = Provider.of<StudentServices>(context);
    final student = studentS.selectedStudent;
    return SizedBox(
      // color: Colors.red,
      width: 600,
      // width: size.width * 0.4,
      // height: size.height * 0.3,
      height: 200,
      child: Form(
        key: _keyForm,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Wrap(
                //  runSpacing: 10,
                spacing: 10,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Parcial 1',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 13),

                          decoration: InputDecorations.authDecoration(
                              prefixIcon: Icons.grade,
                              hintText: '',
                              labelText: 'Calificacion'),

                          // controller: parcial1Controller,
                          // initialValue: '0',
                          keyboardType: TextInputType.number,

                          validator: (value) {
                            if (value == null) {
                              return 'Agrega una calificacion';
                            } else {
                              final isNumeric = num.tryParse(value) != null;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Parcial 2',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 150,
                          child: TextFormField(
                            style: const TextStyle(fontSize: 13),
                            decoration: InputDecorations.authDecoration(
                                prefixIcon: Icons.grade,
                                hintText: '',
                                labelText: 'Calificacion'),

                            // controller: parcial2Controller,
                            // initialValue: '0.0',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              } else {
                                final isNumeric = num.tryParse(value) != null;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Parcial 3',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 150,
                          child: TextFormField(
                            style: const TextStyle(fontSize: 13),

                            decoration: InputDecorations.authDecoration(
                                prefixIcon: Icons.grade,
                                hintText: '',
                                labelText: 'Calificacion'),

                            // controller: parcial3Controller,
                            // initialValue: '0.0',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              } else {
                                final isNumeric = num.tryParse(value) != null;
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
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
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
                          generation: student.generation.id);

                      await studentServices.postRating(rating);

                      parcial1Controller.clear();
                      parcial2Controller.clear();
                      parcial3Controller.clear();

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.data_saver_off_sharp),
                  label: const Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text('Guardar Cal.'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
