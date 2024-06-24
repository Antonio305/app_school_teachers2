import 'package:flutter/material.dart';

class ShowDialogLogin {
  static showDialogLogin(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.login),
          title: const Text('Sesion'),
          content: const Text(
              '¡La sesion se ha caducado, por favor inisia sesion de nuevo!'),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Confirmar"),
              onPressed: () {
                // Navigator.pop(context);
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
        );
      },
    );
  }
}
