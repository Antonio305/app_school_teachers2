import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';

// crearemos una clasa para delvolver el metodoo

class Show {
// final  BuildContext context;
// final String  titlw;
// final String subTitle;

  static AchievementView show(
      {required BuildContext context,
      required String title,
      required String subTitle}) {
    return AchievementView(context,
        color: const Color(0xffFF8B65),
        duration: const Duration(milliseconds: 50),
        alignment: Alignment.topCenter,
        title: title,
        subTitle: subTitle,
        textStyleSubTitle: const TextStyle(fontSize: 12.0),
        isCircle: true, listener: (status) {
      print(status);
    }, onTap: () {})
      ..show();
  }
}
