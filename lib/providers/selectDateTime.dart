import 'package:flutter/material.dart';

class SelectDateTime extends ChangeNotifier {
// metodo getter y para la seleccoin de la fecha para la entre de tareas y para otros mas

  DateTime _dateSelected = DateTime.now();

  // functio get
  DateTime get selectDateTime => _dateSelected;

  /// set

  set selectDateTime(DateTime dateSelected) {
    _dateSelected = dateSelected;
    notifyListeners();
  }
}
