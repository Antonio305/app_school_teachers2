import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/menu_option_provider.dart';

class DropDownButtonOptions extends StatelessWidget {
  // we receive a list // recivimos una lista

  final List<dynamic> list;

  const DropDownButtonOptions({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dropMenuProvider =
        Provider.of<MenuOptionProvider>(context, listen: false);

    return DropdownButton<dynamic>(
      value: dropMenuProvider.dropdownMenuItemGroup,
      icon: const Icon(Icons.arrow_downward),
      elevation: 5,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (dynamic value) {
        // instancia de la clase provider
        // provider instance class
        dropMenuProvider.dropdownMenuItemGroup = value;
      },
      items: list.map<DropdownMenuItem<dynamic>>(( dynamic value) {
        return DropdownMenuItem<dynamic>(
            value: value,
             child: Text(value));
      }).toList(),
    );
  }
}
