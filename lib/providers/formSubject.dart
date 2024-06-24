import 'package:flutter/cupertino.dart';

import '../models/subjects.dart';

class FormSubjectProvider extends ChangeNotifier {
  // intance class  subjects
  late Subjects subject;

  // para hacer validaciones
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

// contructor para recivir una subjects
  FormSubjectProvider(this.subject);

  void updateSubject() {
    subject;
    notifyListeners();
  }

  // funcion para validar el campor de texto
  bool isValidForm() {
    if (_globalKey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}
