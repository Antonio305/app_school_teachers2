import 'package:flutter/material.dart';

import '../../utils/shapeBorderDialog.dart';

class ShowDialogLogin {
  static Future showDialogNotExistUser(BuildContext context, String? message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: MyShapeBorderAlertDialog.borderAlertDialog,
          title: const Text('Error'),
          content: Text(message!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
