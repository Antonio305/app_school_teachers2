import 'package:flutter/material.dart';

import '../models/teacher.dart';

// import '../models/teacher.dart';

class TeacherFormProvider extends ChangeNotifier {
  // creamos  key global para el form

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Teachers teacher = Teachers(
      name: "",
      lastName: "",
      secondName: "",
      gender: "",
      collegeDegree: "",
      typeContract: "",
      status: true,
      rol: "",
      tuition: "",
      uid: "");

  // TeacherFormProvider(this.teacher);

  // funcion para  validar los datos em la  cual hacemos un retorn de los datos

// retorna un voleado si si estan validado los datos
  bool isValidForm() {
    print(teacher!.name);
    print(teacher!.secondName + teacher!.lastName);

    return formKey.currentState!.validate();
  }
}
