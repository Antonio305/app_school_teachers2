import 'dart:io';

import 'package:flutter/material.dart';

import '../models/student.dart';
import '../models/student_adviser.dart';

import 'package:provider/provider.dart';

// es para un solo etudiante
// para mostar el datos de los estudianes

class ContentDataStudent extends StatelessWidget {
  const ContentDataStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StudentAdviser student =
        ModalRoute.of(context)!.settings.arguments as StudentAdviser;
//  final studentServices  = Provider.of(context);

    final size = MediaQuery.of(context).size;
    return Scaffold(

      //  Platform.isWindows || Platform.isMacOS
      //  ?  appBar:  AppBar(
      //         backgroundColor: const Color(0XFF1d2027),
      //         // title: const Text('Datos del estudiante'),
      //       )
      //     : Container(),
      body: SafeArea(
          child: Platform.isWindows || Platform.isMacOS
              ? ContentWindowsMac(size: size, student: student)
              : ContenAndroidIos(size: size, student: student)),
    );
  }
}

class ContenAndroidIos extends StatefulWidget {
  const ContenAndroidIos({
    Key? key,
    required this.size,
    required this.student,
  }) : super(key: key);

  final Size size;
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
    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      letterSpacing: 2,
      shadows: [
        Shadow(
          color: Colors.grey.withOpacity(0.5),
          offset: Offset(1, 1),
          blurRadius: 1,
        ),
      ],
    );
    return Container(
      width: widget.size.width,
      // height: size.height * 0.75,
      decoration: const BoxDecoration(
          // color: Colors.black12,
          // borderRadius: BorderRadius.horizontal(left: 8),
          // border: Border.all(color: Colors.black26, width: 0.5),
          ),
      child: SingleChildScrollView(
        child: Column(

            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
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
                        Text('Telefono: ${widget.student.numberPhone}'),
                        Text('Matricula ${widget.student.tuition}'),
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
                                'Nombre: ${widget.student.studentTutor.nameTutor + "  " + widget.student.studentTutor.lastNameTutor + "  " + widget.student.studentTutor.secondNameTutor}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 22.0),
                            const SizedBox(width: 8.0),
                            Text(
                                'Numero de telefono: ${widget.student.studentTutor.numberPhoneTutor}'),
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
              const Text('Datos escolares'),
              const SizedBox(height: 50),

              Container(
                width: widget.size.width,
                height: 100,
                color: Colors.blue,
              ),

              // const Spacer(),
              // MaterialButton(
              //     color: Colors.blue,
              //     child: const Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              //       child: Text('Editar'),
              //     ),
              //     onPressed: () {})
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

              '${student.name + "  " + student.lastName + "  " + student.secondName}',
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

class ContentWindowsMac extends StatelessWidget {
  const ContentWindowsMac({
    Key? key,
    required this.size,
    required this.student,
  }) : super(key: key);

  final Size size;
  final StudentAdviser student;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.6,
      height: size.height * 0.75,
      decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black26, width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.black,
                  child: Container(),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.black,
                    // color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center ,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40)),
                              // border: Border.all(color: Colors.black26, width: 0.5),
                              color: Color(0xFF1D2027),
                            ),

                            width: size.width,
                            height: 300,
                            // width: 300,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  // backgroundImage: ,
                                  radius: 90.0,
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
                                  //   '

                                  // ${student.name + "  " + student.lastName}

                                  //   ',

                                  '${student.name + "  " + student.lastName + "  " + student.secondName}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Text('eldioseltreno@gmail.com',
                                    style: TextStyle(color: Colors.white60)),
                              ],
                            ),
                          ),
                          // Text(
                          //     'Nombre : ${student.name + student.lastName + student.secondName}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sexo :${student.gender}'),
                              Text('Fecha Nacimiento: ${student.dateOfBirth}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('tipo de Sangre : ${student.bloodGrade}'),
                              Text('Crup: ${student.curp}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Edad : ${student.age}'),
                              Text('direccion: ${student.town}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Telefono: ${student.numberPhone}'),
                              Text('Matricula ${student.tuition}'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text('Datos del tutor'),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Nombre: ${student.studentTutor.nameTutor + student.studentTutor.lastNameTutor + student.studentTutor.secondNameTutor}'),
                              Text(
                                  'Numero de telefono: ${student.studentTutor.numberPhoneTutor}'),
                              Text(
                                  'Parentesco : ${student.studentTutor.kinship}'),
                            ],
                          )
                        ]),
                  ),
                ),
              ), //

              const SizedBox(height: 50),
            ]),
      ),
    );
  }
}
