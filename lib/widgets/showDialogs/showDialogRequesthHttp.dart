import 'package:flutter/material.dart';
import 'package:preppa_profesores/models/MessageError.dart';
import 'package:preppa_profesores/utils/shapeBorderDialog.dart';

class ShowDialogHttpResponsesMessages {
  // function
  static showMessage(BuildContext context, String title, dynamic resp) {
    if (resp == null) {
      return;
    }
    // ignore: unrelated_type_equality_checks
    if (resp.runtimeType == bool) {
      ShowDialogLogin.showDialogLogin(context);
      return;
    } else {
      showDialogErrorNotTitle(context, const Icon(Icons.error), resp);
    }

    //   ShowDialogError.showDialogError(
    //       context, const Icon(Icons.message), title, resp);
    // }
  }

  static showDialogErrorNotTitle(
      BuildContext context, Icon icon, String textContent) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: icon,
          content: SizedBox(
              width: 350,
              child: Text(
                textContent,
                textAlign: TextAlign.center,
              )),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              child: const Text("Aceptar"),
              onPressed: () {
                Navigator.pop(context);

                // Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static showDialogErrorStatus400(BuildContext context, Icon icon,
      String textContent, List<ErrorMessage> erros) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: MyShapeBorderAlertDialog.borderAlertDialog,
          // icon: icon,
          title: Text(
            textContent,
            // textAlign: TextAlign.center,
          ),
          content: SizedBox(
              width: 350,
              child: Wrap(
                children: erros
                    .map((e) => Row(
                          children: [
                            const Text('° '),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(e.msg),
                          ],
                        ))
                    .toList(),
              )),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              child: const Text("Aceptar"),
              onPressed: () {
                Navigator.pop(context);

                // Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class ShowDialogLogin {
  static showDialogLogin(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.login),
          title: const Text('Sesion'),
          content: const Text(
              '¡La sesion se ha caducado, por favor inicia sesion de nuevo!'),
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
                Navigator.pop(context);
                // Navigator.popAndPushNamed(context, 'login');
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
        );
      },
    );
  }
}
