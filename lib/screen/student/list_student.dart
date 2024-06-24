import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/studentByAdviser.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/widgets/utils/style_ElevatedButton.dart';
import 'package:provider/provider.dart';

// property dart
import 'dart:io';

import '../../Services/adviseAndTutorServices.dart';
import '../../models/function_url_launcher.dart';
import '../../models/student_adviser.dart';

class ScreenListStudent extends StatefulWidget {
  const ScreenListStudent({Key? key}) : super(key: key);

  @override
  State<ScreenListStudent> createState() => _ContentState();
}

class _ContentState extends State<ScreenListStudent> {
//  StudentTutor  student = StudentTutor(nameTutor: , lastNameTutor: lastNameTutor, secondNameTutor: secondNameTutor, kinship: kinship, numberPhoneTutor: numberPhoneTutor)

// intance class student,
// not inialize let
  StudentAdviser student = StudentAdviser(
      studentTutor: StudentTutor(
          nameTutor: '',
          lastNameTutor: '',
          secondNameTutor: '',
          kinship: '',
          numberPhoneTutor: 00000),
      name: '',
      lastName: '',
      secondName: '',
      gender: '',
      dateOfBirth: DateTime.now(),
      bloodGrade: '',
      curp: '',
      age: 0,
      town: '',
      numberPhone: 00000000,
      status: false,
      rol: '',
      group: Group(id: '', name: ''),
      semestre: [],
      subjects: [],
      generation: Generation(
          id: '', initialDate: DateTime.now(), finalDate: DateTime.now()),
      uid: '',
      tuition: '');

// CREAR UN LSITA VACIA DE TUPO STUDENTADVISER
  late List<StudentAdviser> students = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final studentServies = Provider.of<StudentAdviserServices>(context);

    final studentServies = Provider.of<AdviserTutorServices>(context);

