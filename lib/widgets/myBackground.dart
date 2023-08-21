import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class myBackground extends StatelessWidget {
  const myBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 15,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const ui.Color.fromARGB(87, 75, 12, 117).withOpacity(0.1),

          // border: Border.all(color: Colors.black),
        ),
      ),
    );
  }
}
