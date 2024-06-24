import 'package:flutter/material.dart';

import '../models/task/newTask.dart';

class FormCreateTaskProvider extends ChangeNotifier {
  late NewTask task;

  FormCreateTaskProvider(this.task);
  // Para la validacion de los campos de texto
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void updateTask() {
    task;
    notifyListeners();
  }

  bool isValidForm() {
    return _formKey.currentState!.validate();
  }
}
