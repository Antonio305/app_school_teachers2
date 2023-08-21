// creamos una  para las opcioes las cuales puede ser personalizadas

import 'package:flutter/cupertino.dart';

class OptionMenu {
//datos
// nombre de la ruta
// icon
// string name
// widget screen  o la pagina

  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  //  / los valores final se inicializan dentro del contructor
  // sin als llaves se define como posicinal
  // con la llaves no importa la posirio ncon el required indica que es necesriotodos los datos
  OptionMenu(
      {required this.route,
      required this.icon,
      required this.name,
      required this.screen});
}
