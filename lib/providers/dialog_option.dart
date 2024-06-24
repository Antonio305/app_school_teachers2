import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/generation_services.dart';
import 'package:preppa_profesores/Services/rating_services.dart';
import 'package:preppa_profesores/widgets/utils/style_ElevatedButton.dart';
import 'package:provider/provider.dart';

import '../Services/group_services.dart';
import '../Services/subject_services.dart';
import 'dart:ui' as ui;

class ListDialogByStudent extends ChangeNotifier {
  static Future selectedParcial(
      BuildContext context, Size size, int option) async {
    int selectedValue = 0; // Variable para almacenar el valor seleccionado

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // Construimos el diálogo
        return AlertDialog(
            icon: const Icon(Icons.photo_size_select_large_rounded),
            title: const Text('Seleccione el parcial'),
            content: Wrap(
              runAlignment: WrapAlignment.center,
              runSpacing: 5,
              spacing: 5,
              children: <Widget>[
                TextButton(
                  style: StyleElevatedButton.styleButton,
                  child: const Text('Primer Parcial'),
                  onPressed: () {
                    // Asignamos el valor seleccionado
                    selectedValue = 1;
                    Navigator.of(context)
                        .pop(); // Cerramos el diálogo y retornamos el valor
                    showSubject(context, selectedValue, option);
                  },
                ),
                TextButton(
                  style: StyleElevatedButton.styleButton,
                  onPressed: () {
                    // Asignamos el valor seleccionado
                    selectedValue = 2;
                    Navigator.of(context)
                        .pop(); // Cerramos el diálogo y retornamos el valor
                    showSubject(context, selectedValue, option);
                  },
                  child: const Text('Segundo parcial'),
                ),
                TextButton(
                  style: StyleElevatedButton.styleButton,
                  child: const Text('Tercer Parcial'),
                  onPressed: () {
                    // Asignamos el valor seleccionado
                    selectedValue = 3;
                    Navigator.of(context)
                        .pop(); // Cerramos el diálogo y retornamos el valor
                    showSubject(context, selectedValue, option);
                  },
                ),
                TextButton(
                  style: StyleElevatedButton.styleButton,
                  child: const Text('Semestral'),
                  onPressed: () {
                    // Asignamos el valor seleccionado
                    selectedValue = 4;
                    Navigator.of(context)
                        .pop(); // Cerramos el diálogo y retornamos el valor
                    showSubject(context, selectedValue, option);
                  },
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                style: StyleElevatedButton.styleButton,
                child: const Text('Salir'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // TextButton(
              //   child: const Text('Aceptar'),
              //   onPressed: () {
              //     // Validar la selección antes de cerrar el diálogo y devolver el valor
              //     // if (selectedValue.isNotEmpty) {
              //     //   Navigator.of(context).pop(selectedValue);
              //     // } else {
              //     // Mostrar un mensaje de error si no se ha seleccionado ningún valor
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(
              //         content: Text('Seleccione un valor'),
              //         duration: Duration(seconds: 2),
              //       ),
              //     );
              //     // }
              //   },
              // ),
            ]);
      },
    );
  }
}

// para hacer la seleccion de la materais

// for selected materiau qualifield
// Create a simple alert
void showSubject(BuildContext context, int partial, int option) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final subjectServices = Provider.of<SubjectServices>(context);
      final subjects = subjectServices.subjects;
      final size = MediaQuery.of(context).size;
      return AlertDialog(
        icon: const Icon(Icons.subject_sharp),
        title: const Text('Materias'),
        content: Wrap(
            runAlignment: WrapAlignment.center,
            runSpacing: 5,
            spacing: 5,
            children: List.generate(
              subjects.length,
              (index) => TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  showGroup(context, subjects[index].uid!, partial, option);
                },
                child: Text(subjects[index].name),
              ),
            )),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            child: const Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

//  para la selecion de grupo

void showGroup(
    BuildContext context, String idSubject, int partial, int option) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final groupServider = Provider.of<GroupServices>(context, listen: false);
      final generationServices =
          Provider.of<GenerationServices>(context, listen: false);
      final generations = generationServices.generations;

      final groups = groupServider.group;
      final size = MediaQuery.of(context).size;
      return AlertDialog(
        title: const Text('Grupos'),
        content: Wrap(
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 5,
          spacing: 5,
          children: List.generate(groups.groups.length, (index) {
            return ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final ratingServices =
                    Provider.of<RatingServices>(context, listen: false);

                switch (option) {
                  case 1:
                    print('PARTIAL ONE');
                    ratingServices.getStudentByBetterGrades(
                        groups.groups[index].uid,
                        idSubject,
                        partial.toString(),
                        generations.first.uid);

                    Navigator.pushNamed(context, 'list_studentByGrades');
                    break;
                  case 2:
                    print('PARTIAN TWO');
                    ratingServices.getStudentByAverageGrades(
                        groups.groups[index].uid,
                        idSubject,
                        partial.toString());

                    Navigator.pushNamed(context, 'list_studentByGrades');
                    break;
                  case 3:
                    print('partial  thre');
                    ratingServices.getStudentByFailingGrades(
                      groups.groups[index].uid,
                      idSubject,
                      partial.toString(),
                    );

                    Navigator.pushNamed(context, 'list_studentByGrades');
                    break;
                  default:
                    ratingServices.getStudentByBetterGrades(
                        groups.groups[index].uid,
                        idSubject,
                        partial.toString(),
                        generations.last.uid);

                    Navigator.pushNamed(context, 'list_studentByGrades');
                }
              },
              child: Text(groups.groups[index].name),
            );
          }),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// ESTE ES UN DIALOG PEOR MUESTARUN MENSAJE EN EL SNACKBAR ALA HROA DE SELECCIONAR ALGUN DATO
// EN LA CUAL NO SE SI ES LO MISMO CON LAS APLICAZCIOENS DE ESCRITORIO
