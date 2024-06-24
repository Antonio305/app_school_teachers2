import 'package:flutter/material.dart';

import 'com/imageButton.dart';

class ButtonWindow extends StatelessWidget {
  const ButtonWindow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 2,
      child: Center(
        child: GetImageButton(),
      ),
    );
  }
}