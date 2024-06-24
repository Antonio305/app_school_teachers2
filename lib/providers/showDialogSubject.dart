///  Esto es para crear los show dialog  para agergar la informacion de las materias.

import 'package:flutter/material.dart';

class ShowDialogSubject extends ChangeNotifier {
  static Future showDialogSubject(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar sala de chat'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Mostrar una lista de salas de chat con alumnos y grupos
                ListTile(
                  title: const Text('Sala de chat 1'),
                  onTap: () {
                    // Seleccionar la sala de chat 1
                  },
                ),
                ListTile(
                  title: const Center(child: Text('Sala de chat 2')),
                  onTap: () {
                    // Seleccionar la sala de chat 2
                  },
                ),
                ListTile(
                  title: const Text('Sala de chat 3'),
                  onTap: () {
                    // Seleccionar la sala de chat 3
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
