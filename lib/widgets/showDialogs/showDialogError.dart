import 'package:flutter/material.dart';

class ShowDialogError {
  static showDialogError(
      BuildContext context, Icon icon, String titleDialog, String textContent) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: icon,
          title: Text(titleDialog),
          content: Text(textContent),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              child: const Text("Aceptar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
