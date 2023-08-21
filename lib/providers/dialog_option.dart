import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/rating_services.dart';
import 'package:preppa_profesores/widgets/utils/style_ElevatedButton.dart';
import 'package:provider/provider.dart';

import '../Services/group_services.dart';
import '../Services/subject_services.dart';
import 'dart:ui' as ui;

class ListDialogByStudent extends ChangeNotifier {
  /*
 LIST OF STATIC TYPE FFUNCTIONS
 -- LISTA DE LAS FUNCIONES DE TIPOS ESTATICOS.

 TO SELCT THE SEMESTRER AND PARCIAL  AND VIEW THE BEST FGRADES
 PARA SLECCIAONR EL SEMSTRE Y  EN CADA UNA DE LAS   

  */

  // primera funcion para seleccionar el parcial en la cual se esta esta creado

  static Future selectedParcial(
      BuildContext context, Size size, int option) async {
    int selectedValue = 0; // Variable para almacenar el valor seleccionado

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        // Construimos el diálogo
        return AlertDialog(
            title: Text('Seleccione el parcial'),
            content: SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.3,
              child: Center(
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    // child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
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
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
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
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
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
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
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
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  // Validar la selección antes de cerrar el diálogo y devolver el valor
                  // if (selectedValue.isNotEmpty) {
                  //   Navigator.of(context).pop(selectedValue);
                  // } else {
                  // Mostrar un mensaje de error si no se ha seleccionado ningún valor
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Seleccione un valor'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  // }
                },
              ),
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
        title: const Text('SELECCIONA EL GRUPO'),
        content: SizedBox(
          width: size.width * 0.5,
          height: size.height / 2.5,
          child: Center(
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: List.generate(
                  subjects.length,
                  (index) => SizedBox(
                        width: 150,
                        child: Card(
                          color: const ui.Color.fromARGB(
                            88,
                            61,
                            20,
                            156,
                          ),
                          child: TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              showGroup(context, subjects[index].uid, partial,
                                  option);
                            },
                            child: Center(
                              child: Text(subjects[index].name),
                            ),
                          ),
                        ),
                      )),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cerrar'),
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
      final groups = groupServider.group;
      final size = MediaQuery.of(context).size;
      return AlertDialog(
        title: const Text('Alert'),
        content: SizedBox(
          width: size.width * 0.4,
          height: size.height / 2,
          child: Center(
            child: Wrap(
              children: List.generate(groups.groups.length, (index) {
                return Card(
                  color: const ui.Color.fromARGB(
                    88,
                    61,
                    20,
                    156,
                  ),
                  // color: Colors.red,

                  // color: indexSelected == index ? Colors.red : Colors.white54,
                  child: MaterialButton(
                    onPressed: () async {
                      // hacgo la navegacio na otra vista
                      Navigator.of(context).pop();
                      //aca se hace la consulta de los datos
                      // intancia de laclse
                      final ratingServices =
                          Provider.of<RatingServices>(context, listen: false);

// crear un siwti para saber cual funtion ay que ejecutar
                      switch (option) {
                        case 1:
                          print('PARTIAL ONE');
                          ratingServices.getStudentByBetterGrades(
                              groups.groups[index].uid,
                              idSubject,
                              partial.toString());

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
                              partial.toString());

                          Navigator.pushNamed(context, 'list_studentByGrades');
                          break;
                        default:
                          ratingServices.getStudentByBetterGrades(
                              groups.groups[index].uid,
                              idSubject,
                              partial.toString());

                          Navigator.pushNamed(context, 'list_studentByGrades');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        height: 30,
                        child: Center(child: Text(groups.groups[index].name)),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Close'),
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
