import 'package:flutter/material.dart';
import 'package:preppa_profesores/local_storage/get_picture_path.dart';

import 'com/imageButton.dart';

class ButtonWindow extends StatelessWidget {
  const ButtonWindow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: GetImageButton(),
      ),
    );
  }
}