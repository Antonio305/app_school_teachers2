
import 'package:flutter/material.dart';

// provider  para evaluar los datos

class LoginFormProvider extends ChangeNotifier {
  // creamos la  propiedad gloabal para evaluar los datos

  GlobalKey<FormState> formKey = GlobalKey<FormState>();



  bool _isLoading = false;

  // cremos una getter y setter para mostar los cambios
  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // cremos un metood para validar los datos
  isValidate() {
    // va retornar la vlaidacio nde los datos
    print(formKey.currentState?.validate());
    // print('$login.user, $login.password');
    return formKey.currentState?.validate() ?? false;
  }
}
