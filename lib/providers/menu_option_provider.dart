//  creamos una para mostrar los datos heeee


import 'package:flutter/material.dart';

class MenuOptionProvider extends ChangeNotifier {
// creamos un metodo getter y seetter

// oara a gestiuo nde lmenu del lado derecho de la aplicacion
  int _index = 0;

  get itemMenuGet {
    return _index;
  }

  set itemMenu(int item) {
    _index = item;
    // cuando cambie de valos notificamos el cambio
    notifyListeners();
  }

// prade del afncion de los estudiante para
// gtestinoar los DRopMenuAButton

  String _dropButtonValue = 'MASCULINO';

  String get dropdownMenuItemSexoGet {
    return _dropButtonValue;
  }

  set dropdownMenuItemSexo(String value) {
    _dropButtonValue = value;
    notifyListeners();
  }

// blooGrade ( Tipo de sagnre)
  String _blooGrade = "A+";
  String get bloogGradStudent {
    return _blooGrade;
  }

  set bloogGradStudent(String value) {
    _blooGrade = value;
    notifyListeners();
  }

  // edad

  int _age = 14;

  int get ageStudent {
    return _age;
  }

  set ageStudent(int value) {
    _age = value;
    notifyListeners();
  }

  // ´parentesco
  String _parectesco = 'PAPA';
  String get parectencoStudent {
    return _parectesco;
  }

  set parectencoStudent(String value) {
    _parectesco = value;
    notifyListeners();
  }

// datos escolares

  String _group = 'GRUPO A';
  // String  _group = '';

  String get dropdownMenuItemGroup {
    return _group;
  }

  set dropdownMenuItemGroup(String value) {
    _group = value;
    notifyListeners();
  }

  String _semestre = 'SEMESTRE I';
  // gestor del semetre
  String get dropdownMenuItemSemestre {
    return _semestre;
  }

  set dropdownMenuItemSemestre(String value) {
    _semestre = value;
    notifyListeners();
  }

// oara la gesti onde la s generaiciones
// en la cual los datos seran obenidos en la base de datos
  String _gereracion = '2019-2021';

  String get dropDownMenuItemGeneracion {
    return _gereracion;
  }

  set dropDownMenuItemGeneracion(String value) {
    _gereracion = value;
    notifyListeners();
  }

  //TODO: METODOS PARA GESTIONAR LOS DATOS DE LA  MTERIAS

  String _gender = 'MASCULINO';

  String get genderTeacher {
    return _gender;
  }

  set genderTeacher(String value) {
    _gender = value;
    notifyListeners();
  }

  String _rol = 'DIRECTOR';

  String get rolTeacher {
    return _rol;
  }

  set rolTeacher(String value) {
    _rol = value;
    notifyListeners();
  }

  bool _status = true;

  bool get statusTeacher {
    return _status;
  }

  set statusTeacher(bool value) {
    _status = value;
    notifyListeners();
  }

  // typeContrac
  String _typeContrac = 'BASE';
  String get typeContracTeacher {
    return _typeContrac;
  }

  set typeContracTeacher(String value) {
    _typeContrac = value;
    notifyListeners();
  }
}
