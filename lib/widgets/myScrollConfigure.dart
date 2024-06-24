// WIDGET CON SCROLL CONFIGURADO
import 'dart:ui';

import 'package:flutter/material.dart';

class MyScrollConfigure extends StatelessWidget {
  final Widget child;

  const MyScrollConfigure({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.unknown,
            PointerDeviceKind.stylus,
            PointerDeviceKind.invertedStylus
          },
        ),
        child: child);
  }
}
