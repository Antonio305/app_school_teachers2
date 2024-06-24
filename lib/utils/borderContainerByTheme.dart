import 'package:flutter/material.dart';

class DecorationContainerByTheme {
  static BoxDecoration decorationContainer(bool myTheme) {
    return BoxDecoration(
        // color: Colors.red,
        border: Border.all(
            // thteme id dark
            color: myTheme == true ? Colors.white12 : Colors.black12),
        // color: Colors.blue,
        borderRadius: BorderRadius.circular(12));
  }
}
