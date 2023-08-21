import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authDecoration({
     String? hintText,
     String? labelText,
     IconData? prefixIcon,
  }) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        // preguntmos si es o igual a null
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.deepPurple)
            : null);
  }
}
