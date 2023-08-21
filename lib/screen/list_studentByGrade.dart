import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/rating_services.dart';
import 'package:preppa_profesores/models/rating.dart';
import 'package:preppa_profesores/models/student_byGrades.dart';
import 'package:provider/provider.dart';

// import 'package:pdf/pdf.dart';

class ScreenListStudentByGrades extends StatefulWidget {
  const ScreenListStudentByGrades({super.key});

  @override
  State<ScreenListStudentByGrades> createState() =>
      _ScreenListStudentByGradesState(); 
}

class _ScreenListStudentByGradesState extends State<ScreenListStudentByGrades> {
  // create lsit tpe Ratings
  List<StudentByGrades> ratings = [];

  @override
  Widget build(BuildContext context) {
    // instance class
    final ratingServices = Provider.of<RatingServices>(context);
    ratings = ratingServices.studentByRating;

    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          // final pdf = pw.Document();

          // pdf.addPage(pw.Page(
          //     pageFormat: PdfPageFormat.a4,
          //     build: (pw.Context context) {M
          //       return pw.Center(
          //         child: pw.Text("Hola mundo!"),
          //       );
          //     }));

          // final output = await getTemporaryDirectory();
          // final file = File("${output.path}/example.pdf");
          // await file.writeAsBytes(await pdf.save());

          // Aquí puedes abrir el archivo PDF utilizando un paquete como `open_file`
        },
        child: Text("Descargar PDF"),
      ),

      appBar: AppBar(
        title: const Text('Estudaiens por calificacio'),
      ),
      // floatingActionButton:
      body: ratingServices.status == true
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ratings.isEmpty
                  ? const Text('No hay alumnos')
                  : ListView.builder(
                      itemCount: ratings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {},
                          style: ListTileStyle.drawer,
                          leading: CircleAvatar(
                            child: Text(
                                ratings[index].student.name.substring(0, 2)),
                          ),

                          /// boton de la iaquierda
                          title: Text(
                              "${ratings[index].student.name}  ${ratings[index].student.lastName}  ${ratings[index].student.secondName}"),
                          subtitle: Text('AUN  NO SE QUE PONER'),
                          trailing: const Icon(Icons.chevron_right_rounded),

                          /// boton de la derecha
                        );
                      },
                    ),
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:preppa_profesores/models/rating.dart';
// import 'package:provider/provider.dart';

// // property dart
// import 'dart:io';

// import '../Services/studentByAdviser.dart';
// import '../models/student_adviser.dart';

// class ScreenListStudentByGrades extends StatefulWidget {
//   const ScreenListStudentByGrades({Key? key}) : super(key: key);

//   @override
//   State<ScreenListStudentByGrades> createState() => _ContentState();
// }

// class _ContentState extends State<ScreenListStudentByGrades> {
// //  StudentTutor  student = StudentTutor(nameTutor: , lastNameTutor: lastNameTutor, secondNameTutor: secondNameTutor, kinship: kinship, numberPhoneTutor: numberPhoneTutor)

// // intance class student,
// // not inialize let
//   StudentAdviser student = StudentAdviser(
//       studentTutor: StudentTutor(
//           nameTutor: '',
//           lastNameTutor: '',
//           secondNameTutor: '',
//           kinship: '',
//           numberPhoneTutor: 00000),
//       name: '',
//       lastName: '',
//       secondName: '',
//       gender: '',
//       dateOfBirth: DateTime.now(),
//       bloodGrade: '',
//       curp: '',
//       age: 0,
//       town: '',
//       numberPhone: 00000000,
//       status: false,
//       rol: '',
//       group: Group(id: '', name: ''),
//       semestre: [],
//       subjects: [],
//       generation: Generation(
//           id: '', initialDate: DateTime.now(), finalDate: DateTime.now()),
//       uid: '',
//       tuition: '');

//       List<Ratings> grades= [];

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     final studentServies = Provider.of<StudentAdviserServices>(context);
//     late List<StudentAdviser> students = studentServies.studentAdviser;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lista de estudiantes'),
//       ),
//       body: Padding(
//         padding: Platform.isWindows || Platform.isMacOS
//             ? const EdgeInsets.symmetric(horizontal: 50)
//             : const EdgeInsets.all(8.0),
//         child: studentServies.status == true
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // const SizedBox(
//                   //   height: 20,
//                   // ),
//                   Platform.isWindows || Platform.isMacOS
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             ScreenListStudentByGrades(size, students),

