import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Services/rating_services.dart';
import '../models/student_byGrades.dart';

class GenerateFiles {
  List<StudentByGrades>? ratings;

  // crate files type pdr by list student by  grades
  /// generar archivo para estudiantes de mejores calificaciones
  /// generate file for students with better grades

  Future<File> generateFileForTopStudents(
      RatingServices ratingServices, String typeConsulGrade) async {
    final pdf = pw.Document();

    ratings = ratingServices.studentByRating;

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                  child: pw.Column(
                children: [
                  pw.Text('Escuela Preparatoria'),
                  pw.Text('Rafael Pascacio Gamboa'),
                  pw.Text('Nivel Medio Superior'),
                ],
              )),
              pw.SizedBox(
                height: 100,
              ),
              // pw.Row(
              //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              //     children: [
              //       // pw.Text('Edadad'),
              //       pw.Text(
              //           'Generacion : ${ratingServices.studentByRating.first.generation.getInitialDateAndFinalGeneration}'),
              //       pw.Text(
              //           'Semestre : ${ratingServices.studentByRating.first.semestre.name}'),
              //       pw.Text(
              //           'Grupo : ${ratingServices.studentByRating.first.group.name}'),
              //       // pw.Text('Grupo : ${ratingServices.studentByRating.last}'),
              //     ]),
              pw.SizedBox(
                height: 100,
              ),
              pw.Text(
                  'Lista de las mejores calificaciones del $typeConsulGrade'),
              pw.SizedBox(
                height: 20,
              ),
              pw.TableHelper.fromTextArray(
                  context: context, data: generarMatriz())
            ],
          );
        }));

    // final output = await getTemporaryDirectory();
    final output = await getApplicationDocumentsDirectory();

    final file = File("${output.path}/example.pdf");

    File fileGenerate = await file.writeAsBytes(await pdf.save());

    // print('File directory');
    // print(output);
    // print('file path ');
    // print(file.path);

    print('pdf generado');
    return fileGenerate;
  }

  List<List<String>> generarMatriz() {
    List<List<String>> matriz = [];
    matriz.insert(0, [
      'Indice',
      'Nombre ',
      'Parcial 1',
      'Parcial 2',
      'ParciaL 3',
      'Calificacion Final'
    ]);

    for (int i = 0; i < ratings!.length; i++) {
      matriz.add([
        i.toString(),
        ratings![i].student.name,
        ratings![i].parcial1.toString(),
        ratings![i].parcial2.toString(),
        ratings![i].parcial3.toString(),
        ratings![i].semesterGrade.toString().substring(0, 3)
      ]);
    }
    // Devolver la matriz
    return matriz;
  }
}