    students = studentServies.studentAdviser;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Estudiantes'),
          centerTitle: true,
        ),
        body: studentServies.status == true
            ? const Center(child: CircularProgressIndicator())
            : IsMobile.isMobile()
                ? ScreenListStudent(size, students)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ScreenListStudent(size, students),

                      // segunda parte
                      // ContentDataStudent(size, student),
                      Desktop(size: size, student: student)
                    ],
                  ));
  }

  Container ScreenListStudent(Size size, List<StudentAdviser> students) {
    return Container(
      width: IsMobile.isMobile() ? size.width : size.width * 0.3,
      height: IsMobile.isMobile() ? size.height : size.height * 0.9,
      decoration: BoxDecoration(
        // color: Colors.white,
        // color: Colors.blue,
        border: Border.all(color: Colors.black26, width: 0.5),

        borderRadius: BorderRadius.circular(10),
      ),
      child: students.isEmpty
          ?
          // const LinearProgressIndicator()
          const Center(
              child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('ERES TUTOR PERO NO HAY ALUMHOS AGREGADOS'),
            ))
          : Padding(
              padding: IsMobile.isMobile()
                  ? const EdgeInsets.symmetric(horizontal: 8)
                  : const EdgeInsets.only(left: 10),
              child: Expanded(
                child: ListView.builder(
                  controller: ScrollController(initialScrollOffset: 0),
                  // scrollDirection: Axis.vertical,
                  itemCount: students.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                          child: Text(students[index].name.substring(0, 2))),
                      title: Text(
                          "${students[index].name} ${students[index].lastName} ${students[index].secondName}",
                          style: const TextStyle(fontSize: 13)),
                      subtitle: Text(
                          "NUMERO DE CONTROL: ${students[index].tuition}",
                          style: const TextStyle(fontSize: 11)),
                      onTap: () {
                        if (IsMobile.isMobile()) {
                          final studentAdviserServices =
                              Provider.of<StudentAdviserServices>(context,
                                  listen: false);
                          studentAdviserServices.studentSelectedByAdbiser =
                              students[index];

                          Navigator.pushNamed(context, 'detail_student');
                        } else {
                          student = students[index];
                          setState(() {});
                        }
                      },
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class Desktop extends StatefulWidget {
  const Desktop({
    Key? key,
    required this.size,
    required this.student,
  }) : super(key: key);

  final Size size;
  final StudentAdviser student;

  @override
  State<Desktop> createState() => _ContentWindowsMacState();
}

class _ContentWindowsMacState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      letterSpacing: 2,
      shadows: [
        Shadow(
          color: Colors.grey.withOpacity(0.5),
          offset: const Offset(1, 1),
          blurRadius: 1,
        ),
      ],
    );
    return SizedBox(
      width: widget.size.width * 0.7,
      height: widget.size.height * 0.9,
      child: SingleChildScrollView(
        child: Flexible(
          child: Padding(
            padding: IsMobile.isMobile()
                ? const EdgeInsets.symmetric(horizontal: 8)
                : const EdgeInsets.symmetric(horizontal: 50),
            child: Column(children: [
              _image(size: widget.size, student: widget.student),
              const SizedBox(
                height: 20,
              ),
              Text('Datos del estudiante', style: textStyle),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.white24,
                  // color: Colors.black26
                  // color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 10,
                      spacing: 40,
                      children: [
                        // Text(
                        //     'Nombre : ${student.name + "  " + student.lastName + "  " + student.secondName}'),
                        Text('Sexo :${widget.student.gender}'),
                        Text('Fecha Nacimiento: ${widget.student.dateOfBirth}'),
                        Text('tipo de Sangre : ${widget.student.bloodGrade}'),
                        Text('Crup: ${widget.student.curp}'),
                        Text('Edad : ${widget.student.age}'),
                        Text('direccion: ${widget.student.town}'),
                        Text('Matricula ${widget.student.tuition}'),
                        TextButton(
                          onPressed: () {
                            if (widget.student.numberPhone == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: const Icon(Icons.call_end),
                                    content: const Text(
                                        'Numero de telefono no asignado'),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('ACEPTAR'))
                                    ],
                                  );
                                },
                              );

                              return;
                            }
                            MyUrlLaucher.makePhoneCall(
                                widget.student.numberPhone.toString());
                          },
                          child: Text(
                              'Numero de Telefono:  ${widget.student.numberPhone ?? 'Numero de telefono no agregado '}'),
                        ),
                        Row(
                          children: [
                            SelectableText(
                                'Correo Electronido:  ${widget.student.email ?? 'Correo electronico no agregado '}'),
                            TextButton(
                                onPressed: () {
                                  if (widget.student.email == null) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          icon: const Icon(Icons.email),
                                          content: const Text(
                                              'CORREO ELECTRONICO NO ASIGNADO'),
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('ACEPTAR'))
                                          ],
                                        );
                                      },
                                    );

                                    return;
                                  }
                                  MyUrlLaucher.returnLauncherEmail(
                                      widget.student.email!);
                                },
                                child: const Row(
                                  children: [
                                    Text('ENVIAR CORREO'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.email_outlined)
                                  ],
                                ))
                          ],
                        ),
                      ]),
                ),
              ), //

              const SizedBox(height: 20),
              // Text('Datos del tutor',style : textStyle),
              Text(
                'Datos escolares',
                style: textStyle,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  // color: Colors.blue,
                  width: widget.size.width,
                  // height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.group),
                            const SizedBox(width: 8.0),
                            Text('Grupo:  ${widget.student.group.name}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.school),
                            const SizedBox(width: 8.0),
                            const Text('Semestres: '),
                            const SizedBox(width: 8.0),
                            Container(
                              // height: 100,
                              width: widget.size.width / 2,
                              child: Wrap(
                                children: List.generate(
                                  widget.student.semestre.length,
                                  (index) =>
                                      Text(widget.student.semestre[index].name),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.date_range),
                            const SizedBox(width: 8.0),
                            Text(
                                'Generacion:  ${widget.student.generation.initialDate.toString().substring(0, 10)} - ${widget.student.generation.finalDate.toString().substring(0, 10)}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Materias', style: textStyle),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Wrap(
                    children: List.generate(
                        widget.student.subjects.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        // backgroundColor: Color(0xFF2E3440),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: SizedBox(
                                          width: 350,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Opciones',
                                                  style: TextStyle(
                                                      // color: Colors.white,
                                                      fontSize: 18,
                                                      // fontFamily: ,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const SizedBox(height: 10),
                                                Wrap(
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                        'Calificacion',
                                                        style: TextStyle(
                                                          // color: Colors.white,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    // SizedBox(height: 10),
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                        'Tareas',
                                                        style: TextStyle(
                                                          // color: Colors.white,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                        'No se que mas',
                                                        style: TextStyle(
                                                          // color: Colors.white,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                const Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      style: StyleElevatedButton
                                                          .styleButton,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cerrar'),
                                                    ),
                                                    // ElevatedButton(
                                                    //   style: StyleElevatedButton
                                                    //       .styleButton,
                                                    //   onPressed: () {
                                                    //     // No hacemos nada.
                                                    //   },
                                                    //   child: Text('Cancelar'),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child:
                                    Text(widget.student.subjects[index].name),
                              ),
                            ))),
              ),
              const SizedBox(height: 20),
              Text('Datos del tutor', style: textStyle),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.white24,
                    // color: Colors.black26
                    // color: Colors.transparent,
                  ),
                  width: widget.size.width,
                  // color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 10,
                      spacing: 40,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.account_circle, size: 22.0),
                            const SizedBox(width: 8.0),
                            Text(
                                'Nombre: ${"${widget.student.studentTutor.nameTutor}  ${widget.student.studentTutor.lastNameTutor}  ${widget.student.studentTutor.secondNameTutor}"}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 22.0),
                            const SizedBox(width: 8.0),
                            // Text(
                            //     'Numero de telefono: ${widget.student.studentTutor.numberPhoneTutor}'),
                            TextButton(
                              onPressed: () {
                                if (widget.student.studentTutor
                                        .numberPhoneTutor ==
                                    null) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        icon: const Icon(Icons.call_end),
                                        content: const Text(
                                            'Numero de telefono no asignado'),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('ACEPTAR'))
                                        ],
                                      );
                                    },
                                  );

                                  return;
                                }
                                MyUrlLaucher.makePhoneCall(widget
                                    .student.studentTutor.numberPhoneTutor
                                    .toString());
                              },
                              child: Text(
                                  'Numero de Telefono:  ${widget.student.numberPhone ?? 'Numero de telefono no agregado '}'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.family_restroom, size: 22.0),
                            const SizedBox(width: 8.0),
                            Text(
                                'Parentesco : ${widget.student.studentTutor.kinship}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // DataStudentSchool(student: widget.student),
              ElevatedButton(
                  onPressed: () {}, child: const Text('DATOS ESCOLARES')),
              const SizedBox(height: 50),
            ]),
          ),
        ),
      ),
    );
  }
}