//                             // segunda parte
//                             // ContentDataStudent(size, student),
//                             Container(
//                               width: Platform.isWindows || Platform.isMacOS
//                                   ? size.width * 0.6
//                                   : size.width * 0.9,
//                               height: size.height * 0.75,
//                               decoration: BoxDecoration(
//                                 // color: Colors.white,
//                                 color: Color.fromARGB(255, 16, 8, 51),
//                                 // border: Border.all(
//                                 //     // color: Colors.black26,  width: 0.5),
//                                 //     color: Colors.red,
//                                 // ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text('Calificacion'),
//                                     const SizedBox(height: 50),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: const [
//                                         Text('PRIMER PARCIAL'),
//                                         Text('PRIMER PARCIAL'),
//                                         Text('PRIMER PARCIAL')
//                                       ],
//                                     ),
//                                     const SizedBox(height: 50),
//                                     Text('CALIFICACION SEMESTRAL'),
//                                     const SizedBox(height: 200),
//                                     ElevatedButton(
//                                         onPressed: () {},
//                                         child:
//                                             const Text('EDITAR CALIFICACION'))
//                                   ]),
//                             ),

//                             // ContentWindowsMac(size: size, student: student)
//                           ],
//                         )
//                       : ScreenListStudentByGrades(size, students),
//                 ],
//               ),
//       ),
//     );
//   }

//   Container ScreenListStudentByGrades(Size size, List<StudentAdviser> students) {
//     return Container(
//       width: Platform.isWindows || Platform.isMacOS
//           ? size.width * 0.3
//           : size.width * 0.9,
//       height: size.height * 0.75,
//       decoration: BoxDecoration(
//         // color: Colors.white,
//         // color: Colors.blue,
//         border: Border.all(color: Colors.black26, width: 0.5),

//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: students.isEmpty
//           ?
//           // const LinearProgressIndicator()
//           const Center(
//               child: Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Text('ERES TUTOR PERO NO HAY ALUMHOS AGREGADOS'),
//             ))
//           : ListView.builder(
//               controller: ScrollController(initialScrollOffset: 0),
//               // scrollDirection: Axis.vertical,
//               itemCount: students.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                       child: Text(students[index].name.substring(0, 2))),
//                   title: Text(
//                       "${students[index].name} ${students[index].lastName} ${students[index].secondName}",
//                       style: const TextStyle(fontSize: 13)),
//                   subtitle: Text(
//                       "NUMERO DE CONTROL: ${students[index].tuition}",
//                       style: const TextStyle(fontSize: 11)),
//                   onTap: () {
//                     if (Platform.isWindows || Platform.isMacOS) {
//                       student = students[index];
//                       setState(() {});
//                     } else if (Platform.isAndroid || Platform.isIOS) {
//                       Navigator.pushNamed(context, 'content_data_student',
//                           arguments: students[index]);
//                     }
//                   },
//                 );
//               },
//             ),
//     );
//   }

//   Container ContentDataStudent(Size size, StudentAdviser student) {
//     return Container(
//       width: size.width * 0.6,
//       height: size.height * 0.75,
//       decoration: BoxDecoration(
//           // color: Colors.black12,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.black26, width: 0.5)),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(

//             // mainAxisAlignment: MainAxisAlignment.center,
//             // crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: 90.0,
//                   backgroundColor: Colors.black,
//                   child: Container(),
//                 ),
//               ),

//               const SizedBox(
//                 height: 20,
//               ),

//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     // color: Colors.black,
//                     // color: Colors.transparent,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         // mainAxisAlignment: MainAxisAlignment.center ,
//                         children: [
//                           Text(
//                               'Nombre : ${student.name + student.lastName + student.secondName}'),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Sexo :${student.gender}'),
//                               Text('Fecha Nacimiento: ${student.dateOfBirth}'),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('tipo de Sangre : ${student.bloodGrade}'),
//                               Text('Crup: ${student.curp}'),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Edad : ${student.age}'),
//                               Text('direccion: ${student.town}'),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Telefono: ${student.numberPhone}'),
//                               Text('Matricula ${student.tuition}'),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           Text('Datos del tutor'),
//                           const SizedBox(height: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                   'Nombre: ${student.studentTutor.nameTutor + " " + student.studentTutor.lastNameTutor + " " + student.studentTutor.secondNameTutor}'),
//                               Text(
//                                   'Numero de telefono: ${student.studentTutor.numberPhoneTutor}'),
//                               Text(
//                                   'Parentesco : ${student.studentTutor.kinship}'),
//                             ],
//                           )
//                         ]),
//                   ),
//                 ),
//               ), //

//               // DATOS ESCOLATRES
//               ElevatedButton(
//                   onPressed: () {}, child: const Text('DATOS ESCOLARES')),

//               const SizedBox(height: 50),

//               // const Spacer(),
//               MaterialButton(
//                   color: Colors.blue,
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//                     child: Text('Editar'),
//                   ),
//                   onPressed: () {})
//             ]),
//       ),
//     );
//   }
// }

// class ContentWindowsMac extends StatefulWidget {
//   const ContentWindowsMac({
//     Key? key,
//     required this.size,
//     required this.student,
//   }) : super(key: key);

//   final Size size;
//   final StudentAdviser student;

//   @override
//   State<ContentWindowsMac> createState() => _ContentWindowsMacState();
// }

