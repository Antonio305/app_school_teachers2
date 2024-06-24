


import 'package:flutter/material.dart';


// import '../models/teacher.dart';

class StudentFormProvider extends ChangeNotifier {
  // creamos  key global para el form

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  // TeacherFormProvider(this.teacher);

  // funcion para  validar los datos em la  cual hacemos un retorn de los datos

// retorna un voleado si si estan validado los datos
  bool isValidForm() {

    return formKey.currentState!.validate();
  }
}
