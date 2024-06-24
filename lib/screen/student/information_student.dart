import 'dart:io';

import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/studentByAdviser.dart';
import 'package:provider/provider.dart';

import '../../models/function_url_launcher.dart';
import '../../models/student_adviser.dart';
import '../../widgets/utils/style_ElevatedButton.dart';

class DetailStudent extends StatelessWidget {
  const DetailStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentAdviserServices = Provider.of<StudentAdviserServices>(context);
    final student = studentAdviserServices.studentSelectedByAdbiser;

    return Scaffold(
      //  Platform.isWindows || Platform.isMacOS
      //  ?  appBar:  AppBar(
      //         backgroundColor: const Color(0XFF1d2027),
      //         // title: const Text('Datos del estudiante'),
      //       )
      //     : Container(),
      body: SafeArea(child: ContenAndroidIos(student: student)),
    );
  }
}

class ContenAndroidIos extends StatefulWidget {
  const ContenAndroidIos({
    Key? key,
    required this.student,
  }) : super(key: key);

  final StudentAdviser student;

  @override
  State<ContenAndroidIos> createState() => _ContenAndroidIosState();
}

class _ContenAndroidIosState extends State<ContenAndroidIos>
    with SingleTickerProviderStateMixin {
// para las animaciones del texto
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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

    return Container(
      width: size.width,
      // height: size.height * 0.75,
      // decoration: const BoxDecoration(
      // color: Colors.black12,
      // borderRadius: BorderRadius.horizontal(left: 8),
      // border: Border.all(color: Colors.black26, width: 0.5),
      // ),
      child: SingleChildScrollView(
        child: Column(

            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _image(size: size, student: widget.student),

              const SizedBox(
                height: 20,
              ),

              Text('Datos del estudiante', style: textStyle),
              const SizedBox(
                height: 10,
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.white24,
                  // color: Colors.white10
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
              Text('Datos del tutor', style: textStyle),
              const SizedBox(height: 20),

// de chat  pgt
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white10.withOpacity(0.1)),

                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.white24,
                    // color: Colors.black26
                    // color: Colors.transparent,
                  ),
                  width: size.width,
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
                                  'Numero de Telefono:  ${widget.student.studentTutor.numberPhoneTutor ?? 'Numero de telefono no agregado '}'),
                            ),
                            // Text(
                            //     'Numero de telefono: ${widget.student.studentTutor.numberPhoneTutor}'),
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
                        const SizedBox(height: 20),
                        const Text('Datos escolares'),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            width: size.width,
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
                                      Text(
                                          'Grupo:  ${widget.student.group.name}'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.school),
                                      const SizedBox(width: 8.0),
                                      const Text('Semestres: '),
                                      const SizedBox(width: 8.0),
                                      Container(
                                        // height: 100,
                                        width: size.width / 2,
                                        child: Wrap(
                                          children: List.generate(
                                            widget.student.semestre.length,
                                            (index) => Text(widget
                                                .student.semestre[index].name),
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
                                        child: ElevatedButton(
                                            style:
                                                StyleElevatedButton.styleButton,
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    // backgroundColor: Color(0xFF2E3440),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: SizedBox(
                                                      width: 350,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Text(
                                                              'Opciones',
                                                              style: TextStyle(
                                                                  // color: Colors.white,
                                                                  fontSize: 18,
                                                                  // fontFamily: ,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Wrap(
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child:
                                                                      const Text(
                                                                    'Calificacion',
                                                                    style:
                                                                        TextStyle(
                                                                      // color: Colors.white,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                // SizedBox(height: 10),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child:
                                                                      const Text(
                                                                    'Tareas',
                                                                    style:
                                                                        TextStyle(
                                                                      // color: Colors.white,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child:
                                                                      const Text(
                                                                    'No se que mas',
                                                                    style:
                                                                        TextStyle(
                                                                      // color: Colors.white,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                            const Divider(),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                ElevatedButton(
                                                                  style: StyleElevatedButton
                                                                      .styleButton,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'Cerrar'),
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
                                            child: Text(widget
                                                .student.subjects[index].name)),
                                      ))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ]),
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
        color: Color.fromARGB(19, 2, 0, 3),
      ),

      width: size.width,
      height: 300,
      // width: 300,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            CircleAvatar(
              // backgroundImage: ,
              radius: 60.0,
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
              // '${student.name + "  " + student.lastName}',

              "${student.name}  ${student.lastName}  ${student.secondName}",
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
