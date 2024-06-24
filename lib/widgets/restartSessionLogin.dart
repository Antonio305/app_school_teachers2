import 'package:flutter/material.dart';

class RestartSession {
  static void restartSession(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reiniciar sesión'),
          content: const Text('¿Desea reiniciar la sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: const Text('Reiniciar'),
            ),
            TextButton(
              onPressed: () {
                // Cancelar
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
