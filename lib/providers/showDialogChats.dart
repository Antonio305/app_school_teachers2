import 'package:flutter/material.dart';

class ShowDialogChat extends ChangeNotifier {
  static Future showDialogChat(BuildContext context) async {
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
                  title: const Text('CHAT GRUPAL'),
                  onTap: () {
                    // Seleccionar la sala de chat 
                    Navigator.pushNamed(context, 'groupChat');
                  },
                ),
                ListTile(
                  title: const Text('CHAT GRUPAL'),
                  onTap: () {
                    Navigator.pushNamed(context, 'chats');
                    // Seleccionar la sala de chat 2
                  },
                ),
                ListTile(
                  title: const Text(' CHAT UNO A UNO'),
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
