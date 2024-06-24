import 'package:flutter/material.dart';

class MyBorder {
  static BoxDecoration myDecorationBorder(Color? color) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: color,
      // color: Colors.amber,
    );
  }

  static BorderRadius myBorderRadius() {
    return BorderRadius.circular(10);
  }

  static BoxDecoration decorationWidgetStory(Color? myColor) {
    return BoxDecoration(
        color: myColor,
        borderRadius: myBorderRadius(),
        border:
            Border.all(width: 0.45, color: Colors.white70.withOpacity(0.1)));
  }
}
