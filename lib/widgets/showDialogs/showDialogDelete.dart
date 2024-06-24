import 'package:flutter/material.dart';

class ShowDialogDelete {
  static showDialogDelete(BuildContext context, Icon icon, String titleDialog,
      String textContent, Function onPress) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: icon,
          title: Align(
            alignment: Alignment.center,
            child: Text(titleDialog)),
          content: Text(textContent),
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
                onPress();
              },
            ),
          ],
        );
      },
    );
  }
}
