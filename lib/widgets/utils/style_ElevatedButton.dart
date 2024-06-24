import 'package:flutter/material.dart';

class StyleElevatedButton {
  static final styleButton = ButtonStyle(
    // backgroundColor: MaterialStateProperty.all(
    //     const ui.Color.fromARGB(88, 61, 20, 156)
    //     ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