// class _ContentWindowsMacState extends State<ContentWindowsMac> {
//   @override
//   Widget build(BuildContext context) {
//     var textStyle = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//       letterSpacing: 2,
//       shadows: [
//         Shadow(
//           color: Colors.grey.withOpacity(0.5),
//           offset: Offset(1, 1),
//           blurRadius: 1,
//         ),
//       ],
//     );
//     return SizedBox(
//       width: widget.size.width * 0.6,
//       height: widget.size.height * 0.9,
//       child: SingleChildScrollView(
//         child: Column(children: [
//           _image(size: widget.size, student: widget.student),
//           const SizedBox(
//             height: 20,
//           ),
//           Text('Datos del estudiante', style: textStyle),
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black26),
//               borderRadius: BorderRadius.circular(10),
//               // color: Colors.white24,
//               // color: Colors.black26
//               // color: Colors.transparent,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Wrap(
//                   crossAxisAlignment: WrapCrossAlignment.start,
//                   runSpacing: 10,
//                   spacing: 40,
//                   children: [
//                     // Text(
//                     //     'Nombre : ${student.name + "  " + student.lastName + "  " + student.secondName}'),
//                     Text('Sexo :${widget.student.gender}'),
//                     Text('Fecha Nacimiento: ${widget.student.dateOfBirth}'),
//                     Text('tipo de Sangre : ${widget.student.bloodGrade}'),
//                     Text('Crup: ${widget.student.curp}'),
//                     Text('Edad : ${widget.student.age}'),
//                     Text('direccion: ${widget.student.town}'),
//                     Text('Telefono: ${widget.student.numberPhone}'),
//                     Text('Matricula ${widget.student.tuition}'),
//                   ]),
//             ),
//           ), //
//           const SizedBox(height: 20),
//           Text('Datos del tutor', style: textStyle),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.all(3.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black26),
//                 borderRadius: BorderRadius.circular(10),
//                 // color: Colors.white24,
//                 // color: Colors.black26
//                 // color: Colors.transparent,
//               ),
//               width: widget.size.width,
//               // color: Colors.blue,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Wrap(
//                   crossAxisAlignment: WrapCrossAlignment.start,
//                   runSpacing: 10,
//                   spacing: 40,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.account_circle, size: 22.0),
//                         const SizedBox(width: 8.0),
//                         Text(
//                             'Nombre: ${"${widget.student.studentTutor.nameTutor}  ${widget.student.studentTutor.lastNameTutor}  ${widget.student.studentTutor.secondNameTutor}"}'),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.phone, size: 22.0),
//                         const SizedBox(width: 8.0),
//                         Text(
//                             'Numero de telefono: ${widget.student.studentTutor.numberPhoneTutor}'),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.family_restroom, size: 22.0),
//                         const SizedBox(width: 8.0),
//                         Text(
//                             'Parentesco : ${widget.student.studentTutor.kinship}'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 50),

//           // DataStudentSchool(student: widget.student),
//           ElevatedButton(
//               onPressed: () {}, child: const Text('DATOS ESCOLARES')),
//           const SizedBox(height: 50),
//         ]),
//       ),
//     );
//   }
// }

// class DataStudentSchool extends StatelessWidget {
//   // receibe how paramer class student
//   final StudentAdviser student;

//   const DataStudentSchool({Key? key, required this.student}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color:const Color(0xff242529),
//       width: double.infinity,
//       // height: 300,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: const Color(0xff242529),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Wrap(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 10),
//               _text(text: 'Semestre'),
//               _text(text: 'Grupo'),
//               _text(text: 'Siclo escolar ${student.generation}'),
//             ]),
//       ),
//     );
//   }
// }

// class _text extends StatelessWidget {
//   final String text;

//   const _text({Key? key, required this.text}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 16,
//         color: Colors.white54,
//         // color: Colors.white12
//       ),
//     );
//   }
// }

// class _image extends StatelessWidget {
//   const _image({
//     Key? key,
//     required this.size,
//     required this.student,
//   }) : super(key: key);

//   final Size size;
//   final StudentAdviser student;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
//         // border: Border.all(color: Colors.black26, width: 0.5),
//         color: Color(0xFF1D2027),
//       ),

//       width: size.width,
//       height: 300,
//       // width: 300,
//       child: Column(
//         children: [
//           CircleAvatar(
//             // backgroundImage: ,
//             radius: 90.0,
//             backgroundColor: Colors.blueAccent,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(90),
//               child: Image.network(
//                 'https://img.apmcdn.org/2e2ceb4fdbd8ac017b85b242fe098cb3b466cf5a/square/44315c-20161208-katherine-johnson.jpg',
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),

//           // name student
//           Text(
//             '${student.name + "  " + student.lastName}',

//             // '${student.name + "  " + student.lastName + "  " + student.secondName}',
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//           ),
//           const Text('eldioseltreno@gmail.com',
//               style: TextStyle(color: Colors.white60)),
//         ],
//       ),
//     );
//   }
// }