class DataStudentSchool extends StatelessWidget {
  // receibe how paramer class student
  final StudentAdviser student;

  const DataStudentSchool({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color:const Color(0xff242529),
      width: double.infinity,
      // height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xff242529),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const _text(text: 'Semestre'),
              const _text(text: 'Grupo'),
              _text(text: 'Siclo escolar ${student.generation}'),
            ]),
      ),
    );
  }
}

class _text extends StatelessWidget {
  final String text;

  const _text({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white54,
        // color: Colors.white12
      ),
    );
  }
}

class _image extends StatelessWidget {
  const _image({
    Key? key,
    required this.size,
    required this.student,
  }) : super(key: key);

  final Size size;
  final StudentAdviser student;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        // border: Border.all(color: Colors.black26, width: 0.5),
        color: Color(0xFF1D2027),
      ),

      width: size.width,
      height: 300,
      // width: 300,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              // backgroundImage: ,
              radius: 80.0,
              backgroundColor: Colors.blueAccent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.network(
                  'https://img.apmcdn.org/2e2ceb4fdbd8ac017b85b242fe098cb3b466cf5a/square/44315c-20161208-katherine-johnson.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // name student
            Text(
              "${student.name}  ${student.lastName}",

              // '${student.name + "  " + student.lastName + "  " + student.secondName}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Text('eldioseltreno@gmail.com',
                style: TextStyle(color: Colors.white60)),
          ],
        ),
      ),
    );
  }
}
